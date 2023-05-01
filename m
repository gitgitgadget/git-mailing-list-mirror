Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B8CC77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 14:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjEAOjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 10:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjEAOj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 10:39:27 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D438B10E0
        for <git@vger.kernel.org>; Mon,  1 May 2023 07:39:01 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75131c2997bso1344442685a.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682951936; x=1685543936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQHm0C4HjEJeGBwPvx2bSNuhy/h/gBfdGETU86/hEWA=;
        b=p51FKQW7nSHYZqN4pp44btv9q7nRHm99Zo7aI57gI66Aeq75Xs0j5b0v1NpLPsaQrM
         gVDb/sJdVk78f4tV3pyHj4lBnR133RaBklzqJwobquI9B3RpIXImf1BHGGrWy+N1Q5OV
         BskVeE5P1CdtiYK+bdKZRT3FyqAJD2Sw0R4n7dOgeENxa6Kn08YBe462qVlJB4aqHfb1
         bgIUgvgmH5pdSN/1S4ibwYcNSt0WghU71MME3X+UBW8sVeeYGdeVcLIvwhi2zTTrkONR
         5PONyjhC9Jb/NU3jd8UwjxL1qfwCJ2zmhq1X97yIR/M3C7VsWDNqB8iY/pObq2JPVTO0
         zwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682951936; x=1685543936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQHm0C4HjEJeGBwPvx2bSNuhy/h/gBfdGETU86/hEWA=;
        b=XsiapGm1dR6RfbPZw4je+Eu4PKO8WG/yC9MWWfzVOyLNA/EMK+Xo4v+8PLQAaDNSQF
         HSp4VojpNc1CGgvmI/E0P+jp2PHRnhtFEl1SSHFc9I2w/HzEfqEb6eImw2hwneQW5F8j
         WgMck8JzN8lPDTjSEKdwy2WShgcAbFkDAOkxiBHvQbFWlcItLVPIl/2JpkYl1geQXkfc
         Nmu6FBPE+kifjsnsEBCeAbtHEjq4GRHVcZPwcbBTa2DxZGdqdj9+Ga/SAt8lhC03tO1U
         Kkm/YPJKS2E7WwjnVCjttQQG3nvxlGZFqk0CTyvxal00BRskEIMT3Ri2/MdeedNzixTh
         +8AQ==
X-Gm-Message-State: AC+VfDyry6/D0AtfS0rqqquxekSfMeasjAtIY0UxYDfRsZQYr60UW6Uq
        OlVu4oV2WxZaL7MA8XaXLqnzFH5XyVffPw==
X-Google-Smtp-Source: ACHHUZ6i71nuybT4gzdyjSF0Wp/d6eXQiiJ+YZurBbUij/IxO2jVyYeH8wkaaFbG+tvmDLVaXcUPPw==
X-Received: by 2002:a05:6214:e6b:b0:56b:f28a:ee2d with SMTP id jz11-20020a0562140e6b00b0056bf28aee2dmr194567qvb.5.1682951936682;
        Mon, 01 May 2023 07:38:56 -0700 (PDT)
Received: from localhost.localdomain (dsl-157-118.b2b2c.ca. [66.158.157.118])
        by smtp.gmail.com with ESMTPSA id i10-20020a0cedca000000b005ef493c6bebsm8687211qvr.77.2023.05.01.07.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 07:38:56 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     Maxim Cournoyer <maxim.cournoyer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 3/3] send-email: detect empty blank lines in command output
Date:   Mon,  1 May 2023 10:38:48 -0400
Message-Id: <20230501143848.19674-4-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501143848.19674-1-maxim.cournoyer@gmail.com>
References: <xmqqcz3s3oz7.fsf@gitster.g>
 <20230501143848.19674-1-maxim.cournoyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The email format does not allow blank lines in headers; detect such
input and report it as malformed and add a test for it.

Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
---
 git-send-email.perl   | 12 ++++++++++--
 t/t9001-send-email.sh | 17 +++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 32febe9af3..22a64e608f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -2026,14 +2026,22 @@ sub process_file {
 	}
 }
 
-# Execute a command and return its output lines as an array.
+# Execute a command and return its output lines as an array.  Blank
+# lines which do not appear at the end of the output are reported as
+# errors.
 sub execute_cmd {
 	my ($prefix, $cmd, $file) = @_;
 	my @lines = ();
+	my $seen_blank_line = 0;
 	open my $fh, "-|", "$cmd \Q$file\E"
 		or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
 	while (my $line = <$fh>) {
-		last if $line =~ /^$/;
+		die sprintf(__("(%s) Malformed output from '%s'"), $prefix, $cmd)
+		    if $seen_blank_line;
+		if ($line =~ /^$/) {
+			$seen_blank_line = $line =~ /^$/;
+			next;
+		}
 		push @lines, $line;
 	}
 	close $fh
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index dfc5be581f..6519eea1ed 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -460,6 +460,23 @@ FoldedField: This is a tale
 	grep "^FoldedField: This is a tale best told using multiple lines.$" msgtxt1
 '
 
+# Blank lines in the middle of the output of a command are invalid.
+test_expect_success $PREREQ 'malform output reported on blank lines in command output' '
+	clean_fake_sendmail &&
+	cp $patches headercmd.patch &&
+	write_script headercmd-malformed-output <<-\EOF &&
+	echo "X-Debbugs-CC: someone@example.com
+
+SomeOtherField: someone-else@example.com"
+	EOF
+	! git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--header-cmd=./headercmd-malformed-output \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		headercmd.patch
+'
+
 test_expect_success $PREREQ 'reject long lines' '
 	z8=zzzzzzzz &&
 	z64=$z8$z8$z8$z8$z8$z8$z8$z8 &&
-- 
2.39.2

