Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 164C920986
	for <e@80x24.org>; Fri,  7 Oct 2016 23:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932854AbcJGX6P (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 19:58:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35128 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbcJGX6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 19:58:12 -0400
Received: by mail-pf0-f195.google.com with SMTP id t25so3544143pfg.2
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nDkqZgGc2O004PC+yNDPrKonBrZu07WixK5CIygc/qM=;
        b=CKfxkZiLZqK9urcZDVjQXzRXnDUuNYvEpRYJ2QgIUIHJy3PkqCFcA76VVognDmTAWZ
         oHBBs3mGlVyVn+toqx/5yIsHijh46QaQ5HLeEguK8wRfTs+W1nUmxotdVt7E33J2fd9d
         Mg/LJHY0T2RoVPdy7YdqK6MFI/1oBkBZEWjINhjDMKIEpGxKhMsOGJFMx3rjO2gyyYds
         LAJlj561hstd9WM+WexzYrLMlZu2ZCtbLH5aJPaFw8HO970nP4g0BL6AH6COA8xuzfZc
         RWa0KKROM8s/ZDnNB5D0vITD389Oi1YgSZxV3iwY1ZI0SGUDT7OOnaO7RapRyAjBH5QT
         zD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nDkqZgGc2O004PC+yNDPrKonBrZu07WixK5CIygc/qM=;
        b=Cgqhfmx0vtUnGr+M8aj737RBKxHu/roWmBZ7irxg27PeJHmpMM3GnQ9g5eGAwScjTy
         c73tfbSxx53NocrjEoh4Yjgffq6ogcalkwviH7z6wKKe193oc2SfWVgtkerfzZVvJCT5
         Y2/4SB95qmqJ0eAZCKOiLIOO97B6D+sv/3Kw2FVKVoTyPT+Tu4CmyDQy2cIRTldm526K
         T2ikOFTtCmGV42Hf8cov3qSfaxrncIeOap+tl5ArEtOwHhH/tOTlLJlVdGzLq4qv/4x5
         vmlvI7EuwWa547sQq/PRdJp+CQziEvPuau/C9QEW/PesiRR5CDssVaev3rtVnntae3yA
         vIUg==
X-Gm-Message-State: AA6/9RkNpai1NRrMQy436CjQMROw3W6vNycVtQFigtxG1A2Em0+Vj6zY//4z7ofl2lz6iw==
X-Received: by 10.98.79.200 with SMTP id f69mr41182238pfj.51.1475884691309;
        Fri, 07 Oct 2016 16:58:11 -0700 (PDT)
Received: from raptor.fas.fa.disney.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id c27sm16662890pfe.6.2016.10.07.16.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 16:58:10 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: [PATCH v3 2/4] mergetool: move main program flow into a main() function
Date:   Fri,  7 Oct 2016 16:58:04 -0700
Message-Id: <20161007235806.22247-2-davvid@gmail.com>
X-Mailer: git-send-email 2.10.1.386.g8ee99a0
In-Reply-To: <20161007235806.22247-1-davvid@gmail.com>
References: <20161007235806.22247-1-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it easier to follow the program's flow by isolating all
logic into functions.  Isolate the main execution code path into
a single unit instead of having prompt_after_failed_merge()
interrupt it partyway through.

The use of a main() function is borrowing a convention from C,
Python, Perl, and many other languages.  This helps readers more
familiar with other languages understand the purpose of each
function when diving into the codebase with fresh eyes.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Unchanged since v2; included for completeness.

 git-mergetool.sh | 180 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 93 insertions(+), 87 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 300ce7f..b2cd0a4 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -366,51 +366,6 @@ merge_file () {
 	return 0
 }
 
-prompt=$(git config --bool mergetool.prompt)
-guessed_merge_tool=false
-
-while test $# != 0
-do
-	case "$1" in
-	--tool-help=*)
-		TOOL_MODE=${1#--tool-help=}
-		show_tool_help
-		;;
-	--tool-help)
-		show_tool_help
-		;;
-	-t|--tool*)
-		case "$#,$1" in
-		*,*=*)
-			merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
-			;;
-		1,*)
-			usage ;;
-		*)
-			merge_tool="$2"
-			shift ;;
-		esac
-		;;
-	-y|--no-prompt)
-		prompt=false
-		;;
-	--prompt)
-		prompt=true
-		;;
-	--)
-		shift
-		break
-		;;
-	-*)
-		usage
-		;;
-	*)
-		break
-		;;
-	esac
-	shift
-done
-
 prompt_after_failed_merge () {
 	while true
 	do
@@ -427,57 +382,108 @@ prompt_after_failed_merge () {
 	done
 }
 
-git_dir_init
-require_work_tree
+main () {
+	prompt=$(git config --bool mergetool.prompt)
+	guessed_merge_tool=false
+
+	while test $# != 0
+	do
+		case "$1" in
+		--tool-help=*)
+			TOOL_MODE=${1#--tool-help=}
+			show_tool_help
+			;;
+		--tool-help)
+			show_tool_help
+			;;
+		-t|--tool*)
+			case "$#,$1" in
+			*,*=*)
+				merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
+				;;
+			1,*)
+				usage ;;
+			*)
+				merge_tool="$2"
+				shift ;;
+			esac
+			;;
+		-y|--no-prompt)
+			prompt=false
+			;;
+		--prompt)
+			prompt=true
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	git_dir_init
+	require_work_tree
 
