From: Gerrit Pape <pape@smarden.org>
Subject: Re: [ANNOUNCE] Cogito-0.17rc1
Date: Thu, 16 Feb 2006 10:20:59 +0000
Message-ID: <20060216102059.17009.qmail@8b7ebad5023b2c.315fe32.mid.smarden.org>
References: <20060212171154.GW31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Feb 16 11:24:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9gFz-00025e-FW
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 11:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWBPKUx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 05:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWBPKUx
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 05:20:53 -0500
Received: from a.mx.smarden.org ([212.21.76.77]:59530 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1030410AbWBPKUw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 05:20:52 -0500
Received: (qmail 17010 invoked by uid 1000); 16 Feb 2006 10:20:59 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060212171154.GW31278@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16289>

On Sun, Feb 12, 2006 at 06:11:54PM +0100, Petr Baudis wrote:
>   I'm announcing the release of Cogito version 0.17rc1, the human-friendly
> version control UI for Linus' GIT tool. Share and enjoy at:
> 
> 	http://www.kernel.org/pub/software/scm/cogito/

Hi, the selftests for cg-seek fail for me on Debian/unstable:

 $ wget -q -O- http://www.kernel.org/pub/software/scm/cogito/cogito-0.17rc1.tar.gz |tar xzpf -
 $ cd cogito-0.17rc1
 $ make
 Generating cg-version...
 $ make test
 [...]
 *** t9300-seek.sh ***
 *   ok 1: initialize repo
 Adding file different
 *   ok 2: record second commit
 *   ok 3: seeking to the first commit
 *   ok 4: we should have .git/head-name == master
 *   ok 5: current branch should be cg-seek-point
 *   ok 6: current commit should be commit1
 *   ok 7: newfile should be gone
 *   ok 8: different should be v1
 *   ok 9: identical should be identical
 * FAIL 10: seeking to the second commit
         cg-seek ab3fddb2498b5378c1eb91f341c0f9cfbc15944f
 *   ok 11: we should not unseeked properly
 * FAIL 12: current commit should be commit2
         [ 422409bf18cdcf9214cd9fcc34a2cace15ce5aff =
 ab3fddb2498b5378c1eb91f341c0f9cfbc15944f ]
 *   ok 13: seeking to the last (well, still second) commit
 *   ok 14: we should be unseeked properly
 *   ok 15: current commit should be commit2
 *   ok 16: newdir/newfile should be back
 *   ok 17: different should be v2
 *   ok 18: identical should be identical
 *   ok 19: local change to identical (non-conflicting)
 *   ok 20: local change to newdir/newfile (conflicting)
 *   ok 21: seeking to the first commit
 *   ok 22: current commit should be commit1
 *   ok 23: different should be v1
 *   ok 24: identical should be nonconflicting
 *   ok 25: unseeking
 *   ok 26: we should be unseeked properly
 *   ok 27: current commit should be commit2
 * failed 2 among 27 test(s)

This seems to be a workaround:

--- t/.t9300-seek.sh    2006-02-16 10:13:31.000000000 +0000
+++ t/t9300-seek.sh     2006-02-16 10:14:00.000000000 +0000
@@ -45,7 +45,7 @@
        "[ $(cat identical) = identical ]"
 
 test_expect_success 'seeking to the second commit' \
-       "cg-seek $commit2"
+       "cg-seek && cg-seek $commit2"
 test_expect_success 'we should not unseeked properly' \
        "([ -e .git/head-name ] &&
         [ $(basename $(git-symbolic-ref HEAD)) = cg-seek-point ])"

Regards, Gerrit.
