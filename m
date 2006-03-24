From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] make test (t3600-rm.sh) fails
Date: Fri, 24 Mar 2006 02:29:49 -0800
Message-ID: <7v7j6k16g2.fsf@assigned-by-dhcp.cox.net>
References: <4423C681.3000302@issaris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 11:29:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMjYK-0001LG-3G
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 11:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbWCXK3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 05:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWCXK3w
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 05:29:52 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64397 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1422829AbWCXK3v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 05:29:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324102950.FEOR17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Mar 2006 05:29:50 -0500
To: Panagiotis Issaris <takis@issaris.org>
In-Reply-To: <4423C681.3000302@issaris.org> (Panagiotis Issaris's message of
	"Fri, 24 Mar 2006 11:14:25 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17906>

Panagiotis Issaris <takis@issaris.org> writes:

> * FAIL 9: Test that "git-rm -f" fails if its rm fails
>        git-rm -f baz
>...
> My system:
> Ubuntu 5.10 aka Breezy
> Linux issaris 2.6.15.060103 #1 Tue Jan 3 14:27:55 CET 2006 i686 GNU/Linux

I wonder what your system shows if you run:

	$ cd t && sh -x t3600-rm.sh -i -v

The test #9 makes the test directory unwritable before trying to
unlink a file there, and git-rm runs rm without -f which should
make it fail.  So either your "chmod u-w ." is broken, you are
running it as root and defeating "chmod u-w .", or you have a
broken rm that does not report failure with its exit status.

The relevant part on my machine looks like this:

$ cd t
$ sh -x t3600-rm.sh -i -v
...
*   ok 8: Test that "git-rm -f" succeeds with embedded space, tab, or newline characters.
+ test y = y
+ chmod u-w .
+ test_expect_failure 'Test that "git-rm -f" fails if its rm fails' 'git-rm -f baz'
+ test 2 = 2
+ say 'expecting failure: git-rm -f baz'
+ echo '* expecting failure: git-rm -f baz'
* expecting failure: git-rm -f baz
+ test_run_ 'git-rm -f baz'
+ eval 'git-rm -f baz'
++ git-rm -f baz
rm: cannot remove `baz': Permission denied
+ eval_ret=123
+ return 0
+ '[' 0 = 0 -a 123 '!=' 0 ']'
+ test_ok_ 'Test that "git-rm -f" fails if its rm fails'
++ expr 8 + 1
+ test_count=9
+ say '  ok 9: Test that "git-rm -f" fails if its rm fails'
+ echo '*   ok 9: Test that "git-rm -f" fails if its rm fails'
*   ok 9: Test that "git-rm -f" fails if its rm fails
...
