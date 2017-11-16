Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82562202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 15:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935787AbdKPPsU (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 10:48:20 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45753 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933811AbdKPPsT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 10:48:19 -0500
Received: by mail-wm0-f67.google.com with SMTP id 9so1119393wme.4
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 07:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDeVVMhh7b9qdmdye49rNuOIonG3GHIBq1HobiGckkY=;
        b=G5+Hl5w0kF4iSeb/zQZzmTx2dff5iNjST2w1MoaCVNRa9CjHXdfoMxxtnPpnvkIVxx
         TpmjpoCpCgyaZC5UIXl7OUC7QQ6J09FmKfEKNfCqhGq64WJDdNtKfdD6sfbRqaeOyK3q
         kWtPA0K0HoQ54gF19bxOzVf+bmJnlPI0QAjtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDeVVMhh7b9qdmdye49rNuOIonG3GHIBq1HobiGckkY=;
        b=F0BePhymaww2ChtBqnDzTTBLOsZBESSj5UrAnG86D7ME21bqkGkQKZvkpPZ7SDffa6
         oYyNqxhWELNX20puU/JvYCsD26FgAFcdhzaGQnUjp7cdVOUhXpJE3qP8pdFD4osu30l+
         puuAtlAbtd20NR05hdx1D7pzuWR9tveMaXRELSVP90DL99oY7nhkzgdL5MwG255U0QlV
         URufJiJS3YqARVUkZ2b4Ljy1rFxwYOPRFMLIO2VnQraYGvujN3WvYt/2MgsTV7vsCS6m
         11pOPxP7trShLESZglKdjJ2j4fXStFtDfM2evSPWL7iHEUTfJ58nzcMMa+ERfuVmfUaC
         wzJQ==
X-Gm-Message-State: AJaThX6w5NcrdHHTNS7abLHdimd9/rrdh3hAQ4WgsUV12Ch5vFxn1PN0
        PbZhPlYkp5fWp5nXHOtk3bvMow==
X-Google-Smtp-Source: AGs4zMYR4439Ysjvnps2cPj2jjxZRsDfHAlBFEamesCnFq6SIVayvZ9hNn4AsZ+ZaFUB+yKAkJl1uw==
X-Received: by 10.28.224.4 with SMTP id x4mr1790191wmg.118.1510847297973;
        Thu, 16 Nov 2017 07:48:17 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id w18sm1538829wra.30.2017.11.16.07.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 07:48:17 -0800 (PST)
Received: from zen.linaroharston (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTP id C04733E0260;
        Thu, 16 Nov 2017 15:48:16 +0000 (GMT)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] git-send-email: fix get_maintainer.pl regression
Date:   Thu, 16 Nov 2017 15:48:14 +0000
Message-Id: <20171116154814.23785-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Getting rid of Mail::Address regressed behaviour with common
get_maintainer scripts such as the Linux kernel. Fix the missed corner
case and add a test for it.

Fixes: cc9075067776ebd34cc08f31bf78bb05f12fd879

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 perl/Git.pm           |  3 +++
 t/t9000/test.pl       |  4 +++-
 t/t9001-send-email.sh | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index ffa09ace9..9b17de1cc 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -936,6 +936,9 @@ sub parse_mailboxes {
 			$end_of_addr_seen = 0;
 		} elsif ($token =~ /^\(/) {
 			push @comment, $token;
+		} elsif ($token =~ /^\)/) {
+		        my $nested_comment = pop @comment;
+			push @comment, "$nested_comment$token";
 		} elsif ($token eq "<") {
 			push @phrase, (splice @address), (splice @buffer);
 		} elsif ($token eq ">") {
diff --git a/t/t9000/test.pl b/t/t9000/test.pl
index dfeaa9c65..f10be50cd 100755
--- a/t/t9000/test.pl
+++ b/t/t9000/test.pl
@@ -35,7 +35,9 @@ my @success_list = (q[Jane],
 	q['Jane 'Doe' <jdoe@example.com>],
 	q[Jane@:;\.,()<>Doe <jdoe@example.com>],
 	q[Jane <jdoe@example.com> Doe],
-	q[<jdoe@example.com> Jane Doe]);
+	q[<jdoe@example.com> Jane Doe],
+	q[jdoe@example.com (open list:for thing (foo/bar))],
+    );
 
 my @known_failure_list = (q[Jane\ Doe <jdoe@example.com>],
 	q["Doe, Ja"ne <jdoe@example.com>],
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4d261c2a9..0bcd7ab96 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -172,6 +172,27 @@ test_expect_success $PREREQ 'cc trailer with various syntax' '
 	test_cmp expected-cc commandline1
 '
 
+test_expect_success $PREREQ 'setup get_mainter script for cc trailer' "
+cat >expected-cc-script.sh <<-EOF && chmod +x expected-cc-script.sh
+#!/bin/sh
+echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
+echo 'Two Person <two@example.com> (maintainer:THIS THING)'
+echo 'Third List <three@example.com> (moderated list:THIS THING (FOO/bar))'
+echo '<four@example.com> (moderated list:FOR THING)'
+echo 'five@example.com (open list:FOR THING (FOO/bar))'
+echo 'six@example.com (open list)'
+EOF
+"
+
+test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
+	test_commit cc-trailer &&
+	clean_fake_sendmail &&
+	git send-email -1 --to=recipient@example.com \
+		--cc-cmd="$(pwd)/expected-cc-script.sh" \
+		--smtp-server="$(pwd)/fake.sendmail" &&
+	test_cmp expected-cc commandline1
+'
+
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
-- 
2.15.0

