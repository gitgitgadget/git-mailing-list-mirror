Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 938CF1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 00:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfJKALG (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 20:11:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44872 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfJKALG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 20:11:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so7963714ljj.11
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 17:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DCaadtoTYo9FkdqDkeioOpYcQKjRt90yplvgLHztZCA=;
        b=dWa+AR99UQCOjXvvuh6EYcOqi5Lk7fo9fsu96jI6KdlTghFPzq3KMYtG5bNg8ma/LK
         MTG4JwOWCvdLqdVCqRX4MxVu40m30Kf4ZUswFHuOpSO85vWCWtc3UWWhnFhT6G+l35ia
         44KMFUSAMuSRDnySrhJmXvl6eaEg/Rs7NB/KtVBvUJWkPqIN799jL5Dj69yx3zv4vnmS
         5tgfz0fytnO5OcHs4u9SQuQz1MMNQHAuLC/HKh3JrliQgtfUwgvvoTvhwmpgr+d18TKl
         tOFIBysyDA3WzVeuARZ7suBhSeACmTY1y4utM/HNw2SRPDZt2Qqemvu7rZOLrSrFYKdO
         c95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DCaadtoTYo9FkdqDkeioOpYcQKjRt90yplvgLHztZCA=;
        b=dxkFVXvR2YIuG8jU/EwoMyBgFj/oCwN6qbRIJsNcjPoFnDYHBY3wrbyG3mf1d7E5S1
         nKsvSUFDHMGQaNr+CAwX93dPQI2q1btEPpQL/45mpQ8IUHoj14RD9M6d+pVKfWN2hh4w
         /tJfgAsr+nYPiq+gNdnTkbkjEA2V7mqyiWS7UfMDokjm5mRNg1GVYhEII7nG+OovEzOQ
         khGfIYz1t6BUsaDpCGsJeMJ1SBRmU8Nt0t8q+ACc6cvkGlhVBuPUld5Q/ILuSoZkZxup
         5L4JlKc66ZkwP0JF+83m8X5wku46NGup+BWbub78BI1TnVT8HM6UV4KTxnAff8JukCnm
         /cwA==
X-Gm-Message-State: APjAAAU7fHXYtvLJ3yqFgQ6KrdqYoPldOT3+wqgLZRzy8ye2M9N8fk6X
        stHuTMMZ8aeceolUluoSPo4Wdvu2
X-Google-Smtp-Source: APXvYqx2W9u79CarrpV4TfjmLoDSM98rneb8CnO7DU0HGuOFVEy30KB/6gsJF8KCwp/VtS8iysP0/w==
X-Received: by 2002:a2e:1214:: with SMTP id t20mr7989152lje.240.1570752664053;
        Thu, 10 Oct 2019 17:11:04 -0700 (PDT)
Received: from OJAN-PAAVO.localdomain ([213.80.106.30])
        by smtp.gmail.com with ESMTPSA id y26sm1778915ljj.90.2019.10.10.17.11.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:11:03 -0700 (PDT)
Date:   Fri, 11 Oct 2019 02:11:14 +0200
From:   Jakob Jarmar <jakob.j@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] stash: avoid recursive hard reset on submodules
Message-ID: <20191011001114.GB640501@OJAN-PAAVO.localdomain>
References: <CA+xNDHtVc7pJr=SdihKDKiLE9TE_TcpEWWmPq+N9+fFcfM36wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+xNDHtVc7pJr=SdihKDKiLE9TE_TcpEWWmPq+N9+fFcfM36wA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git stash push does not recursively stash submodules, but if
submodule.recurse is set, it may recursively reset --hard them. Having
only the destructive action recurse is likely to be surprising
behaviour, and unlikely to be desirable, so the easiest fix should be to
ensure that the call to git reset --hard never recurses into submodules.

This matches the behavior of check_changes_tracked_files, which ignores
submodules.

Signed-off-by: Jakob Jarmar <jakob@jarmar.se>
---

Sorry for sending a patch with messed up whitespace. This one should be
correct.

 builtin/stash.c     | 2 +-
 git-legacy-stash.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index b5a301f24d..c986c258f2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1383,7 +1383,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 			cp.git_cmd = 1;
 			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
-					 NULL);
+					 "--no-recurse-submodules", NULL);
 			if (run_command(&cp)) {
 				ret = -1;
 				goto done;
diff --git a/git-legacy-stash.sh b/git-legacy-stash.sh
index f60e9b3e87..07ad4a5459 100755
--- a/git-legacy-stash.sh
+++ b/git-legacy-stash.sh
@@ -370,7 +370,7 @@ push_stash () {
 			git diff-index -p --cached --binary HEAD -- "$@" |
 			git apply --index -R
 		else
-			git reset --hard -q
+			git reset --hard -q --no-recurse-submodules
 		fi
 
 		if test "$keep_index" = "t" && test -n "$i_tree"
-- 
2.23.0

