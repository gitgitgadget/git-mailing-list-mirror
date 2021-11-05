Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D27DC433FE
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467BC61076
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhKEOLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbhKEOLB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 10:11:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D5DC061227
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 07:08:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d5so13967717wrc.1
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DUefIznwQo2N9MqllWvBkRCL/i3Ibp+eGLOmj5jux88=;
        b=U27kElG0mYGrrVq837Sju0LExnHql8qEV1wzhLAxCVtU5BvYc/c9Tl7VsDJiqchaqI
         QmnvyFdiJu+AsPoSCAUlgahPZKxcPHT5b6XXUIU1rSzEwCN6oi911U4xpoJIvC4GkOi9
         KKlIMvQcksywOKe2ctGkQhQ6eYt5P7v1zB+uWCICEL+Tg7KUB4i3VNNxg0m5JvalP+9P
         /I9rNp19yIBS0o3KviPCHVvP+WUyk7qJcG5IMda07LZo0eGGNZzQHDTL+HqNbgUia+KK
         rr2HDW0i5P0jA/9VtqWjom+JLISJdamv5WbK4EXbW1OrmD7EwrN0BX0aXaDVIwPJL/J5
         aIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DUefIznwQo2N9MqllWvBkRCL/i3Ibp+eGLOmj5jux88=;
        b=gUNEFqY35BkaFQUlQCQ6ykheMLArTW15xJajQPVt9ri9MWz+yIzJyVwdlenkXcm1hg
         6NvylEuaKM3Hp+UAJLaZtVPVdnMywwtkG5anS+uE+yToM364BNTGM6OyjYS6M4atf6Dn
         sentUNMZr/8GSVJVBA6XnLOYVSIGUB8hzfMBaLQNU7TclZErp+tVJZmwkl7gzWatpAX7
         Zu810Zg6iTjcDa3MC8PdoxMcC3GNwGPkJdsOfpi01unj84Isd2b1dvlY6UI6vgyjBAaf
         3m6V+2eWZhJ9JJhHqF0F2WUed3zn7HKkUQwocSHJdlfECeM0lf92WW2dX8tw5gbqTgO7
         ugXg==
X-Gm-Message-State: AOAM5339eTJ35KHC+uacfh4Is4P4c/wkdVsM22ac3vCNBrMOobHHhgXj
        Qnd5nwBWJMHvOlt4w/TPDdrKhQYo0uIeSQ==
X-Google-Smtp-Source: ABdhPJx/tseeI6qWGb+KwcEGc7eN6NKk7+nOfZMbcZuhGmMKFxnD7j0TWNHIepa0iisODqL4tWyVCw==
X-Received: by 2002:adf:e482:: with SMTP id i2mr45067680wrm.284.1636121298687;
        Fri, 05 Nov 2021 07:08:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7821556wrs.19.2021.11.05.07.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:08:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/10] generate-cmdlist.sh: don't parse command-list.txt thrice
Date:   Fri,  5 Nov 2021 15:08:08 +0100
Message-Id: <patch-v3-10.10-100084070fd-20211105T135058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "define_categories()" and "define_category_names()" functions
to take the already-parsed output of "category_list()" as an argument,
which brings our number of passes over "command-list.txt" from three
to two.

Then have "category_list()" itself take the output of "command_list()"
as an argument, bringing the number of times we parse the file to one.

Compared to the pre-image this speeds us up quite a bit:

    $ git show HEAD~:generate-cmdlist.sh >generate-cmdlist.sh.old
    $ hyperfine --warmup 10 -L v ,.old 'sh generate-cmdlist.sh{v} command-list.txt'
    Benchmark #1: sh generate-cmdlist.sh command-list.txt
      Time (mean ± σ):      22.9 ms ±   0.3 ms    [User: 15.8 ms, System: 9.6 ms]
      Range (min … max):    22.5 ms …  24.0 ms    125 runs

    Benchmark #2: sh generate-cmdlist.sh.old command-list.txt
      Time (mean ± σ):      30.1 ms ±   0.4 ms    [User: 24.4 ms, System: 17.5 ms]
      Range (min … max):    29.5 ms …  32.3 ms    96 runs

    Summary
      'sh generate-cmdlist.sh command-list.txt' ran
        1.32 ± 0.02 times faster than 'sh generate-cmdlist.sh.old command-list.txt'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index cfe0454d1de..205541e0f7f 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -26,7 +26,7 @@ command_list () {
 }
 
 category_list () {
-	command_list "$1" |
+	echo "$1" |
 	cut -d' ' -f2- |
 	tr ' ' '\012' |
 	grep -v '^$' |
@@ -37,7 +37,7 @@ define_categories () {
 	echo
 	echo "/* Command categories */"
 	bit=0
-	category_list "$1" |
+	echo "$1" |
 	while read cat
 	do
 		echo "#define CAT_$cat (1UL << $bit)"
@@ -51,7 +51,7 @@ define_category_names () {
 	echo "/* Category names */"
 	echo "static const char *category_names[] = {"
 	bit=0
-	category_list "$1" |
+	echo "$1" |
 	while read cat
 	do
 		echo "	\"$cat\", /* (1UL << $bit) */"
@@ -64,7 +64,7 @@ define_category_names () {
 print_command_list () {
 	echo "static struct cmdname_help command_list[] = {"
 
-	command_list "$1" |
+	echo "$1" |
 	while read cmd rest
 	do
 		synopsis=
@@ -93,6 +93,9 @@ do
 	shift
 done
 
+commands="$(command_list "$1")"
+categories="$(category_list "$commands")"
+
 echo "/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
 	const char *name;
@@ -100,8 +103,8 @@ struct cmdname_help {
 	uint32_t category;
 };
 "
-define_categories "$1"
+define_categories "$categories"
 echo
-define_category_names "$1"
+define_category_names "$categories"
 echo
-print_command_list "$1"
+print_command_list "$commands"
-- 
2.34.0.rc1.721.ga0c1db665bc

