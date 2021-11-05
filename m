Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5144C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B09561076
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhKEOLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhKEOLB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 10:11:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90490C061225
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 07:08:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso6564026wmf.0
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kbN8tIgA/wGJ+HBZyzOuSNMRtIyCpHV1qp4LjlXUeZA=;
        b=MaSJwdV8AylvfQh3ljpfIt5nbPzEdvkEdc8YJWWHYNjoaPzibcS97qVXLGaKEZAyL2
         XOenqulU2PDX1jgzy00rVvQ5yrMI3CihW1otbVhZC6ozKbpSEQhhfibV0YWr7Tde21CG
         xB5oIDcM0UYpRJhPvNJ3QeS9ii/O7E687Umqo9sSqLNXMzPN4Uo5mpB0jBZWYuNZKxvZ
         4hWIcY93TpVzBrE3qi0942/n33Pqa6Avp0ZHLq9x9vVy5HMpt+pCoF3lJ4qrQo8W8pAS
         zRgaw9yq+sTJ5vkrdMN5TcVjZ9uK44LM6Q4ccsrXh3yPs9xwwCx++S8p+9kiOX4Lyzl2
         BObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbN8tIgA/wGJ+HBZyzOuSNMRtIyCpHV1qp4LjlXUeZA=;
        b=mywdL+vrUid1pgtcIayGZDAQRr6fSr6gctKzl79KwaFJFdU+P1f7e6ihWwhLxdw++c
         ay0Qm6es3p4SLMWz4qYyuAjzYOv4D9X9qyTUJ8i1PdHo2AoP1lflwrhuNXixa8XPbzaa
         gUmC4KfltgUs2ObuiFDO0vy0xBhUmL4uiYWbhAE+6DueRqoL5XleavQ7EXkUAPrw2k06
         4mtzF8/FMtX/YA1rLQ0RS7xFWtfjbcxjNlOe/dmZv34qIv+ieMEgjwvwtXmdVo6Mwwhu
         NK6LY3hdlsPF90OtD6GWPDnVXiWhufGUCemqK+4GAVrSZLJWT0vPMtCaG/PY4A5CSRsZ
         51RA==
X-Gm-Message-State: AOAM5302H/RMmidjN5QjzAcTOslr8fNvMJKuYZeCPvduv5YbG4br6siX
        2tuyEaE97A0E8MgAVUxpCWXVD2TLm6vreg==
X-Google-Smtp-Source: ABdhPJxL7AMqlQh9d/t0rvqnFe9bLA/uE3rvdyL8AHEEBfPddSdrajvaj2OXhWnyUtAJPwQ9Uz6afQ==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr31049217wmh.107.1636121297693;
        Fri, 05 Nov 2021 07:08:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7821556wrs.19.2021.11.05.07.08.16
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
Subject: [PATCH v3 09/10] generate-cmdlist.sh: replace "grep' invocation with a shell version
Date:   Fri,  5 Nov 2021 15:08:07 +0100
Message-Id: <patch-v3-09.10-e2702bcc1d0-20211105T135058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
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
HEAD~:
o
  'sh generate-cmdlist.sh.old command-list.txt' ran
    1.56 ± 0.11 times faster than 'sh generate-cmdlist.sh command-list.txt'
   18.00 ± 0.19 times faster than 'sh generate-cmdlist.sh.master command-list.txt'

But when I tried running generate-cmdlist.sh 100 times in CI I found
that it helped across the board even on OSX & Linux. I tried testing
it in CI with this ad-hoc few-liner:

    for i in $(seq -w 0 11 | sort -nr)
    do
    	git show HEAD~$i:generate-cmdlist.sh >generate-cmdlist-HEAD$i.sh &&
    	git add generate-cmdlist* &&
    	cp t/t0000-generate-cmdlist.sh t/t00$i-generate-cmdlist.sh || : &&
    	perl -pi -e "s/HEAD0/HEAD$i/g" t/t00$i-generate-cmdlist.sh &&
    	git add t/t00*.sh
    done && git commit -m"generated it"

