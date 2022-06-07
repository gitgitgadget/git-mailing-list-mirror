Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B634BC43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 15:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbiFGPvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 11:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiFGPvI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 11:51:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F2EF33A9
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 08:51:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u8so20428364wrm.13
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 08:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4Ahy/6m/84ucWfcFHTC+Vfzg0oC8QUvy5LQLFp/Ous=;
        b=qGdU17D3WMdHkOc27fGB7COuaH8pCpk3iZJNTLy05DCwGLlmuOZnjrIRFK8ye/TmjN
         8neO6noPnSBQHxC+4z2WnZneMcf3KG5mfbxZP05dRHuchnz6e3QkrjUucwClhn5oDp7u
         m/67GWynVKfR+qjCPK34SksNbI3yKO7TwuIpF0VlE+nHgl/ufzajxszDfCWFSr5lq52v
         E4r4ACA+9h54sLiovAvfuc1AeYc8jOf/3gb7fWxuGmCcrG1tM/xLYWtWqhuQCsnVWa5y
         L3DFIozZKp7d71HAqG+Ej64mKWO+lRF1wTIKHY9R0S4mTzMtAF6LvR4/l63rrAzD5YdM
         4TKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4Ahy/6m/84ucWfcFHTC+Vfzg0oC8QUvy5LQLFp/Ous=;
        b=0Gq2NNSTVwwfuSmucxXHYI1w0nB0e+yy2QjNQC1bief+e57mzn5CBNNpC5FmRFvaBy
         VFv0cZOVS3p/eI8IHBekEmC/v0M+toYTtsPbIjPYsY/obdJnwANZ254gkps7VZSHcQ5w
         CtRrQTv9OX+FG31qj+vODVL4PvTG5bZciPau11nXj/iWHD0bQxV/5KsUZ1r0iFMTDdBK
         Igih36kjPFATE1QXRjQ1cgulZsKTGkq4UbM8ZiXe0018fuBlTdwyUIh5VYj0oNXLn36s
         7bXljaSERBuwrWHyX9YaIbqtbFH7+C8SHEIbAKvcJzn8yNR5v2zAZ5vhRCWE8dx9Ts05
         dqkw==
X-Gm-Message-State: AOAM532+qVUUUlNpFX0SvICfcACPLjh2lIU1ReBhGiYeqrSU0mWJMQUp
        iuXCGpC+GXOZX9KwDbjaJ+AouDqMmPQBJw==
X-Google-Smtp-Source: ABdhPJx8TfbXWLGBw6aWVqPfet1RbECmySEPcPkUO4J2j3+VrYg/W7J/WAcva2Xl/bKRp0RV64+X5w==
X-Received: by 2002:a5d:6d0d:0:b0:218:45b1:ef1f with SMTP id e13-20020a5d6d0d000000b0021845b1ef1fmr9359557wrq.558.1654617065869;
        Tue, 07 Jun 2022 08:51:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6-20020adfbc06000000b0020fe4c5e94csm18790056wrg.19.2022.06.07.08.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:51:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] remote.c: don't dereference NULL in freeing loop
Date:   Tue,  7 Jun 2022 17:50:04 +0200
Message-Id: <patch-2.3-0e258c230f6-20220607T154520Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.g0c3594a0ba5
In-Reply-To: <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com> <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in fd3cb0501e1 (remote: move static variables into
per-repository struct, 2021-11-17) where we'd free(remote->pushurl[i])
after having NULL'd out remote->pushurl. itself. We free
"remote->pushurl" in the next "for"-loop, so doing this appears to
have been a copy/paste error.

Before this change GCC 12's -fanalyzer would correctly note that we'd
dereference NULL in this case, this change fixes that:

	remote.c: In function ‘remote_clear’:
	remote.c:153:17: error: dereference of NULL ‘*remote.pushurl’ [CWE-476] [-Werror=analyzer-null-dereference]
	  153 |                 free((char *)remote->pushurl[i]);
	      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	      [...]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 3e75db7bb4f..0b243b090d9 100644
--- a/remote.c
+++ b/remote.c
@@ -147,7 +147,7 @@ static void remote_clear(struct remote *remote)
 
 	for (i = 0; i < remote->url_nr; i++)
 		free((char *)remote->url[i]);
-	FREE_AND_NULL(remote->pushurl);
+	FREE_AND_NULL(remote->url);
 
 	for (i = 0; i < remote->pushurl_nr; i++)
 		free((char *)remote->pushurl[i]);
-- 
2.36.1.1178.g0c3594a0ba5

