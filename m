Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC3BC38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjARMrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjARMqW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FF3917E9
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:51 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s3so11169291edd.4
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/mRFhO0OP7MX0zd7H897jix2OcNvcOLPx1m+KhKGN0=;
        b=jnCBy6ImsH86DLmhAc79BeulAqFdPTNx6cHDtle/0y3kz/vrNYRpf+oyhSMFlSNE4v
         h79B+srSPZOdar35HOeD/WAE51RwsHIG87JN+r35eW4D1NLPRFj/un++arNjdzGmcbPy
         QK/lpGe8wZBqKp4Dal9FrgQd2IyBEVIioG9Zuy5I3gUK/BQ3Id8iSmDND6chicyLKPWH
         XncXUgjNcs5GKm6KuuMDNN5eQjT3biZwPH4G7rTW87XTniOi5TgJgfwSs5WVdFF2/UnO
         o+tZM+iBtxk9d2cBtFw+YB9gUyo80rtS1AT2nEu3kOuK9Ce8noVEeScRxs5qBzbksbJC
         WpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/mRFhO0OP7MX0zd7H897jix2OcNvcOLPx1m+KhKGN0=;
        b=4fWvXCI5w54JFqt/hZ8vmNpeNRxcN18bOSIQmG/RlD0owmVvcTp7eGGjBZ/xfH+QFw
         +XqnyZxrvMhpdKDtRCVM0D5bMgbTgsA98Sn0ZL4fQRpP3L7VgIH9UQHyViQREkrfTEEy
         x8FMrpw94zLhygDj6r2U7757o7SEtRnCeZc9bVWTcJgS+5gcwp8+tx/Mdkt6UYETXQlj
         8ERqm2je9ZHtWXO2vqCCjfD3P6yxyieYM0i3Rl905ChJxUw54G/y57vXguoBJLileWic
         J3IixFTEbqdba3XGpI2zsYOhRpOSQ6YSS59WOPn9OkHiEVPF+R61T5N9LN63EsHxUo93
         /1GQ==
X-Gm-Message-State: AFqh2kq1emPId5loi7eBFKDCRXPj/TtHJ5LlJrEr+B53TxCzvmx3mfqb
        IBuY9reBojiaAVjiR+pezKG9dEE0FgBygQ==
X-Google-Smtp-Source: AMrXdXubL2KltHFCIVMcTwQIFSJKeGcAHTjQRhBzPBWSMTXn3T3OgLuKehI1cEXNItVdkV9kNBmnww==
X-Received: by 2002:aa7:d310:0:b0:499:e564:a1c with SMTP id p16-20020aa7d310000000b00499e5640a1cmr6086817edq.11.1674043729865;
        Wed, 18 Jan 2023 04:08:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 17/19] grep API: plug memory leaks by freeing "header_list"
Date:   Wed, 18 Jan 2023 13:08:30 +0100
Message-Id: <patch-v5-17.19-6a8f4a567aa-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "header_list" struct member was added in [1] it wasn't made
to free the list using loop added for the adjacent "pattern_list"
member, see [2] for when we started freeing it.

This makes e.g. this command leak-free when run on git.git:

	./git -P log -1 --color=always --author=A origin/master

1. 80235ba79ef ("log --author=me --grep=it" should find intersection,
   not union, 2010-01-17)
2. b48fb5b6a95 (grep: free expressions and patterns when done.,
   2006-09-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/grep.c b/grep.c
index a4450df4559..c908535e0d8 100644
--- a/grep.c
+++ b/grep.c
@@ -795,6 +795,7 @@ static void free_grep_pat(struct grep_pat *pattern)
 void free_grep_patterns(struct grep_opt *opt)
 {
 	free_grep_pat(opt->pattern_list);
+	free_grep_pat(opt->header_list);
 
 	if (opt->pattern_expression)
 		free_pattern_expr(opt->pattern_expression);
-- 
2.39.0.1225.g30a3d88132d

