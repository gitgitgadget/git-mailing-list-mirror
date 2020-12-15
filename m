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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67479C2BB48
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F94522CB8
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgLPABk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgLOXvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 18:51:23 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BB8C0613D6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:50:43 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g185so776527wmf.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VG6l5nCZsP8ch5cJpuo4xjAzfFrFcZAAPIOAHk7CXw=;
        b=mkG7P8uld95N45QXe5a4NvfpQArH7aySNvrpzGDraPTFGYpmBaD1EFTlA9nZgZUbdf
         ubC1GvuH2twn71t2JlQYQoxOHJV+hz2S7wVoeFJUD7PeAiejN+m4LM1HCG2FEUq8NMBw
         vci/WuV5VLA/tUSUrZgz1+0ROSd45JqzQti8qf8RWMBYDelYsy1YEoI/KnSJOK0IHtwp
         MUEnsnis9czZRoO/riko4MmPxqmjgAxrt82lY14vjyDhuFGa70tPXm+SqCkeUKhxezW9
         2ZzkoDn/sQTbGxWry0yR4FVIu/Dk+Ye3b4l21/VnllPvlTsfInQRZGPi36e5EOKFhpNQ
         p9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VG6l5nCZsP8ch5cJpuo4xjAzfFrFcZAAPIOAHk7CXw=;
        b=XHF3HJ7MjF113LPZ3qsPTGUjzap9JucfYOVWvKemQ3YrGFAJ04UghW9iJlRVeRU/3E
         4Ahjlq7pHWKCQESXOeh6CCVX4wvBcKkPS4ZuilJZ02IJzTYeiUI7fcEhK74I0HmLWz3l
         hbMJE3Y6jLyk6gvoPyBPHlmJ4A1bESmzYVc8pc66QVhaWbJsgLS3o+X3AqyvBQ7BTy66
         uQ9CtC9sJeWR8HeQ+BhdCaDFbDLjrlVDnMxxBrufwXtqjXXUG9ykAyxL6MuZb3bm0wrh
         otT5rO8zWSEAp/5E79SiQ5aU1/pECIT+eBkoHLvctf2tM8ANWR3lfKMI1XVqcFQPs4Ce
         +xEA==
X-Gm-Message-State: AOAM533YCokJ1gDbcFgDnjz80sXnAtvKbzTTDF4V8nLFV8u2cbZRVkyO
        THK91rQSTEANN+/2hojm/gvA4+5XZwev6Q==
X-Google-Smtp-Source: ABdhPJzG5WGcleSnVDB6P6TBcs3DFW4CPvETMMXsMCXDBOEhfddFo9ogERiPgR46cLbF+IK8QivU3g==
X-Received: by 2002:a1c:2586:: with SMTP id l128mr831429wml.78.1608076241699;
        Tue, 15 Dec 2020 15:50:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f9sm417703wrh.9.2020.12.15.15.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:50:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] strmap: do not "return" in a void function
Date:   Wed, 16 Dec 2020 00:50:26 +0100
Message-Id: <20201215235027.10401-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <xmqq7dpkdup6.fsf@gitster.c.googlers.com>
References: <xmqq7dpkdup6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On SunCC this is a hard error, and since this code first appears in
the v2.30-0-rc0 release it won't build on Solaris SunCC.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 strmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/strmap.h b/strmap.h
index c4c104411bf..1e152d832d6 100644
--- a/strmap.h
+++ b/strmap.h
@@ -165,7 +165,7 @@ static inline int strintmap_contains(struct strintmap *map, const char *str)
 
 static inline void strintmap_remove(struct strintmap *map, const char *str)
 {
-	return strmap_remove(&map->map, str, 0);
+	strmap_remove(&map->map, str, 0);
 }
 
 static inline int strintmap_empty(struct strintmap *map)
@@ -249,7 +249,7 @@ static inline int strset_contains(struct strset *set, const char *str)
 
 static inline void strset_remove(struct strset *set, const char *str)
 {
-	return strmap_remove(&set->map, str, 0);
+	strmap_remove(&set->map, str, 0);
 }
 
 static inline int strset_empty(struct strset *set)
-- 
2.29.2.222.g5d2a92d10f8

