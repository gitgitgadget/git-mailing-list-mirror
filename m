Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44593C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiGMNRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiGMNQl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C376F13D68
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o4so15483651wrh.3
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tH0HbfKTIX82++Ibo08v5ScpLAoDuEKMMWqGUqrXI5Y=;
        b=YOg0GgQ2hE9srngwHfS6FEUrJ1mGQgzpRd9AK3qOq8RaPkuqU4kI6tS9kZK0xqejgO
         9WyncqGAiWY6aBfyr3FYHZQAodNsCb4G1vepKHWhKCnifplB84Tv9GvmKWzMza73SgW4
         JcEoEvZyIUVlV0tnvtlLgTkV8TikWM6CfY5n/An2+4kKXit8Zk3iseIWWv97uSi3Itp6
         p9TnPCRzdnkBv2RwWD6kbDT5mg9XwAbnm25dWi6+NPQfZZjr6AP7goQu6J/RSo34oyQc
         uGg1g3JHgd/NB6c/wYBh+g5P61UEDw9nlWPWcPDUs880Rh7xDAXPKJrgDPb3DLxXMong
         NwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tH0HbfKTIX82++Ibo08v5ScpLAoDuEKMMWqGUqrXI5Y=;
        b=DsdCklY3qAO/951S+O769OW8FEkmqNldaNASVq8wMNxVlYRoxVGjpYncc+idlepRKV
         HP33qHo5NtIuzmACWD/t7AlUED7hn9hh5hLcinxIApr7vbQKo3e/Li9EmAs3P/0EMwB+
         MA9VIADEMM2yHGDABArkykLMIgaexa6yYr/SkiCyCdLPjYvmt63XAbYbI4gRNkwwPoXo
         9ZwiuFijP+pYfGitxcWGVFMjgpf/KrOY7WTBwBMjlDD3flr1ut9ux8KNPBJAW3ZZU3dm
         no6iz8G56KOOPqrm1dzJUIlpfH3dyG22kiylIaLJTxjv/eHO6X+uheqf4zkBd4CNvkyQ
         womw==
X-Gm-Message-State: AJIora9B08k6XSGMcYJd/8Z3r8smDA/BEqADn1YLWskNXpKVzRVlXUjt
        8q5WrXkMZBrpDPgCepOn1h5BGzfzqNXj3g==
X-Google-Smtp-Source: AGRyM1vCznLg3jX1dBSB5cSf9pPGYyzRSdI+n6JITX2N4sz4nJf1Ezduj9HhmFTfNvhacUW3Sp3arg==
X-Received: by 2002:adf:eed1:0:b0:21d:7052:278a with SMTP id a17-20020adfeed1000000b0021d7052278amr3416639wrp.170.1657718196656;
        Wed, 13 Jul 2022 06:16:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/11] submodule--helper: fix "reference" leak is "module_clone_data"
Date:   Wed, 13 Jul 2022 15:16:16 +0200
Message-Id: <patch-11.11-475b1196a93-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix leaks in the "reference" member of "struct module_clone_data" that
have been with us since 31224cbdc72 (clone: recursive and reference
option triggers submodule alternates, 2016-08-17) and
8c8195e9c3e (submodule--helper: introduce add-clone subcommand,
2021-07-10).

Those commits added an xstrdup()'d member of the
STRING_LIST_INIT_NODUP'd "struct string_list". We need to free()
those, but not the ones we get from argv, let's make use of the "util"
member, if it has a pointer it's the pointer we'll need to free.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d9fab5d77da..966f543fbd9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1598,6 +1598,7 @@ struct module_clone_data {
 static void module_clone_data_release(struct module_clone_data *cd)
 {
 	free(cd->path_free);
+	string_list_clear(&cd->reference, 1);
 }
 
 struct submodule_alternate_setup {
@@ -1652,7 +1653,9 @@ static int add_possible_reference_from_superproject(
 
 		sm_alternate = compute_alternate_path(sb.buf, &err);
 		if (sm_alternate) {
-			string_list_append(sas->reference, xstrdup(sb.buf));
+			char *p = strbuf_detach(&sb, NULL);
+
+			string_list_append(sas->reference, p)->util = p;
 			free(sm_alternate);
 		} else {
 			switch (sas->error_mode) {
@@ -3194,9 +3197,11 @@ static int add_submodule(const struct add_data *add_data)
 		clone_data.url = add_data->realrepo;
 		clone_data.quiet = add_data->quiet;
 		clone_data.progress = add_data->progress;
-		if (add_data->reference_path)
-			string_list_append(&clone_data.reference,
-					   xstrdup(add_data->reference_path));
+		if (add_data->reference_path) {
+			char *p = xstrdup(add_data->reference_path);
+
+			string_list_append(&clone_data.reference, p)->util = p;
+		}
 		clone_data.dissociate = add_data->dissociate;
 		if (add_data->depth >= 0)
 			clone_data.depth = xstrfmt("%d", add_data->depth);
-- 
2.37.0.932.g7b7031e73bc

