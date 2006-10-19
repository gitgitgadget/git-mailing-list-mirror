From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 15:44:34 +0200
Message-ID: <vpqr6x4pghp.fsf@ecrins.imag.fr>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org>
	<45359B2A.1070102@utoronto.ca> <87y7rdd47j.wl%cworth@cworth.org>
	<20061019091045.GV75501@over-yonder.net> <45375E56.4090106@op5.se>
	<vpqirigqzpd.fsf@ecrins.imag.fr> <20061019123349.GE20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 15:47:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaYEI-0002Ux-DF
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 15:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161413AbWJSNqS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 09:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161418AbWJSNqS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 09:46:18 -0400
Received: from imag.imag.fr ([129.88.30.1]:15587 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1161413AbWJSNqN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 09:46:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9JDiYgA002153
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Oct 2006 15:44:34 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GaYCI-0005B1-GZ; Thu, 19 Oct 2006 15:44:34 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GaYCI-0000Qb-DA; Thu, 19 Oct 2006 15:44:34 +0200
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061019123349.GE20017@pasky.or.cz> (Petr Baudis's message of "Thu\, 19 Oct 2006 14\:33\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 19 Oct 2006 15:44:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29347>

Petr Baudis <pasky@suse.cz> writes:

> The lack of parents ordering in Git is directly connected with
> fast-forwarding.

[...]

>  repo1 repo2
>
>    a       a
>   / \     / \
>  c   b   c   b
>   \ /     \ /
>    m       m

Yes, bzr has similar thing too. AIUI, the difference is that git does
it automatically, while bzr has two commands in its UI, "merge" and
"pull".

In your case, the "leftmost ancestor" of m is b, because at the time
it was created, it was commited from b.

One problem with that approach is that from revision m and looking
backward in history (say, running "bzr log"), you have two ways to go
backward:

1) Take the history of _your_ commits, and your pull till the point
   where you've branched.

2) Follow the history taking the leftmost ancestor at each step.

In bzr, the notion of "branch" corresponds to a succession of
revisions, which are explicitely stored in a file (ls
.bzr/branch/revision-history), which is what commands like "log"
follow, and what is used for revision numbering. And this sucession of
revision must obey (at most) one of the above. In the past, it was 1),
which means that "pull" (i.e. fast-forward) was only adding revisions
to a branch. In your scenario, repo1 would get a revision history of
"a c m" while repo2 would have had "a b m" with the same tip.

Today, the revision history follows leftmost ancestor. One good
property of this is that revision history is unique for a given
revision. But the terrible drawback is that "pull" and "push" do not
/add/ revisions to your revision history, they rewrite the target one
with the source one. That means I can have

$ bzr log --line
1: some upstream stuff
2: started my work
3: continued my work

# upstream merges.

$ bzr pull
$ bzr log --line
1: some upstream stuff
2: some other upstream stuff ...
3: ... commited while I was working
4: merged from Matthieu this terrible feature

-- 
Matthieu -- definitely curious to give a real try to git ;-)
