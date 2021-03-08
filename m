Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F20C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AE5651FD
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 12:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCHMrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 07:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCHMrA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 07:47:00 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AFFC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 04:46:59 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m9so14552662edd.5
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 04:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Znx3GetcA0S+LBF4DrKB5jV8gFVfRtLegPGi8WKU4tc=;
        b=G2yvHKdRkzP0xF84JCw9gQ+G8+qtk/uh2WdaJO09ZHGPU6FOCyDiMJNyh29hsWv4d2
         yetZdM0IqIC9/aGyl4FO5OK3AMMKWoLDV8EXYUu1l0PtgqbW6ieiv5iJREUpmkQoMpFX
         4C97CnaibtBvx+wCj/361JaM0qQVoL65ED7NxvjUtFkkl7qxloQPVkf1r4zsjOaJFvvh
         eh83TryS/q5cx7DpEiBk4GCHmtqdKVUBRwa6gaQQrnoTjM8XqZW73j1TFgC58HFmNrKr
         ECgx5Ynm6yZMfcf89H7dCgeyRReyjA2toua5eoQAtGtCmS2F0KOki+Wwovmxgopy+/fS
         w6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Znx3GetcA0S+LBF4DrKB5jV8gFVfRtLegPGi8WKU4tc=;
        b=mabD9+FFSGOnjfLMiNC4ppsoAsz8+3/dsq7zzJGFoT5Gw7zXLYERRa9qnUtRRR3Bt5
         DWpqXdCGFGpkgR8FNjt0Z3LkU6nYKHQJVNT+y3o9T1eIgKb7Y8/bi9nbP0DIShjn6VW/
         69CGb8cKZ3eNZJaLOhWaw8r+pzFcHOin3ilB+bBSli0EO1SuHdFh95MwZ28E3+nsNk9u
         FX6BaTSRscpWVg4+pZJ9XUCnCeVl+xyhbO96hGCO3GSAhsZh36hDZfMMjy5RynV4bMaK
         5FfShC+huk+aS/0J/ABpMO3oJK6nJwQA/iJw+9uZpaYSY8djSdrsnLPDNNs+6LZBOMkg
         KBcw==
X-Gm-Message-State: AOAM533t/l+S5+QvSsbE57H59lU+Kwt0VdfkXakn3M4FHJIlZYLvUa4n
        Ud3gj2KdYC5ONHU4PJ08JgIDiWVR10OnGQ==
X-Google-Smtp-Source: ABdhPJygV0Mf8ZT90IUWizE1YeJPmX/WhYB7kGk3qWs2bhaxEnAplq7Nis0Xg7fv7RQX43jL7GEKaw==
X-Received: by 2002:aa7:d511:: with SMTP id y17mr21932711edq.275.1615207618219;
        Mon, 08 Mar 2021 04:46:58 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id dg26sm7113475edb.88.2021.03.08.04.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:46:57 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 03/11] merge-ort: add a function for initializing our
 special attr_index
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <815af5d30ebd5e7f80aa42e4a54808af2e3781e0.1614905738.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <815af5d30ebd5e7f80aa42e4a54808af2e3781e0.1614905738.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 13:46:57 +0100
Message-ID: <87czw9ke2m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Add a function which can be called to populate the attr_index with the
> appropriate .gitattributes contents when necessary.  Make it return
> early if the attr_index is already initialized or if we are not
> renormalizing files.
>
> NOTE 1: Even if the user has a working copy or a real index (which is
> not a given as merge-ort can be used in bare repositories), we
> explicitly ignore any .gitattributes file from either of these
> locations.  merge-ort can be used to merge two branches that are
> unrelated to HEAD, so .gitattributes from the working copy and current
> index should not be considered relevant.
>
> NOTE 2: Since we are in the middle of merging, there is a risk that
> .gitattributes itself is conflicted...leaving us with an ill-defined
> situation about how to perform the rest of the merge.  It could be that
> the .gitattributes file does not even exist on one of the sides of the
> merge, or that it has been modified on both sides.  If it's been
> modified on both sides, it's possible that it could itself be merged
> cleanly, though it's also possible that it only merges cleanly if you
> use the right version of the .gitattributes file to drive the merge.  It
> gets kind of complicated.  The only test we ever had that attempted to
> test behavior in this area was seemingly unaware of the undefined
> behavior, but knew the test wouldn't work for lack of attribute handling
> support, marked it as test_expect_failure from the beginning, but
> managed to fail for several reasons unrelated to attribute handling.
> See commit 6f6e7cfb52 ("t6038: remove problematic test", 2020-08-03) for
> details.  So there are probably various ways to improve what
> initialize_attr_index() picks in the case of a conflicted .gitattributes
> but for now I just implemented something simple -- look for whatever
> .gitattributes file we can find in any of the higher order stages and
> use it.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index d91b66a052b6..028d1adcd2c9 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -988,6 +988,67 @@ static int merge_submodule(struct merge_options *opt,
>  	return 0;
>  }
>  
> +MAYBE_UNUSED

