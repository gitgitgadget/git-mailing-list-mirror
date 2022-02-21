Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7B5C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiBUTjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:39:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiBUTj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:39:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3706322BD2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:00 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id d10so35796420eje.10
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MSZMErovdgwPrkuntoS6Yaji4BIcmuOdMyWxD+uvSM=;
        b=SLe58eqFVPOwN6GotJbBe8TffsC10TZTjFRtVjGppTIKkBim4yl6nDsNGUS6Y3pV2q
         VksUp8ShjITCm1V9P8w4LPuUvKmTvPhyr0nDizGgULDjsA/mu8KiQow+WRBs/nPlFglv
         6KG6/k/UoD0vuyuN9ah6EQ6GvglZ4pULgqQffho0URQ6AgTLeoRVOTr5/oeqpO43iK8j
         LPWddNb4u1RwoLdVdd/LU1hlAaOx1usn3WWBjYb+fIokqdNknokdSZBWPPOb+ErIONoI
         cC7oBsEKEJ+s7wbs7y23pHTXKlb+tK+xh3oRSIc4A0LnSgH4v2xX/K3HDIzEJay0Y3rR
         cXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MSZMErovdgwPrkuntoS6Yaji4BIcmuOdMyWxD+uvSM=;
        b=crjj/6SEoK7iEYtVUv10ODlnQNPziR7qAr+RbD58LyUt2yFTgkGJq5h6LTe/MgVSfV
         KbimB9w20gljfJjSQDzHqfZYcTOwd4XZ2+Msdh258kAQPEyKe90fGOqosdb0BFXVy6Qi
         dCIlgRKtWcVQ32LM/m6CMGK4T4i8GGkh/vHn7oUkplE5R7BPheAZBNzTWiH9vaGjF2Wl
         7wG5uwzAVL5L0BfVK5DJflQE3plLGoHs+HYABJKF3bWfIhA88FTzV8BWAly0ORp3tgjo
         rujn9GABisrW68ZSH25nJ7gxbf67ohcaXMlKBO3xWwx57ZkqzZf7hu2T9A4L8HgyuFqO
         g7Zw==
X-Gm-Message-State: AOAM532uK6AYEMV9FveJPVQrFB8M1j5dIuQTfQkwmL4qtb0y6hA4LbQ8
        IZ9N7Q/TfictTXT9BpA7Qlb6cYgbl3XZ+w==
X-Google-Smtp-Source: ABdhPJx1AoR6Ba9NKs9qwHpQi6DvKHa4bptGqICWOPCVCwjOpYHmap/zBpksLavRaeiVPtztfqL7YQ==
X-Received: by 2002:a17:906:b845:b0:6cf:37d1:f246 with SMTP id ga5-20020a170906b84500b006cf37d1f246mr17338771ejb.280.1645472339093;
        Mon, 21 Feb 2022 11:38:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c25sm8718199edu.103.2022.02.21.11.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:38:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/9] help.c: use puts() instead of printf{,_ln}() for consistency
Date:   Mon, 21 Feb 2022 20:38:45 +0100
Message-Id: <patch-v2-2.9-124643c4b35-20220221T193708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code in "help.c" that used printf_ln() without format
specifiers to use puts() instead, as other existing code in the file
does. Let's also change related code to use puts() instead of the
equivalent of calling "printf" with a "%s\n" format.

This formatting-only change will make a subsequent functional change
easier to read, as it'll be changing code that's consistently using
the same functions to do the same things.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 help.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 71444906ddf..77af953826e 100644
--- a/help.c
+++ b/help.c
@@ -124,7 +124,8 @@ static void print_cmd_by_category(const struct category_description *catdesc,
 		uint32_t mask = catdesc[i].category;
 		const char *desc = catdesc[i].desc;
 
-		printf("\n%s\n", _(desc));
+		putchar('\n');
+		puts(_(desc));
 		print_command_list(cmds, mask, longest);
 	}
 	free(cmds);
@@ -317,7 +318,7 @@ void list_commands(struct cmdnames *main_cmds, struct cmdnames *other_cmds)
 	}
 
 	if (other_cmds->cnt) {
-		printf_ln(_("git commands available from elsewhere on your $PATH"));
+		puts(_("git commands available from elsewhere on your $PATH"));
 		putchar('\n');
 		pretty_print_cmdnames(other_cmds, colopts);
 		putchar('\n');
@@ -439,7 +440,7 @@ void list_all_cmds_help(void)
 	struct cmdname_help *aliases;
 	int i, longest;
 
-	printf_ln(_("See 'git help <command>' to read about a specific subcommand"));
+	puts(_("See 'git help <command>' to read about a specific subcommand"));
 	print_cmd_by_category(main_categories, &longest);
 
 	list_all_other_cmds(&others);
-- 
2.35.1.1132.ga1fe46f8690

