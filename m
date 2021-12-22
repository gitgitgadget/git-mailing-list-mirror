Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90C9C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345000AbhLVS4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344946AbhLVS4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:43 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5356FC061747
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g7-20020a7bc4c7000000b00345c4bb365aso1626591wmk.4
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ktIBxUaPIKKFrC2R2WjpGto/EjpmGRCAsIvpDAcqcQ=;
        b=G8IJhxr4MkNQLQJmSEyPdrTlwuxdX8M5ZLXzmn540tZ1/st0rA6amIhIb10DblI7uz
         6t4w2aQ0oM5xFfz5MiTAGMYVScmZnH7irQ6SiXO6QOw25tEr/Adg1M8WrOmOL5MDARKE
         JkNsh8smapsfPUmgkxyiZo41kD5fx/VmGcXTpFZpGTluT0a+A2NYuvo64u5BDRkBbcZR
         zeIkV3U88YpvusQ2DQ9dfEWQflR0zfnBx/upuqvw6lXvS0PUenocEf0JdI9JD8TpPHcF
         K0NhtmK1uuxsMDK+eW50kqPfH0PVqEzFz25ncozORYUxkr1EW5eCR8cdTy+K11CixP5q
         lKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ktIBxUaPIKKFrC2R2WjpGto/EjpmGRCAsIvpDAcqcQ=;
        b=tIOFR7sxVX7BR1NFmkDuI+qGsCuQ3XgcynqBhuCiRBsC4TbkabdUUOiTnaaNNZIM5k
         ph3EvU+yYaQhfeh8AqeePxdGY6HL4T4HxhPk1OmVERZADfi+0bfuoxxk8a9JTUXoU7uu
         2TnL2r8yVTpwFQy3U6xBWySeHeJZudjq/Rt4MwBiA9HZpS0WhWVVJwtlNkID7lrkES2D
         afTlQltOw8phyzxJE3thwiNI8T0yZ8nfdbunQSGSD1Ms4ECA+NWh6S9bCLLq2ikYNIoi
         ZWtxuFczxwxgwW2dPKZXBm8GdvqEc2M5IoGDpBnjorYGao8TJJcHNArznANgYr9P4Rvb
         1FEw==
X-Gm-Message-State: AOAM530vxKIcpMwyIDC7nu3mvtm0pnu3rrV7TGar+2+4QtHzW4usE3db
        02y9OmcZP0462ZT+SAVSjW0DzojyY2E=
X-Google-Smtp-Source: ABdhPJxySPZht14xh6zDRCirA5HBUCATk68XU4xv9+7v40ftv6F7Gdc3CQZGhn0duaqN1e2099kvIg==
X-Received: by 2002:a1c:9acf:: with SMTP id c198mr1818456wme.117.1640199401759;
        Wed, 22 Dec 2021 10:56:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm3206062wmp.9.2021.12.22.10.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:41 -0800 (PST)
Message-Id: <30016fee4c85c0a803017070d28b3ccf2111ee91.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:27 +0000
Subject: [PATCH v5 07/16] reftable: all xxx_free() functions accept NULL
 arguments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This fixes NULL derefs in error paths. Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reader.c | 2 ++
 reftable/writer.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 0d16b098f5e..c7a32331c76 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -647,6 +647,8 @@ int reftable_new_reader(struct reftable_reader **p,
 
 void reftable_reader_free(struct reftable_reader *r)
 {
+	if (!r)
+		return;
 	reader_close(r);
 	reftable_free(r);
 }
diff --git a/reftable/writer.c b/reftable/writer.c
index 3ca721e9f64..9fd24fa93ce 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -150,6 +150,8 @@ void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
 
 void reftable_writer_free(struct reftable_writer *w)
 {
+	if (!w)
+		return;
 	reftable_free(w->block);
 	reftable_free(w);
 }
-- 
gitgitgadget

