Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7583AC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 00:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 457C961003
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 00:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhFAAHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 20:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhFAAHv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 20:07:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2A0C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 17:06:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f2so1287822wri.11
        for <git@vger.kernel.org>; Mon, 31 May 2021 17:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UnAqOBNWKZ57J7+Qp7W276FOKh1MulhIMozZcz8gGJ0=;
        b=SOqkVQTjX8p0My3PhUf397fF5jHY4gnx4XSNpHb4XWz2hJ5uWJ+PMEpODVxJogwdOR
         74Y37h0vUnPPKc8tJcN/KCJ960eHCMk2V9B01yW0UhHTNKHu9ggEndog5v0w6uN/lz45
         b/gNI6txAW/WpFz+LsAWKALt6fLKBkuNmcBMewPz0/sPUHw3PJSZ2cW6KrLEV5waH6Oc
         KzDJnwUTdqN7oEEUtH6SSlUsiOOZXHGriOGVaAa3RmeFp/s1Mb735O2nBb3+p9/19FWk
         syUCUH4Z1eBywvifxAwZH/SL6uQpnNsVJM+FRLt0ccXxTLhkaL5K6nR0oOxEQPu5FLoD
         mvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UnAqOBNWKZ57J7+Qp7W276FOKh1MulhIMozZcz8gGJ0=;
        b=f0OA8dLrt0NuSuBNPm5YNOP9VAUa94APo+uTI39Wuk3+zxWVXhqtz1YaJc0/P/whjD
         ytyXKo3+s53QRF5aY8+4kzESGqXsCeqU70QTVS6TOo72SgzYN9VSU7/Lls4QjYoke2kN
         rGZmgix8HGDa5seoKY3rJgfR0l2QfoTQ+4DMBA6eban0PoQ5CbbKbBbOeDmxfSUPCD1O
         T5+867bwKWwuw+CPNfpy14b+sGut1wHrKl02pU3KyyOjpBbTD+AlZVSSMn0MMvmT8sIW
         +8XlMh14lnb2squjUQoCGsQ9mFQ7bqVaD4MV6xrCGOduHk/ws0hM23K8AbdSKnNbg884
         5gRw==
X-Gm-Message-State: AOAM533hmRApi2KwLPvmalVgKUkA2zaRGIA2+ia8beTIIKWxbDWZmmOD
        gc6NNqdbPMhBWiq24iF0MFDJcJtsIUtcog==
X-Google-Smtp-Source: ABdhPJxHKrK3aJQk1JPYPt/vabqoIhPG/T841bNCX9rDHd4JlqjLZjALlsK63d0pKLVS2lelKRu2kQ==
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr7013368wru.242.1622505966928;
        Mon, 31 May 2021 17:06:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm1286398wro.21.2021.05.31.17.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 17:06:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] builtin/fsck.c: don't conflate "int" and "enum" in callback
Date:   Tue,  1 Jun 2021 02:05:59 +0200
Message-Id: <patch-1.1-f109a61b11-20210601T000433Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a warning on AIX's xlc compiler that's been emitted since my
a1aad71601a (fsck.h: use "enum object_type" instead of "int",
2021-03-28):

    "builtin/fsck.c", line 805.32: 1506-068 (W) Operation between
    types "int(*)(struct object*,enum object_type,void*,struct
    fsck_options*)" and "int(*)(struct object*,int,void*,struct
    fsck_options*)" is not allowed.

I.e. it complains about us assigning a function with a prototype "int"
where we're expecting "enum object_type". Enums are just ints in C,
but it seems xlc is more picky than some about conflating them at the
source level.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This is new in v2.32.0, so sending this during the rc phase, just a
warning though, so unless you're using fatal warnings on that
OS/platform it won't impact anything, and even then it's just a minor
annoyance...

 builtin/fsck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 87a99b0108..b42b6fe21f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -109,7 +109,8 @@ static int fsck_error_func(struct fsck_options *o,
 
 static struct object_array pending;
 
-static int mark_object(struct object *obj, int type, void *data, struct fsck_options *options)
+static int mark_object(struct object *obj, enum object_type type,
+		       void *data, struct fsck_options *options)
 {
 	struct object *parent = data;
 
-- 
2.32.0.rc1.460.g26a014da44c

