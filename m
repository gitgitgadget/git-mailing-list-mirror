Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46661F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbdBCCy4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:56 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33932 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbdBCCye (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:34 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so1209561wmi.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q35xieNF8+sMJIZAplV1zCnJXzA2hOpxUzt36l8GJT4=;
        b=ROw9+DhJDDqmSwL7KKzxp8bN32HlPjvNeILAmLFd3WSdf8WrRbjo7kSpEwyMLUXdfy
         1jFJJ3fgy8YLBhzQmIS02e4ko7/Bw1GrQbWtre7k1fudMzFgTgTd7gYu9oieC/KFPMuH
         d3nG+XSpqp/OJVkjEF+9qIJ9X/gKzSQjOLCE0cx7juRvbk4e3Agdqkp12RJlRt022y/o
         dQEOhZDOw7SMhBI2YHzdrNRQeQ8D6foDGDb+bGRB8NDlauZcyzBaVGoXzL6fXmeopVSl
         Tf69S+kmOucSIHa0IGM0a/JflbrWMB9pnQuzp63XSUF/l7oVrlN/D1jneGHqZZcSKG+1
         oIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q35xieNF8+sMJIZAplV1zCnJXzA2hOpxUzt36l8GJT4=;
        b=Rmj+Bk3Qzw+SQWW5yUXMT+YTx0ZsRl36plKdPj+Al2EXjBXoGX9S8hJYgFXRyei26M
         u7lW5crrXwtDlxcpxpBzH/581OQ8/oe8JZef5VM9Ttq8uJ0WPDOv1+XxqKUt6RYAxlTv
         0clTiQaBNnFSbYgDMl3FJrD42HZxWCd9SveFpp6TlxPuW8YC2kjoZjwp3QGGPezWdek7
         7UDhOfE1oN59vbaGOWiSBu7fCW3FM5uPvMU/6oPYoNcLhVBxuYDxVv65g9LABrfWqnGU
         7pxBd3Nm8dBPJ+z/A1Zdr3OcdvMzDKjLj637spQ8/0qM+VXMPD4DQxp/CE9uUYZOSifU
         2wHQ==
X-Gm-Message-State: AMke39kTH94fMUp8fKyNu0SQ8UCub+XofS4dOQn1/s5z44BhdeCPIHR0OeSu71jzImSwkg==
X-Received: by 10.28.179.7 with SMTP id c7mr422870wmf.128.1486090472971;
        Thu, 02 Feb 2017 18:54:32 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:32 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 09/12] completion: let 'for-each-ref' filter remote branches for 'checkout' DWIMery
Date:   Fri,  3 Feb 2017 03:54:02 +0100
Message-Id: <20170203025405.8242-10-szeder.dev@gmail.com>
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
DWIMery outputs only remote branches that match the current word to be
completed, but the filtering is done in a shell loop iterating over
all remote refs.

Let 'git for-each-ref' do the filtering, as it can do so much more
efficiently and we can remove that shell loop entirely.

This speeds up refs completion for 'git checkout' considerably when
there are a lot of non-matching remote refs to be filtered out.
Uniquely completing a branch in a repository with 100k remote
branches, all packed, best of five:

  On Linux, before:

    $ time __git_complete_refs --cur=maste --track

    real    0m1.993s
    user    0m1.740s
    sys     0m0.304s

  After:

    real    0m0.266s
    user    0m0.248s
    sys     0m0.012s

  On Windows, before:

    real    0m6.187s
    user    0m3.358s
    sys     0m2.121s

  After:

    real    0m0.750s
    user    0m0.015s
    sys     0m0.090s

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8f1203025..e2c4794f3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -413,15 +413,9 @@ __git_refs ()
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
-			local ref entry
-			__git for-each-ref --shell --format="ref=%(refname:strip=3)" \
-				"refs/remotes/" | \
-			while read -r entry; do
-				eval "$entry"
-				if [[ "$ref" == "$cur_"* ]]; then
-					echo "$ref"
-				fi
-			done | sort | uniq -u
+			__git for-each-ref --format="%(refname:strip=3)" \
+				"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
+			sort | uniq -u
 		fi
 		return
 	fi
-- 
2.11.0.555.g967c1bcb3

