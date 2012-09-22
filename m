From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Sat, 22 Sep 2012 10:27:01 +0530
Message-ID: <CALkWK0kWJ3ndEMGzyGGMEa+ko3BTShC7_o-HVsXzFCGwRem5Jw@mail.gmail.com>
References: <505CCA55.6030609@gmail.com> <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net> <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
 <20120921211217.GA24134@sigill.intra.peff.net> <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
 <m2k3vn9gyu.fsf@igel.home> <7vhaqr3t6j.fsf@alter.siamese.dyndns.org>
 <CALkWK0kxmD_HJtnV0ShSdpgSjoLQHtv0=b4s=utG52zFLb2Bjg@mail.gmail.com>
 <7vwqzm3bhf.fsf@alter.siamese.dyndns.org> <CALkWK0nTWQ3g75fN5wQLwgeW986vAzGdXajSGCY5SdpK8W=0aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 06:57:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHmV-00012z-TY
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab2IVE5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 00:57:23 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:35970 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2IVE5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:57:22 -0400
Received: by qaas11 with SMTP id s11so1789235qaa.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 21:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Dnj0euSoFaKa9yRe0vFvTcV+ScYStGkFmxlUM4FIx08=;
        b=cbyXj9YPseICZx4fqAfeSMeM8goH6zgbxTcdl+XBRuMLk/jpvC20yQPrEU7iqGtYBM
         Oqu3VP+M+p6jFbey7CoVSTvF7/r+lOrEMS8E8+0FfDHEogKgwq0WOx+dfUh3Qb5usbCV
         V3RWWtLuKPv1d89c90IceF+ECiOzypCeE3a+onH6rX997g1EKQKTA5Y+v0IGc1M/7LGG
         7/HXEhGkAMEx13PPNvGtj4fyW4k/ve6529JF+P9fMM55oRAiA91lOffBPhE4vPk9zK8A
         4UTp6uTifif+2ICfqgQFYpXxOz0MGhn+TjJx//VlHxiAi3RkX5oteZlK0nfA3wwxdIq0
         3tmg==
Received: by 10.229.136.17 with SMTP id p17mr4715185qct.86.1348289841970; Fri,
 21 Sep 2012 21:57:21 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Fri, 21 Sep 2012 21:57:01 -0700 (PDT)
In-Reply-To: <CALkWK0nTWQ3g75fN5wQLwgeW986vAzGdXajSGCY5SdpK8W=0aA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206192>

Here's a patch.

-- 8< --
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Sat, 22 Sep 2012 10:25:10 +0530
Subject: [PATCH] test-lib: do not trust $SHELL

Do not trust $SHELL to be a bourne-compatible shell.  Instead, use the
Makefile variable $SHELL_PATH.  This fixes a bug: when a test was run
with --tee and $SHELL was set to ZSH, $PATH on line 479 was not
getting split due to ZSH not respecting $IFS.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/test-lib.sh | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f8e3733..798bf93 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -15,22 +15,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .

-# if --tee was passed, write the output not only to the terminal, but
-# additionally to the file test-results/$BASENAME.out, too.
-case "$GIT_TEST_TEE_STARTED, $* " in
-done,*)
-	# do not redirect again
-	;;
-*' --tee '*|*' --va'*)
-	mkdir -p test-results
-	BASE=test-results/$(basename "$0" .sh)
-	(GIT_TEST_TEE_STARTED=done ${SHELL-sh} "$0" "$@" 2>&1;
-	 echo $? > $BASE.exit) | tee $BASE.out
-	test "$(cat $BASE.exit)" = 0
-	exit
-	;;
-esac
-
 # Keep the original TERM for say_color
 ORIGINAL_TERM=$TERM

@@ -54,6 +38,22 @@ GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 export PERL_PATH SHELL_PATH

+# if --tee was passed, write the output not only to the terminal, but
+# additionally to the file test-results/$BASENAME.out, too.
+case "$GIT_TEST_TEE_STARTED, $* " in
+done,*)
+	# do not redirect again
+	;;
+*' --tee '*|*' --va'*)
+	mkdir -p test-results
+	BASE=test-results/$(basename "$0" .sh)
+	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
+	 echo $? > $BASE.exit) | tee $BASE.out
+	test "$(cat $BASE.exit)" = 0
+	exit
+	;;
+esac
+
 # For repeatability, reset the environment to known value.
 LANG=C
 LC_ALL=C
-- 
1.7.12.GIT
