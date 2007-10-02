From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 02 Oct 2007 09:03:37 +0200
Message-ID: <vpq641qroae.fsf@bauges.imag.fr>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<7v3awunjup.fsf@gitster.siamese.dyndns.org>
	<49137EAF-BB73-40DC-973C-E60C14B3FA7F@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 02 09:04:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcboA-0005Lw-IN
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 09:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbXJBHEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 03:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbXJBHEe
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 03:04:34 -0400
Received: from imag.imag.fr ([129.88.30.1]:47919 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbXJBHEd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 03:04:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l9273bVu017035
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Oct 2007 09:03:37 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Icbn7-00028Q-4I; Tue, 02 Oct 2007 09:03:37 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Icbn7-0005Nl-1p; Tue, 02 Oct 2007 09:03:37 +0200
In-Reply-To: <49137EAF-BB73-40DC-973C-E60C14B3FA7F@zib.de> (Steffen Prohaska's message of "Tue\, 2 Oct 2007 08\:44\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 02 Oct 2007 09:03:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59668>

Steffen Prohaska <prohaska@zib.de> writes:

> On Oct 2, 2007, at 7:53 AM, Junio C Hamano wrote:
>
>>
>> * jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
>>  + rebase: allow starting from a dirty tree.
>>  + stash: implement "stash create"
>>
>> Instead of refusing to rebase, telling you that your work tree
>> is dirty, this stashes your local changes, runs rebase and then
>> unstashes automatically.  That _sounds_ nicer and easier to use,
>> but I am not sure if it is a wise/sane thing to do.  We may want
>> to revert the "autostash" from rebase.  Opinions?
>
> What would happen if 'git stash' fails to work? Could this bring
> the repo in a state that is hard to recover from? Especially if
> 'stash' commands were run automatically for you. Maybe if you had
> a choice you would not choose to use stash but would commit your
> changes, or would bring your work tree in a clean state by other means.

I'm also concerned about the possibility of stash/unstash to fail:
that means the user has to deal with two kinds of conflicts (rebase
can conflict, unstash can also), which can be confusing.

But the current behavior can be greatly improved by just making the
error message better. Currently, I have this:

$ git rebase branch
foo.txt: needs update
$ _

I'd prefer something like

$ git rebase branch
cannot rebase: the working tree is not clean.
foo.txt: Changed but not updated
Commit your changes, or put them appart with "git stash" and retry.
$ _

-- 
Matthieu
