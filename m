Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EF1C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 11:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD90204EC
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 11:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+TcMtMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgHULyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgHULv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 07:51:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95CC061342
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 04:51:58 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f5so766606plr.9
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pUjoCq74BnYjNMvcufy8EJsFpCjc289JJ6CPqlJOxGk=;
        b=Z+TcMtMX9XcWmqcMoPrMKZ/Tgwml/gjH20L/T0+QHGjO7PamrqDaClYUl99DafXzgX
         6yylwR41xkh9tC7KuHaLfNvrQ8NesamzS4/XfPBdzHRIxGc/pCOMmJCBULKIIv/stwdh
         iBXOReBsImmb1gbMRql2Bft1eMx5jHnxsxYCiRm7TJg8tBuG/3tJFe3WLFXH1b/bmfSS
         g47j7aWEnDU8QZOhMAc/LcDeZJLfTBu3zDGv7DkDQQDUbXx0oPPeRIzC+8BT1z4tqVqD
         zaQGxisUCY18FRmjtweAXx5q0PgQalNuJyNeZTRKwZStcSkQzNztv2HURisA8nP3ShHk
         sC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pUjoCq74BnYjNMvcufy8EJsFpCjc289JJ6CPqlJOxGk=;
        b=M5bogqFDAEukUxlSwVUuGlSOStms3TFXx/E0M0g6OarLXRFSPxmcDIiCmQMbZiG803
         zD2Yp/jPSfl36rxB7RFkJLpdB6tPxil53rLCLjz19FqTjhTqEpLqRnvgAYAuJS/11nbz
         EK7D/UcD7DrA8CYEeHHtx420yMultkMPJ/AX+fiM3+iX031ZqsWSpVSGyf8TOgLusC38
         Shjj99WylwN+QhTOnyTH6M+JjpcVQULPVndCeOsjyngCoFeys2vYFLhz9iI3Jv9FM+1P
         eR7pgDWN0KZA4biSoftrbzx1LRT8+RwQKYgIe3fWvcyR/4PxZK/YwgomLUV2xbOuLFHe
         AnVg==
X-Gm-Message-State: AOAM532KpOQICBp5E/qn9yUduwoJSepDmmEkkRzXxnIs2hyWb2gwyHsg
        g3Y6rHRs8G6VM2EuQmZIQPVZ8MQh2w0=
X-Google-Smtp-Source: ABdhPJyHggLnwRvHCOYenGDSFZrSANkZn7HTAZ44czEQfkgTYUCDLorNc47y9riP07/YIKVKP1z/Dw==
X-Received: by 2002:a17:90a:de10:: with SMTP id m16mr2250268pjv.34.1598010717245;
        Fri, 21 Aug 2020 04:51:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:63a8:cb7a:1eb1:40a4:f50c:706e])
        by smtp.gmail.com with ESMTPSA id y1sm2300413pfl.136.2020.08.21.04.51.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 04:51:55 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 0/2] diff: index-line: respect --abbrev in object's name
Date:   Fri, 21 Aug 2020 18:51:45 +0700
Message-Id: <cover.1598010556.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.143.g760df7782d.dirty
In-Reply-To: <cover.1596887883.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For diff-family, Git supports 2 different options for 2 different
purposes, `--full-index' for showing diff-patch object's name in full,
and `--abbrev' to customize the length of object names in diff-raw and
diff-tree header lines, without any options to customise the length of
object names in diff-patch format. When working with diff-patch format,
we only have two options, either full index, or default abbrev length.

Although, that consistent is documented, it doesn't stop users from
trying to use `--abbrev' with the hope of customising diff-patch's
objects' name's abbreviation.

Let's resolve that inconsistency.


brian m. carlson (1):
  t4013: improve diff-post-processor logic

Đoàn Trần Công Danh (1):
  diff: index-line: respect --abbrev in object's name

 Documentation/diff-options.txt                |  9 +--
 diff.c                                        |  5 +-
 t/t4013-diff-various.sh                       | 63 ++++++++++++-------
 ...ff.diff-tree_--root_-p_--abbrev=10_initial | 29 +++++++++
 ...--root_-p_--full-index_--abbrev=10_initial | 29 +++++++++
 ...f.diff-tree_--root_-p_--full-index_initial | 29 +++++++++
 6 files changed, 138 insertions(+), 26 deletions(-)
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_initial

Range-diff against v4:
1:  a52d0e59ec ! 1:  d7e0f13eba t4013: improve diff-post-processor logic
    @@ Commit message
         algorithm.
     
         However, we forgot to special case all-zero object names, which is
    -    special for not-exist objects, in consequence, we could't catch
    +    special for missing objects, in consequence, we could't catch
         possible future bugs where object names is all-zeros including but
    -    not limiting to:
    +    not limited to:
         * show intend-to-add entry
         * deleted entry
         * diff between index and working tree with new file
     
    -    In addition, in the incoming change, we would like to test for
    -    diff with 10 characters index, which is also not covered by current
    -    diff-processor logic.
    +    We also mistakenly munged file-modes as if they were object names
    +    abbreviated to 6 hexadecimal digits.
     
    -    Let's fix the bug for all-zero object names and extend object names'
    -    abbrev to 16 while we're at it.
    +    In addition, in the upcoming change, we would like to test for
    +    customizing the length of abbreviated blob objects on the index line,
    +    which is not supported by current diff-processor logic.
    +
    +    Let's fix the bug for all-zero object names, and file modes.
    +    While we're at it, support abbreviation of object names up to 16 bytes.
     
         Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
2:  3cec490500 ! 2:  a9eb73ceab diff: index-line: respect --abbrev in object's name
    @@ Commit message
         object names in diff-patch format. When working with diff-patch format,
         we only have two options, either full index, or default abbrev length.
     
    -    Although, that consistent is documented, it doesn't stop users from
    +    Although, that behaviour is documented, it doesn't stop users from
         trying to use `--abbrev' with the hope of customising diff-patch's
         objects' name's abbreviation.
     
    -    Let's resolve that inconsistency.
    +    Let's allow the blob object names shown on the "index" line to be
    +    abbreviated to arbitrary length given via the "--abbrev" option.
     
         To preserve backward compatibility with old script that specify both
    -    `--full-index' and `--abbrev', always shows full object id
    +    `--full-index' and `--abbrev', always show full object id
         if `--full-index' is specified.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
    @@ Documentation/diff-options.txt: endif::git-format-patch[]
     -	digits can be specified with `--abbrev=<n>`.
     +	lines, show only a partial prefix.
     +	In diff-patch output format, `--full-index` takes higher
    -+	precedent, i.e. if `--full-index` is specified, full blob
    ++	precedence, i.e. if `--full-index` is specified, full blob
     +	names will be shown regardless of `--abbrev`.
     +	Non default number of digits can be specified with `--abbrev=<n>`.
      
-- 
2.28.0.143.g760df7782d.dirty

