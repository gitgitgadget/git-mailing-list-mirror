Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE372C77B7D
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 22:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjDVW1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 18:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDVW13 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 18:27:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2915626B5
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 15:27:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2febac9cacdso1801319f8f.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682202446; x=1684794446;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFUnhZfo0GwxPoFfVPC+dHvXxMRLedfL5tNwS3zV7K4=;
        b=ctamGdWxhqY0palFPn7vEbqhiwvyVdimK9ua7rF64RXHhcgt3BW1eTq4qjZma4zkog
         JKd4a+KO6NEsD60ewGBsG8kRF5Uh8R/nPY7VVo5mITiwFNdv55vGnCrpSnzr/cpLmEgx
         j8Fsr4ZRQWZtoZwClWAw2c2U1vSkpmmEoXb6LUGz3dLlfku9iHz3AXPc0H3sc/q3YWso
         u9DGn/jAT9xxyKaOuTgkQhDe4bWOcsxnlo4EXHZeng0Z6qeRJJ21yHeRMh23O32ATPUZ
         NVg3v08I6tiB0zCAJcrBaIGwSOIlasLVliTcHdo1KrwN2EuDI8CSOtgIXsseP6HUmujX
         cgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682202446; x=1684794446;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFUnhZfo0GwxPoFfVPC+dHvXxMRLedfL5tNwS3zV7K4=;
        b=ftN8O+aSM9HDFkSZub9b/lfgKDZ7AaA5fjq9CvFbcDu1cj7xUdyYYrgWipi8bU8IWp
         1HKynxtiSJDcEyLty9XFuhv5rfXkzSuiR1/+P4c9Sde+eIIwtifCW7pz5rWydS5kBNgQ
         ynYkcl4jjU7NtVD+69Ct62a+hrXZOMR26V28c3px62AvAfne9Kt1jjLMfG3scJlX/gDU
         YKuSgZRMxRpClEVY6YcZ7JvD9PyfR12QmE32n/sPkO2tmsUTKzebTxyUjmlG4Me3tKu1
         o5s+C9LrEVRKsDUEMbiyPW4IoM9ub1KepatUwyDrwVLE7x5Bt3MzcBclkVmzgF9N3GQs
         5IRQ==
X-Gm-Message-State: AAQBX9daUK2lVpUTTv1sHS4DG0fDhhc0ReVmSItt3IFJSni0aH5jl8Ug
        MmHCivQ7m6g+oY3mLZoH+i0=
X-Google-Smtp-Source: AKy350ZKtoPpTULnzwEnEhRMwuG8JuZq3/tgYm6juWlWQGd2tAh2eXhSV55LoYnrspn/hfFpKohAAg==
X-Received: by 2002:a5d:5223:0:b0:2f6:b17a:ea57 with SMTP id i3-20020a5d5223000000b002f6b17aea57mr6512686wra.59.1682202446436;
        Sat, 22 Apr 2023 15:27:26 -0700 (PDT)
Received: from [192.168.2.52] (32.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.32])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003f193d7c6b7sm4779349wme.41.2023.04.22.15.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 15:27:26 -0700 (PDT)
Subject: [PATCH v2] follow usage recommendations for branch_get()
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <456b2a6f-eedb-a75a-2299-06ee6e7f3a47@gmail.com>
Date:   Sun, 23 Apr 2023 00:27:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our recommendation is to use branch_get(NULL) to obtain the 'struct
branch*' for the currently checked out branch in the current worktree.
While branch_get("HEAD") produces the same result, it does not follow
the recommended usage and may cause confusion.

Let's change some calls to branch_get() we currently have in our
codebase that do not follow the recommendation, applying the following
semantic patch:

    @@
    @@
    - branch_get("HEAD")
    + branch_get(NULL)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/fetch.c | 2 +-
 builtin/pull.c  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ab623f41b4..3c1806aae9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1755,7 +1755,7 @@ static int do_fetch(struct transport *transport,
 	commit_fetch_head(&fetch_head);
 
 	if (set_upstream) {
-		struct branch *branch = branch_get("HEAD");
+		struct branch *branch = branch_get(NULL);
 		struct ref *rm;
 		struct ref *source_ref = NULL;
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 967368ebc6..f93e8610e0 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -335,7 +335,7 @@ static const char *config_get_ff(void)
  */
 static enum rebase_type config_get_rebase(int *rebase_unspecified)
 {
-	struct branch *curr_branch = branch_get("HEAD");
+	struct branch *curr_branch = branch_get(NULL);
 	const char *value;
 
 	if (curr_branch) {
@@ -440,7 +440,7 @@ static int get_only_remote(struct remote *remote, void *cb_data)
  */
 static void NORETURN die_no_merge_candidates(const char *repo, const char **refspecs)
 {
-	struct branch *curr_branch = branch_get("HEAD");
+	struct branch *curr_branch = branch_get(NULL);
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
@@ -713,7 +713,7 @@ static const char *get_upstream_branch(const char *remote)
 	if (!rm)
 		return NULL;
 
-	curr_branch = branch_get("HEAD");
+	curr_branch = branch_get(NULL);
 	if (!curr_branch)
 		return NULL;
 
@@ -777,7 +777,7 @@ static int get_rebase_fork_point(struct object_id *fork_point, const char *repo,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
 
-	curr_branch = branch_get("HEAD");
+	curr_branch = branch_get(NULL);
 	if (!curr_branch)
 		return -1;
 
-- 
2.34.1
