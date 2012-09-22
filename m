From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Sat, 22 Sep 2012 09:56:04 +0530
Message-ID: <CALkWK0kxmD_HJtnV0ShSdpgSjoLQHtv0=b4s=utG52zFLb2Bjg@mail.gmail.com>
References: <505CCA55.6030609@gmail.com> <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net> <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
 <20120921211217.GA24134@sigill.intra.peff.net> <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
 <m2k3vn9gyu.fsf@igel.home> <7vhaqr3t6j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 06:26:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHIZ-0005vq-5m
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab2IVE00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 00:26:26 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:58712 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab2IVE0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:26:25 -0400
Received: by qcro28 with SMTP id o28so3126232qcr.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 21:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rN7vhOdlg5dWrla2IwmOLb17VPaiLftSfmCQBXBpWrI=;
        b=tubEU5LI7LaaN9GtNNw12reG8TLmFkW/3A6mMSkDIG3sjD7upxB+fpSQQQ3qTe8jpD
         A5cs/VZaSQ9Bwu7MQS8u5wlTg08fPPadCFhvLm3nCAYNibkfqxMoJWMaLyu4+4B9ApQx
         uMnH7YjZpXFrPpOviOE3LTpzmnWhB2tQD4vXSNWmJrzZ6R4VaXfNdil+5VndG4XAMwF1
         pCeBhVJQjdbXktWX1cPJVZWvDJSxcojpGW2DIKb+8YFx/qYgL3d4Q63m/2v510ZAlDwG
         +Yk6ps5MRr1DGu9YEVMIU1f9dZFN78bODwba2wcWPFGCLQizIS1upVFyxWMV230d58CN
         bysw==
Received: by 10.224.58.147 with SMTP id g19mr17001768qah.77.1348287984738;
 Fri, 21 Sep 2012 21:26:24 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Fri, 21 Sep 2012 21:26:04 -0700 (PDT)
In-Reply-To: <7vhaqr3t6j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206187>

Hi Junio,

Junio C Hamano wrote:
> The reference to ${SHELL-/bin/sh} in the test need to be updated to
> SHELL_PATH as Peff suggested in the other subthread.

For that, the entire block needs to be moved down to come after `.
GIT_BUILD_DIR="$TEST_DIRECTORY"/..`.  Is this okay?

diff --git a/t/test-lib.sh b/t/test-lib.sh
index dfa86e4..2284b8b 100644
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
