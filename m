Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409DAC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E8D2068E
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO35SIHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKTVSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:18:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33737 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVSo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 16:18:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id c184so411137pfb.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 13:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wEEg5Em9M80m2qrBVvnD55D8JA6XPSx+tu87ITXhLWo=;
        b=JO35SIHfP+f25jnaslRlogn6a6SjIFo2dxtEGVAu6JZRdoaH5p6vmINpkE+NUrSF9I
         zigF4MdwRhJ0tyM59FRreAlJkN67BolLZYEzu0fukUe1QNjZtUM2G1WSBvAWY51NjrV/
         haiR4u3EXqRLgVVnzFVFaHV2Ykahfh+P54pxJ5vaO80z4e17b5AuigTv5QJXtjr3f+rT
         pKVjcXtbIsiVfHwoOX80/1xHgf5NuwTQf2r8RqsZBjEuYd2T1OJ51o/k7Og1k6JvkDtX
         j/mkbjSyH2RAV4/MOHi8ajtCVxo4Spsz3Xd8/71IlQdnMaRZFmPKYqwh3xUHxyBjHgog
         IL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wEEg5Em9M80m2qrBVvnD55D8JA6XPSx+tu87ITXhLWo=;
        b=ON3bYNXKI2r07YMr25jdi9rMesimyJx61D9PR38qdSgrwvHwQIS7e2adSy35Nf2rfO
         Jv2qlpfcLhdHFmETyipVcLVikwM+ts0K7S1KNfwVNt4rqePc2VclZwMDfq/WYarOHNXD
         NsWs0FeC2S0l+nxI0dCdo622zfcm64E0tqkKT8qJlwUSta+JwrTFYLqTO4kUptQH7v3D
         sJGbNjBkUXYbYnM5QIph7GcJ2VD4ljEdvAL1cAhYdl8xheeDYJLurlUUEEzwptDUlQ1Y
         CySwA+ykEX72q9uKERiA4H2CKc6QYGcNt66W/hL9rwvUVxd8ggna3zUlMnAwIqYlDlMy
         mUKw==
X-Gm-Message-State: APjAAAUUTtbIJfbQRqQXILqbSda6GU09XYzgiWrhpV5qgnf29RpFeBgb
        RIUPP1QCJT6ypR16V6j5PLPtvWFU
X-Google-Smtp-Source: APXvYqzo9roNfgCDv751X8XsZWWum12QdttBQN1KN85WUP+CabstUM6kMUNGxbO2YpmcozaYRmKl/w==
X-Received: by 2002:a62:2a4c:: with SMTP id q73mr6374864pfq.94.1574284723209;
        Wed, 20 Nov 2019 13:18:43 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id h26sm307682pfo.93.2019.11.20.13.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:18:42 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:18:41 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 07/10] t3206: range-diff compares logs with commit notes
Message-ID: <093d32ac4f198341232a46bf867317b8c3c7d566.1574284470.git.liu.denton@gmail.com>
References: <cover.1574207673.git.liu.denton@gmail.com>
 <cover.1574284470.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574284470.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test suite had a blindspot where it did not check the behavior of
range-diff and format-patch when notes were present. Cover this
blindspot.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3206-range-diff.sh | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index f654aed54f..19ba644933 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -505,4 +505,56 @@ test_expect_success 'range-diff overrides diff.noprefix internally' '
 	git -c diff.noprefix=true range-diff HEAD^...
 '
 
+test_expect_success 'range-diff compares notes by default' '
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	test_when_finished git notes remove topic unmodified &&
+	git range-diff --no-color master..topic master..unmodified \
+		>actual &&
+	sed s/Z/\ /g >expect <<-EOF &&
+	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
+	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
+	4:  $(test_oid t4) ! 4:  $(test_oid u4) s/12/B/
+	    @@ Metadata
+	    Z
+	    Z ## Commit message ##
+	    Z    s/12/B/
+	    -    topic note
+	    +    unmodified note
+	    Z
+	    Z ## file ##
+	    Z@@ file: A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'format-patch --range-diff compares notes by default' '
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	test_when_finished git notes remove topic unmodified &&
+	git format-patch --cover-letter --range-diff=$prev \
+		master..unmodified >actual &&
+	test_when_finished "rm 000?-*" &&
+	test_line_count = 5 actual &&
+	test_i18ngrep "^Range-diff:$" 0000-* &&
+	grep "= 1: .* s/5/A" 0000-* &&
+	grep "= 2: .* s/4/A" 0000-* &&
+	grep "= 3: .* s/11/B" 0000-* &&
+	grep "! 4: .* s/12/B" 0000-* &&
+	sed s/Z/\ /g >expect <<-EOF &&
+	    @@ Metadata
+	    Z
+	    Z ## Commit message ##
+	    Z    s/12/B/
+	    -    topic note
+	    +    unmodified note
+	    Z
+	    Z ## file ##
+	    Z@@ file: A
+	EOF
+	sed "/@@ Metadata/,/@@ file: A/!d" 0000-* >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.24.0.450.g7a9a4598a9

