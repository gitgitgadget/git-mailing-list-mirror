From: Junio C Hamano <junkio@cox.net>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 19:36:24 -0800
Message-ID: <7vfypur5jb.fsf@assigned-by-dhcp.cox.net>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	<b0943d9e0511160311k725526d8v@mail.gmail.com>
	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
	<7vy83ny450.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>
	<7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net> <437D2D14.5080205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 04:38:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecx4K-0001CP-Bh
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 04:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbVKRDg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 22:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbVKRDg2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 22:36:28 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:34713 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751496AbVKRDgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 22:36:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118033525.ILUQ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 22:35:25 -0500
To: John Benes <smartcat99s@gmail.com>
In-Reply-To: <437D2D14.5080205@gmail.com> (John Benes's message of "Thu, 17
	Nov 2005 19:23:32 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12189>

John Benes <smartcat99s@gmail.com> writes:

> Junio C Hamano wrote:
>
> I was able to compile master and pu on Cygwin without NO_MMAP=YesPlease
> in the Cygwin section.  However, the make test failed on the
> binary-apply on both master and pu, output follows.
>
> Commit ID's used for testing:
> refs/heads/master	4e1da85d7d0480b6d9973317da4f7a5aa603fcb5
> refs/heads/pu		3b4587eb3c549649af7e84659b4808003c34c2d3

Thanks.  But the test result look suspicious for pu.

	$ git-ls-tree 3b4587eb t | grep t4103

outputs empty, so what you tested does not seem to be that
commit.

Anyway, the master is more important at this point.

> make test barfing on master:
> *** t4103-apply-binary.sh ***
> * FAIL 7: check binary diff with replacement.
>         git-checkout master
>                  git-apply --check --allow-binary-replacement BF.diff
> * FAIL 8: check binary diff with replacement (copy).
>         git-checkout master
>                  git-apply --check --allow-binary-replacement CF.diff
> * FAIL 15: apply binary diff.
>         do_reset
>                  git-apply --allow-binary-replacement --index BF.diff &&
>                  test -z "$(git-diff --name-status binary)"
> * FAIL 16: apply binary diff (copy).
>         do_reset
>                  git-apply --allow-binary-replacement --index CF.diff &&
>                  test -z "$(git-diff --name-status binary)"
> * failed 4 among 16 test(s)
> make[1]: *** [t4103-apply-binary.sh] Error 1

So it fails on these binary diffs with full index tests.  Could
you try running it like this?

	$ cd t
        $ sh ./t4103-apply-binary.sh -i -v

If all things being equal, this will stop at the first failing
test "* FAIL 7: ", and you will have trash/ directory under t/.

	$ cd trash
	$ ls -l

I would first want to see if it was diff that failed or the
apply.  What does BF.diff contain?
