Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492291F404
	for <e@80x24.org>; Thu, 15 Mar 2018 16:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeCOQoq (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 12:44:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40348 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeCOQop (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 12:44:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id e5-v6so7153170lfb.7
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTWj/8Ov5pQgdE0YRUFvniCxXN95kxt8uXD2GIi+y2s=;
        b=WdJiCIMrgBBcSK3VeBEdyb0shh+p/O9HZr8xzawERQccVWTSGpvxIA6z89XLDXBltV
         WlnY10sBUFBwH9ASj0KMvtYoMwSc/zDS0iwGV4BzVXheeki1khgcNlFqNZwUqH8thjk0
         hJArcg0u+O6zCbm3lv2E0oE6xg3o0RC+fC31PeFSQeDQKlW8xqbhnc63dIq1oX7H2rHH
         KKe5vobPwuErI6oG/q0vBQW+86csvP1/YwGTtQP5blm7PqnhBoei7tYdyO+5kA0ndn9S
         IT/7QugNEsJO7NRdGmaPjm0xQX2zmi91Cu4C6P4RUZ8qwzNW3fvulTgI66fu4q3HOLQV
         wR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTWj/8Ov5pQgdE0YRUFvniCxXN95kxt8uXD2GIi+y2s=;
        b=GzS/jEo3Zlb0012Nt56WfzF6LjBfsLeETs/sSNoEERjdXMy7yCQRTpDUakJaUpMi87
         fvmz8B3oqOoCINzc7tBtZJxMM/05MH/IWoKSpDpwg5wY46uWx/5IMJyDIMYhfbbDiVZ9
         VigFf02svOwE80cOI5Jg8IQoA0dUNms1ubW2YL+iz1SV6l80dLvvyIobq0RGITR8HSPM
         xDnz6GTE8NgcRNTSCtqeebTurzvHOkqHtzImu2nMjRTWI7Bp4oxVRfV3wkksM8/I71+h
         xk/lPvNmiX+rc8cc2gdLH90sUOZKs2BXFPbdyN4949Z0Kk92M1V6fEfSxfKKDf2aoLk8
         OGjw==
X-Gm-Message-State: AElRT7Fob7fogrzhLm5x1DyQKjtN5OT7gDlTPfl+Zu5wDmP4oPqLYopw
        KKWaJ8xjCGloMa14Uu0V73o=
X-Google-Smtp-Source: AG47ELsiXr0Px1nqNhrwMghqzm0oVFx139pe91H+bvH3nATfgtk/u/hjLYUdvj27dLqvOGZNJXN6eA==
X-Received: by 2002:a19:4350:: with SMTP id m16-v6mr7009924lfj.105.1521132283324;
        Thu, 15 Mar 2018 09:44:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u24sm1037406lju.32.2018.03.15.09.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Mar 2018 09:44:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] worktree prune: improve prune logic when worktree is moved
Date:   Thu, 15 Mar 2018 17:44:12 +0100
Message-Id: <20180315164412.14697-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180315164412.14697-1-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com>
 <20180315164412.14697-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Automatic detection of worktree relocation by a user (via 'mv', for
instance) was removed by 618244e160 (worktree: stop supporting moving
worktrees manually - 2016-01-22). Prior to that,
.git/worktrees/<tag>/gitdir was updated whenever the worktree was
accessed in order to let the pruning logic know that the worktree was
"active" even if it disappeared for a while (due to being located on
removable media, for instance).

"git worktree move" has come so we don't really need this, but since
it's easy to do, perhaps we could keep supporting manual worktree move
a bit longer. Notice that when a worktree is active, the "index" file
should be updated pretty often in common case. The logic is updated to
check for index mtime to see if the worktree is alive.

The old logic of checking gitdir's mtime is dropped because nobody
updates it anyway. The new corner case is, if the index file does not
exist, we immediately remove the stale worktree. But if the "index"
file does not exist, you may have a bigger problem.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c        | 3 ++-
 t/t2026-worktree-prune.sh | 7 +++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index e55edf2aa5..594ace7c2b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -102,7 +102,8 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	path[len] = '\0';
 	if (!file_exists(path)) {
 		free(path);
-		if (st.st_mtime <= expire) {
+		if (stat(git_path("worktrees/%s/index", id), &st) ||
+		    st.st_mtime <= expire) {
 			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
 			return 1;
 		} else {
diff --git a/t/t2026-worktree-prune.sh b/t/t2026-worktree-prune.sh
index a0f1e3bb80..b7d6d5d45a 100755
--- a/t/t2026-worktree-prune.sh
+++ b/t/t2026-worktree-prune.sh
@@ -78,10 +78,9 @@ test_expect_success 'not prune locked checkout' '
 
 test_expect_success 'not prune recent checkouts' '
 	test_when_finished rm -r .git/worktrees &&
-	mkdir zz &&
-	mkdir -p .git/worktrees/jlm &&
-	echo "$(pwd)"/zz >.git/worktrees/jlm/gitdir &&
-	rmdir zz &&
+	git worktree add jlm HEAD &&
+	test -d .git/worktrees/jlm &&
+	rm -rf jlm &&
 	git worktree prune --verbose --expire=2.days.ago &&
 	test -d .git/worktrees/jlm
 '
-- 
2.16.2.903.gd04caf5039

