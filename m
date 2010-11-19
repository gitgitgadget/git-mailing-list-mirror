From: Jeffrey Middleton <jefromi@gmail.com>
Subject: Re: pager config for external commands
Date: Fri, 19 Nov 2010 11:16:53 -0600
Message-ID: <AANLkTikE6=At-BV22myZtM4nuNL6z4hoJ-kS=O1LkBXo@mail.gmail.com>
References: <AANLkTimtjR0O3K8iGOVVVaFJS2+2wHcHhWf45tFYXjRQ@mail.gmail.com>
 <AANLkTimMSp8XVzoaax2mW-jYP26B+zF2QSJFcy4TUi60@mail.gmail.com> <20101119160058.GA7967@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 19 18:17:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJUaP-0007HP-Qo
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 18:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039Ab0KSRRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 12:17:16 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34701 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622Ab0KSRRP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 12:17:15 -0500
Received: by eye27 with SMTP id 27so2840763eye.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 09:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=fGY+1kNPukXNH3R5CfOHiox1r2RAN0FwgPhP7udinYo=;
        b=g2QFVUQ52Pb6n4sXYeIlj1VfPFIwfcq+5Q4Zd3qGrg/te32C+G+y1u+2t0o2UVfo6T
         MWo5alq6K9VifeefLD3l1gd51hsegBaAYtLA5jr7sI8+BqHoMt9Z8EiZeoMDWyDJIOeL
         6vUxXw1+cE9cfzY2NvApVKPNa79hkqYDjwe6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=AP4CbQWMgluf5MGS9zK0TRGSfiXp95VjVEtL17EE9E1owJI7PQ4C0ej/uex9bR+HVw
         UdrnM4Ybar2oeOmnC4el/Xv3s7kQY8fx3GC/ibDMZDTH5DxqEjnv2j5eCuxiQvzmHlKq
         N8Ohz/8LGgShG/2+z7GaaJ+qamV3ILgXojRrA=
Received: by 10.216.242.12 with SMTP id h12mr2159283wer.26.1290187033681; Fri,
 19 Nov 2010 09:17:13 -0800 (PST)
Received: by 10.216.206.30 with HTTP; Fri, 19 Nov 2010 09:16:53 -0800 (PST)
In-Reply-To: <20101119160058.GA7967@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161769>

On Fri, Nov 19, 2010 at 10:00 AM, Jeff King <peff@peff.net> wrote:
> Basically the problem is that we just call execv("git-<cmd>"). If it
> works, then we are running an external, but we no longer have an
> opportunity to start the pager. If it doesn't, then we don't necessarily
> want to commit our pager choice. We may be running an alias, or we may
> simply barf with "no such command".

Okay, that makes sense, I think. But execv_dashed_external does
currently commit the pager choice, just without looking it up from the
config. This means that, for example, git --paginate
<nonexistent-command> does invoke the pager. Is that intended? I don't
think I see any tests covering the combination of pager.<cmd> for
anything but builtins.

Also, instead of having git implement "look up in PATH" internally,
would it make sense to simply commit the pager choice, try the execv,
then uncommit the pager choice if the command was not found?

Jeffrey
