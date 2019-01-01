Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E58FC1F770
	for <e@80x24.org>; Tue,  1 Jan 2019 14:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfAAOGC (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 09:06:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41404 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfAAOGC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 09:06:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so13583569pgq.8
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 06:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r3iLstf2ltplYP10myhKA4afWacnEI19MLWKot94Glk=;
        b=b5f9Mxj3yzONNBOXa2gdNQ30LFggB0yFX/KXvgI2ab2wcUG8+MEXFjUZK32HFzhv7H
         wisDBQtGeos3BG38re2LTDwWwroXuxiKcqs1vob+9PTL+6I76bceCExi+xOiqhdUq7BJ
         0N9083ZO1A2V6D9Nw3AZWFl+fOSY1CVuDFi/Jvph47pTDg4y1PaVEdycjpI+MY6eh8wN
         7mRH7mGp8eF6ym6mDd8tpuSzM/9AD0bBTdfsZhYWIpNX2a99H4RHpkyMq7NJtMZfT39H
         wJQVVAyL3ij9FnczgQLQR6Qppp4iKEDQKKPV8BiXNbrEQlbI/6l8ZsiD/S8AL4MKxbNV
         0/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r3iLstf2ltplYP10myhKA4afWacnEI19MLWKot94Glk=;
        b=PJWDmRXiN1Fm/k/SSi/Mg8cySwTxfKohWrGhMGCnYXFwKcAN9KBEt1c0n21ClKhzBG
         NoFnIpRSPqDiPmau8E0lkmdHoHCZJGfv8VcDXV1yAccIGURgyceAEJkPCLGL+0tOq+c/
         IjTebkOnS+wkOW7p2/p5tPS0GsfLkyTwXzBNu/e2OqfflcA101l00fO3WwqF4vyTS4Ik
         M+LyE+OOxJErAU4DDpWDC0x0lhDor09FCogvWjk1YVW9zEex99Mylq9YdvPwha0AAc+A
         +ATRDPog7u9CjlJEAkUAJNaB5saqepscw6AP9kZQT8OrlTNwCJFHQEXWbUHuT4BToLWG
         AeVQ==
X-Gm-Message-State: AJcUukcPkuIVeic8z/wMOUZXCoSo6yTsNNHKTJA6ubhQ19Iv6FBGeFbL
        pQ0GuLNc12Pxr9DlT7/H/FFKDxCc
X-Google-Smtp-Source: ALg8bN7ix77Ie/ne/mH4kSn86Eq7TvRzZJ3oeqUepFInDSvplw44eZDmv887c7ZXB6KU3LZiZoQW1Q==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr37553212pgk.21.1546351561178;
        Tue, 01 Jan 2019 06:06:01 -0800 (PST)
Received: from localhost.localdomain ([39.119.71.29])
        by smtp.gmail.com with ESMTPSA id o13sm75551257pfk.57.2019.01.01.06.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 06:06:00 -0800 (PST)
From:   Chayoung You <yousbe@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 2/2] completion: treat results of git ls-tree as file paths
Date:   Tue,  1 Jan 2019 23:05:09 +0900
Message-Id: <20190101140509.1857-3-yousbe@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101140509.1857-1-yousbe@gmail.com>
References: <20181230053125.55896-1-yousbe@gmail.com>
 <20190101140509.1857-1-yousbe@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's say there are files named 'foo bar.txt', and 'abc def/test.txt' in
repository. When following commands trigger a completion:

    git show HEAD:fo<Tab>
    git show HEAD:ab<Tab>

The completion results in bash/zsh:

    git show HEAD:foo bar.txt
    git show HEAD:abc def/

Where the both of them have an unescaped space in paths, so they'll be
misread by git. All entries of git ls-tree either a filename or a
directory, so __gitcomp_file() is proper rather than __gitcomp_nl().

Note the commit f12785a3, which handles quoted paths properly. Like this
case, we should dequote $cur_ for ?*:* case. For example, let's say
there is untracked directory 'abc deg', then trigger a completion:

    git show HEAD:abc\ de<Tab>
    git show HEAD:'abc de<Tab>
    git show HEAD:"abc de<Tab>

