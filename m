Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D84207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 18:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755889AbcJLSux (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 14:50:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50099 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754995AbcJLSuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 14:50:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8324544C7C;
        Wed, 12 Oct 2016 14:50:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jk2eKr7yqRTQTjAoOK+++9BIYSI=; b=yA3ZBM
        Aj3mun0gYwtDqeOcOT7v/5C7L3Z/CvZi/wdH/exFMEjWtNbnmmTqsP4+U6qQAmfi
        Wk9OLIijIsDueUQ0tNxtsmEuTpDCdi/lxywPYcKzh7ReB5sLN4Fsy1zsc1kd+X1l
        xkUa9O16L+j3JSLp7G/EIpDWXiLnkoNdBcuQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JUGSB8H4hsDcv1YXyPN+Uk+r8t/iCT3d
        0JgHzR0C1snWzYU1Ph+8OuAtlqZS+NRmsKxq87LKEIKLQostjB8JxzzeVsSYl0n9
        i8vSUfVJitccV1QPtDHgILboWPI4Fyd98KpYK7blpJmjgjq77gRfgdge+kwHhvj0
        GHp1UU4Zs6c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7ABEE44C7A;
        Wed, 12 Oct 2016 14:50:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA5E944C79;
        Wed, 12 Oct 2016 14:50:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org, pclouds@gmail.com, mtutty@gforgegroup.com,
        rappazzo@gmail.com
Subject: Re: [PATCH] worktree: allow the main brach of a bare repository to be checked out
References: <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
        <20161012164104.zcxpcwqrp5h65qmc@hurricane>
        <xmqqfuo14dnr.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 12 Oct 2016 11:50:07 -0700
In-Reply-To: <xmqqfuo14dnr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 12 Oct 2016 11:37:12 -0700")
Message-ID: <xmqqbmyp4d28.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B362CBE4-90AC-11E6-A9DF-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>
>> OK, so here it is as a proper patch.

Here is what I queued.  Duy, what do you think?  It seems OK to me.

Thanks.

-- >8 --
From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Date: Wed, 12 Oct 2016 18:41:07 +0200
Subject: [PATCH] worktree: allow the main brach of a bare repository to be
 checked out

In bare repositories, get_worktrees() still returns the main repository,
so git worktree list can show it. ignore it in find_shared_symref so we
can still check out the main branch.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2025-worktree-add.sh | 8 ++++++++
 worktree.c              | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 4bcc335a19..b618d6be21 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -138,6 +138,14 @@ test_expect_success 'checkout from a bare repo without "add"' '
 	)
 '
 
+test_expect_success '"add" default branch of a bare repo' '
+	(
+		git clone --bare . bare2 &&
+		cd bare2 &&
+		git worktree add ../there3 master
+	)
+'
+
 test_expect_success 'checkout with grafts' '
 	test_when_finished rm .git/info/grafts &&
 	test_commit abc &&
diff --git a/worktree.c b/worktree.c
index 5acfe4cd64..f7869f8d60 100644
--- a/worktree.c
+++ b/worktree.c
@@ -345,6 +345,8 @@ const struct worktree *find_shared_symref(const char *symref,
 
 	for (i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
+		if (wt->is_bare)
+			continue;
 
 		if (wt->is_detached && !strcmp(symref, "HEAD")) {
 			if (is_worktree_being_rebased(wt, target)) {
-- 
2.10.1-591-g271c03b70f

