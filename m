From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 0/5] Extend pattern refspecs
Date: Fri, 6 Mar 2009 00:19:42 -0500
Message-ID: <76718490903052119y4d6a7e0ck24bfeb1c0964e413@mail.gmail.com>
References: <alpine.LNX.1.00.0903052346270.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 06:21:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfSUj-0004oV-Sd
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 06:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbZCFFTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 00:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbZCFFTp
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 00:19:45 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:21808 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbZCFFTp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 00:19:45 -0500
Received: by rv-out-0506.google.com with SMTP id g37so318794rvb.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 21:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JCZm5pk8peTHYhLXlUCoPGxvBtgtOhhPWvjgAZc3L2c=;
        b=LOnN1DGd6GKOx6kCEZp0Ew+t59bV/zXK8Nm6WwvHVvUEgjruCNv/QiE6sSj8GZWVGi
         EI2OPC2H4BNy8lf5kk6sNI2pgBqAD6lkbNL+7ORsuCsB+tskS3ucZdTmMHCiZLCwtyuM
         0w5N7SYGvcxuS2N6BH3RiLq1TDgHzclMB5wLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ljCKleZUzf2CmpC3Cw64Do30uRcMcuQsfjORlHmRL6wEfWNSVo8qBQKnuqVtXcvarQ
         Gbr2gJrGh/kp4AX4vA0iqnj2udKe2CnzE8j0TuMo/ICZhxzjPgFAfN1/vhqMBzXMLivJ
         +TkV24O+/+VlWy4Ye0qjXQmA+uhccWCaLgtog=
Received: by 10.140.187.10 with SMTP id k10mr1069139rvf.81.1236316782337; Thu, 
	05 Mar 2009 21:19:42 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0903052346270.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112385>

On Thu, Mar 5, 2009 at 11:56 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> This series only supports the narrowest case of having the * in the middle
> of a side of a refspec: having it as a full path component on each side.
>
> Patches 1-3 centralize all of the parsing and matching rules to a pair of
> functions; patch 4 makes the stored representation more convenient (and
> serves as a distinguished bisection outcome for anything I missed that was
> relying on the contents of struct refspec for patterns); and patch 5
> extends the matching implementation and loosens the ref format
> requirements to allow the * to be in the middle.
>
> An easy followup would relax the restrictions further without requiring
> any particularly tricky further changes.

This series and js/remote-improvements (e5dcbfd) in pu may not get
along completely. "git remote show" tries to show how the refspecs
expand out. And actually, that should be fine since builtin-remote now
uses the same code as fetch/push to expand the refs.

However, "git remote show -n" (-n means don't query the remote) makes
use of a new function, get_push_ref_states_noquery(), which more or
less tries to reverse the parsed refspec back into the original
string. That function relies on the current (before your patch)
refspec semantics and assumes if refspec.pattern is set, then the '*'
is at the end. So it will need tweaking.

j.
