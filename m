Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2582C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 17:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiKVRzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiKVRyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 12:54:33 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA26D43
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:52:34 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bj12so37446498ejb.13
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1YpmGNVOnjw19//WHEgIxZLZ07P6LNgG8OIlO38lTQ=;
        b=fC5C22qnUAIKZ14p7vGwn2xyYx7TsD4HSEpkcnY8L9kmmjXI4Ybf6jG2C9Dt/bwZWf
         v0uIXkQHANyjNxfk6K0396cmzlgWdE+6aFMOqBLV7tu4Np0GjzpDCNkqNGzNd8nPtzqx
         GmNQF5TLVBJ60OMS/PezGLFDSwknbrLT3WOskzVvd32jgiqKZmoO9cUKLQoQ32mTC6GK
         8i9YhCQANrUXLslvgmGLuLLVDFSr35dA4pHVTWfhyckk7Wwcd2xt5t0V5dCKxDi2OYyp
         PeCP1jv3xFryOQJOMN3B1u44wYidvpXzH2mh/hRg59CIHpG3uLEuJUuF18ByVAUJNkH6
         AMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1YpmGNVOnjw19//WHEgIxZLZ07P6LNgG8OIlO38lTQ=;
        b=L9QNmSZ/PKUpJMF1IKBxjhDJtd8Lu4VxRHkwTLQ2DflAKcA2Qnmr4A1OSMVlSl6wYv
         QzDAH/n5+eElGF51cfpJzcjzg/hvQ9S2T7lwSySx5DA/b3ddYqzVHgVaBegqH9iwFJtq
         vkB9N0OMK4fCVbRWN0ZSB5wAZ+8T4bsd96RWJBe2kVORgAuahcPj/+PpnBx6np42gekN
         Njnetq2eWOklbTa0pBIKIuTSVcM6xdMvoRpdvxFhxy5HNGGaIviUpF8MugZnYTxOr4/C
         Wu3TcW7IbaSWx9KT/P7kpXAvIjVP4QeiSb/Fuojwolz4VxB4rj/p6xMj463ZAFJpzwJp
         DqUQ==
X-Gm-Message-State: ANoB5pnLTkvPQ1oPOfivadSndajn8DSQG8TYhY1xTKlpMCHiGNxbFnM9
        VtZJYkn1NL6dlTFBJ79fGuz0WjhL8t8=
X-Google-Smtp-Source: AA0mqf633lI5WmIt6GouekwQelKEUuk8jzhT8BtPGzUzEaYNxxJlyTsik1YHDG6pIDZwc3OL7Carpw==
X-Received: by 2002:a17:906:eda3:b0:7ae:9188:ddc2 with SMTP id sa3-20020a170906eda300b007ae9188ddc2mr6191125ejb.647.1669139553157;
        Tue, 22 Nov 2022 09:52:33 -0800 (PST)
Received: from Precision-5550.. ([2a04:cec0:1182:5ffb:b420:3bec:4f4c:e712])
        by smtp.gmail.com with ESMTPSA id i10-20020aa7c9ca000000b00461a6997c5dsm6618204edt.83.2022.11.22.09.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 09:52:32 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/2] pack-objects: allow --filter without --stdout
Date:   Tue, 22 Nov 2022 18:51:49 +0100
Message-Id: <20221122175150.366828-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.38.1.475.g7216a7bc05
In-Reply-To: <20221122175150.366828-1-christian.couder@gmail.com>
References: <20221025122856.20204-1-christian.couder@gmail.com>
 <20221122175150.366828-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <chriscool@tuxfamily.org>

9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
taught pack-objects to use --filter, but required the use of
--stdout since a partial clone mechanism was not yet in place to
handle missing objects. Since then, changes like 9e27beaa23
(promisor-remote: implement promisor_remote_get_direct(), 2019-06-25)
and others added support to dynamically fetch objects that were missing.

Remove the --stdout requirement so that in a follow-up commit, repack
can pass --filter to pack-objects to omit certain objects from the
resulting packfile.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 573d0b20b7..a4dccca4cd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4385,12 +4385,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (pfd.have_revs && pfd.revs.filter.choice) {
-		if (!pack_to_stdout)
-			die(_("cannot use --filter without --stdout"));
-		if (stdin_packs)
+	if (pfd.have_revs && pfd.revs.filter.choice && stdin_packs)
 			die(_("cannot use --filter with --stdin-packs"));
-	}
 
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
-- 
2.38.1.475.g7216a7bc05

