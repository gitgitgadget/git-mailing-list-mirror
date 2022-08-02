Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D11C19F29
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbiHBPzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiHBPyw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:54:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E924122BD8
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso473212wma.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BFdDakF7LfJ22DLJSTkby7LZT8pWEi8EtHpQ2aCHliU=;
        b=WmsvGeg9FHuDvqeVXkMuuZzed6th1uVnH412yikb6e1frRzzhkSOyiC7IPOODprmHE
         VIgx0rAJg2SBli+v9TBVfj5T1MdGuS3hf9jVFMTEPe8lqvRz5sNQTPpRtiLx9GSfGEaI
         21KSwvTfQiL+ezrRVKrfR71M93Y5nb3WI1oqx2vV8uedqNL5cd0jKQjRF3VYsqS6bjDo
         HEBWq3prUHDhtm7u5TETz6aksp4v6A4f/u3DRMfLYl17y1XTHQL+pSpMcwFRX+B1EZv+
         wFRi3r7EFmYVnsn8xHxJU8Twj4MBroL47GLIfaXd5dhqv8UqKqxZbI55yWXvf+pf2RMQ
         o4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BFdDakF7LfJ22DLJSTkby7LZT8pWEi8EtHpQ2aCHliU=;
        b=gLTgylohykgwLNn277iFlPt6xKlSS0cIE2E9CGx7LURGtNygEfn1LBQSDBGElLUVOB
         /hKKOOUZQEmZTnTjf0x4rcr1TSaJABeIO2wnd6RlLeSKJCoNjNxxx7S9W0qOK+dfVMWp
         pqEB5uDR3yTdLgTQD/VpVXbHdNtzoNHCbbtioqXZRjiHMQxH+WYg8C7mwX8vrPt47o5y
         WRtnIxheVhaiEG247xteUk1l9ZlkRT7XQWYJiQlnrGGoQ+EayR7f1ojtBYgXcoW2L6UN
         ZUPxUydLhYxvg9IF0v7aI9c65MgCXSas50HVHaPImZPoEKIbMpKYdMBZoyXWapaXbV0b
         IvxA==
X-Gm-Message-State: ACgBeo3gTWGnndD2bMXIcABdujW+6u5gC3L9kf7dGN43anM0U9VU1AKo
        M2XV84DXehLq4uPJTorMSt6GRcTJ6v/NjQ==
X-Google-Smtp-Source: AA6agR4ATvUg/27AOKNLyrdiwa1c9j2+PMUg9x62YspJeQLJ+Tdq0Yx+1OoEV3rkcsNaZ14Ssp9AaQ==
X-Received: by 2002:a05:600c:a07:b0:39e:da6e:fc49 with SMTP id z7-20020a05600c0a0700b0039eda6efc49mr61781wmp.143.1659455690165;
        Tue, 02 Aug 2022 08:54:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 05/17] submodule--helper: don't leak {run,capture}_command() cp.dir argument
Date:   Tue,  2 Aug 2022 17:54:29 +0200
Message-Id: <patch-v5-05.17-509133c37fa-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in c51f8f94e5b (submodule--helper: run update
procedures from C, 2021-08-24) and 3c3558f0953 (submodule--helper: run
update using child process struct, 2022-03-15) by not allocating
memory in the first place.

The "dir" member of "struct child_process" will not be modified by
that API, and it's declared to be "const char *". So let's not
needlessly duplicate these strings.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index dd9a62d139d..3f79908b203 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2131,7 +2131,7 @@ static int is_tip_reachable(const char *path, struct object_id *oid)
 	char *hex = oid_to_hex(oid);
 
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(path);
+	cp.dir = path;
 	cp.no_stderr = 1;
 	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", NULL);
 
@@ -2149,7 +2149,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 
 	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(module_path);
+	cp.dir = module_path;
 
 	strvec_push(&cp.args, "fetch");
 	if (quiet)
@@ -2201,7 +2201,7 @@ static int run_update_command(struct update_data *ud, int subforce)
 	}
 	strvec_push(&cp.args, oid);
 
-	cp.dir = xstrdup(ud->sm_path);
+	cp.dir = ud->sm_path;
 	prepare_submodule_repo_env(&cp.env);
 	if (run_command(&cp)) {
 		int ret;
-- 
2.37.1.1233.ge8b09efaedc

