Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E14FC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4581720714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQsecFI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgCZPff (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:35:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37319 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgCZPfd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 11:35:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id de14so7322795edb.4
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=foBY/mH6k2D/bsKWKIhwbwseCoDDelfr5UKKVRqstfA=;
        b=iQsecFI9CQ62XH+xye8cjKIy5OXB6pUHqaPfr0Bvrwcfbk+oCtMd27v17Vky5ZyQqQ
         fB+5QNI9SoOVzj3WjzJQxnNb9CPvsRh0XzwsK0ACH1cy27YwjSq0VPrbzvgE2eu0klqc
         /v1GYFpJ2kJ0fWiXgP5HXLJHkHx2FcN7x3JY2umISnQ4HMQrv8IeozcJDO5DGdRc+DEd
         KA6sZNCUctQ57k2vDfkPLqqnoiZeV13Ufnq7CvZTLd5RfqDzUGmuqhObwJhGrdNNDL2k
         2TRXZYDVUdLlokBoKlVJ3ZehKQnVS9tpjcXeKJOSbolRtX+XgRIWACNXF7snQBjHmT+y
         N3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=foBY/mH6k2D/bsKWKIhwbwseCoDDelfr5UKKVRqstfA=;
        b=Evs4r214HyE8o94/FFiOAFKRrptMs3LqTLr+AjBgUl2BhwZqRMCR1jvucs+VTq7KpL
         giOTzOx+Y1EP8hpbaKXloaCbsW4UHTvmo0XzRKQn5IW11IoQymPTiSlnmGx9AheOejhL
         OTR3gIuX5LHXaB9cG5T/kITpk5ob6J9GY77HXq0m+rVj+AVBdHZGVUUeveRrq60oAfku
         y8X4YQJoQLGjV3sApPKytVhAiWInJqo1891JRztOmsjmlcEtC+CwHKkiwniTV6xFucI9
         mSnifN8RnZEQeZZ5f9lQCk54u+k7YMBVMKZ/3x+CLfcq/iv+m1BmDlN2ID9ujuZA7REk
         twlw==
X-Gm-Message-State: ANhLgQ1wmWtyLYDh+eNzdF+eN1qcGm0qU72D+28LZep42/mEZulN3kaX
        rIWtgNnAglivzCN8F0vSpW5Vx+/H
X-Google-Smtp-Source: ADFU+vt++25otBwH/bYo+nNWlSz/yrxKFZL4SM1Lnk2kRYDiYsmnsvbQOdKMdHJuqXGvb/aSpJkPgA==
X-Received: by 2002:a17:906:1603:: with SMTP id m3mr8496187ejd.205.1585236931886;
        Thu, 26 Mar 2020 08:35:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cm11sm386730edb.1.2020.03.26.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:35:31 -0700 (PDT)
Message-Id: <b4217c36070e504ddacf4cfe71897fb324f65db1.1585236929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
References: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 15:35:25 +0000
Subject: [PATCH v3 2/5] t/lib-gpg.sh: stop pretending to be a stand-alone
 script
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It makes no sense to call `./lib-gpg.sh`. Therefore the hash-bang line
is unnecessary.

There are other similar instances in `t/`, but they are too far from the
context of the enclosing patch series, so they will be addressed
separately.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-gpg.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 11b83b8c24a..4ead1268351 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -1,5 +1,3 @@
-#!/bin/sh
-
 gpg_version=$(gpg --version 2>&1)
 if test $? != 127
 then
-- 
gitgitgadget

