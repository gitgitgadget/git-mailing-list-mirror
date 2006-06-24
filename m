From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Fri, 23 Jun 2006 18:01:56 -0700
Message-ID: <7vejxf74e3.fsf@assigned-by-dhcp.cox.net>
References: <7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
	<7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
	<m1k678yt6m.fsf@ebiederm.dsl.xmission.com>
	<20060622220201.19132.67536.stgit@machine.or.cz>
	<7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
	<20060622235017.GH21864@pasky.or.cz>
	<7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
	<7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
	<20060623123904.GL21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 03:02:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtwXK-0004yx-DQ
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 03:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751AbWFXBB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 21:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933165AbWFXBB6
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 21:01:58 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39422 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932751AbWFXBB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 21:01:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624010157.CALF6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 21:01:57 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060623123904.GL21864@pasky.or.cz> (Petr Baudis's message of
	"Fri, 23 Jun 2006 14:39:04 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22462>

Petr Baudis <pasky@suse.cz> writes:

>> By the way, you also need to adjust the testsuite so that it
>> finds the Perl modules from freshly built tree before
>> installing.  I think (but haven't checked yet) the stuff written
>> in Python does that already, so you might want to mimic it.
>
> It should be enough to -I../perl/blib/lib -I../perl/blib/arch/auto/Git.

-- >8 --
[PATCH] Perl interface: add build-time configuration to allow building with -fPIC

On x86-64 it seems that Git.xs does not link without compiling
the main git objects with -fPIC.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Also I moved explanation of MOZILLA_SHA1 closer to other SHA1
   choices.

 Makefile |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 7842195..c42521e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,11 +1,6 @@
 # The default target of this Makefile is...
 all:
 
-# Define MOZILLA_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine coming from Mozilla. It is GPL'd and should be fast
-# on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
-# choice) has very fast version optimized for i586.
-#
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # This also implies MOZILLA_SHA1.
 #
@@ -37,6 +32,14 @@ #
 # Define ARM_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for ARM.
 #
+# Define MOZILLA_SHA1 environment variable when running make to make use of
+# a bundled SHA1 routine coming from Mozilla. It is GPL'd and should be fast
+# on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
+# choice) has very fast version optimized for i586.
+#
+# Define USE_PIC if you need the main git objects to be built with -fPIC
+# in order to build and link perl/Git.so.  x86-64 seems to need this.
+#
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
@@ -63,13 +66,13 @@ #
 # Define COLLISION_CHECK below if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
 # sufficient guarantee that no collisions between objects will ever happen.
-
+#
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
 # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
 # randomly break unless your underlying filesystem supports those sub-second
 # times (my ext3 doesn't).
-
+#
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-cache perspective.
 
@@ -450,6 +453,9 @@ else
 endif
 endif
 endif
+ifdef USE_PIC
+	ALL_CFLAGS += -fPIC
+endif
 ifdef NO_ACCURATE_DIFF
 	ALL_CFLAGS += -DNO_ACCURATE_DIFF
 endif
-- 
1.4.1.rc1.gf2641
