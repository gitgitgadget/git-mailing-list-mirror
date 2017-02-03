Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8218C1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbdBCCyh (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:37 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33925 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbdBCCyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:33 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so1209516wmi.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8E1hplQUEk7MPaPNEt+LQbtnYHDxB0QvQgn+BCLo7M=;
        b=MfN1355OQieWH0THu/u0mliTRSrMJ0/GZ5eC9CJidgiCaLHD18H96L4U1gYyqZSY9M
         ND8zSIk0yDF7bGYnAa6NSgfsiNqxTM4T0JvM31Hd6HXoVGabx28PCg+Aq5BGEPGurJra
         6CYNFd7APaHAdVjMLrkihe+EnTyocE+ceVBZwoarhpze84sX3kWbXIru6lNA8CzrkVRo
         wCM/Iyut73gU8F6l+k+q5JR0PviyW33XuLF/0RtOfzZrz9Tvg3xVfSiHLD7+OKL9DCbc
         gviO1OgeJbvnRezg1nKLnpYJ+gwNyvnETWOlBW+aXivO4Whnnow+e7B8wWmhvZtndSWW
         g18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8E1hplQUEk7MPaPNEt+LQbtnYHDxB0QvQgn+BCLo7M=;
        b=I/79dxHjTY0Eh/u5rmmxexQ8QXWVTV+113LE+iH7aXJnSb0FXJKRkZIdV1CPU1dRJj
         dElruwpa7XwoFa8K0cnAzKpBu1c+3zKx0FysIkgT3ore/TK3+TXI0I6LxDE2H80QzPgV
         HLlDZldsE+npzX6Qyq2t/w3QI8MXBfMMmNWk294gli43+TRQnt07iWWqe9mzQI0G/uCb
         m3ZUlZUTPoX9sV+SA2gH958R3QoP016XBw84JPoOeuOKfzaxaIQfd1J5Clo8xD4Hv/K6
         54c+P4mavnA1lPCoTZhOzAhRvLbNbl4HdicGEjQJtH/pEvhLPojtepyRxXavBEyPyzJg
         dxWw==
X-Gm-Message-State: AIkVDXK4QE8HgQHouCtvnQlSISTiYu2Ri1EWjBHkQpVxZtiKWebFRmqykphcZwbk/dozXw==
X-Received: by 10.223.177.202 with SMTP id r10mr10023515wra.94.1486090471899;
        Thu, 02 Feb 2017 18:54:31 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:31 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 08/12] completion: let 'for-each-ref' strip the remote name from remote branches
Date:   Fri,  3 Feb 2017 03:54:01 +0100
Message-Id: <20170203025405.8242-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203025405.8242-1-szeder.dev@gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code listing unique remote branches for 'git checkout's tracking
DWIMery uses a shell parameter expansion in a loop iterating over each
listed ref to remove the remote's name from the remote branches, i.e.
the leading path component from the short ref.  When listing refs from
a configured remote repository, '| sed s///' is used for the same
purpose.

Let 'git for-each-ref' strip one more leading path component from the
refs, i.e. use the format 'refname:strip=3' instead of '=2', making
that parameter expansion and 'sed' execution unnecessary.

This speeds up refs completion for 'git checkout'.  Uniquely
completing a branch for 'git checkout maste<TAB>' in a repo with 100k
remote branches, all packed, best of five:

  On Linux, near the beginning of this series, for reference:

    $ time __git_complete_refs --cur=maste --track

    real    0m8.185s
    user    0m6.896s
    sys     0m1.616s

  Before this patch:

    real    0m2.714s
    user    0m2.344s
    sys     0m0.436s

  After:

    real    0m1.993s
    user    0m1.740s
    sys     0m0.304s

  On Windows, near the beginning:

    real    1m8.421s
    user    0m7.591s
    sys     0m3.557s

  Before this patch:

    real    0m8.191s
    user    0m4.638s
    sys     0m2.918s

  After:

    real    0m6.187s
    user    0m3.358s
    sys     0m2.121s

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 615292f8b..8f1203025 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -414,11 +414,10 @@ __git_refs ()
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
 			local ref entry
-			__git for-each-ref --shell --format="ref=%(refname:strip=2)" \
+			__git for-each-ref --shell --format="ref=%(refname:strip=3)" \
 				"refs/remotes/" | \
 			while read -r entry; do
 				eval "$entry"
-				ref="${ref#*/}"
 				if [[ "$ref" == "$cur_"* ]]; then
 					echo "$ref"
 				fi
@@ -439,9 +438,9 @@ __git_refs ()
 	*)
 		if [ "$list_refs_from" = remote ]; then
 			echo "HEAD"
-			__git for-each-ref --format="%(refname:strip=2)" \
+			__git for-each-ref --format="%(refname:strip=3)" \
 				"refs/remotes/$remote/$cur_*" \
-				"refs/remotes/$remote/$cur_*/**" | sed -e "s#^$remote/##"
+				"refs/remotes/$remote/$cur_*/**"
 		else
 			__git ls-remote "$remote" HEAD \
 				"refs/tags/$cur_*" "refs/heads/$cur_*" \
-- 
2.11.0.555.g967c1bcb3

