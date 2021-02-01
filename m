Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F272FC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 16:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF74364D9D
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 16:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBAQWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 11:22:46 -0500
Received: from mout.web.de ([212.227.17.11]:47921 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhBAQWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 11:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1612196449;
        bh=vymI3bKgTw+XOFSlfF6Q4cg5hJuaNMFu60tNbacjcXU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ldsnwxLNCj2wLDFnl2G6BF+0ZGrRkOl84Uc+32W6rWM3eP51yU8kiS4yLJ7wRu6dh
         lcDVDUaxGs436C+Hk1mU9MADn6HNPTFxQsu6Sf74XlR7p2RrVHduehAwM5wAYgw/mW
         OTYFxRG4oxVQx6CLIsZBBJt7VGrMmUPSlckHFAkQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MVchv-1lSNmT3seF-00Z1Pd; Mon, 01 Feb 2021 17:12:39 +0100
Subject: Re: [PATCH v2 2/5] commit-reach: use one walk in remove_redundant()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
 <2f80ae5fcb00d9d5c1b0502af45921cb20ebdf94.1612183647.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <419ddcca-8534-8dc5-bcd8-1e244414bcf1@web.de>
Date:   Mon, 1 Feb 2021 17:12:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <2f80ae5fcb00d9d5c1b0502af45921cb20ebdf94.1612183647.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1T58x4qXxc2/HYtwRcFCLkAmnCMOSHPJDTu6rEfffVqKqFKy05h
 PtaiZIfB+FlCaeIjOjvp2wMqOb8RIv74F3vWsnP1VYHEyGRAVg5V3eQLVqJo6ruFMC7sWaP
 c6JanqO/6uSWU76B/DyUQX4UXt6RWkGPEUdSxuDrEV1EATPWZI5j7GSdqCV7A8w0kQWu3iM
 tdIc7XTsFX0V0x0VWfqtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RCjrIOVVFtw=:4KUzjDEq5V+l74pddNsiFs
 E8+0XsYJNTmGOELHBQdW4s8yZJWbhB0sxavr9oHdpAS0VMxQtBhvhv+e3buB5Gdxu/FpRz6Rz
 hW+3baLcURshf16a37y9idQnsdQqLHkUJgDdRIl6z9eY637ei6nFzAmS3XyuQZJ/NJWVaUJN9
 v9ky0Hs1+TKjj8rMl3C93tFc5I6WvR5CFl54pmKrGQRQlM42MDJhlxZVem6eEElcK+8W1Lhqz
 lw3rlNo7AQaCh+3RDcECS/ieMkfrYGPYB3ER/D+MPi2z7uFuCPniz9aDTzALTQMO5en2uvt55
 eul0DcD1nXnweWki2vqPTRpLMGF3mps4Qr/1757QlXc6bnr1T1tu4ikECtRUPzUG6wiOeOksx
 MnUj1/6Yk5X5wpiH7kec7NsiIC/EJh41D8ExlwN467dSwyjKTa+0GxLIyLLNZzgVBgrpj2LlW
 5740M1DtYlEfI0fXPPAQe2x/yfDIzHpErVlrwYtUUp2OoT8LKs/+xEzzrVwlSCRnYtxPVA0ME
 OM26OGdudyq0Qi+PLrpRrmzXeGWmZ0LX3uZoLdwhQhrfwgXj+Kyq+4xcnPjlzQ9haR4dwtX58
 ingO/m0lN3pB5YfZtAAwbsZAlQjeuAzl74agD2RyGO3eQQOFaXwMjH55Ov7Xiy8eCo8ze4C1b
 kp9avscYshfUF3epwHjGViUXGUEG8FPrX5gMrPmfItt2Yga2v3ChD7z8B9kVitYiE9CqlzsKd
 DBeMi1hOs/Dy12NbHGmQWQj9aQzABLlshFFUJxjPZmbZ67TXdVlSqhjnCja44Rp5JcCem4HN1
 jF4U9UoReI7fLJZ7lVW2n2ZOMREabwn27xjXlgSpEWhaaGLu19p+u6PewnUg1pR0bSALi2aVr
 ilEnqnn6qi9vTy7/up3g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.02.21 um 13:47 schrieb Derrick Stolee via GitGitGadget:
> @@ -210,12 +204,110 @@ static int remove_redundant(struct repository *r,=
 struct commit **array, int cnt
>  	for (i =3D filled =3D 0; i < cnt; i++)
>  		if (!redundant[i])
>  			array[filled++] =3D work[i];
> +	for (j =3D filled, i =3D 0; i < cnt; i++)
> +		if (redundant[i])
> +			array[j++] =3D work[i];

This puts the loop back in that you removed in the previous commit.
Intentionally?

>  	free(work);
>  	free(redundant);
>  	free(filled_index);
>  	return filled;
>  }
>
> +static int remove_redundant_with_gen(struct repository *r,
> +				     struct commit **array, int cnt)
> +{
> +	int i, count_non_stale =3D 0;
> +	timestamp_t min_generation =3D GENERATION_NUMBER_INFINITY;
> +	struct commit **walk_start;
> +	size_t walk_start_nr =3D 0, walk_start_alloc =3D cnt;
> +	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date =
};
> +
> +	ALLOC_ARRAY(walk_start, walk_start_alloc);
> +
> +	/* Mark all parents of the input as STALE */
> +	for (i =3D 0; i < cnt; i++) {
> +		struct commit_list *parents;
> +		timestamp_t generation;
> +
> +		repo_parse_commit(r, array[i]);
> +		parents =3D array[i]->parents;
> +
> +		while (parents) {
> +			repo_parse_commit(r, parents->item);
> +			if (!(parents->item->object.flags & STALE)) {
> +				parents->item->object.flags |=3D STALE;
> +				ALLOC_GROW(walk_start, walk_start_nr + 1, walk_start_alloc);
> +				walk_start[walk_start_nr++] =3D parents->item;
> +				prio_queue_put(&queue, parents->item);
> +			}
> +			parents =3D parents->next;
> +		}
> +
> +		generation =3D commit_graph_generation(array[i]);
> +
> +		if (generation < min_generation)
> +			min_generation =3D generation;
> +	}
> +
> +	/* push the STALE bits up to min generation */
> +	while (queue.nr) {
> +		struct commit_list *parents;
> +		struct commit *c =3D prio_queue_get(&queue);
> +
> +		repo_parse_commit(r, c);
> +
> +		if (commit_graph_generation(c) < min_generation)
> +			continue;
> +
> +		parents =3D c->parents;
> +		while (parents) {
> +			if (!(parents->item->object.flags & STALE)) {
> +				parents->item->object.flags |=3D STALE;
> +				prio_queue_put(&queue, parents->item);
> +			}
> +			parents =3D parents->next;
> +		}
> +	}
> +
> +	/* rearrange array */
> +	for (i =3D count_non_stale =3D 0; i < cnt; i++) {
> +		if (!(array[i]->object.flags & STALE))

Here I would have added another condition, count_non_stale !=3D i, to
avoid self-assignment (array[x] =3D array[x]).  The code works without
it, though.  Not sure if there is a performance benefit to be had --
branch vs. pointer copy.  Probably not worth it..

> +			array[count_non_stale++] =3D array[i];
> +	}
> +
> +	/* clear marks */
> +	for (i =3D 0; i < walk_start_nr; i++)
> +		clear_commit_marks(walk_start[i], STALE);

You can replace this loop with a call to clear_commit_marks_many().

> +	free(walk_start);
> +
> +	return count_non_stale;
> +}
> +
> +static int remove_redundant(struct repository *r, struct commit **array=
, int cnt)
> +{
> +	/*
> +	 * Some commit in the array may be an ancestor of
> +	 * another commit.  Move the independent commits to the
> +	 * beginning of 'array' and return their number. Callers
> +	 * should not rely upon the contents of 'array' after
> +	 * that number.
> +	 */
> +	if (generation_numbers_enabled(r)) {
> +		int i;
> +
> +		/*
> +		 * If we have a single commit with finite generation
> +		 * number, then the _with_gen algorithm is preferred.
> +		 */
> +		for (i =3D 0; i < cnt; i++) {
> +			if (commit_graph_generation(array[i]) < GENERATION_NUMBER_INFINITY)
> +				return remove_redundant_with_gen(r, array, cnt);
> +		}
> +	}
> +
> +	return remove_redundant_no_gen(r, array, cnt);
> +}
> +
>  static struct commit_list *get_merge_bases_many_0(struct repository *r,
>  						  struct commit *one,
>  						  int n,
>
