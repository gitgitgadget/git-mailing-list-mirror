Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A83C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiI3SJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiI3SIz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB38C1E555D
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j7so2635934wrr.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MI8cyFoQ3UD0aw7rYQYB+Vtav/uiv1hAE+/X9c4buR0=;
        b=TvuuP3cFkRnSq2A2xLOmSnZGmYO71a1N952QjIrJF8gnNinIa5JN1spCWhOaO1y3Sb
         5Nboa21ou2VgL2LCT1SgoKnN2SKDnXCAhFwXKqewmUdekqNWtVp9q5hJol6SegxmTLCC
         BD7o1IAp0cLwLDapKU8CZVd/p5Yd45pSe7lOB+Dnnaq6vN/SS9wGH1+2CQuE3VMIk9sk
         P+nKxgK2ormCuHdfSxvpSeWuQdVOYoY7fNcBTowSptVR5V3ApCUXLy+ivYJ/kUFuwmG9
         tQQ81ku3hefYb/MLRhg5ylxAG2tyyyCUUNnI1ykW4it6s4yrsAKDKD9cVcZu5en5Vjuc
         /HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MI8cyFoQ3UD0aw7rYQYB+Vtav/uiv1hAE+/X9c4buR0=;
        b=JH66Dp8WpD5NlQJx9qYAEBz9Fe7ZzJB/NE8j7Dq5pfrz6K9b9YdAEB/xDBZb1wp9L4
         A88r3yi4RECBWS//TQ3so+HRm4ClajYa2SLxAFLQKDKO/nZ3uVrUANEMqlsrOR50YzRZ
         UeUUXEwA8qFzcRW9QCvVkvxmGnShsoaXygerPWV8QcKg6f2xVK29ubPi/iKzBmb3z+5Y
         eVoer/bOl0o/lF5q3JWbuopK/NXYNi8OflO9mrj6BT+H9Icjq9WiH8QCCNh8M+q+av7x
         sVvQ4WO/C5yYzv8N+db461ESlAINoYlW/PiOfenv+WfaiTsja0Oa5nyekxmoSITzD4Ks
         sA6A==
X-Gm-Message-State: ACrzQf3WsehkDpB8jAoBGRlIMuia1qu0kBQJajKI/36I869l+0kDC8o5
        AFZvAr3XtjsMz9dvaYQ95lb8BL2NZZO+8Q==
X-Google-Smtp-Source: AMsMyM77YNB2XFl8Jq/1O2fJH7Y3gRlsGyrgnw0Q7SHE9U+rRbnun5LgUwwuWkdnwR/wbYUEy3g48w==
X-Received: by 2002:a5d:4648:0:b0:22c:cc4b:5327 with SMTP id j8-20020a5d4648000000b0022ccc4b5327mr6536036wrs.646.1664561329950;
        Fri, 30 Sep 2022 11:08:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/36] doc txt & -h consistency: add "-z" to cat-file "-h"
Date:   Fri, 30 Sep 2022 20:07:35 +0200
Message-Id: <patch-v3-12.36-357a228000c-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in db9d67f2e9c (builtin/cat-file.c: support NUL-delimited
input with `-z`, 2022-07-22), before that change the SYNOPSIS and "-h"
output were the same, but not afterwards.

That change followed a similar earlier divergence in
473fa2df08d (Documentation: add --batch-command to cat-file synopsis,
2022-04-07). Subsequent commits will fix this sort of thing more
systematically, but let's fix this one as a one-off.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 989eee0bb4c..fa7bd891692 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -893,7 +893,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
 		N_("git cat-file (--batch | --batch-check | --batch-command) [--batch-all-objects]\n"
 		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
-		   "             [--textconv | --filters]"),
+		   "             [--textconv | --filters] [-z]"),
 		N_("git cat-file (--textconv | --filters)\n"
 		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 		NULL
-- 
2.38.0.rc2.935.g6b421ae1592

