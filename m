Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1ABC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiBUTjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:39:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiBUTjp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:39:45 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77A822535
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p9so35847570ejd.6
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kayE45ZnIDTqeQ4IovKKdu8XimRIxxUyv+taR16QIvE=;
        b=M+KMmh8pqlkhEIHh32JZG1JJkjo1KaN7tASK+9WuOR1jEXEuzE0OgHpF5sWv8nSAfA
         Nn9BwTEXGa3BjwsB0GPAAf3HpjS+UFU9ip50rQPz4gLubpPHRrQ/AOsNiPUquSGszpM4
         GYDHOTEHcs8bet7KmpLFrokxt33BDR4zlc1daEw3O/xXl+61YPA1sbS7w3NVUylYZN2m
         jlrWMZd8ABqkY986gJ2mo3CBEkshs/ypioX7dXrjiu7YWPeM+8Y3QJncnU8a2B8+aq6P
         +pOFl/twMZzVLH0KNB6QmTPVYN6SHe4tg/p2HQq7uLlQjZNEhEVz6+ULQDAMlTlWOyfv
         lewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kayE45ZnIDTqeQ4IovKKdu8XimRIxxUyv+taR16QIvE=;
        b=UlW0xVPiwUfeRbYJ6zrqZoiykWmpQj3XbBl3Cttx+5T4UoPBFzj021OMYcVDhat351
         74UVSewRUHw+BiNGX67NfEMDJlPdwIzWN8oD/NpLsJ/rk3pIRj73EwmwpflAS2zz4fGM
         oItYAHjyK15t+DWRVh8xdEcfxEdjYBZxxzW5RbTtrYB2ajCb+m4h7qXKElx8ioBltbxb
         vaI4iRyc0+X299WNRMvoMhAxGePyeeVPRVtsOolq+r6o471feuPtFBxV84JRNbpus7T3
         JpiEMHpFp0KDIbHzv94oJfzMV8yhTBIfVLMkSyxJr5Qm+yZgV2O3BN88bZcJDxJZqFkR
         vXiQ==
X-Gm-Message-State: AOAM530EA7IQuJreFYq956zNDTT1V8ZScq9zDVDh74ZIXYRqmYIK7smX
        /JjNX7p7wiPT6qJr3cwL/H+N7SgYERc3eg==
X-Google-Smtp-Source: ABdhPJz23+E597uRD1WDEVyXy/iuIpk/HFCIyD+1JAvRrTNui4sKS72QvCQKRk5bLsR+B9OQ9uzHQg==
X-Received: by 2002:a17:906:1e0c:b0:6cf:d014:e454 with SMTP id g12-20020a1709061e0c00b006cfd014e454mr17083359ejj.583.1645472346196;
        Mon, 21 Feb 2022 11:39:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c25sm8718199edu.103.2022.02.21.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:39:05 -0800 (PST)
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
Subject: [PATCH v2 9/9] help: don't print "\n" before single-section output
Date:   Mon, 21 Feb 2022 20:38:52 +0100
Message-Id: <patch-v2-9.9-08dc693dc3e-20220221T193708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a formatting regression in 1b81d8cb19d (help: use command-list.txt
for the source of guides, 2018-05-20). Adjust the output of "git help
--guides" and any other future single-section commands so that a
newline isn't inserted before the only section being printed.

This changes the output from:

    $ git help --guides

    The Git concept guides are:
    [...]

To:

    $ git help --guides
    The Git concept guides are:
    [...]

That we started printing an extra "\n" in 1b81d8cb19d wasn't intended,
but an emergent effect of moving all of the printing of "git help"
output to code that was ready to handle printing N sections.

With 1b81d8cb19d we started using the "print_cmd_by_category()"
function added earlier in the same series, or in cfb22a02ab5 (help:
use command-list.h for common command list, 2018-05-10).

Fixing this formatting nit is easy enough. Let's have all of the
output that would like to be "\n"-separated from other lines emit its
own "\n". We then adjust "print_cmd_by_category()" to only print a
"\n" to delimit the sections it's printing out.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 help.c          | 5 ++++-
 t/t0012-help.sh | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 45a21e7e35c..afd3af24124 100644
--- a/help.c
+++ b/help.c
@@ -124,7 +124,8 @@ static void print_cmd_by_category(const struct category_description *catdesc,
 		uint32_t mask = catdesc[i].category;
 		const char *desc = catdesc[i].desc;
 
-		putchar('\n');
+		if (i)
+			putchar('\n');
 		puts(_(desc));
 		print_command_list(cmds, mask, longest);
 	}
@@ -328,6 +329,7 @@ void list_commands(struct cmdnames *main_cmds, struct cmdnames *other_cmds)
 void list_common_cmds_help(void)
 {
 	puts(_("These are common Git commands used in various situations:"));
+	putchar('\n');
 	print_cmd_by_category(common_categories, NULL);
 }
 
@@ -481,6 +483,7 @@ void list_all_cmds_help(int show_external_commands, int show_aliases)
 	int longest;
 
 	puts(_("See 'git help <command>' to read about a specific subcommand"));
+	putchar('\n');
 	print_cmd_by_category(main_categories, &longest);
 
 	if (show_external_commands)
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 64321480c68..6c3e1f7159d 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -226,7 +226,6 @@ test_expect_success "'git help -a' section spacing" '
 
 test_expect_success "'git help -g' section spacing" '
 	test_section_spacing_trailer git help -g <<-\EOF &&
-
 	The Git concept guides are:
 
 	EOF
-- 
2.35.1.1132.ga1fe46f8690

