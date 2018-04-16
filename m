Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96DB61F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeDPWle (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:41:34 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42363 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeDPWl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:41:29 -0400
Received: by mail-wr0-f193.google.com with SMTP id s18so30244078wrg.9
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1otGnuyYaj5hI0thCNRvELe8upxb6Y20aX4/q85H55U=;
        b=ulLaoGcNOIrqA2GMDE1t3KnvGeyFOFqJe44DYvwZId/9Esn1lGE7oeneepNBysuSVd
         9MvhyStxj8XM4SrGju9Jirp9jFEAlCop49IoPdiILxy5LtWF021vMO/6AJpfxheF5VVx
         trNROMPf4gtfB+X9Y5IM42mAxDBTAG82Stxh2rZRfftpqGOmEuMCPVzMSC85lThHhmUw
         PWAUq/ERXDmSOWf/WV2dSi7gDgvzAMISDLcjg/ieunqjDbVK/L0haO0Ok6kjF0CTJSlF
         z/dxbgcvd8xRLA4cLLzsElsEJahkxniJLjQ/0jQy9Jbjz5r/eWHV1vWQfqwQPi3JLNk3
         TKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1otGnuyYaj5hI0thCNRvELe8upxb6Y20aX4/q85H55U=;
        b=rqdyvwY5Y5jq/l9V4nfsKjlwZBayLyPEEowxDCkuFq5DI9rjQVLBkruSrnW4gOoBtG
         +1ULLGDenqIP/thD4m2yxYk3bvQ3mmDAQWK6M3l8SBzkr/jJCtOtG7eQgDhgRi65XdBd
         ksGFHEDdronHhszGhqTf/Jncetu4iMvQBINx79PIFbBnGcBde7aMPqN5KIiLaR8J2wNm
         P3lVbz2UuxYpjjqM07D7P4K+NF1dx0MyFmpZOUNKpxcT3KVA/AkyaOPFsOcH+2AUGd5b
         Sn6xAgDNqrCCMg+KGZM5tc/EECFOcuD7i1pqoUGqzsO1DK6MPzRnsz1+FEXi8CPkMDn4
         221w==
X-Gm-Message-State: ALQs6tCzR7D8HcOW+Lna36SGAzlGGfm3qVzH/BeZvc1fa07cppQzWKwf
        xjx3dO/Nf/qYxyERqDjp3qX8Iw==
X-Google-Smtp-Source: AIpwx4+2HYyMjD+S0SHIwPrzSaWwP9vPM/+vpNnXqcUKDhRtOVfvkpluAvu5toVcA5IwEK6VXvKcDQ==
X-Received: by 10.28.207.201 with SMTP id f192mr65028wmg.148.1523918487901;
        Mon, 16 Apr 2018 15:41:27 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id p128sm14977788wmd.45.2018.04.16.15.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:41:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 07/11] completion: use 'awk' to strip trailing path components
Date:   Tue, 17 Apr 2018 00:41:11 +0200
Message-Id: <20180416224113.16993-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <20180416224113.16993-1-szeder.dev@gmail.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com>
 <20180416224113.16993-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During git-aware path completion we complete one path component at a
time, i.e. 'git add <TAB>' offers only 'dir/' at first, not
'dir/subdir/file' right away, just like Bash's own filename
completion.  However, since both 'git ls-files' and 'git diff-index'
dive deep into subdirectories, we have to strip all trailing path
components from the listed paths, keeping only the leading path
component.  This stripping is currently done in a shell loop in
__git_index_files(), which can take a significant amount of time when
it has to iterate through a large number of paths.

Replace this shell loop with a little 'awk' script using '/' as input
field separator and printing the first field, which produces the same
output much faster.

Listing all tracked files (12) and directories (23) at the top of the
worktree in linux.git (over 62k files), i.e. what's doing all the hard
work behind 'git rm <TAB>':

  Before this patch, best of five, using GNU awk on Linux:

    $ time cur= __git_complete_index_file

    real    0m2.149s
    user    0m1.307s
    sys     0m1.086s

  After:

    real    0m0.067s
    user    0m0.089s
    sys     0m0.023s

  Difference: -96.9%
  Speedup:     32.1x

Note that this could be done with 'sed', or even with 'cut', just as
well, but the upcoming patches require 'awk's scriptability.

Note also that this change means one more fork()+exec()ed process
during path completion, adding more overhead especially on Windows,
but a later patch will more than make up for it by eliminating two
other processes in the same function.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3948265d32..0abba88462 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -452,15 +452,12 @@ __git_ls_files_helper ()
 # 3: List only paths matching this path component (optional).
 __git_index_files ()
 {
-	local root="$2" match="$3" file
+	local root="$2" match="$3"
 
 	__git_ls_files_helper "$root" "$1" "$match" |
-	while read -r file; do
-		case "$file" in
-		?*/*) echo "${file%%/*}" ;;
-		*) echo "$file" ;;
-		esac
-	done | sort | uniq
+	awk -F / '{
+		print $1
+	}' | sort | uniq
 }
 
 # __git_complete_index_file requires 1 argument:
-- 
2.17.0.366.gbe216a3084

