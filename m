Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379DDC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C5E610D0
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhJVTjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbhJVTio (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:38:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90445C061229
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g141so3862559wmg.4
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsMfxwpE3eZAW54R1YCG18IgQpzFZRpihiEB3XUhBOY=;
        b=TxKFZP+vzDqN/RV828dsq8jGgdF1VjapDIa/ThD64cHoYIaJ5DyrxWelqI+CI9EpVj
         /H18XacmPQKtaFML0eKx1wibNU+W9wlVS4q8vDQ7OpoYeP/iaTuxlf/gprNyn65J9UmP
         KIJ5lqikbhDpoBPM+gcdzFDP+GA5gvpZvb+wipEiheP3iSF8RhTjM2tFxicjCKL9eUvf
         y0i43RTW7sLMywR/I7b3AYvwiGe3YlxJnl+MUY6mgaxWSbdYOiO5WxmLjoNkZZXW+mmb
         ZjG1PI5Ic3S0VqFmPg9J6QFYPGOWl2wqlHRUaK0qdF3n7vBitLFY4nbi4ShaldqFs3zy
         ZaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsMfxwpE3eZAW54R1YCG18IgQpzFZRpihiEB3XUhBOY=;
        b=Nhx3dkmqS8IRtsUVnVMWzRy1+hMUSLSFCnHEL+DqXkYUIQdHGMYupkdbEY0iUf/gch
         kcOSw6bRlSJ8VHTbs6AqK/gVLFJIr2RkAPyS3RKJmcbd2EEbTFloDlsS7OniC3g//m5B
         XwLaZuza1Sf1NUU2PF/M2ZjqUIl+8wD1hG6GGIBvZhLksWunCKxayr2+kxYcWKj6Oouk
         SUq/T3rs1VTht8pAIZtGj2K/waO9fqRTerpIiWWYNbcvzDW84ZUEniTz5p0otsi9JabN
         ulz/kdHDeIjs+ZGqrz9Euyj3k4JpIg4wuVFzNgwlfO+RrpBZKKOXvU/KofWVDE1TcGxW
         EJtg==
X-Gm-Message-State: AOAM5308xINJu+EzW+eISlbo51Hhoft5lWK5b/UG8snZrea974gY0Qys
        mlU59xDs1yuqDwthDMf73NcLmHE/ZsKP8A==
X-Google-Smtp-Source: ABdhPJzW8EwGqv29YOjypyYsNWco2ET5KZYkHkDVB/NyC0RsHKsP9SPyPm6kkB3kMn9UT5QtbrltUQ==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr1803006wmc.75.1634931383915;
        Fri, 22 Oct 2021 12:36:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm8871814wrs.73.2021.10.22.12.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:36:23 -0700 (PDT)
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
Subject: [PATCH v2 09/10] generate-cmdlist.sh: replace "grep' invocation with a shell version
Date:   Fri, 22 Oct 2021 21:36:13 +0200
Message-Id: <patch-v2-09.10-7903dd1f8c2-20211022T193027Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the "grep" we run to exclude certain programs from the
generated output with a pure-shell loop that strips out the comments,
and sees if the "cmd" we're reading is on a list of excluded
programs. This uses a trick similar to test_have_prereq() in
test-lib-functions.sh.

On my *nix system this makes things quite a bit slower compared to
HEAD~, but since the generate-cmdlist.sh is already quite fast, and
this likely helps systems where command invocations are more
expensive (i.e. Windows) let's use this anyway.

  'sh generate-cmdlist.sh.old command-list.txt' ran
    1.56 ± 0.11 times faster than 'sh generate-cmdlist.sh command-list.txt'
   18.00 ± 0.19 times faster than 'sh generate-cmdlist.sh.master command-list.txt'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 9b7d6aea629..2b184bbc65f 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -6,12 +6,27 @@ die () {
 }
 
 command_list () {
-	eval "grep -ve '^#' $exclude_programs" <"$1"
+	while read cmd rest
+	do
+		case "$cmd" in
+		"#"*)
+			continue;
+			;;
+		*)
+			case "$exclude_programs" in
+				*":$cmd:"*)
+				;;
+			*)
+				echo "$cmd $rest"
+				;;
+			esac
+		esac
+	done
 }
 
 category_list () {
-	command_list "$1" |
-	cut -c 40- |
+	command_list <"$1" |
+	cut -d' ' -f2- |
 	tr ' ' '\012' |
 	grep -v '^$' |
 	LC_ALL=C sort -u
@@ -48,7 +63,7 @@ define_category_names () {
 print_command_list () {
 	echo "static struct cmdname_help command_list[] = {"
 
-	command_list "$1" |
+	command_list <"$1" |
 	while read cmd rest
 	do
 		synopsis=
@@ -69,11 +84,11 @@ print_command_list () {
 	echo "};"
 }
 
-exclude_programs=
+exclude_programs=:
 while test "--exclude-program" = "$1"
 do
 	shift
-	exclude_programs="$exclude_programs -e \"^$1 \""
+	exclude_programs="$exclude_programs$1:"
 	shift
 done
 
-- 
2.33.1.1505.g075a284c562