As with the lst series you had I also think this is better squashed with
04/11.

> +static void initialize_attr_index(struct merge_options *opt)
> +{
> +	/*
> +	 * The renormalize_buffer() functions require attributes, and
> +	 * annoyingly those can only be read from the working tree or from
> +	 * an index_state.  merge-ort doesn't have an index_state, so we
> +	 * generate a fake one containing only attribute information.
> +	 */
> +	struct merged_info *mi;
> +	struct index_state *attr_index = &opt->priv->attr_index;
> +	struct cache_entry *ce;
> +
> +	if (!opt->renormalize)
> +		return;
> +
> +	if (attr_index->initialized)
> +		return;

Will comment on this in 04/11.

> +	attr_index->initialized = 1;
> +
> +	mi = strmap_get(&opt->priv->paths, GITATTRIBUTES_FILE);
> +	if (!mi)
> +		return;
> +
> +	if (mi->clean) {
> +		int len = strlen(GITATTRIBUTES_FILE);
> +		ce = make_empty_cache_entry(attr_index, len);
> +		ce->ce_mode = create_ce_mode(mi->result.mode);
> +		ce->ce_flags = create_ce_flags(0);
> +		ce->ce_namelen = len;
> +		oidcpy(&ce->oid, &mi->result.oid);
> +		memcpy(ce->name, GITATTRIBUTES_FILE, len);
> +		add_index_entry(attr_index, ce,
> +				ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
> +		get_stream_filter(attr_index, GITATTRIBUTES_FILE, &ce->oid);
> +	}
> +	else {

Style nit: } else {

> +		int stage, len;
> +		struct conflict_info *ci;
> +
> +		ASSIGN_AND_VERIFY_CI(ci, mi);
> +		for (stage=0; stage<3; ++stage) {

Style nit: stage < 3

Style nit: I find just stage++ to be more readable in for-loops, makes
no difference to the compiler, just more idiomatic.

> +			unsigned stage_mask = (1 << stage);
> +
> +			if (!(ci->filemask & stage_mask))
> +				continue;
> +			len = strlen(GITATTRIBUTES_FILE);
> +			ce = make_empty_cache_entry(attr_index, len);
> +			ce->ce_mode = create_ce_mode(ci->stages[stage].mode);
> +			ce->ce_flags = create_ce_flags(stage);
> +			ce->ce_namelen = len;
> +			oidcpy(&ce->oid, &ci->stages[stage].oid);
> +			memcpy(ce->name, GITATTRIBUTES_FILE, len);
> +			add_index_entry(attr_index, ce,
> +					ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
> +			get_stream_filter(attr_index, GITATTRIBUTES_FILE,
> +					  &ce->oid);
> +		}
> +	}
> +}
> +

