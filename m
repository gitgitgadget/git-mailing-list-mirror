Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E7AC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD7E61050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhIUC7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349436AbhIUC0g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82607C1E327C
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d6so32432887wrc.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ICxNleTqXjJVIXAtxmFjocwC4IZYQ1Z6cPnvPLZ7AXA=;
        b=MaoVnBKZgbvTZiyxpCNnaFxCLwG13WwNu5us5hRoXBuWkRPDesEy/qluwePkWSD6H9
         U30DOdHcLpPvsJ+lAPpdlWX//ojEjxV9sylJPyWVl3YrqtIoQIH6oRcJ0kzm/JO461P9
         3AwyhWi4ZH8zO376o8Bf0BaZnT5O+BSSLLqOZ4Lp2cuDcFt6Heo05vmTqYrun6kFCjM0
         V0XqZyiQzR5Utj4lZebFJ9GfIGfJTdn0ywcNR57+hfaJQbpfAtEazQQoKClmbB8+Tspy
         OR9m2jlYCt1cQ+8XD35cwlfQIT5fTgYjskv1lv+HpLvUwweCfCWHMJHn4y90rxiolQtG
         GwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ICxNleTqXjJVIXAtxmFjocwC4IZYQ1Z6cPnvPLZ7AXA=;
        b=i8fW/9bgmVP/smfyoIjcHnfKH9m61QIeTYH/w89rhOGfIrPyRMSQO9tiMnUpp+xPWK
         NukF2bTDFSq/0lHb3gF7asC4zOCTyC0P0PTHrS/Jgc3ZQlSXxCeRSUh3xtIaHdyGGqo9
         kDOHRf10PMn4TeYyOOzwd8SVmPHrU8Rq44dexTUXBy9VU2LOdazduu2ka0mo92eER+HI
         yCPW9jUfLvTpk339cqBfCe8Qy0JFEIuEirxZXUTELDYmi8G35E2cklOQXdIXN72jppJa
         uv1AY6o0Tizfh1Zhg2g0Ka/A9jbSZ2LX2AgWBzu1l+AdXreTZnIgRoVs9bmEhDbXQHCG
         +W4w==
X-Gm-Message-State: AOAM531QW2Q23HlJYWBG0wCFu9vlSwfnJMusS1JwuLyNlN9CEedG4HhQ
        Mq16yA/sW0r4xGK0txTbFbTYn4K6hgjfJA==
X-Google-Smtp-Source: ABdhPJyIEr/N8JcEXpRIvs0G9Ocm7DIsgq3AKJDcvzSJjWGyAdAWS87aPzyu+cvpfZ2C6xP0ls/RQA==
X-Received: by 2002:adf:d1cf:: with SMTP id b15mr4285984wrd.181.1632164673826;
        Mon, 20 Sep 2021 12:04:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 09/17] object-file.c: don't set "typep" when returning non-zero
Date:   Mon, 20 Sep 2021 21:04:13 +0200
Message-Id: <patch-v7-09.17-d9f5adfc74b-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the loose_object_info() function returns an error stop faking up
the "oi->typep" to OBJ_BAD. Let the return value of the function
itself suffice. This code cleanup simplifies subsequent changes.

That we set this at all is a relic from the past. Before
052fe5eaca9 (sha1_loose_object_info: make type lookup optional,
2013-07-12) we would always return the type_from_string(type) via the
parse_sha1_header() function, or -1 (i.e. OBJ_BAD) if we couldn't
parse it.

Then in a combination of 46f034483eb (sha1_file: support reading from
a loose object of unknown type, 2015-05-03) and
b3ea7dd32d6 (sha1_loose_object_info: handle errors from
unpack_sha1_rest, 2017-10-05) our API drifted even further towards
conflating the two again.

Having read the code paths involved carefully I think this is OK. We
are just about to return -1, and we have only one caller:
do_oid_object_info_extended(). That function will in turn go on to
return -1 when we return -1 here.

This might be introducing a subtle bug where a caller of
oid_object_info_extended() would inspect its "typep" and expect a
meaningful value if the function returned -1.

Such a problem would not occur for its simpler oid_object_info()
sister function. That one always returns the "enum object_type", which
in the case of -1 would be the OBJ_BAD.

Having read the code for all the callers of these functions I don't
believe any such bug is being introduced here, and in any case we'd
likely already have such a bug for the "sizep" member (although
blindly checking "typep" first would be a more common case).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index a8be8994814..bda3497d5ca 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1503,8 +1503,6 @@ static int loose_object_info(struct repository *r,
 		git_inflate_end(&stream);
 
 	munmap(map, mapsize);
-	if (status && oi->typep)
-		*oi->typep = status;
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
 	strbuf_release(&hdrbuf);
-- 
2.33.0.1098.g29a6526ae47

