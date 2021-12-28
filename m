Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B4AC433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhL1Pga (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbhL1Pg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:36:26 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15915C06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:26 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so38997367wrr.8
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+jkzxjgPQgPICKmeh7ft30kzeqsljR4Gp8JbraYIpE=;
        b=V/u849neUGn+8EDO5w/XGQXiW7Ja/kLeFzNqqHh+4wzHb/RxHGAWujTE+SCOxeOiAI
         KtOXEI6MEjYTFB6q7M13COSGHPW0sJieJVOjyBlFXDXrncXXNJt3g+6gQfvrQkzwrd+9
         odaltgKetm2wJfgNhM3oTMHjlkw8VJuhp6DV0cn1Werq+YPMaA4xBN1U0E7rEgXCLVe5
         NxWARVSM/LqWlE9m+ez7WZhQp9HCV7FSG/2jBVMfJs9sOYi9h3aU4WkwN2wj4KlZSlpe
         nSSi5rIkFuH5DJbbpBq4RliN3XwLUw6tEKJfZX352RU98F5omvRz/n3Znj5ExGe1Dton
         EK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+jkzxjgPQgPICKmeh7ft30kzeqsljR4Gp8JbraYIpE=;
        b=UgFQMg9rsYp3bLCGNs1ZgqU3QO34jSk3n+twkgwe95dSX9oRCavx54fXRvZL5CoZeg
         hO+qu2HDtW6NoivXINicoBuGgN2Zd5m2TlJNdGGlDP7rrT9xowV0kKs6DOyKPZcIe8XR
         ziYzHBhbJIr2Eh1ROVEzDPRuw+ntq6Zf50N3s/t5OW7DPS5iM1637efazMh2OwFQZAMG
         xI8lRYskUU7Y2IRXfT2k1h8GK5CVOTw7cZhg5TZSRgm3vDNJYLl+3rYlrEK9i9Divk1Z
         amPdm3g1TSgJ0/gxsK9R+GPw/91Bs1jd0vWxlMO2QAi8+GaVA8YzU75M0mOLbIgzDuUg
         18Ow==
X-Gm-Message-State: AOAM531pVIjXpwGfSP2N5GE4+qw0sZwFWu8BvX8HDXsj7z7VtJQxnXLV
        7ICPpzNlzMQBc+gIB0gP5Wm0DxL+f+HPzuv/
X-Google-Smtp-Source: ABdhPJxY+Yh6fgB0vfxZkSIrA+ZKs78coLjIt0elLtVRnHf6XwaUCAjG4ojWa0VwIAfwFEYDR8Donw==
X-Received: by 2002:a5d:480c:: with SMTP id l12mr16566332wrq.48.1640705784427;
        Tue, 28 Dec 2021 07:36:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p23sm18403137wms.3.2021.12.28.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:36:24 -0800 (PST)
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
Subject: [PATCH 7/7] help: don't print "\n" before single-section output
Date:   Tue, 28 Dec 2021 16:35:12 +0100
Message-Id: <patch-7.7-08fd12fe7b4-20211228T153456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
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
index 2296f06ad9f..30be45cea59 100644
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
index c41b412e34a..aae01f15229 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -223,7 +223,6 @@ test_expect_success "'git help -a' section spacing" '
 
 test_expect_success "'git help -g' section spacing" '
 	test_section_spacing_trailer git help -g <<-\EOF &&
-
 	The Git concept guides are:
 
 	EOF
-- 
2.34.1.1257.g2af47340c7b

