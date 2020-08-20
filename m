Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CBCC433E3
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAF4207DA
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUVyOe/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgHTMgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbgHTMfp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 08:35:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C191AC061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 05:35:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so919141pjb.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDdIdXMz9sAUQGsD2ZwnDtURxfXeR1cTZhTtysr8giM=;
        b=LUVyOe/iLWXalI1Jscc3y8Z9aV2tqsMZf4w7p4C/iHwcjULExUJ+SyBAydMaQ4peXI
         4B+pG749+ULvljMtzvKLjq83Bk0qMdwqP2iBUa1hKVztFkzsgUqvDlpHZSO9TQgGuS6I
         4exdFesYhM7DJ+B78xvkgVl+/e/fD1i/38ex2X2PvaVVBE7ind7qjpsGqVmxjw7Wk0do
         fxHXzgeR6Y8OmzPanCZp1gfeaThq/MFe04oc6PNH/9l1r+juQ3nCEpgJ9aSWKh2iQXy8
         7/QyLbulFkE/zgnHAnutPErwxI//ggX5T/2C17bsmKDYnuAkvFxO1ffqhr2hPdN9FrCt
         eWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDdIdXMz9sAUQGsD2ZwnDtURxfXeR1cTZhTtysr8giM=;
        b=PBKQhQoISSSMfgOPm59Hgp7c9/BUwzdLHd8FyakMHqHA57MpYyKmpw17bEdgIwbog3
         1GWc1Uj3V53K7Lpc/t5h05lec7SiNSEWaCJratQ+BQv1nDczv47nqxgB0qNPHCDHvKK8
         55A2aJ6s5wxsCc7hex2nBGKf+VXNcS9gzCmtuN6RMgCnWSfLCtz8XRkKRSiXaPSmQYPN
         VDh+4Z0ksrRi2M5MFutovLNpnOVQyAxXRgU9wzeYnnj1uLbu13/z/lxczgBM2BHU9mmz
         QDrLj4mMIoLfVYdwZQY2QET5bHSh8/LGBPpMEbjoYfyZLhwrjSJRFCvHHuMbHRuQ+6Qj
         pk6w==
X-Gm-Message-State: AOAM532Fe/k/wDXxRPeC2aOK3qtDWXEfPI4zJ20H4RxRlaYExrwwsh9k
        h3F1P5TqyuErDxJNiMkbfxn9gCIIgEE=
X-Google-Smtp-Source: ABdhPJwvsSz+nthjYROZSyXu5DI7HeCIwTsRGQIz1L0hjgdl3uNYTrjHvq0q1k1rXkk6PIHNlI3K8A==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr2550460plr.194.1597926943986;
        Thu, 20 Aug 2020 05:35:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:63a8:cb7a:1eb1:40a4:f50c:706e])
        by smtp.gmail.com with ESMTPSA id h5sm3171054pfk.0.2020.08.20.05.35.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 05:35:42 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 0/2] diff: index-line: respect --abbrev in object's name
Date:   Thu, 20 Aug 2020 19:35:33 +0700
Message-Id: <cover.1597926783.git.congdanhqx@gmail.com>
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

On 2020-08-19 21:56:33-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> >> Anyone is welcome to have my sign-off if they pick up any part of this
> >> patch.
> >
> > This one seems to work with:
> >
> > 	make -j9 test GIT_TEST_DEFAULT_HASH=sha256
> >
> > If noone step up and write this into a patch in some days,
> > I'll take this as first step in my series.
> 
> So, is there anything happening on this front?

Sorry, I was busy with work-life this week.

--------------8<-----------

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

Range-diff against v3:
1:  7966f6ca1d < -:  ---------- revision: differentiate if --no-abbrev asked explicitly
-:  ---------- > 1:  a52d0e59ec t4013: improve diff-post-processor logic
2:  1d32e791a4 = 2:  3cec490500 diff: index-line: respect --abbrev in object's name
-- 
2.28.0.143.g760df7782d.dirty

