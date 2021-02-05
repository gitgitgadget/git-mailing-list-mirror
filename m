Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05300C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 01:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9729864F4D
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 01:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhBEBdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 20:33:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61406 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhBEBdV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 20:33:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 834FA1252A5;
        Thu,  4 Feb 2021 20:32:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mE9wh5RwVkM0YN1XutIbMOjyK50=; b=Pf9/nB
        WA9bNBfUVW1TKiaQ8B0yp+EAk7weKV0WyraN9QqoVe7U8WTE1iu1ujudtxSFxBWk
        SBUXbnMp6CueipbQrtCqxn8B/IGIs4r8mVfh4qzGomcuEeQwODX/aedcZ6AipNA2
        KD2vIRc5sN9stwm5j+Ff/WBDuo1pulqBmSWCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vTSpVNZDjwdVZdjaMEGE58htURPlfVbI
        AkRLhJ/tyUUh0kbdf/g7u18dZZcP//Vw1fFSJSCubHeF6jyrv45gvedRfFxrSQPh
        Ged/B9bB5gqCrLFrpDG5bf91GQjkOA51nXYGuM2hDw21Z+hoyfc9/uPdPj8rJIAX
        qIX6GKwd/j4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B1A61252A4;
        Thu,  4 Feb 2021 20:32:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BBC591252A3;
        Thu,  4 Feb 2021 20:32:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
References: <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
        <pull.841.v5.git.1612481392.gitgitgadget@gmail.com>
        <04b5d75adbc3d80e9f9cf9cd380294949e7c68e8.1612481392.git.gitgitgadget@gmail.com>
        <xmqqmtwj2ugg.fsf@gitster.c.googlers.com>
Date:   Thu, 04 Feb 2021 17:32:34 -0800
In-Reply-To: <xmqqmtwj2ugg.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 04 Feb 2021 17:07:27 -0800")
Message-ID: <xmqqim772tal.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07077F30-6752-11EB-AEDC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ah, I didn't think of adding this inside the same loop.  As long as
> the pending objects are independent, this should work, but it is
> unsafe, I think.

Here is what I added on top of the 3-patch series for tonight's
pushout.

 * No need to count positive/negative; just seeing both exists is
   sufficient and there is no need to examine any later elements, if
   any.

 * Clearing commit marks needs to be done after we have seen enough,
   or it can clear the stuff we would want to inspect before we
   have a chance to.  Do it in a separate post-cleaning loop.

 * Dedent by judicious use of 'goto'.

 * The last parameter to setup_revisions() is a pointer, so spell it
   NULL not 0.

 * "rang" -> "range" typofix (it might be even better to look for
   "range:")

----- >8 ---------- >8 ---------- >8 ---------- >8 ---------- >8 ---------- >8 -----
Subject: [PATCH] fixup! range-diff/format-patch: handle commit ranges other than A..B

 range-diff.c          | 30 +++++++++++++++++-------------
 t/t3206-range-diff.sh |  2 +-
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index c307bca9de..7a38dc8715 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -570,24 +570,28 @@ int is_range_diff_range(const char *arg)
 {
 	char *copy = xstrdup(arg); /* setup_revisions() modifies it */
 	const char *argv[] = { "", copy, "--", NULL };
-	int i, positive = 0, negative = 0;
+	int i;
 	struct rev_info revs;
+	unsigned npmask = 0;
 
 	init_revisions(&revs, NULL);
-	if (setup_revisions(3, argv, &revs, 0) == 1)
-		for (i = 0; i < revs.pending.nr; i++) {
-			struct object *obj = revs.pending.objects[i].item;
+	if (setup_revisions(3, argv, &revs, NULL) != 1)
+		goto cleanup;
 
-			if (obj->flags & UNINTERESTING)
-				negative++;
-			else
-				positive++;
-			if (obj->type == OBJ_COMMIT)
-				clear_commit_marks((struct commit *)obj,
-						   ALL_REV_FLAGS);
-		}
+	for (i = 0; i < revs.pending.nr && npmask != 3; i++) {
+		struct object *obj = revs.pending.objects[i].item;
+
+		npmask |= (obj->flags & UNINTERESTING) ? 01 : 02;
+	}
+
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object *obj = revs.pending.objects[i].item;
+		if (obj->type == OBJ_COMMIT)
+			clear_commit_marks((struct commit *)obj, ALL_REV_FLAGS);
+	}
 
+cleanup:
 	free(copy);
 	object_array_clear(&revs.pending);
-	return negative > 0 && positive > 0;
+	return npmask == 3;
 }
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 45f21ee215..2b518378d4 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -160,7 +160,7 @@ test_expect_success 'A^! and A^-<n> (unmodified)' '
 
 test_expect_success 'A^{/..} is not mistaken for a range' '
 	test_must_fail git range-diff topic^.. topic^{/..} 2>error &&
-	test_i18ngrep "not a commit rang" error
+	test_i18ngrep "not a commit range" error
 '
 
 test_expect_success 'trivial reordering' '
-- 
2.30.0-601-g9b6178ed87

