From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/4] t6302: also test annotated in addition to signed tags
Date: Sun,  6 Mar 2016 19:10:26 -0500
Message-ID: <1457309427-30124-4-git-send-email-sunshine@sunshineco.com>
References: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 01:11:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acilT-00082O-5E
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 01:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbcCGALI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 19:11:08 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34009 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbcCGALA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 19:11:00 -0500
Received: by mail-io0-f195.google.com with SMTP id z76so1307819iof.1
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 16:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cWB17mFfkjznfniFn1LnBMXBQrKkTqu+AlcWstlR1Gc=;
        b=X7o0YbmIZV8Ld7z5LP7VIktSPcc/5glUflx84sWlB/HDCo57eJB9Jn6idG9BEfUVRB
         6uWlc4nVFzKeYOO7OjZLp54LcMSq7X442+yNOUaVQqMK9X0R/CKL9Bd0vaxEyOuBubL0
         AcNOjvFMJiVmNeDRnG55aZ+QALdaLb3wj4oRIyO6deCmIehfCuSOj7UlXBOZTVPJ4VoM
         hNJs+1eAs0cTgaOrLHdGgpRGnF5V0udRQxBZ6f+nG9an+N6dQsBZjJ7hMeUzrg5kDYr1
         NdCPWm+Fl2EZx0iH7nzUYx9CxYCYuCwAa7U5oHhwvZbkj+vi/CiwBv0yxwOwZBD+aAyN
         yEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=cWB17mFfkjznfniFn1LnBMXBQrKkTqu+AlcWstlR1Gc=;
        b=S07W9z8vGHg5pH/wZSn6P7JU8eEdLwqj52cltr3iFDZcLuVbx0EEvhOLseKdfsfXnP
         xRIcuIdh/O7l3QwFkGgQ3Kcfq/lphKJGhLL7shHts93Pts54O2B6RBgV4gdEG4J05Zn6
         N2O7eoywkgdAxQl56KRxK38LCEEwXNlPLr8krpUY7rruG0TtJ9FbVgVnEYhmo03Hp8Bp
         JPt6AF8xWwsiHijmLjolivgDquYSZ3oMwWZws63dXlrRF/agCT5lm7FaEYXR8a21vHLG
         GB2ta6F2EXgKr+J3leOyTmByKSwQWiBuzLh+6ZCpqynC9LNDNTcDc9qXIL9PTm6RQ/dJ
         ys9A==
X-Gm-Message-State: AD7BkJL5DrsnrMaj7ZlGQ7J0s9hW8dPNR1gC8vMVFKTyyFiE9KAaOf3nyzR813008roHfQ==
X-Received: by 10.107.138.35 with SMTP id m35mr8182332iod.127.1457309459752;
        Sun, 06 Mar 2016 16:10:59 -0800 (PST)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id t62sm1337418ioi.41.2016.03.06.16.10.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 16:10:59 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc1.175.g19dcece
In-Reply-To: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288369>

It is conceivable, if not highly plausible, that a change to the
git-for-each-ref code that does the filtering and formatting can become
buggy because a payload with GPG signature looks somewhat different from
what is in an annotated but not signed tag. Thus, let's test unsigned
tags, as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Due either to pragmatism or laziness, I plagiarized Junio's v1 review
comment[1] for the commit message.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/285170

 t/t6302-for-each-ref-filter.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 54a7387..2e28559 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -17,6 +17,8 @@ test_expect_success 'setup some history and refs' '
 	test_commit three &&
 	git checkout -b side &&
 	test_commit four &&
+	git tag -m "An annotated tag" annotated-tag &&
+	git tag -m "Annonated doubly" doubly-annotated-tag annotated-tag &&
 	git tag -s -m "A signed tag" signed-tag &&
 	git tag -s -m "Signed doubly" doubly-signed-tag signed-tag &&
 	git checkout master &&
@@ -36,6 +38,7 @@ test_expect_success 'filtering with --points-at' '
 test_expect_success 'check signed tags with --points-at' '
 	sed -e "s/Z$//" >expect <<-\EOF &&
 	refs/heads/side Z
+	refs/tags/annotated-tag four
 	refs/tags/four Z
 	refs/tags/signed-tag four
 	EOF
@@ -58,6 +61,8 @@ test_expect_success 'filtering with --merged' '
 test_expect_success 'filtering with --no-merged' '
 	cat >expect <<-\EOF &&
 	refs/heads/side
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
 	refs/tags/doubly-signed-tag
 	refs/tags/four
 	refs/tags/signed-tag