-if test -z "$merge_tool"
-then
-	# Check if a merge tool has been configured
-	merge_tool=$(get_configured_merge_tool)
-	# Try to guess an appropriate merge tool if no tool has been set.
 	if test -z "$merge_tool"
 	then
-		merge_tool=$(guess_merge_tool) || exit
-		guessed_merge_tool=true
+		# Check if a merge tool has been configured
+		merge_tool=$(get_configured_merge_tool)
+		# Try to guess an appropriate merge tool if no tool has been set.
+		if test -z "$merge_tool"
+		then
+			merge_tool=$(guess_merge_tool) || exit
+			guessed_merge_tool=true
+		fi
 	fi
-fi
-merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
-merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
-
-files=
+	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
+	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
-if test $# -eq 0
-then
-	cd_to_toplevel
+	files=
 
-	if test -e "$GIT_DIR/MERGE_RR"
+	if test $# -eq 0
 	then
-		files=$(git rerere remaining)
+		cd_to_toplevel
+
+		if test -e "$GIT_DIR/MERGE_RR"
+		then
+			files=$(git rerere remaining)
+		else
+			files=$(git ls-files -u |
+				sed -e 's/^[^	]*	//' | sort -u)
+		fi
 	else
-		files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
+		files=$(git ls-files -u -- "$@" |
+			sed -e 's/^[^	]*	//' | sort -u)
 	fi
-else
-	files=$(git ls-files -u -- "$@" | sed -e 's/^[^	]*	//' | sort -u)
-fi
-
-if test -z "$files"
-then
-	echo "No files need merging"
-	exit 0
-fi
-
-printf "Merging:\n"
-printf "%s\n" "$files"
-
-rc=0
-for i in $files
-do
-	printf "\n"
-	if ! merge_file "$i"
+
+	if test -z "$files"
 	then
-		rc=1
-		prompt_after_failed_merge || exit 1
+		echo "No files need merging"
+		exit 0
 	fi
-done
 
-exit $rc
+	printf "Merging:\n"
+	printf "%s\n" "$files"
+
+	rc=0
+	for i in $files
+	do
+		printf "\n"
+		if ! merge_file "$i"
+		then
+			rc=1
+			prompt_after_failed_merge || exit 1
+		fi
+	done
+
+	exit $rc
+}
+
+main "$@"
-- 
2.10.1.386.g8ee99a0

