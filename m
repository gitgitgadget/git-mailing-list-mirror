Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31931F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeDPWlf (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:41:35 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42371 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeDPWlb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:41:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id s18so30244209wrg.9
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dphqOukVzOzuoH0JeDVS8C3dIMVdx45Iczx2TeOry4=;
        b=CvBy1vkf0or39/GNkKpfYGzxYZupjB8BtbkiyMq0iV7VtmTejOFvXZRlThZQrs355K
         jZGtiRa1Fi1fA9YkA5nB/FKGFFsBxcB5E1g+XfkAT9uvbRMleVDC6LHMhqzgUgjUWowp
         AVpVRChZcQDxywZ93PchhByzmW73dGm0WPWpaZJLK6jGQiULeMhbC4Du0T18zmKdFlIj
         ykcMK67tbAzV7BmcvygdKNS1aO9RaUbTJydECOW+G7O8VqsqcHs6EPAa8CfBS1VXsQoh
         ZysOqYEurA0K9Wb+Qp1s9oCl5v5wyzpr0xiHZNAGuXmjKN5e5Q5icpooBV3ol8EC1Nw0
         eLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dphqOukVzOzuoH0JeDVS8C3dIMVdx45Iczx2TeOry4=;
        b=W3P7dDgM4xwfQjYTmSFbBqlpFNPs3FctsCW/XgWg0ofLSRmUnonDAcr9lnKVOIEzsM
         CuWZ91Y7lYbUP/N4NFQg/VKb5MFRowHWYaNB9BWjuDC77EV85gC2nx2ejVNBopDlF5OE
         5/SPfpypR4ppPXywyaDfXSaFwo2E5EpUij7QUJTKkqz5Zh1Hjnsamd/Yllclu6ZTejHw
         B0IEy+MGNn2iAP1f3ScY5+isfyvj8oF9cTAm9cwL7qq1p80rxUuOH9pCOZU8qTOFNLb0
         YpISLSMiYJUiVuZkQCBjsvj88j6Ph21AdHENiKXpxDKmRPqSpmSrDzOAXOtp/aGr17C3
         Z48A==
X-Gm-Message-State: ALQs6tB8r716YGvl+DFjf+1KLu6ngnqF6of0xDN1FoB5AQkj93FRgK6G
        vntz54Po6ExViQQCUjxle6XlbQ==
X-Google-Smtp-Source: AIpwx4+4w3pwGHnD3PvggaqyLvuIXCq+tMnKJ5hyFQiNY/HrKM7KzvczlbkJUBVHq1HULhwWSHTtOA==
X-Received: by 10.223.192.136 with SMTP id d8mr10888969wrf.268.1523918489744;
        Mon, 16 Apr 2018 15:41:29 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id p128sm14977788wmd.45.2018.04.16.15.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:41:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 09/11] completion: remove repeated dirnames with 'awk' during path completion
Date:   Tue, 17 Apr 2018 00:41:13 +0200
Message-Id: <20180416224113.16993-10-szeder.dev@gmail.com>
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

During git-aware path completion, after all the trailing path
components have been removed from the output of 'git ls-files' and
'git diff-index' (see previous patch), each directory name is repeated
as many times as the number of listed paths it contains.  This can be
a lot of repetitions, especially when invoking path completion close
to the root of a big worktree, which would cause a considerable
overhead downstream of __git_index_files(), in particular in the shell
loop that fills the COMPREPLY array.  To reduce this overhead,
__git_index_files() runs the classic '... |sort |uniq' pattern to
remove those repetitions from the function's output.

While removing repeated directory names is effective in reducing the
number of iterations in that shell loop, it still imposes the overhead
of fork()+exec()ing two external processes, and two additional stages
in the pipeline, where potentially relatively large amount of data can
be passed between two subsequent pipeline stages.

Extend __git_index_files()'s 'awk' script to remove repeated path
components by first creating and filling an associative array indexed
by all encountered path components (after the trailing path components
have been removed), and then iterating over this array and printing
the indices, i.e. unique path components.  This way we can remove the
'|sort |uniq' pipeline stages, and their eliminated overhead results
in faster path completion.

Listing all tracked files (12) and directories (23) at the top of the
worktree in linux.git (over 62k files), i.e. what's doing all the hard
work behind 'git rm <TAB>':

  Before this patch, best of five, using GNU awk on Linux:

    real    0m0.069s
    user    0m0.089s
    sys     0m0.026s

  After:

    real    0m0.052s
    user    0m0.072s
    sys     0m0.014s

  Difference: -24.6%

Note that this changes order of elements in __git_index_files()'s
output.  This is not an issue, because this function was only ever
intended to feed paths into the COMPREPLY array, and Bash will sort
its elements (according to the users locale) anyway.

Note also that using 'awk' to remove repeated path components is also
beneficial for the performance of the next two patches:

  - The first will extend this 'awk' script to dequote quoted paths in
    the output of 'git ls-files' and 'git diff-index'.  With this
    patch it will only have to dequote unique path components, not
    all.

  - The second will, among other things, extend this 'awk' script to
    prepend prefix path components from the command line to the
    currently completed path component.  Consequently, each line in
    'awk's output will grow longer.  Without this patch that '|sort
    |uniq' would have to exchange and process that much more data.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0abba88462..70bc75dfc7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -456,8 +456,12 @@ __git_index_files ()
 
 	__git_ls_files_helper "$root" "$1" "$match" |
 	awk -F / '{
-		print $1
-	}' | sort | uniq
+		paths[$1] = 1
+	}
+	END {
+		for (p in paths)
+			print p
+	}'
 }
 
 # __git_complete_index_file requires 1 argument:
-- 
2.17.0.366.gbe216a3084

