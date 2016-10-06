Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58835207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 23:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754745AbcJFXsL (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 19:48:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32944 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbcJFXsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 19:48:09 -0400
Received: by mail-pf0-f194.google.com with SMTP id i85so1835078pfa.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 16:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qa7We7Zn6MGl6EzjQQRyEtHc+ykA/dQXggCYsz0RiIc=;
        b=vBT2YJ+j+j0DDBeMGl6KpmSAypUXYjppGM+CkelvvpH8gP+Ifu5/M1iTlGHMgktM/Y
         lVpOgMmA/N3YiaeJ6TOhxviNhSR4eF+Rtqz99nM0PWrPC0Fpu8s+rOS5M+X6vf0wvBon
         Ovo8jbzxwRMpUaFkUstvTg1FLQHm9aRzHrCI8V87F4a40lJz4jztugDaTZO7GjFWE6lW
         5dRNAhOl3VPeeO1j8X5MKoyjUknyxzVqaJ6cr5bXlSbsEJXlRhYyrentV8pLcLH5DJVI
         DfHnivJ/7XZQ9X3p0Oqrv871VRgmbMRuBzbZYv7yKUzsX7JBCK83yovoxK3e57Iv/GSB
         PDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qa7We7Zn6MGl6EzjQQRyEtHc+ykA/dQXggCYsz0RiIc=;
        b=adJ0hu2aT7UBBoGgdm4+GlzaCVJYmSENvi7D2YyWsV09sBZWv12nix4RIAx3+0nHlu
         7cxSNQG+JCpjDRnLL126JWo3yi7brAYULz7qwmreoUdFsN8jC68XPo7WWG95gi5Qhgfl
         GuYpXR6uLvFmd1BvclCGjzNB9KaolKoe7v2hpjk5WzFfjXgd4LC71689mUhEEcrzQS4I
         piNRSf2nBNM8ebLARR39iK1lFOzmwlkVHOt6PnXzRe+VT5siMVd1VSNe3Tfjw/bQ0iWm
         5EEqfFkp+7mWwjPmXNWx3dwIYxe335xbauG5Lj6zffiKAiXM2ymin6zCiptRLgBx1L7/
         joXA==
X-Gm-Message-State: AA6/9Rlftikdq4dSTzrL1atkYH5qEEV0zKsXG0pixFa1JN7ESpz5sJcQquV29qMKb7AOSg==
X-Received: by 10.98.85.198 with SMTP id j189mr23304793pfb.123.1475797688145;
        Thu, 06 Oct 2016 16:48:08 -0700 (PDT)
Received: from localhost.localdomain ([107.72.96.123])
        by smtp.gmail.com with ESMTPSA id m83sm8490726pfg.48.2016.10.06.16.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2016 16:48:07 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: [PATCH 2/4] mergetool: move main program flow into a main() function
Date:   Thu,  6 Oct 2016 16:47:57 -0700
Message-Id: <1475797679-32712-2-git-send-email-davvid@gmail.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1475797679-32712-1-git-send-email-davvid@gmail.com>
References: <1475797679-32712-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
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
2.10.1.355.g33afd83.dirty

