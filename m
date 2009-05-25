From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFC PATCH] am: do not do any reset on --abort
Date: Mon, 25 May 2009 12:10:21 -0400
Message-ID: <32541b130905250910r251e4667m2b63b651e1724b59@mail.gmail.com>
References: <20090525104308.GA26775@coredump.intra.peff.net> 
	<alpine.DEB.1.00.0905251348050.4288@intel-tinevez-2-302> <20090525120019.GA1740@coredump.intra.peff.net> 
	<4A1A8C6C.5020009@viscovery.net> <20090525160207.GB5449@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 25 18:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8clp-0001Q4-UC
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 18:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbZEYQLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 12:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbZEYQLP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 12:11:15 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:44801 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZEYQLO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 12:11:14 -0400
Received: by gxk10 with SMTP id 10so5701662gxk.13
        for <git@vger.kernel.org>; Mon, 25 May 2009 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Zn3WR7uMNRMA1qbaLBMwE2O3WvJl7hdgZQQUtquOOGc=;
        b=Tm1NfXfXiDbro/kdnssKKki5yTLKcwxbg3LaU3UDMHhJrOxONzBt6RjtPYmQ/dUqBO
         5NEHPegvIhu9MRYhyvZO6CT8I81+HsK1fJHhRiXzoMZ5e5TMoOQvsjqDwkxhYofFk1yf
         prDo4+Of2e4Gs7XQdO0A/TwqaEMrcXVkjY86E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eNnyWacQ2oYRAC5gSDbxInRqlgzb//FYDEPLujn2Xtm6ZYnjuCx4WllM+5wB3pqbwo
         5R1nAKtEuG3A4+DMG/LqYJFwq1x+8b8wdtSU9I1DgJfK/skc2joMsDhY71z0tkrwOr3j
         ewqJH7n8wKN35ybi9ND30SDY1zLNIMyPdD5a0=
Received: by 10.151.137.6 with SMTP id p6mr14540495ybn.154.1243267841059; Mon, 
	25 May 2009 09:10:41 -0700 (PDT)
In-Reply-To: <20090525160207.GB5449@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119943>

On Mon, May 25, 2009 at 12:02 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 25, 2009 at 02:17:48PM +0200, Johannes Sixt wrote:
>
>> I wonder why we have this problem (and do something about it) with git-am,
>> but not with git-rebase. Is it perhaps that the usual case were people
>> were bitten by the old behavior is:
>
> I don't know. I had assumed a safety valve we put in git-am might need
> to be matched in rebase. But I don't recall whether I have screwed
> myself in the same way with rebase. Perhaps because rebase happens on a
> detached HEAD, I tend to notice sooner that something is not right.

Ah, maybe that's the difference.  rebase seems to detach the HEAD,
then do a bunch of stuff, then reset the original branch only when
it's done.  So aborting doesn't reset any branches at all, it just
checks out the original branch.

Thus one option would be to try to make am more like rebase: detach
the HEAD before it starts, and reattach it only on success.  At least
then you only have one set of UI problems to fix.

(Of course, I've gotten myself into trouble anyway by checking new
stuff in on the detached HEAD and later aborting a rebase.  I have
quite a love-hate relationship with detached HEADs.)

Maybe the best solution here isn't to prevent people from shooting
themselves in the foot, but instead to help them recover afterwards.
I've noticed most people don't know about 'git reflog'; they often
seem astonished when I tell them about it.  reflog + not blowing away
dirty repositories would mean that you're always safe.

Have fun,

Avery
