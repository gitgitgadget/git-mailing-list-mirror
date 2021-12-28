Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9C7C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhL1PgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhL1PgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:36:23 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09222C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t26so39057925wrb.4
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBSGte6plgVqU5/KnLMeP5cIR8H4seZOE7Z19maPXVc=;
        b=jhFv2CccFhPECa1AjF3JekQJXPBEhXYpTbFzkLX7GVgBVIsa/KYt6Y518FraAeKmlz
         96S75aw7TAsqRa29C+LReTp/FdetKB+x70Abx8iMFoh4cfzSDggERuRrUF71NImvFo4b
         Gz4AKFNqp0TUJSaSrhOZfjqTzK7zt45edNo45qI7wXp7fxxw5iG/dpfpbXuBhxn8Qv1W
         +chxu/LLMBRaXN+35ksrejxl8iS9QC8TQI6kDqrlJpG2CwBQ6+TemV4kdabDwEwWkDE7
         qS93EyaSeHj6+9qrZ0RE6AzMYxDpZJa3mFFV++QYHmDYaS62atpqj5ksWa/gU4CHpk7v
         IiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBSGte6plgVqU5/KnLMeP5cIR8H4seZOE7Z19maPXVc=;
        b=ScjK5/ZzELt8JEWfCAl8zAwd1G7h3RbAhfPBovA27vYmY7f8EDvawu0PkRhxZaFiPK
         g1/TAlMEdw+jtF5YpQb+BhdkbEQBJIBOdiz5mVvqFtzhyt76gM1pwSccOmneyKKYEUuO
         qynrAN+HI/ckUhhFtE6Tw+fxodJRjZlOR+Hm4lHmBysa3ELwZftaJv9hosk5CFrQWO4e
         aIhvO+pj0I27hoDKqLP9VIZK+24iPKMU0oOlnCoXBV+Nu1zgFTg9TbUR33Adg1iIkhb3
         srp5RIIo5XpdwIFLEYrL9e/O+K7qGrKkMccHvRmklu6ScLfS/rMOC4XIklUWfRK0hGZS
         c+YA==
X-Gm-Message-State: AOAM532OicZs+mYwzqaGBaGDZBRmFuY8DBtu5aZS9JZQhm4REG15vJIW
        qHC3NXRIHv0EkqG2fTHEnmMoleqXECMvjy9J
X-Google-Smtp-Source: ABdhPJwy0Yp7uMF2/mAhBwSmt4FMhHe8DYn7EOPJp248k9XM5yGkLKjiaEVwfFGzha8iC9MY8A9z2g==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr14306398wrf.538.1640705780990;
        Tue, 28 Dec 2021 07:36:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p23sm18403137wms.3.2021.12.28.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:36:20 -0800 (PST)
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
Subject: [PATCH 2/7] help.c: use puts() instead of printf{,_ln}() for consistency
Date:   Tue, 28 Dec 2021 16:35:07 +0100
Message-Id: <patch-2.7-f84662469a3-20211228T153456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
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
index 973e47cdc30..0ba9b866f03 100644
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
2.34.1.1257.g2af47340c7b

