From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/6] t1500: test_rev_parse: facilitate future test enhancements
Date: Tue, 10 May 2016 01:20:50 -0400
Message-ID: <20160510052055.32924-2-sunshine@sunshineco.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:21:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0077-0003ga-49
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 07:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbcEJFVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 01:21:33 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33315 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbcEJFVc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 01:21:32 -0400
Received: by mail-io0-f194.google.com with SMTP id x35so415327ioi.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 22:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qvNNNh2uuTqYXBI78yhu88WI8YEmdlFyjsN/FWiR7UE=;
        b=I+9QI50vIbkncIeMtAdoWSf2jRdTot3S910YRBnRK3DUUD1oFRQTG+oDPBeUgAUM2O
         BUzYz1TH204OWOuUWj4wzwboOZVcnFY71csNtrQ37ZPq583eApmEdP8B0dF6n5+QsT2B
         cMeZ5huCWWiM0MUUqvpD+os0o/HUtc11zExEu2uM1lPzy10aEiyR7UsdgRZX2EW0kJsY
         g9L/qwxk/FcGSQKxN9tfC7qmcyNMewsHhkY6ITERTUY1vOZMB0MjInqVO7i6Kal7po1h
         P4idPsB77oI0nWt8Ee41xG1ZgmN74hDEMEdxq66lPGoacUoUh6poOuRCw62Wk6+gXJnG
         yFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=qvNNNh2uuTqYXBI78yhu88WI8YEmdlFyjsN/FWiR7UE=;
        b=Bx4F3OsVCeU2FUyRvg8NqFrXVSFnBV37sRmJ/j//9vwjs5ldD68a3gsZbUjwtoZhKF
         4l5Q2jiuDP9MXAbPsfLM1gjH4lKeLaPZw59l4S58xK9on9RUSBHwdVYA0AIrBhrYfuBh
         DNeY4WMthwpSGk/jEzktOWZTFCHEZWRlNVV+amyjgFPys4VhS/gexcCuz4fYDeVPdxPQ
         tSffUmydvoAyS+1RdhwhVPRsKuHa8pQtW9MhO9LihiJjBLDug1lMzWbO9q9mppioTv0l
         HC88g9e61RwUQzIJIgP9OyXpsEviygjCCiexopw1nMDYGP5AntBoDg2xObYzVoB1fwJr
         RA0A==
X-Gm-Message-State: AOPr4FV7fcSF4BwQUIhbS/d+WBxep7eo9JHWEYICv47MgImFBd1eGztCSIlFYUbr+regtQ==
X-Received: by 10.107.160.5 with SMTP id j5mr15408153ioe.42.1462857691881;
        Mon, 09 May 2016 22:21:31 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id vu8sm458336igb.1.2016.05.09.22.21.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 May 2016 22:21:31 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.530.g51d527d
In-Reply-To: <20160510052055.32924-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294092>

Tests run by test_rev_parse() are nearly identical; each invokes
git-rev-parse with a single option and compares the result against an
expected value. Such duplication makes it onerous to extend the tests
since any change needs to be repeated in each test. Reduce the
duplication by parameterizing the test and driving it via a for-loop.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 48ee077..03f22fe 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -3,38 +3,28 @@
 test_description='test git rev-parse'
 . ./test-lib.sh
 
-test_rev_parse() {
+# usage: label is-bare is-inside-git is-inside-work prefix git-dir
+test_rev_parse () {
 	name=$1
 	shift
 
-	test_expect_success "$name: is-bare-repository" \
-	"test '$1' = \"\$(git rev-parse --is-bare-repository)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: is-inside-git-dir" \
-	"test '$1' = \"\$(git rev-parse --is-inside-git-dir)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: is-inside-work-tree" \
-	"test '$1' = \"\$(git rev-parse --is-inside-work-tree)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: prefix" \
-	"test '$1' = \"\$(git rev-parse --show-prefix)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: git-dir" \
-	"test '$1' = \"\$(git rev-parse --git-dir)\""
-	shift
-	[ $# -eq 0 ] && return
+	for o in is-bare-repository \
+		 is-inside-git-dir \
+		 is-inside-work-tree \
+		 show-prefix \
+		 git-dir
+	do
+		expect="$1"
+		test_expect_success "$name: $o" '
+			echo "$expect" >expect &&
+			git rev-parse --$o >actual &&
+			test_cmp expect actual
+		'
+		shift
+		test $# -eq 0 && break
+	done
 }
 
-# label is-bare is-inside-git is-inside-work prefix git-dir
-
 ROOT=$(pwd)
 
 test_rev_parse toplevel false false true '' .git
-- 
2.8.2.530.g51d527d
