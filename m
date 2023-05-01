Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C72AC77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 14:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjEAOj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjEAOjX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 10:39:23 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F7E7E
        for <git@vger.kernel.org>; Mon,  1 May 2023 07:39:00 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-74cebbb7bc5so245832385a.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682951935; x=1685543935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxBeK0upIRndruWHXIMwFXJ0YFivAT8VMI+ywkD/0w0=;
        b=FF6RofALrKuk5iL9ggqC+TxhaFOYihHgy90xw9Y71nkvTAiB6YWVOLVFagi/Br1WFa
         6cQfEmnRslE5qVBGbV2cjup1rUw2H4pBZ9fyX0BfTCedMzndKs+F10AN/DQ8tTaG05sT
         ANLVLsvWfdOXUvZlh0Mulyx4e2ycyuADVEVSIsCFWo662sNAq+0VsKW6P6oLEiHQhmqq
         pL2MZKUv6EYowBGoODEeqoxqEGAVlMSI2d7k/sf9qET1Qkde7Vi7l1uqMaOyy1uImL0Z
         K7ae1KhofdcZEHuVSOlBoBky3/bcx7yM6kDVpBK6cbR1oB46lA928OZU0NQtFaPbnfrF
         N85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682951935; x=1685543935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxBeK0upIRndruWHXIMwFXJ0YFivAT8VMI+ywkD/0w0=;
        b=KQDDDURoWINbFWJaAQmRFfCw2ENnJR747kNTGass1a4UgcZCwAjO2IOsPNT75/GkR6
         unex2yqay0Xbt607AXezGw8OzRoyZ+qhDc01nZF7FNaY3XtuGlm1WNNjSs+wAtcePlBv
         ErU3kyTHOperGdR4JCjmN84IwfllQnPSjbJCsimu+u6eTd26UZnm69bCZXTZiIcluq0/
         t/UDpUqFQ7Brf4ORMI0coQ92qz+OXTqH+WfBiGANFR8yd2ZCCsBg3cThP4I6S1K5XBd8
         STCgass4V7dnc2TSJM7RMs5C1zthH59+2r4EjqbQizaNpUGr6GDfOpGIpmIJJMWJ0WMN
         HwUQ==
X-Gm-Message-State: AC+VfDyh9Fq66WMcmGX1zrlto/s7x7pk4GBFpjhE9aul5mBERvZtsTxs
        cD/FEFK+DAFrL/QYB0TiY7YDq40CxRId0Q==
X-Google-Smtp-Source: ACHHUZ6SOt6ikqLHdIx2Ta6iaM5Ofa3vWZcAMBTAMunUzQqUHEbOoYz5VB5Oo/wO9NRG7Nxb6pyG5w==
X-Received: by 2002:a05:6214:c21:b0:61a:175c:6ca7 with SMTP id a1-20020a0562140c2100b0061a175c6ca7mr21627qvd.39.1682951934848;
        Mon, 01 May 2023 07:38:54 -0700 (PDT)
Received: from localhost.localdomain (dsl-157-118.b2b2c.ca. [66.158.157.118])
        by smtp.gmail.com with ESMTPSA id i10-20020a0cedca000000b005ef493c6bebsm8687211qvr.77.2023.05.01.07.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 07:38:54 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     Maxim Cournoyer <maxim.cournoyer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 1/3] send-email: extract execute_cmd from recipients_cmd
Date:   Mon,  1 May 2023 10:38:46 -0400
Message-Id: <20230501143848.19674-2-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501143848.19674-1-maxim.cournoyer@gmail.com>
References: <xmqqcz3s3oz7.fsf@gitster.g>
 <20230501143848.19674-1-maxim.cournoyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactor is to pave the way for the addition of the new
'--header-cmd' option to the send-email command.

Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
---
New in v4:
- Drop copyright line.

 git-send-email.perl | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 66c9171109..04503e3c3c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -2021,15 +2021,29 @@ sub process_file {
 	}
 }
 
+# Execute a command and return its output lines as an array.
+sub execute_cmd {
+	my ($prefix, $cmd, $file) = @_;
+	my @lines = ();
+	open my $fh, "-|", "$cmd \Q$file\E"
+		or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
+	while (my $line = <$fh>) {
+		last if $line =~ /^$/;
+		push @lines, $line;
+	}
+	close $fh
+	    or die sprintf(__("(%s) failed to close pipe to '%s'"), $prefix, $cmd);
+	return @lines;
+}
+
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
 # and return a results array
 sub recipients_cmd {
 	my ($prefix, $what, $cmd, $file) = @_;
-
+	my @lines = ();
 	my @addresses = ();
-	open my $fh, "-|", "$cmd \Q$file\E"
-	    or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
-	while (my $address = <$fh>) {
+	@lines = execute_cmd($prefix, $cmd, $file);
+	for my $address (@lines) {
 		$address =~ s/^\s*//g;
 		$address =~ s/\s*$//g;
 		$address = sanitize_address($address);
@@ -2038,8 +2052,6 @@ sub recipients_cmd {
 		printf(__("(%s) Adding %s: %s from: '%s'\n"),
 		       $prefix, $what, $address, $cmd) unless $quiet;
 		}
-	close $fh
-	    or die sprintf(__("(%s) failed to close pipe to '%s'"), $prefix, $cmd);
 	return @addresses;
 }
 
-- 
2.39.2

