Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B9A20D09
	for <e@80x24.org>; Mon, 17 Apr 2017 00:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756854AbdDQAZH (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 20:25:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60434 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753871AbdDQAZG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 20:25:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEAF48ABA0;
        Sun, 16 Apr 2017 20:25:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bmUeXydkq/ZtoSbqm4LVuuhXvlA=; b=k+CzfU
        vaAYsok5ZXteno/U88WQWAN2H5iKjtAmqvEnbrXKec2wev1TVximj4TuTEc7aB+W
        X6LcrG7NTWw+MGHiEhN/mDpeKRgFSk6Dm5r9oqePr06MhZJbiFLjGiCij+K8lp9U
        OuqH0AE/N0aZ3LNOdE9m9p8nei4B3PHfhWQVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JfuLRX2j3xGP2+1cQD6k7IgqKWyEMiKF
        5BtpVZyHhPAF2opnKDXVXXaXzFYZN6b9DIZTRcbVjCM2YQP43kX/Hr+ZTetu1qOh
        kLWxunbS5gAXC1eLe3N4w5HxOGm7h3LUHHI7PmMrAohpNUndV3Lz+mRaVo0lb4I+
        eBG2lU27DH4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4CBA8AB9F;
        Sun, 16 Apr 2017 20:25:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C3A48AB9D;
        Sun, 16 Apr 2017 20:25:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2017, #02; draft as of Sat, 15)
References: <xmqqy3v2kmf5.fsf@gitster.mtv.corp.google.com>
        <CACsJy8B08DN+0Kn-g6iV2JVkHej814tqXjFSx=XBhckDyGx5Vw@mail.gmail.com>
Date:   Sun, 16 Apr 2017 17:25:01 -0700
In-Reply-To: <CACsJy8B08DN+0Kn-g6iV2JVkHej814tqXjFSx=XBhckDyGx5Vw@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 16 Apr 2017 17:47:13 +0700")
Message-ID: <xmqqtw5nlw2q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CB694EE-2304-11E7-9242-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> * nd/worktree-add-lock (2017-04-15) 2 commits
>>  - SQUASH???
>>  - worktree add: add --lock option
>>
>
> Allow to lock a workktree immediately after it's created. This helps
> prevent a race between "git worktree add; git worktree lock" and "git
> worktree prune".

Thanks.  Also thanks for "we at least need to ensure the lock file
is there" comment, which led to this:

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Sat, 15 Apr 2017 00:36:31 -0700
Subject: [PATCH] SQUASH???

---
 builtin/worktree.c      | 16 +++++++---------
 t/t2025-worktree-add.sh |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3dab07c829..5ebdcce793 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -243,7 +243,10 @@ static int add_worktree(const char *path, const char *refname,
 	 * after the preparation is over.
 	 */
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	write_file(sb.buf, "initializing");
+	if (!opts->keep_locked)
+		write_file(sb.buf, "initializing");
+	else
+		write_file(sb.buf, "added with --lock");
 
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
@@ -306,15 +309,10 @@ static int add_worktree(const char *path, const char *refname,
 done:
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	if (!ret && opts->keep_locked) {
-		/*
-		 * Don't keep the confusing "initializing" message
-		 * after it's already over.
-		 */
-		truncate(sb.buf, 0);
-	} else {
+	if (!ret && opts->keep_locked)
+		;
+	else
 		unlink_or_warn(sb.buf);
-	}
 	argv_array_clear(&child_env);
 	strbuf_release(&sb);
 	strbuf_release(&symref);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 6dce920c03..b5c47ac602 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -66,7 +66,7 @@ test_expect_success '"add" worktree' '
 test_expect_success '"add" worktree with lock' '
 	git rev-parse HEAD >expect &&
 	git worktree add --detach --lock here-with-lock master &&
-	test_must_be_empty .git/worktrees/here-with-lock/locked
+	test -f .git/worktrees/here-with-lock/locked
 '
 
 test_expect_success '"add" worktree from a subdir' '
-- 
2.12.2-820-g9f56312714

