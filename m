From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v2 2/2] git-web--browser: avoid errors in terminal when running Firefox on Windows
Date: Sat, 26 Jan 2013 04:40:33 +0400
Message-ID: <b62d19fa972caa17054502168ae4d153c05b0363.1359160531.git.Alex.Crezoff@gmail.com>
References: <cover.1359160531.git.Alex.Crezoff@gmail.com>
Cc: Jeff King <peff@peff.net>, Alexey Shumkin <Alex.Crezoff@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 01:41:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tytpl-00013E-Kt
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 01:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab3AZAlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 19:41:03 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:49100 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab3AZAk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 19:40:57 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so169394lab.9
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 16:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=pp/9ypGRrvLJ2TXgQxMiky893byXGvJHirnB3+UOZa8=;
        b=GANV6w6HACO9hncx4kWOECOq+HiQkD4szezH5JtsAJhZD7RBpSClgm6PX855DsMNPG
         pqLIFbSPPa55Z4A5hFNtItF2gNA3pl+Ixs/+lox85tbwfUIfNNUCR+jR4W/MsNqXMATc
         EGMJNKneiz9A8X1joUVWga0vNgazSjNza7+8HvhbMurFlWca3dEF+vCMPYNECEF4AGT2
         Jb1LRAtWA1unMXzCkiCpAtWM3fZPbWG+Ojz59+f2pNdIpAum3Ss2Q4hiWLf3oiW2aM97
         HUCc9df9V7HqyuiC16seRvjK1+NaxEB1xOiLsf7jm6p7ZXIau7SHC6JxDD5RtlPWAFsL
         0Fhw==
X-Received: by 10.112.38.228 with SMTP id j4mr2436645lbk.1.1359160855566;
        Fri, 25 Jan 2013 16:40:55 -0800 (PST)
Received: from ds212plus (ppp91-77-32-144.pppoe.mtu-net.ru. [91.77.32.144])
        by mx.google.com with ESMTPS id ie3sm1029213lab.4.2013.01.25.16.40.53
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 16:40:54 -0800 (PST)
Received: from localhost.localdomain (unknown [192.168.1.5])
	by ds212plus (Postfix) with ESMTPS id C2B3860197;
	Sat, 26 Jan 2013 04:41:38 +0400 (MSK)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.14.5/8.14.5) with ESMTP id r0Q0efIY010005;
	Sat, 26 Jan 2013 04:40:41 +0400
Received: (from alex@localhost)
	by localhost.localdomain (8.14.5/8.14.5/Submit) id r0Q0efKx010004;
	Sat, 26 Jan 2013 04:40:41 +0400
X-Mailer: git-send-email 1.8.1.1.10.g71fa0b7
In-Reply-To: <cover.1359160531.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1359160531.git.Alex.Crezoff@gmail.com>
References: <7v1ud93uw8.fsf@alter.siamese.dyndns.org> <cover.1359160531.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214602>

Firefox on Windows by default is placed in "C:\Program Files\Mozilla Firefox"
folder, i.e. its path contains spaces. Before running this browser "git-web--browse"
tests version of Firefox to decide whether to use "-new-tab" option or not.

Quote browser path to avoid error during this test.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Reviewed-by: Jeff King <peff@peff.net>
---
 git-web--browse.sh         |  2 +-
 t/t9901-git-web--browse.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 1e82726..f96e5bd 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -149,7 +149,7 @@ fi
 case "$browser" in
 firefox|iceweasel|seamonkey|iceape)
 	# Check version because firefox < 2.0 does not support "-new-tab".
-	vers=$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)\..*')
+	vers=$(expr "$("$browser_path" -version)" : '.* \([0-9][0-9]*\)\..*')
 	NEWTAB='-new-tab'
 	test "$vers" -lt 2 && NEWTAB=''
 	"$browser_path" $NEWTAB "$@" &
diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
index b0dabf7..c1ee813 100755
--- a/t/t9901-git-web--browse.sh
+++ b/t/t9901-git-web--browse.sh
@@ -8,8 +8,23 @@ This test checks that git web--browse can handle various valid URLs.'
 . ./test-lib.sh
 
 test_web_browse () {
-	# browser=$1 url=$2
+	# browser=$1 url=$2 sleep_timeout=$3
+	sleep_timeout="$3"
+	rm -f fake_browser_ran &&
 	git web--browse --browser="$1" "$2" >actual &&
+	# if $3 is set
+	# as far as Firefox is run in background (it is run with &)
+	# we trying to avoid race condition
+	# by waiting for "$sleep_timeout" seconds of timeout for 'fake_browser_ran' file appearance
+	if test -n "$sleep_timeout"
+	then
+	    for timeout in $(test_seq $sleep_timeout)
+		do
+			test -f fake_browser_ran && break
+			sleep 1
+		done
+		test $timeout -ne $sleep_timeout
+	fi &&
 	tr -d '\015' <actual >text &&
 	test_cmp expect text
 }
@@ -46,6 +61,42 @@ test_expect_success \
 '
 
 test_expect_success \
+	'Paths are properly quoted for Firefox. Version older then v2.0' '
+	echo "fake: http://example.com/foo" >expect &&
+	write_script "fake browser" <<-\EOF &&
+
+	if test "$1" = "-version"; then
+		echo "Fake Firefox browser version 1.2.3"
+	else
+		# Firefox (in contrast to w3m) is run in background (with &)
+		# so redirect output to "actual"
+		echo "fake: ""$@" >actual
+	fi
+	: >fake_browser_ran
+	EOF
+	git config browser.firefox.path "$(pwd)/fake browser" &&
+	test_web_browse firefox http://example.com/foo 5
+'
+
+test_expect_success \
+	'Paths are properly quoted for Firefox. Version v2.0 and above' '
+	echo "fake: -new-tab http://example.com/foo" >expect &&
+	write_script "fake browser" <<-\EOF &&
+
+	if test "$1" = "-version"; then
+		echo "Fake Firefox browser version 2.0.0"
+	else
+		# Firefox (in contrast to w3m) is run in background (with &)
+		# so redirect output to "actual"
+		echo "fake: ""$@" >actual
+	fi
+	: >fake_browser_ran
+	EOF
+	git config browser.firefox.path "$(pwd)/fake browser" &&
+	test_web_browse firefox http://example.com/foo 5
+'
+
+test_expect_success \
 	'browser command allows arbitrary shell code' '
 	echo "arg: http://example.com/foo" >expect &&
 	git config browser.custom.cmd "
-- 
1.8.1.1.10.g71fa0b7
