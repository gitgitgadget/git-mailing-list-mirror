Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252FE1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeDPWmw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:42:52 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:38423 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbeDPWmu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:42:50 -0400
Received: by mail-wr0-f174.google.com with SMTP id h3so17632678wrh.5
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KTlaNYfQgL6p32zv2r1ghYLROYp/nert2vphoAL11A=;
        b=Dq/mLOasjpwfKlZYHfrDvGvO+6sx5QMitz7/T3CGO29+5+SUNSA+kpc8/K8Rdr4ta5
         DIpvgEYiJY+siax3mEMy41u8i78qMLQSsY6azsrPfkn/TqX0jCgFhVmEAPmwrt6vy+qg
         Uztf2TarM2jRkpZVpEyL0hMGm5xczQY5Wft40mTfqQWvOwX+q9G8phwMcpl/nD0Xx+P3
         n7VPOKOkHPdqQYquVznvvh7GesibJtGGiW9l3sarMnFDlqooRLRcU7/Pyb2Bunf1MhKu
         LZdJp2uB+wD6OLwhY7z3IqjAVKKE4yy/WF3oEGxZRS/JqlLhv4MrDwM5gTQXm4y9c9BV
         EtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KTlaNYfQgL6p32zv2r1ghYLROYp/nert2vphoAL11A=;
        b=BYPIGPHoeB7xntJOyHN3Q5Xz3mSmy7S0ifMYJJtiVgU8vESI/TBBNa5aQxhK29wXQz
         B9iuLhjX033fsyuEN6SAu1867VnrDPs1U/ooW69uZl8NsGr3wb9rMIXxKVzAGu3yxfvS
         m3JT0w9xhVJ3G6+nsYXjIl0vX/J3SQY3vyTGHm7IulsselnIn6NmTlcPgi9tAOIKhqFX
         u4OsTUrnshoZDm7EEC1u6CQQTUyj2n+BiyPATp3MqEhB3IYjfTukyuwpIjUrxaz9JKFf
         OtBLprdA7Q33+wHhuhs7DgSQBC69L+QeqGh3OTQUJiFwBFVwSc06Pctmw0ZU0XrimsQv
         jY9g==
X-Gm-Message-State: ALQs6tCDirZIRFLsj+0sANO1mWbr6FZ6O7DoY6hRsnsjRTI4GU7HPUFP
        ycjWtaWRMbhqGXRH3Qai+6y+Vw==
X-Google-Smtp-Source: AIpwx49TsCSVYuT4Io5FJbXKL4Oea8O31+0x3MwINqDWDj181bI7zldYi7KA2k3OEWEHT5ZRiMhWgg==
X-Received: by 10.223.195.132 with SMTP id p4mr11584909wrf.279.1523918568883;
        Mon, 16 Apr 2018 15:42:48 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id e10sm23413937wri.23.2018.04.16.15.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:42:48 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 11/11] completion: fill COMPREPLY directly when completing paths
Date:   Tue, 17 Apr 2018 00:42:36 +0200
Message-Id: <20180416224236.17078-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <20180416224236.17078-1-szeder.dev@gmail.com>
References: <20180416224113.16993-1-szeder.dev@gmail.com>
 <20180416224236.17078-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During git-aware path completion, when a lot of path components have
to be listed, a significant amount of time is spent in
__gitcomp_file(), or more accurately in the shell loop of
__gitcompappend(), iterating over all the path components filtering
path components matching the current word to be completed, adding
prefix path components, and placing the resulting matching paths into
the COMPREPLY array.

Now, a previous patch in this series made 'git ls-files' and 'git
diff-index' list only paths matching the current word to be completed,
so an additional filtering in __gitcomp_file() is not necessary
anymore.  Adding the prefix path components could be done much more
efficiently in __git_index_files()'s 'awk' script while stripping
trailing path components and removing duplicates and quoting.  And
then the resulting paths won't require any more filtering or
processing before being handed over to Bash, so we could fill the
COMPREPLY array directly.

Unfortunately, we can't simply use the __gitcomp_direct() helper
function to do that, because __gitcomp_file() does one additional
thing: it tells Bash that we are doing filename completion, so the
shell will kindly do four important things for us:

  1. Append a trailing space to all filenames.
  2. Append a trailing '/' to all directory names.
  3. Escape any meta, globbing, separator, etc. characters.
  4. List only the current path component when listing possible
     completions (i.e. 'dir/subdir/f<TAB>' will list 'file1', 'file2',
     etc. instead of the whole 'dir/subdir/file1',
     'dir/subdir/file2').

While we could let __git_index_files()'s 'awk' script take care of the
first two points, the third one gets tricky, and we absolutely need
the shell's support for the fourth.

