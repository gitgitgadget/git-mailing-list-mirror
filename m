Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB1DC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiL3CT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbiL3CS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C5A178B5
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:53 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c17so28840176edj.13
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haUot/xIAfYVQDjzJA68WZl7D4dmBs9l/ik3MXovgVE=;
        b=ilooEiuOgAsGXkPm0uQkeu/oGYuNjwOwhrpDz7+ZyRXI4Y/mkTKdFb0bIvMC5W/Flb
         FmdTkV/FE2FpBA9L/RL+uOBMqCGzhKkZPIJsdtp+IsMOjmhvCY05FOZvBexUyvD+a5NP
         bRwL+oh6xDv/kF4nfCzw7iAiY3CVrqbdgjTzIYouTpZdvWwrxAjz2sKsDV8VzmdywFU2
         j6CLHanWRFuEa+5vlh2GJNau5G1KSH/oRU4vxvpTKh5oDvXGJqCoDsKU40tXCw+rrlkx
         CAsNNKq4w6IIAu6i1Ts7sjN9hjKSK96IRyFcjGJzeg/OrSGDsHjzf7tzx+ptecOF2VKw
         dmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haUot/xIAfYVQDjzJA68WZl7D4dmBs9l/ik3MXovgVE=;
        b=FYYFOTaAGqzAJbye5xqBK5uiwGuS3VumPxiSn2m48hsJKfuieoqIe0l48sPRCCNdUc
         ERDAFP1H9x026vE1ntaGTD/CTgYAO1eAr74kz5m4qpJhZdKz9/Exh/MQOX9JfNj+eCn0
         qwYY0MbX+uCLyZR3SNJTY0FS4nBj9+ULQYI1tZHWIi9q6wu//h4v4MBn7AJaOdjOYUR3
         M3WC66FOTYBxuEWryuim1GgumXtQOqV/m4menqcfPFOSt9icBeqJMnUFTnGRyo4ngcGl
         8p6jRnHtM8pjvvFy+mOvuBwNit7bmwmzW59MxMeyClZIVCWpEn5fBMq3by1pj1ls5KoB
         956g==
X-Gm-Message-State: AFqh2kqxwNxWhLD4FdqkU0ILGuJGHElqSagfw/IynyzCZIMsFZ5QaSpG
        6Fk2hjq47zoT+y3sN2P52OAReXO6LUFJHg==
X-Google-Smtp-Source: AMrXdXvsDFClY5UtN979NJHKCvIYMMX2zNckWtzUQupj6KD67oPw8z87vs7rGrwy9hXv83Y++tfyYw==
X-Received: by 2002:a50:eb06:0:b0:46c:b221:8605 with SMTP id y6-20020a50eb06000000b0046cb2218605mr26581957edp.0.1672366733033;
        Thu, 29 Dec 2022 18:18:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/20] connected.c: free(new_pack) in check_connected()
Date:   Fri, 30 Dec 2022 03:18:30 +0100
Message-Id: <patch-v2-15.20-d5210017cab-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since this code was introduced
in c6807a40dcd (clone: open a shortcut for connectivity check,
2013-05-26). We'd never free() the "new_pack" that we'd potentially
allocate. Since it's initialized to "NULL" it's safe to call free()
here unconditionally.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 connected.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/connected.c b/connected.c
index b90fd61790c..e4d404e10b2 100644
--- a/connected.c
+++ b/connected.c
@@ -38,7 +38,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	if (!oid) {
 		if (opt->err_fd)
 			close(opt->err_fd);
-		return err;
+		goto cleanup;
 	}
 
 	if (transport && transport->smart_options &&
@@ -85,8 +85,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 promisor_pack_found:
 			;
 		} while ((oid = fn(cb_data)) != NULL);
-		free(new_pack);
-		return 0;
+		goto cleanup;
 	}
 
 no_promisor_pack_found:
@@ -123,8 +122,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		rev_list.no_stderr = opt->quiet;
 
 	if (start_command(&rev_list)) {
-		free(new_pack);
-		return error(_("Could not run 'git rev-list'"));
+		err = error(_("Could not run 'git rev-list'"));
+		goto cleanup;
 	}
 
 	sigchain_push(SIGPIPE, SIG_IGN);
@@ -157,6 +156,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		err = error_errno(_("failed to close rev-list's stdin"));
 
 	sigchain_pop(SIGPIPE);
+	err = finish_command(&rev_list) || err;
+cleanup:
 	free(new_pack);
-	return finish_command(&rev_list) || err;
+	return err;
 }
-- 
2.39.0.1153.g589e4efe9dc

