From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/5] modernize t1500
Date: Wed, 18 May 2016 16:15:40 -0400
Message-ID: <20160518201545.9113-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 22:16:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b37t6-0006tS-9h
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 22:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbcERUQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 16:16:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34987 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcERUQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 16:16:06 -0400
Received: by mail-io0-f194.google.com with SMTP id i75so11525453ioa.2
        for <git@vger.kernel.org>; Wed, 18 May 2016 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=/dnmM+JLAPCUJuA+1JHN8yITlL3PrtU8yFo7DLW2XTg=;
        b=vyeLGnIqNN7GA1za8RFVQ4Wz43S9ObOl6liCCh22YW3jLt1WV43BSEysg7agDcNsJJ
         pTCkwh444GC3Y7H25LUTZXU0FYSa3JjYA/TdT3ZaGr3wUr/tVCvFWnaBnHBO41Kiv1RX
         efdJSBprVbMkg7RDwGPyHsyF8VJdKtIRNSm9JNwrKAi1NuIzh6yZF6fwra52TGcDDO6v
         SiDcMNADqIo8kx3aDzPxb7bxPW+Jq50Z7s8k5wPu3GpViHDYXIB26Cw/6e9FfVZ+nxhk
         YMQpEwNO9kDzU5ZIux6PucJXUeaLx+GBL2sPug5HIIhdBZ6aTEpC+7lgIDf7FAHCyOkN
         LhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=/dnmM+JLAPCUJuA+1JHN8yITlL3PrtU8yFo7DLW2XTg=;
        b=XJ2IFaUGTETyLqUuMzOqT1IX2mkL+uRwtOdXzso7ZZ3+OCChGujHyP2FVFtezdReFS
         xIqZG+5PYmXuPHDKAcMjqDbvw8geJ50huQ+X/M2Wmt7shDLxLmyjt7kat8A9d8JHIvTn
         YjQ1Q13+sDjkHLiedhogp+p8D/Fz4oFe3oQsBqeCS2IDIU2UFYR06jMUPOT5UxDJQvgc
         KhSqRKpN5XyJPVUXgZK3v4O1uAmE3JeZA4ZU1r5wXE4L2BX2dlLOVHMV9RF2PP3uaZql
         q6b96CnwuQAmYRvOk0GO466wKaKEH4718UI0+mc2Sazn36orT/xvBFPvpnI6Tg+yk5e6
         8a6Q==
X-Gm-Message-State: AOPr4FVMueba1TBy9BbaNDb730s1Skz3gHvKXNzetPqtKeEiPV5YESPi9pQmlHP653K/Kw==
X-Received: by 10.36.207.137 with SMTP id y131mr20400676itf.32.1463602565017;
        Wed, 18 May 2016 13:16:05 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id q15sm3241137iod.6.2016.05.18.13.16.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 13:16:02 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.748.g927f425
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294999>

This is a re-roll of [1] which modernizes t1500 by updating tests to set
up their own needed state rather than relying upon manipulation of
global state.

Changes since v2[1]:

Avoid POSIX ${dir:+-C "$dir"} since some older broken shells incorrectly
expand this to a single argument ("-C <dir>") rather than the expected
two (-C and "<dir>"). Thanks to Peff and SZEDER for providing links to
previous reports of this problem[2][3].

Include the leading dashes in option names iterated over by the for-loop
in test_rev_parse() to potentially make it easier for some future change
to specify multiple options at once to git-rev-parse (SZEDER's
example[4] was "git rev-parse --absolute-path --git-dir").

A v2 to v3 interdiff is included below.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/294902
[2]: http://thread.gmane.org/gmane.comp.version-control.git/294902/focus=294916
[3]: http://thread.gmane.org/gmane.comp.version-control.git/294902/focus=294923
[4]: http://thread.gmane.org/gmane.comp.version-control.git/294902/focus=294971

Eric Sunshine (5):
  t1500: be considerate to future potential tests
  t1500: test_rev_parse: facilitate future test enhancements
  t1500: avoid changing working directory outside of tests
  t1500: avoid setting configuration options outside of tests
  t1500: avoid setting environment variables outside of tests

 t/t1500-rev-parse.sh | 123 ++++++++++++++++++++++++++-------------------------
 1 file changed, 63 insertions(+), 60 deletions(-)

--- >8 ---
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 39af565..038e24c 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -5,13 +5,13 @@ test_description='test git rev-parse'
 
 # usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir
 test_rev_parse () {
-	dir=
+	d=
 	bare=
 	gitdir=
 	while :
 	do
 		case "$1" in
-		-C) dir="$2"; shift; shift ;;
+		-C) d="$2"; shift; shift ;;
 		-b) case "$2" in
 		    [tfu]*) bare="$2"; shift; shift ;;
 		    *) error "test_rev_parse: bogus core.bare value '$2'" ;;
@@ -25,11 +25,11 @@ test_rev_parse () {
 	name=$1
 	shift
 
-	for o in is-bare-repository \
-		 is-inside-git-dir \
-		 is-inside-work-tree \
-		 show-prefix \
-		 git-dir
+	for o in --is-bare-repository \
+		 --is-inside-git-dir \
+		 --is-inside-work-tree \
+		 --show-prefix \
+		 --git-dir
 	do
 		test $# -eq 0 && break
 		expect="$1"
@@ -42,13 +42,13 @@ test_rev_parse () {
 			fi &&
 
 			case "$bare" in
-			t*) test_config ${dir:+-C "$dir"} core.bare true ;;
-			f*) test_config ${dir:+-C "$dir"} core.bare false ;;
-			u*) test_unconfig ${dir:+-C "$dir"} core.bare ;;
+			t*) test_config ${d:+-C} ${d:+"$d"} core.bare true ;;
+			f*) test_config ${d:+-C} ${d:+"$d"} core.bare false ;;
+			u*) test_unconfig ${d:+-C} ${d:+"$d"} core.bare ;;
 			esac &&
 
 			echo "$expect" >expect &&
-			git ${dir:+-C "$dir"} rev-parse --$o >actual &&
+			git ${d:+-C} ${d:+"$d"} rev-parse $o >actual &&
 			test_cmp expect actual
 		'
 		shift
--- >8 ---

-- 
2.8.2.748.g927f425
