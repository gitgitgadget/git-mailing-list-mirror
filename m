From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Tue, 24 Jul 2007 00:16:11 +0200
Message-ID: <85k5sqdavo.fsf@lola.goethe.zz>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
	<20070719105105.GA4929@moonlight.home>
	<86zm1sbpeh.fsf@lola.quinscape.zz>
	<20070719123214.GB4929@moonlight.home>
	<863azka7d4.fsf@lola.quinscape.zz> <87ps2inab5.fsf@hades.wkstn.nix>
	<85y7h6dewp.fsf@lola.goethe.zz> <87lkd6n62i.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:16:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID6CQ-0002rc-Dj
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 00:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbXGWWQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 18:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbXGWWQO
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 18:16:14 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:41071 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752628AbXGWWQN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 18:16:13 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 3201932EBEA;
	Tue, 24 Jul 2007 00:16:12 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 211DD2D3788;
	Tue, 24 Jul 2007 00:16:12 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-045-109.pools.arcor-ip.net [84.61.45.109])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id E72FF36E86B;
	Tue, 24 Jul 2007 00:16:11 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 74A991C002B7; Tue, 24 Jul 2007 00:16:11 +0200 (CEST)
In-Reply-To: <87lkd6n62i.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of "Mon\, 23 Jul 2007 22\:49\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53492>

Nix <nix@esperi.org.uk> writes:

> On 23 Jul 2007, David Kastrup uttered the following:
>> Nix <nix@esperi.org.uk> writes:
>>> Actually, if we had a post-checkout hook, we could use a pre-commit
>>> hook to keep track of directory existence, permissions, et seq, and
>>> a post- checkout hook to restore them.
>>
>> Actually, tracking permissions would be cheap: one just needs to
>> replace the permission-munging macros in git with identity.  Ownership
>> -- well, that's harder.
>>
>> But my sentiment remains: git _tracks_ stuff: it notices when things
>> move around and follows them.  Statically snapshotting permissions
>> creates a layer that is quite less flexible.  The information gets
>> detached.
>
> Not if you record it in a file which is checked in in the same
> commit that is tracked, it isn't (that's what the pre-commit hook is
> for).

I have my doubts that anybody but git actually has a clue what to
snapshot when, and where to place it: don't forget that index
manipulation and committing are done at different times, and you need
not even commit all of the index.

> It's true that git won't natively have any knowledge of that data,
> but Linus has fairly effectively shown that it shouldn't have any
> such knowledge and doesn't need it.

Last time I looked, git tracked the executable bit.  For kernel
development, this is pretty much what it takes, and with colloborative
work, tracking anything but the owner permissions is going to lead to
annoying and verbose merge behavior quite a lot.  And of the owner
permissions, r and w complicate proper handling when unset.

But being able to specify other masks for applications other than
multi-site colloborative development would likely not hurt.

> Doing this *efficiently* is another matter: probably a pair of hooks
> are needed, run on pre-checkout and post-checkout: they can
> communicate so as only to fiddle permissions on things which are
> newly appeared or whose permissions have changed.
>
> Obviously because the permissions, ownerships et al aren't recorded
> in the index this will slow committing down,

It will also detach the time where the file contents and the
permissions get recorded.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
