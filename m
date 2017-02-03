Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8F21FAF4
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbdBCCtj (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:39 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35122 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbdBCCth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:37 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so1170374wmu.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4doW5WG4BWtmKYsLs/jOErp8/UsopsKxaShRTRKCNgs=;
        b=qLdkHR0EJHdD7vYDTFvOBpAo07mivbY4LjXn23IqR4XTli/b175x6nnD9/KrT7F2fZ
         RMSFjqFmlnH7g8aHuVI9UJtGBbVWKJYRuKwist1WIpaCvt4geoBLcUTZ/L9j9WT3fjem
         QcilGSqfsZHWAko1lEnVxGHwwaK8YUAk87v73qP4WutkS1XK5QubcWBYXRUhcAqelaAi
         Gdh1PoodjzHVigczpF5axmAu6D3UmjGf/vvJMCFKP8xTVBF5V15IAVP/cXGJqxoRAtXU
         W6dFSu6NZAG0RamYgvFb7Z/NN8ShFsshybqubGfQgoOzCtC1OOs2VtqEvfDOw3uD6w79
         grTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4doW5WG4BWtmKYsLs/jOErp8/UsopsKxaShRTRKCNgs=;
        b=Tp0cAbstZbgkrZxMygEB79ImpP0vlHhf/sZ5m99QvkTndgPmGzWEL4p+iP9LQMeDBV
         FiyP2+5lj4wdtNhTDSKtP0pKQTket3ANvMfWdsNKgGUGKj0fTeqdLXCAGL3DW36NsT+T
         l/jIZSzw182WBKp1KY2LC8bnMxJukXLgKl1WPnn972FbV31E3EaX258A3pTkvbPFXTmr
         79vmicp/GzKTbLgzMwqw8zeokNwNlTgclflQAQotRTGipsCNcepxDmuc8QuDgD6jvR9b
         Ej0bTnwsJZugn7KQWvkXMdo3nFPCQlSBVxYAoZobaLI5IAVpDRzygNfBIbVy9sve6XBU
         gLPw==
X-Gm-Message-State: AIkVDXI17YRRMnmRArGuq/RtwsT2olU8Ms+ce7H/YbE8t15o5Rk5Jf1p+wZ2J1qaokZ6Qw==
X-Received: by 10.223.179.15 with SMTP id j15mr9558320wrd.159.1486090160739;
        Thu, 02 Feb 2017 18:49:20 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:20 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 08/21] completion: fix most spots not respecting 'git --git-dir=<path>'
Date:   Fri,  3 Feb 2017 03:48:16 +0100
Message-Id: <20170203024829.8071-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The completion script already respects the path to the repository
specified on the command line most of the time, here we add the
necessary '--git-dir=$(__gitdir)' options to most of the places where
git was executed without it.  The exceptions where said option is not
added are the git invocations:

  - in __git_refs() which are non-trivial and will be the subject of
    the following patch,

  - getting the list of git commands, merge strategies and archive
    formats, because these are independent from the repository and
    thus don't need it, and

  - the 'git rev-parse --git-dir' in __gitdir() itself.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5b2bd6721..295f6de24 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -283,11 +283,13 @@ __gitcomp_file ()
 # argument, and using the options specified in the second argument.
 __git_ls_files_helper ()
 {
+	local dir="$(__gitdir)"
+
 	if [ "$2" == "--committable" ]; then
-		git -C "$1" diff-index --name-only --relative HEAD
+		git --git-dir="$dir" -C "$1" diff-index --name-only --relative HEAD
 	else
 		# NOTE: $2 is not quoted in order to support multiple options
-		git -C "$1" ls-files --exclude-standard $2
+		git --git-dir="$dir" -C "$1" ls-files --exclude-standard $2
 	fi 2>/dev/null
 }
 
@@ -408,7 +410,7 @@ __git_refs2 ()
 __git_refs_remotes ()
 {
 	local i hash
-	git ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
+	git --git-dir="$(__gitdir)" ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
 	while read -r hash i; do
 		echo "$i:refs/remotes/$1/${i#refs/heads/}"
 	done
@@ -1186,7 +1188,7 @@ _git_commit ()
 		return
 	esac
 
-	if git rev-parse --verify --quiet HEAD >/dev/null; then
+	if git --git-dir="$(__gitdir)" rev-parse --verify --quiet HEAD >/dev/null; then
 		__git_complete_index_file "--committable"
 	else
 		# This is the first commit
@@ -1486,7 +1488,7 @@ _git_log ()
 {
 	__git_has_doubledash && return
 
-	local g="$(git rev-parse --git-dir 2>/dev/null)"
+	local g="$(__gitdir)"
 	local merge=""
 	if [ -f "$g/MERGE_HEAD" ]; then
 		merge="--merge"
-- 
2.11.0.555.g967c1bcb3