should uniquely complete 'abc def', but bash completes 'abc def' and
'abc deg' instead. In zsh, triggering a completion:

    git show HEAD:abc\ def/<Tab>

should complete 'test.txt', but nothing comes. The both problems will be
resolved by dequoting paths.

__git_complete_revlist_file() passes arguments to __gitcomp_nl() where
the first one is a list something like:

    abc def/Z
    foo bar.txt Z

where Z is the mark of the EOL.

- The trailing space of blob in __git ls-tree | sed.
  It makes the completion results become:

      git show HEAD:foo\ bar.txt\ <CURSOR>

  So git will try to find a file named 'foo bar.txt ' instead.

- The trailing slash of tree in __git ls-tree | sed.
  It makes the completion results on zsh become:

      git show HEAD:abc\ def/ <CURSOR>

  So that the last space on command like should be removed on zsh to
  complete filenames under 'abc def/'.

Signed-off-by: Chayoung You <yousbe@gmail.com>
---
 contrib/completion/git-completion.bash | 31 ++++++++++----------------
 t/t9902-completion.sh                  | 10 ++++-----
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 816ee3280..26ea310fd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -855,7 +855,7 @@ __git_compute_merge_strategies ()
 
 __git_complete_revlist_file ()
 {
-	local pfx ls ref cur_="$cur"
+	local dequoted_word pfx ls ref cur_="$cur"
 	case "$cur_" in
 	*..?*:*)
 		return
@@ -863,14 +863,18 @@ __git_complete_revlist_file ()
 	?*:*)
 		ref="${cur_%%:*}"
 		cur_="${cur_#*:}"
-		case "$cur_" in
+
+		__git_dequote "$cur_"
+
+		case "$dequoted_word" in
 		?*/*)
-			pfx="${cur_%/*}"
-			cur_="${cur_##*/}"
+			pfx="${dequoted_word%/*}"
+			cur_="${dequoted_word##*/}"
 			ls="$ref:$pfx"
 			pfx="$pfx/"
 			;;
 		*)
+			cur_="$dequoted_word"
 			ls="$ref"
 			;;
 		esac
@@ -880,21 +884,10 @@ __git_complete_revlist_file ()
 		*)   pfx="$ref:$pfx" ;;
 		esac
 
-		__gitcomp_nl "$(__git ls-tree "$ls" \
-				| sed '/^100... blob /{
-				           s,^.*	,,
-				           s,$, ,
-				       }
-				       /^120000 blob /{
-				           s,^.*	,,
-				           s,$, ,
-				       }
-				       /^040000 tree /{
-				           s,^.*	,,
-				           s,$,/,
-				       }
-				       s/^.*	//')" \
-			"$pfx" "$cur_" ""
+		__gitcomp_file "$(__git ls-tree "$ls" \
+				| sed 's/^.*	//
+				       s/$//')" \
+			"$pfx" "$cur_"
 		;;
 	*...*)
 		pfx="${cur_%...*}..."
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 137fdc9bd..94157e587 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1515,8 +1515,8 @@ test_expect_success 'show completes all refs' '
 
 test_expect_success '<ref>: completes paths' '
 	test_completion "git show mytag:f" <<-\EOF
-	file1 Z
-	file2 Z
+	file1Z
+	file2Z
 	EOF
 '
 
@@ -1525,7 +1525,7 @@ test_expect_success 'complete tree filename with spaces' '
 	git add "name with spaces" &&
 	git commit -m spaces &&
 	test_completion "git show HEAD:nam" <<-\EOF
-	name with spaces Z
+	name with spacesZ
 	EOF
 '
 
@@ -1534,8 +1534,8 @@ test_expect_success 'complete tree filename with metacharacters' '
 	git add "name with \${meta}" &&
 	git commit -m meta &&
 	test_completion "git show HEAD:nam" <<-\EOF
-	name with ${meta} Z
-	name with spaces Z
+	name with ${meta}Z
+	name with spacesZ
 	EOF
 '
 
-- 
2.17.1

