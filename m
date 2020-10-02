Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8248C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 18:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8BE206CA
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 18:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wkQEgeeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBSvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 14:51:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52308 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBSvj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 14:51:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3216E2B4A;
        Fri,  2 Oct 2020 14:51:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sdmqzNSOngLeOAMqnbX8Wdw1toQ=; b=wkQEge
        eUUN9pV6lBWrBNq87Oa2zC6Iam+eLEvvutuBS0d94l7wllbBMuVoFBvO1C4FXRUz
        DWyFdoanJPhQJx4SHfVIn2rQZahEFiSBUFOaSPWRQc2GlzpLdCD2/BGrcgkiEkWb
        oaUxB8eHyeCINpJn8B6Vwx//ZWBMlRShgFUkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xTxPv0ipGkp9YAcu8KWse4xjX/IukRSq
        /mGysUegJH+HBYLlOcTVZ/X2KZAyYs/0pJIgsWB8ut2JsD1KE/v3hpGLKMqlur3e
        SR0iBWfwhhXP9rWka94kT/alIqWqfE4Lj/tCcS5hrUmfL6+OmKogcoupmVEhtdRz
        X4gppdSD6iQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AEFCE2B49;
        Fri,  2 Oct 2020 14:51:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DAE31E2B46;
        Fri,  2 Oct 2020 14:51:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>,
        Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-reach: fix in_merge_bases_many bug
References: <pull.739.git.1601650736489.gitgitgadget@gmail.com>
Date:   Fri, 02 Oct 2020 11:51:33 -0700
In-Reply-To: <pull.739.git.1601650736489.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 02 Oct 2020 14:58:56
        +0000")
Message-ID: <xmqqv9fs8nre.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B663BA0-04E0-11EB-ABCB-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The fix itself is to swap min_generation with a max_generation in
> repo_in_merge_bases_many().
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Reported-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

The order of these looked iffy so I rearranged them in chrono order,
Srinidhi's series found it broken, and with Dscho's help, fix was
produced and you sent it with your sign off.

>  commit-reach.c        |  8 ++++----
>  t/helper/test-reach.c |  2 ++
>  t/t6600-test-reach.sh | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 4 deletions(-)

I've applied this and then rebased Srinidhi's latest on top, with
the following to re-enable the commit-graph in the codepath.  t5533
and t6600 passes and when the fix in the message I am responding to
is reverted, t5533 again fails.

Thanks.

    SQUASH??? drop "hide the breakage under the rug" hack
    
    Derrick and Dscho spotted and fixed the incorrect optimization in
    in_merge_bases_many() when the commit-graph is in use, so there is
    no longer a reason why we would want to disable commit-graph locally
    in this codepath.

diff --git a/remote.c b/remote.c
index 98a578f5dc..8c91188677 100644
--- a/remote.c
+++ b/remote.c
@@ -2405,34 +2405,18 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 	return ret;
 }
 
-/* Toggle the "commit-graph" feature; return the previously set state. */
-static int toggle_commit_graph(struct repository *repo, int disable) {
-	int prev = repo->commit_graph_disabled;
-	repo->commit_graph_disabled = disable;
-	return prev;
-}
-
 /*
  * Check for reachability of a remote-tracking
  * ref in the reflog entries of its local ref.
  */
 static void check_if_includes_upstream(struct ref *remote)
 {
-	int prev;
 	struct ref *local = get_local_ref(remote->name);
 	if (!local)
 		return;
 
-	/*
-	 * TODO: Remove "toggle_commit_graph()" calls around the check.
-	 * Depending on whether "commit-graph" enabled or not,
-	 * "in_merge_bases_many()" returns different results;
-	 * disable it temporarily when the check runs.
-	 */
-	prev = toggle_commit_graph(the_repository, 1);
 	if (is_reachable_in_reflog(local->name, remote) <= 0)
 		remote->unreachable = 1;
-	toggle_commit_graph(the_repository, prev);
 }
 
 static void apply_cas(struct push_cas_option *cas,