Here HEAD~02 and the t0002* file refers to this change, and HEAD~03
and t0003* file to the preceding commit, the relevant results were:

    linux-gcc:

    [12:05:33] t0002-generate-cmdlist.sh .. ok       14 ms ( 0.00 usr  0.00 sys +  3.64 cusr  3.09 csys =  6.73 CPU)
    [12:05:30] t0003-generate-cmdlist.sh .. ok       32 ms ( 0.00 usr  0.00 sys +  2.66 cusr  1.81 csys =  4.47 CPU)

    osx-gcc:

    [11:58:04] t0002-generate-cmdlist.sh .. ok    80081 ms ( 0.02 usr  0.02 sys + 17.80 cusr 10.07 csys = 27.91 CPU)
    [11:58:16] t0003-generate-cmdlist.sh .. ok    92127 ms ( 0.02 usr  0.01 sys + 22.54 cusr 14.27 csys = 36.84 CPU)

    vs-test:

    [12:03:14] t0002-generate-cmdlist.sh .. ok       30 s ( 0.02 usr  0.00 sys + 13.14 cusr 26.19 csys = 39.35 CPU)
    [12:03:20] t0003-generate-cmdlist.sh .. ok       32 s ( 0.00 usr  0.02 sys + 13.25 cusr 26.10 csys = 39.37 CPU)

I.e. even on *nix running 100 of these in a loop was up to ~2x faster
in absolute runtime, I suspect it's due factors that are exacerbated
in the CI, e.g. much slower process startup due to some platform
limits, or a slower FS.

The "cut -d" change here is because we're not emitting the
40-character aligned output anymore, i.e. we'll get the output from
command_list() now, not an as-is line from command-list.txt.

This also makes the parsing more reliable, as we could tweak the
whitespace alignment without breaking this parser. Let's reword a
now-inaccurate comment in "command-list.txt" describing that previous
alignment limitation. We'll still need the "### command-list [...]"
line due to the "Documentation/cmd-list.perl" logic added in
11c6659d85d (command-list: prepare machinery for upcoming "common
groups" section, 2015-05-21).

There was a proposed change subsequent to this one[3] which continued
moving more logic into the "command_list() function, i.e. replaced the
"cut | tr | grep" chain in "category_list()" with an argument to
"command_list()".

That change might have had a bit of an effect, but not as much as the
preceding commit, so I decided to drop it. The relevant performance
numbers from it were:

    linux-gcc:

    [12:05:33] t0001-generate-cmdlist.sh .. ok       13 ms ( 0.00 usr  0.00 sys +  3.33 cusr  2.78 csys =  6.11 CPU)
    [12:05:33] t0002-generate-cmdlist.sh .. ok       14 ms ( 0.00 usr  0.00 sys +  3.64 cusr  3.09 csys =  6.73 CPU)

    osx-gcc:

    [11:58:03] t0001-generate-cmdlist.sh .. ok    78416 ms ( 0.02 usr  0.01 sys + 11.78 cusr  6.22 csys = 18.03 CPU)
    [11:58:04] t0002-generate-cmdlist.sh .. ok    80081 ms ( 0.02 usr  0.02 sys + 17.80 cusr 10.07 csys = 27.91 CPU)

    vs-test:

    [12:03:20] t0001-generate-cmdlist.sh .. ok       34 s ( 0.00 usr  0.03 sys + 12.42 cusr 19.55 csys = 32.00 CPU)
    [12:03:14] t0002-generate-cmdlist.sh .. ok       30 s ( 0.02 usr  0.00 sys + 13.14 cusr 26.19 csys = 39.35 CPU)

As above HEAD~2 and t0002* are testing the code in this commit (and
the line is the same), but HEAD~1 and t0001* are testing that dropped
change in [3].

1. https://lore.kernel.org/git/cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com/
2. https://lore.kernel.org/git/patch-v2-08.10-83318d6c0da-20211022T193027Z-avarab@gmail.com/
3. https://lore.kernel.org/git/patch-v2-10.10-e10a43756d1-20211022T193027Z-avarab@gmail.com/
---
 command-list.txt    |  2 +-
 generate-cmdlist.sh | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index 04cde20c3da..675c28f0bd0 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -43,7 +43,7 @@
 # specified here, which can only have "guide" attribute and nothing
 # else.
 #
-### command list (do not change this line, also do not change alignment)
+### command list (do not change this line)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
 git-am                                  mainporcelain
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 9b7d6aea629..cfe0454d1de 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -6,12 +6,28 @@ die () {
 }
 
 command_list () {
-	eval "grep -ve '^#' $exclude_programs" <"$1"
+	while read cmd rest
+	do
+		case "$cmd" in
+		"#"* | '')
+			# Ignore comments and allow empty lines
+			continue
+			;;
+		*)
+			case "$exclude_programs" in
+			*":$cmd:"*)
+				;;
+			*)
+				echo "$cmd $rest"
+				;;
+			esac
+		esac
+	done <"$1"
 }
 
 category_list () {
 	command_list "$1" |
-	cut -c 40- |
+	cut -d' ' -f2- |
 	tr ' ' '\012' |
 	grep -v '^$' |
 	LC_ALL=C sort -u
@@ -69,11 +85,11 @@ print_command_list () {
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
2.34.0.rc1.721.ga0c1db665bc

