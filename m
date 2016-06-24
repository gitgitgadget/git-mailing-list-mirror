Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF792018A
	for <e@80x24.org>; Fri, 24 Jun 2016 14:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbcFXONJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 10:13:09 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33934 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbcFXONI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 10:13:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id 66so9402452pfy.1
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 07:13:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9fMxhJZajcKQ/ikNOt8Z2+qgfGjerDPj0DAqL8Ep5D8=;
        b=q4OopCfIzvG56aYFRS5OExb3Q0ln2q+qmW3ZrWRG7/jPPjSnye7x2Ej08/q3GuqhB7
         YSC1JSm6dd8cyeWuA1w+6StSpXHVoz3AnPsa0ckM4f5ZD1VmuKQy3wO44VOmmWCVrth4
         4/aXKAQp+rPC757AVJ881IfrDA/yXhV55naD3Rjib6KCBinfpOcOF6T4kujcc+h087eM
         wnTkj/5RSftH8TEFF7rdE/dd1gKpxvI01meN4dL76TJLYr5zxdQrxbmEsOEhGc4Ebe6c
         P+QbNMV23z14vfvnY1TkXgwHCS+TRDqiJDb7UsEXarKgGLIoURc57nL0F05/GMghRrT5
         5vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9fMxhJZajcKQ/ikNOt8Z2+qgfGjerDPj0DAqL8Ep5D8=;
        b=Q9VPfvC6USSZm8w84AZu6o/Q8zSWY2GFW77VO39dAYVy2bpBwCimgKY8O7v6o5sSkB
         ECDO6cPtsdSOSwcB7Wc76WUoVrYrAeEoof1O690uj3SZcQ/mE40SdX+HaifxQbGJSDwX
         uXxFFGIgi50LwTDJJvebUsY0etU5vBkJdFAg68ovv7wmxlCt4qUvctNZWxtcuUB/Bdcs
         dHrq6KX5yBEA8wh8z1BEyFDQR8c97J3IWZz6eOfz0alQA1uWdxXzKJS8SgqJAWo4uDuY
         tfGIKezB+XVOJNE7aqJxNhutxR9jdbRCOWSW3CNIXo0ko9ZmM1tlibjGnc+Q3PQznvbg
         sNJA==
X-Gm-Message-State: ALyK8tK4IC/zIDNvC7/TLW7dOrlESht18QcPHzCo5y07kCRVoykLiFdJ4ceJabEUQWp0mQ==
X-Received: by 10.98.208.197 with SMTP id p188mr7780058pfg.152.1466777587241;
        Fri, 24 Jun 2016 07:13:07 -0700 (PDT)
Received: from localhost.localdomain ([223.183.227.25])
        by smtp.gmail.com with ESMTPSA id y70sm566172pff.25.2016.06.24.07.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 07:13:06 -0700 (PDT)
From:	Mehul Jain <mehul.jain2029@gmail.com>
To:	git@vger.kernel.org
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v3 1/3] t4202: refactor test
Date:	Fri, 24 Jun 2016 19:42:34 +0530
Message-Id: <20160624141234.22836-1-mehul.jain2029@gmail.com>
X-Mailer: git-send-email 2.9.0.rc0.dirty
In-Reply-To: <20160622165126.12786-2-mehul.jain2029@gmail.com>
References: <20160622165126.12786-2-mehul.jain2029@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Subsequent patches will want to reuse the 'signed' branch that the
'log --graph --show-signature' test creates and uses.

Split the set-up part into a test of its own, and make the existing
test into a separate one that only inspects the history on the 'signed'
branch. This way, it becomes clearer that tests added by subsequent
patches reuse the 'signed' branch in the same way.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t4202-log.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 128ba93..ab66ee0 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -860,12 +860,15 @@ test_expect_success 'dotdot is a parent directory' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'log --graph --show-signature' '
+test_expect_success GPG 'setup signed branch' '
 	test_when_finished "git reset --hard && git checkout master" &&
 	git checkout -b signed master &&
 	echo foo >foo &&
 	git add foo &&
-	git commit -S -m signed_commit &&
+	git commit -S -m signed_commit
+'
+
+test_expect_success GPG 'log --graph --show-signature' '
 	git log --graph --show-signature -n1 signed >actual &&
 	grep "^| gpg: Signature made" actual &&
 	grep "^| gpg: Good signature" actual
-- 
2.9.0.rc0.dirty