Add the helper function __gitcomp_file_direct(), which, just like
__gitcomp_direct(), fills the COMPREPLY array with prefiltered and
preprocessed paths without any additional processing, without a shell
loop, with just one single compound assignment, and, similar to
__gitcomp_file(), tells Bash and ZSH that we are doing filename
completion.  Extend __git_index_files()'s 'awk' script a bit to
prepend any prefix path components to all listed paths.  Finally,
modify __git_complete_index_file() to feed __git_index_files()'s
output to ___gitcomp_file_direct() instead of __gitcomp_file().

After this patch there is no shell loop left in the path completion
code path.

This speeds up path completion when there are a lot of paths matching
the current word to be completed.  In a pathological repository with
100k files in a single directory, listing all those files:

  Before this patch, best of five, using GNU awk on Linux:

    $ time cur=dir/ __git_complete_index_file

    real    0m0.983s
    user    0m1.004s
    sys     0m0.033s

  After:

    real    0m0.313s
    user    0m0.341s
    sys     0m0.029s

  Difference: -68.2%
  Speedup:      3.1x

  To see the benefits of the whole patch series, the same command with
  v2.17.0:

    real    0m2.736s
    user    0m2.472s
    sys     0m0.610s

  Difference: -88.6%
  Speedup:      8.7x

Note that this patch changes the output of the __git_index_files()
helper function by unconditionally prepending the prefix path
components to every listed path.  This would break users' completion
scriptlets that directly run:

  __gitcomp_file "$(__git_index_files ...)" "$pfx" "$cur_"

because that would add the prefix path components once more.
However, __git_index_files() is kind of a "helper function of a helper
function", and users' completion scriptlets should have been using
__git_complete_index_file() for git-aware path completion in the first
place, so this is likely doesn't worth worrying about.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 34 +++++++++++++++++++++++---
 contrib/completion/git-completion.zsh  |  9 +++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e97d57024b..360ee9ca51 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -404,6 +404,23 @@ __gitcomp_nl ()
 	__gitcomp_nl_append "$@"
 }
 
+# Fills the COMPREPLY array with prefiltered paths without any additional
+# processing.
+# Callers must take care of providing only paths that match the current path
+# to be completed and adding any prefix path components, if necessary.
+# 1: List of newline-separated matching paths, complete with all prefix
+#    path componens.
+__gitcomp_file_direct ()
+{
+	local IFS=$'\n'
+
+	COMPREPLY=($1)
+
+	# use a hack to enable file mode in bash < 4
+	compopt -o filenames +o nospace 2>/dev/null ||
+	compgen -f /non-existing-dir/ > /dev/null
+}
+
 # Generates completion reply with compgen from newline-separated possible
 # completion filenames.
 # It accepts 1 to 3 arguments:
@@ -455,14 +472,14 @@ __git_index_files ()
 	local root="$2" match="$3"
 
 	__git_ls_files_helper "$root" "$1" "$match" |
-	awk -F / '{
+	awk -F / -v pfx="${2//\\/\\\\}" '{
 		paths[$1] = 1
 	}
 	END {
 		for (p in paths) {
 			if (substr(p, 1, 1) != "\"") {
 				# No special characters, easy!
-				print p
+				print pfx p
 				continue
 			}
 
@@ -481,7 +498,7 @@ __git_index_files ()
 				# skip it.
 				continue
 			else
-				print p
+				print pfx p
 		}
 	}
 	function dequote(p,    bs_idx, out, esc, esc_idx, dec) {
@@ -545,7 +562,7 @@ __git_complete_index_file ()
 		cur_="$dequoted_word"
 	esac
 
-	__gitcomp_file "$(__git_index_files "$1" "$pfx" "$cur_")" "$pfx" "$cur_"
+	__gitcomp_file_direct "$(__git_index_files "$1" "$pfx" "$cur_")"
 }
 
 # Lists branches from the local repository.
@@ -3311,6 +3328,15 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 	}
 
+	__gitcomp_file_direct ()
+	{
+		emulate -L zsh
+
+		local IFS=$'\n'
+		compset -P '*[=:]'
+		compadd -Q -f -- ${=1} && _ret=0
+	}
+
 	__gitcomp_file ()
 	{
 		emulate -L zsh
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index c3521fbfc4..53cb0f934f 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -93,6 +93,15 @@ __gitcomp_nl_append ()
 	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
+__gitcomp_file_direct ()
+{
+	emulate -L zsh
+
+	local IFS=$'\n'
+	compset -P '*[=:]'
+	compadd -Q -f -- ${=1} && _ret=0
+}
+
 __gitcomp_file ()
 {
 	emulate -L zsh
-- 
2.17.0.366.gbe216a3084

