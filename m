Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304CCC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 11:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F06613AB
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 11:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhHXLmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbhHXLmm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 07:42:42 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FF8C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 04:41:58 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id b1so16498124qtx.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cD7ELZ5+3lU55taEmnhE1ySROemRT1Z9rI2D4RdcK4c=;
        b=hFdFCuTEH3WXpfJ30aQbPelVtOjIUV3kuJASSdV+eV9TNMOmLHYJtdD5kmHzJdOdui
         V8vUQCekNnZxuqWEftn3wTSiX9RiCInk2dLaUIACNjOtq9FhJ9XKdGq5dzZzlqmc0qMS
         Kn1ti74jLWEUy3Yzwh+QIHu+Mh87xzYsYQlWZyjeNzWEmqpntzslCcwMIY6yhYkxcXY5
         6oR/aLp9onyChh+9/Fc/uXQkTUKWHOyDOI5J3Vj9y4yu50RAWN83+TYjIr1No6B19tqP
         eafB9FzBNP1amM8TzZYSU7+UEM62LYZscOb+6bJYy4TDhUv3s52FC+skpuE9TgVErFdu
         3oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cD7ELZ5+3lU55taEmnhE1ySROemRT1Z9rI2D4RdcK4c=;
        b=FX1rNmHyFfQbmQe7vVclUEnumUTXgqH2XP8QLJY8Lsnj2oJMBiDf8vhAUQmKCtpDgV
         xWZ2gYp8NydFVpGNd1jK7CQWi2p+t5FBY0nFVNvhdVg4VN2S24oe2dQvNeOyu7PSVz42
         v59upiFki2mgT8o+NYWMjqL7Qu/Tz4uc2EWtnDtMqxTczuC5qT+T2QpKJFzgzIxFPg/1
         02YsinDqUGRtauJAW9bfe2/dpRrUUc9W/7Ewjzel7tA23ZN0H6jRkqKKnr011lC0kXL3
         EmAiR+twcc1V3wISMPf1ue74nQWXwsYKdyXh9imV+fAhRDpMNKMuP1r/2EeXAwEB/Wxs
         Ax/g==
X-Gm-Message-State: AOAM5318Vpnr+bXt925sk2lvMAWiL1y53SvfyUDpWmFOiK0DXyAur4AT
        gFIWfjP5YSv4XxXNxe/SNfjfWXTQqU0=
X-Google-Smtp-Source: ABdhPJwKl2Ke6jAIgJdhA82o+krqbsHfq2RHeD/elTHkQbSHpeFn4pV/jHRNITw2Pk2gUJMnODuNuA==
X-Received: by 2002:a05:622a:1a8c:: with SMTP id s12mr33463526qtc.232.1629805316913;
        Tue, 24 Aug 2021 04:41:56 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o12sm8373971qtt.94.2021.08.24.04.41.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 04:41:56 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     tr@thomasrast.ch, mhaeuser@posteo.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH] send-email: allow fixing the cover letter subject
Date:   Tue, 24 Aug 2021 04:41:35 -0700
Message-Id: <20210824114135.54810-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

a03bc5b6ad (send-email: Refuse to send cover-letter template
subject, 2009-06-08) fixes a common problem with the direct use
of `git send-email` to send topics, where the cover letter will
be a template by accident.

Allow using --subject to fix the --cover-letter subject and skip
the safety check without having to use --force.

Note that the use of --compose is also allowed, and will also
get its Subject set through the commandline, but it might make
more sense to instead make them incompatible and force editing
the cover letter instead, hence why sending this only as a RFC.

patch is based on another one[1] still in fly, and the documentation
change is long overdue, but probably should need a better
explanation; lastly using a non ASCII subject also needs fixing,
but it also affects compose, so was left out for now.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>

[1] https://lore.kernel.org/git/4db7759c-2123-533b-9f89-954c07f5832a@posteo.de/
---
 Documentation/git-send-email.txt |  3 +--
 git-send-email.perl              |  8 ++++++--
 t/t9001-send-email.sh            | 16 +++++++++++++++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab4ba..9d2bfa6095 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -113,8 +113,7 @@ is not set, this will be prompted for.
 
 --subject=<string>::
 	Specify the initial subject of the email thread.
-	Only necessary if --compose is also set.  If --compose
-	is not set, this will be prompted for.
+	Only necessary if --compose or --cover-letter are also set.
 
 --to=<address>,...::
 	Specify the primary recipient of the emails generated. Generally, this
diff --git a/git-send-email.perl b/git-send-email.perl
index fd79849530..a33328a5d9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -997,7 +997,7 @@ sub file_declares_8bit_cte {
 				  default => "UTF-8");
 }
 
-if (!$force) {
+if (!$force and not defined $initial_subject) {
 	for my $f (@files) {
 		if (get_patch_subject($f) =~ /\Q*** SUBJECT HERE ***\E/) {
 			die sprintf(__("Refusing to send because the patch\n\t%s\n"
@@ -1719,7 +1719,6 @@ sub process_file {
 	@xh = ();
 	my $input_format = undef;
 	my @header = ();
-	$subject = $initial_subject;
 	$message = "";
 	$message_num++;
 	# First unfold multiline header fields
@@ -1747,6 +1746,11 @@ sub process_file {
 		if (defined $input_format && $input_format eq 'mbox') {
 			if (/^Subject:\s+(.*)$/i) {
 				$subject = $1;
+
+				if (defined $initial_subject &&
+				$subject =~ /\Q*** SUBJECT HERE ***\E/) {
+					$subject = $initial_subject;
+				}
 			}
 			elsif (/^From:\s+(.*)$/i) {
 				($author, $author_encoding) = unquote_rfc2047($1);
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 747872d5be..043532fe85 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1728,7 +1728,6 @@ test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=base64' '
 	test_cmp expected actual
 '
 
-
 # Note that the patches in this test are deliberately out of order; we
 # want to make sure it works even if the cover-letter is not in the
 # first mail.
@@ -1765,6 +1764,21 @@ test_expect_success $PREREQ '--force sends cover letter template anyway' '
 	test -n "$(ls msgtxt*)"
 '
 
+test_expect_success $PREREQ '--subject can be used to fix the cover letter' '
+	clean_fake_sendmail &&
+	git send-email \
+		--cover-letter -2 \
+		--subject="foo" \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		2>errors >out &&
+	! grep "SUBJECT HERE" errors &&
+	ls msgtxt* >list &&
+	test_line_count = 3 list &&
+	grep "Subject: foo" msgtxt1
+'
+
 test_cover_addresses () {
 	header="$1"
 	shift
-- 
2.33.0.481.g26d3bed244