@@ -71,6 +76,8 @@ test_expect_success 'filtering with --contains' '
 	refs/heads/master
 	refs/heads/side
 	refs/odd/spot
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
 	refs/tags/doubly-signed-tag
 	refs/tags/four
 	refs/tags/signed-tag
@@ -90,6 +97,8 @@ test_expect_success 'left alignment is default' '
 	refname is refs/heads/master  |refs/heads/master
 	refname is refs/heads/side    |refs/heads/side
 	refname is refs/odd/spot      |refs/odd/spot
+	refname is refs/tags/annotated-tag|refs/tags/annotated-tag
+	refname is refs/tags/doubly-annotated-tag|refs/tags/doubly-annotated-tag
 	refname is refs/tags/doubly-signed-tag|refs/tags/doubly-signed-tag
 	refname is refs/tags/four     |refs/tags/four
 	refname is refs/tags/one      |refs/tags/one
@@ -106,6 +115,8 @@ test_expect_success 'middle alignment' '
 	| refname is refs/heads/master |refs/heads/master
 	|  refname is refs/heads/side  |refs/heads/side
 	|   refname is refs/odd/spot   |refs/odd/spot
+	|refname is refs/tags/annotated-tag|refs/tags/annotated-tag
+	|refname is refs/tags/doubly-annotated-tag|refs/tags/doubly-annotated-tag
 	|refname is refs/tags/doubly-signed-tag|refs/tags/doubly-signed-tag
 	|  refname is refs/tags/four   |refs/tags/four
 	|   refname is refs/tags/one   |refs/tags/one
@@ -122,6 +133,8 @@ test_expect_success 'right alignment' '
 	|  refname is refs/heads/master|refs/heads/master
 	|    refname is refs/heads/side|refs/heads/side
 	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/annotated-tag|refs/tags/annotated-tag
+	|refname is refs/tags/doubly-annotated-tag|refs/tags/doubly-annotated-tag
 	|refname is refs/tags/doubly-signed-tag|refs/tags/doubly-signed-tag
 	|     refname is refs/tags/four|refs/tags/four
 	|      refname is refs/tags/one|refs/tags/one
@@ -137,6 +150,8 @@ cat >expect <<-\EOF
 |       refname is refs/heads/master       |refs/heads/master
 |        refname is refs/heads/side        |refs/heads/side
 |         refname is refs/odd/spot         |refs/odd/spot
+|    refname is refs/tags/annotated-tag    |refs/tags/annotated-tag
+|refname is refs/tags/doubly-annotated-tag |refs/tags/doubly-annotated-tag
 |  refname is refs/tags/doubly-signed-tag  |refs/tags/doubly-signed-tag
 |        refname is refs/tags/four         |refs/tags/four
 |         refname is refs/tags/one         |refs/tags/one
@@ -182,6 +197,8 @@ test_expect_success 'alignment with format quote' "
 	|'      '\''master| A U Thor'\''      '|
 	|'       '\''side| A U Thor'\''       '|
 	|'     '\''odd/spot| A U Thor'\''     '|
+	|'      '\''annotated-tag| '\''       '|
+	|'   '\''doubly-annotated-tag| '\''   '|
 	|'    '\''doubly-signed-tag| '\''     '|
 	|'       '\''four| A U Thor'\''       '|
 	|'       '\''one| A U Thor'\''        '|
@@ -198,6 +215,8 @@ test_expect_success 'nested alignment with quote formatting' "
 	|'         master               '|
 	|'           side               '|
 	|'       odd/spot               '|
+	|'  annotated-tag               '|
+	|'doubly-annotated-tag          '|
 	|'doubly-signed-tag             '|
 	|'           four               '|
 	|'            one               '|
@@ -214,6 +233,8 @@ test_expect_success 'check `%(contents:lines=1)`' '
 	master |three
 	side |four
 	odd/spot |three
+	annotated-tag |An annotated tag
+	doubly-annotated-tag |Annonated doubly
 	doubly-signed-tag |Signed doubly
 	four |four
 	one |one
@@ -230,6 +251,8 @@ test_expect_success 'check `%(contents:lines=0)`' '
 	master |
 	side |
 	odd/spot |
+	annotated-tag |
+	doubly-annotated-tag |
 	doubly-signed-tag |
 	four |
 	one |
@@ -246,6 +269,8 @@ test_expect_success 'check `%(contents:lines=99999)`' '
 	master |three
 	side |four
 	odd/spot |three
+	annotated-tag |An annotated tag
+	doubly-annotated-tag |Annonated doubly
 	doubly-signed-tag |Signed doubly
 	four |four
 	one |one
-- 
2.8.0.rc1.175.g19dcece
