Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D978FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A0D61357
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhHPBQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhHPBQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 21:16:24 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542CFC061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:15:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f23so17436221qkk.13
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1eGy5L/Ps5ReCRsZes2ECW1qURoffpx+y+0DtvS3qE=;
        b=jeRd4K3Dy8Jd/tfs8il5LBzOGlSbKwfYmyOnb7ekK9Ns2Ie/9aOrj1nWYaC6GxqjSt
         tX+3x4OkSXtSXl+95kGf9mv7EyDgwXWV8e17OkqV47Eup/04CvUnydo+CL2HOpaf5XoS
         A3nkTtdeT7ZwwVYVIHnC5hqjYEdPq6DcairsjIVXUNTnEk14Zjmghu488afxz4dXgrRP
         yeDvCWWrI+8zJrgBOC6qngrXIVcyxC27DYlMvuolja5Nf2Tl0HNroVUhajfC+Qh5ueHk
         HMclE9W4sKtd+JeJVBfUf3qgn7glkPphtXTTNnYpd+hNLEYaoRFuR5eJ6+VSFkQWsOWN
         /BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1eGy5L/Ps5ReCRsZes2ECW1qURoffpx+y+0DtvS3qE=;
        b=Xal5u4d4/82z+m7GDpWzlayy3QVTlLBm8By78uL/T/MQUsXyRn0t3oBoH2QK3jry2f
         Ok0n/waYQR71MA8l1H5F0Dx9buE6U4fXMbK6/wDKCjd1To7Y2YJj2VHm0MBRnd+j3nA5
         j6vYP6Dn5H2nL2d6t/tUSLcbr3GmOLEozGWefdDBTYJkm1V4D69N1bIuY14Vlc3DhM/L
         gYoy15fEqFAp/WoiAjv8D7hGAlZRTl/yDq9qCJiFavHMa6NowRR7NINERDvIVVgySto2
         c2v0lY6QLc7fbcgTH84PJB99URy7W4UIwza5jUA+xgRRsTc0NWqBwT4T7X/8NCzJpjX+
         caKQ==
X-Gm-Message-State: AOAM532usc+iM6slT+YVsXsK8n4dItZCLDPYGt5qz2zzv21aVSOyo6yn
        r0isf9+jJUP1/xC1i41p7STNecR1Fv0=
X-Google-Smtp-Source: ABdhPJwlb/gJzQDkftOUwx8CxVInPn/SWWlzlKK3L9z/tLzn5nxCvOU/5DlSNDxoo+oGkQMjMjt3QQ==
X-Received: by 2002:a05:620a:a11:: with SMTP id i17mr13273573qka.359.1629076552197;
        Sun, 15 Aug 2021 18:15:52 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f2sm4121181qth.11.2021.08.15.18.15.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 18:15:51 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 0/7] hn/reftable "fixes" for BSD
Date:   Sun, 15 Aug 2021 18:15:31 -0700
Message-Id: <20210816011538.34199-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.476.g1b09a32a73
In-Reply-To: <20210802190054.58282-1-carenas@gmail.com>
References: <20210802190054.58282-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few issues I noticed while buiding "seen" in some BSD systems.

Patches 1-3 aren't changed from v1, and 4 had the fixes suggested by
Junio[1] added.

Patch 5 affects an EOL NetBSD 7.2 system and therefore might be dropped
but I thought it was safe/generic enough and might become useful in
other old systems as well.

The last 2 patches are a well known recurring issue, that even prompted
a explicit documentation update in cc0c42975a (CodingGuidelines: spell
out post-C89 rules, 2019-07-16).

All these patches are expected to be applied on top of hn/reftable and
hopefully absorved and discarded.

Carlo Marcelo Arenas Belón (7):
  fixup! Provide zlib's uncompress2 from compat/zlib-compat.c
  reftable: clarify zlib version dependency
  openbsd: allow reftable building with zlib 1.2.3
  fixup! reftable: add dump utility
  fixup! Provide zlib's uncompress2 from compat/zlib-compat.c
  fixup! reftable: reftable file level tests
  fixup! reftable: (de)serialization for the polymorphic record type

 Makefile                  | 2 +-
 compat/zlib-uncompress2.c | 3 +++
 config.mak.uname          | 1 +
 reftable/block.c          | 4 +++-
 reftable/dump.c           | 1 +
 reftable/readwrite_test.c | 4 ++--
 reftable/record_test.c    | 4 +++-
 7 files changed, 14 insertions(+), 5 deletions(-)

[1] https://lore.kernel.org/git/xmqq35rpqg27.fsf@gitster.g/
-- 
2.33.0.rc2.476.g1b09a32a73

