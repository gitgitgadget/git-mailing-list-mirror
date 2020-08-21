Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE41C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 10:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E3A20656
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 10:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqM3FjBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgHUKLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgHUKLG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 06:11:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB72C061385
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 03:11:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so1297187wmi.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7HY1gSKJLufvvvBu89V8qAza32i6divUjtCBBhkduSg=;
        b=XqM3FjBvXwdCp6CJTv8wcpjoJ6vLzEaeZLpOVPeBh03OjwGrBNJlT9dUYrTJfNNFOD
         Sr9Qgon6+Ly6Lr829ZLET8UeNoQ0/WsGyEYKX073q5uGrECfl0sjNt7qKf7XZ7Puu0/l
         wL+8it1TXPObIua9I/lT0Pp0lHfmDvvC5PmL2STukauTdHzvlUO2adcceFWCcjdQXMBf
         zhx7sXXpmCOchYA0x7ZXSPBQy2WGmB/4W38O64LiJoiZNRJoM0m0BlJRee42d7X0OQnF
         SrR4xmP8WgRprqLRp+iVmJuIrB+QT5nknikPDaBBCVePvaqdCX90M8mIrgBa6SnRVGx2
         tEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7HY1gSKJLufvvvBu89V8qAza32i6divUjtCBBhkduSg=;
        b=WLV8KTTAERVzsNju5xDOJAHI8shu73JK8H50P11UgvbTGwMloy8MCvXFE6lo+PKubL
         unEsVpc4OEpCKJppnnDUjf7j9+jt36GxWVCdayWdVS/jIO1iambsDITCiY6/soTy8QLs
         VOxzbGNWssPZgu86ET8RW5Sk0oB+lyBwVZErMLFJ2smCxzaKzEr18WYTJ6OvGVPGFHpU
         tp1UA0Kp4q+ILEcf8sjUq35KxSK57CV/6cuT5NVa1nsylyQ7dd39SiSjFU3vb5fFHwWF
         s3DCANTt9fq1Jj70VW1W2SBiGI5NPfLo92xRISc/1CTqASuAvumNJPiBOYpqDxfS9Iv7
         Oitw==
X-Gm-Message-State: AOAM531g5upX+COSQq5OLsoASqwiuJDeUWKYm7wIMtIjhVpG1sOH5tWn
        9bst9kFMaWzqcBhyESVaIBRF+/Aww1A=
X-Google-Smtp-Source: ABdhPJyofGrlVKKtDIfepFIN3rBpmkxZjjps0AWpd6y/zfngNSW+4jficG0wiO+Ta/dxcyBCb7PwlA==
X-Received: by 2002:a1c:e919:: with SMTP id q25mr2963005wmc.123.1598004664130;
        Fri, 21 Aug 2020 03:11:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm3237847wrq.69.2020.08.21.03.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:11:03 -0700 (PDT)
Message-Id: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
In-Reply-To: <pull.707.git.1597841551.gitgitgadget@gmail.com>
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 10:11:00 +0000
Subject: [PATCH v2 0/2] Fix trailers atom bug and improved tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there exists a bug in 'contents' atom. It does not show any error
if used with modifier 'trailers' and semicolon is missing before trailers
arguments. This small patch series is focused on fixing that bug and also
unified 'trailers' and 'contents:trailers' tests. Thus, removed duplicate
code from t6300 and made tests more compact.

Hariom Verma (2):
  t6300: unify %(trailers) and %(contents:trailers) tests
  ref-filter: 'contents:trailers' show error if `:` is missing

 ref-filter.c            | 21 +++++++++++++---
 t/t6300-for-each-ref.sh | 55 ++++++++++++++---------------------------
 2 files changed, 36 insertions(+), 40 deletions(-)


base-commit: 675a4aaf3b226c0089108221b96559e0baae5de9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-707%2Fharry-hov%2Ffix-trailers-atom-bug-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-707/harry-hov/fix-trailers-atom-bug-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/707

Range-diff vs v1:

 1:  bd0bb8d0ef ! 1:  4816aa3cfa t6300: unify %(trailers) and %(contents:trailers) tests
     @@ t/t6300-for-each-ref.sh: test_expect_success 'set up trailers for next test' '
      -
      -test_expect_success '%(contents:trailers:only) and %(contents:trailers:unfold) work together' '
      +	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
     -+	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >reverse &&
     -+	test_cmp actual reverse &&
      +	test_cmp expect actual &&
     ++	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >actual &&
     ++	test_cmp actual actual &&
       	git for-each-ref --format="%(contents:trailers:only,unfold)" refs/heads/master >actual &&
     - 	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/master >reverse &&
     - 	test_cmp actual reverse &&
     +-	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/master >reverse &&
     +-	test_cmp actual reverse &&
      -	{
      -		grep -v patch.description <trailers | unfold &&
      -		echo
      -	} >expect &&
     - 	test_cmp expect actual
     +-	test_cmp expect actual
     ++	test_cmp expect actual &&
     ++	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/master >actual &&
     ++	test_cmp actual actual
       '
       
     + test_expect_success '%(trailers) rejects unknown trailers arguments' '
      @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers) rejects unknown trailers arguments' '
       	fatal: unknown %(trailers) argument: unsupported
       	EOF
 2:  7daf9335a5 ! 2:  39aa46bce7 ref-filter: 'contents:trailers' show error if `:` is missing
     @@ ref-filter.c: static int trailers_atom_parser(const struct ref_format *format, s
      +			return 1;
      +		}
      +		else if (*opt == ':') {
     -+			*option = ++opt;
     ++			*option = opt + 1;
      +			return 1;
      +		}
      +	}

-- 
gitgitgadget
