Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F278AC433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 10:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50612080C
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 10:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4hVRfzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgHZKiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgHZKiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 06:38:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0A4C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 03:38:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y2so1777711ljc.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=X3YnYoGj5mLPUprf5QSdquo7ibyyeswzBIvYCVcfCD4=;
        b=i4hVRfzOy1xXv2N2S6WFlTlIqHwCBKg3VQjlFA02qH3JVycj3VH4RrIdd1bYISw0Jq
         VJHsLIBTO81tEXbJ0xCgnbMmsuw1XNxoPKwIuxOJPte3D4EcMj/eDN5N2FKWV03EeM/D
         GOSog8cI+fwyl0+2Wm4zpmXAyARQH291slTb1U0RLfTN5Zb5awXK5ZvxVeFNyAdK4fNp
         LvRbrakqh77aYIPipwc6y/F9ARZ8HlCXhf0ljMR2z1VvUnNVdzEVDj62OFL+LBfqoCZc
         ZrhzgYlMZvgGyYnHazdFDbvCxAT7bafqjmzqdk9UHzFJuBMPOJ+80qQte01PTqcP20z6
         LsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=X3YnYoGj5mLPUprf5QSdquo7ibyyeswzBIvYCVcfCD4=;
        b=ljoxJ3iR2DD48z/Eml0lYV/8Fc69L9qvtzOQY4Doux8+CxWuCwS4OQ/9CTe++UEaCC
         qMsNRF9DP63p2TIjzSwAzaroZyiiB2YdA7YRG1Jvi9fshIDlvMf60EILZBRecnIBx5Zd
         9p3AsnW5lz5CyoBJ8O5nUYLyyRer/+3OMMvWse0ac7MW4tl3ysaGSwOAW+LnurkPzHCt
         OoUCF259SB8WI4e47+4loHX4ejTR1WdZ8f05266HPlrc0HiK45pq40WX/IohXyLjumjv
         fvWZRSUtDMTwB5nQsCfKoKUVxDEJKDHL7wNOa6l3LV+L8tCcT6zXp49loHyXKtmbJeu9
         m6AA==
X-Gm-Message-State: AOAM533tY7VWYKN1U0cLMk7Ww6mbXVbCu0jLbbBzVqWscu7dD7ddC1fa
        +nV1MwNTie3TCRFj5ZT1YrfiUGlMRDTWUA==
X-Google-Smtp-Source: ABdhPJy4p/cQX5WONj+yQAN6xJShTX3oduJdU++vqr+8V3eCZaVgpHbAHSqwI+kBYOdAuTb/eox+UQ==
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr6659737ljj.188.1598438287101;
        Wed, 26 Aug 2020 03:38:07 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id h17sm410248ljj.118.2020.08.26.03.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 03:38:06 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 09/11] commit-graph: use generation v2 only if entire chain does
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <5a147a9704f0f8d8644c92ea38583e966378b931.1597509583.git.gitgitgadget@gmail.com>
        <85pn7ihabl.fsf@gmail.com> <20200826071519.GA6805@Abhishek-Arch>
Date:   Wed, 26 Aug 2020 12:38:04 +0200
In-Reply-To: <20200826071519.GA6805@Abhishek-Arch> (Abhishek Kumar's message
        of "Wed, 26 Aug 2020 12:45:19 +0530")
Message-ID: <857dtld75f.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhishek,

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Sat, Aug 22, 2020 at 07:14:38PM +0200, Jakub Nar=C4=99bski wrote:
>> Hi Abhishek,
>>
>> ...
>>
>> However the commit message do not say anything about the *writing* side.
>>
>
> Revised the commit message to include the following at the end:
>
> When writing the new layer in split commit-graph, we write a GDAT chunk
> only if the topmost layer has a GDAT chunk. This guarantees that if a
> layer has GDAT chunk, all lower layers must have a GDAT chunk as well.
>

All right.

> Rewriting layers follows similar approach: if the topmost layer below
> set of layers being rewritten (in the split commit-graph chain) exists,
> and it does not contain GDAT chunk, then the result of rewrite does not
> have GDAT chunks either.

All right.

I see that you went with proposed more complex (but better) solution...

>>
>> ...
>>
>> To be more detailed, without '--split=3Dreplace' we would want the follo=
wing
>> layer merging behavior:
>>
>>    [layer with GDAT][with GDAT][without GDAT][without GDAT][without GDAT]
>>            1              2           3             4            5
>>
>> In the split commit-graph chain above, merging two topmost layers
>> (layers 4 and 5) should create a layer without GDAT; merging three
>> topmost layers (and any other layers, e.g. two middle ones, i.e. 3 and
>> 4) should create a new layer with GDAT.

A simpler solution would be to create a new merged layer without GDAT if
any of the layers being merged do not have GDAT.

In this solution merging 3+4+5, 3+4, and even 2+3 would result with
layer without GDAT, and only merging 1+2 would result in layer with GDAT.

>>
>>    [layer with GDAT][with GDAT][without GDAT][-------without GDAT-------]
>>            1              2           3               merged
>>
>>    [layer with GDAT][with GDAT][-------------with GDAT------------------]
>>            1              2                    merged
>>
>> I hope those ASCII-art pictures help understanding it
>>
>
> Thanks! There were helpful.
>
> While we work as expected in the first scenario i.e merging 4 and 5, we
> would *still* write a layer without GDAT in the second scenario.
>
> I have tweaked split_graph_merge_strategy() to fix this:
>
> ----------------------------------------------
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 6d54d9a286..246fad030d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1973,6 +1973,9 @@ static void split_graph_merge_strategy(struct write=
_commit_graph_context *ctx)
>  		}
>  	}
>
> +	if (!ctx->write_generation_data && g->chunk_generation_data)
> +		ctx->write_generation_data =3D 1;
> +
>  	if (flags !=3D COMMIT_GRAPH_SPLIT_REPLACE)
>  		ctx->new_base_graph =3D g;
>  	else if (ctx->num_commit_graphs_after !=3D 1)

...which turned out to be not that complicated.  Nice work!

Though this needs tests that if fulfills the stated condition (because I
am not sure if it is entirely correct: we are not checking the layer
below current one, isn't it?... ah, you explain it below).

One possible solution would be to grep `test-tool read-graph` output for
"^chunks: ", then pass it through `uniq` (without `sort`!), check that
the number of lines is less or equal 2, and if there are two lines then
check that we get the following contents:

  chunks: oid_fanout oid_lookup commit_metadata generation_data
  chunks: oid_fanout oid_lookup commit_metadata

(assuming that information about layers is added in top-down order).

This test must be run with GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D0, which
I think is the default.

> ----------------------------------------------------
>
> That is, if we were not writing generation data (because of mixed
> generation concerns) but the new topmost layer has a generation data
> chunk, we have merged all layers without GDAT chunk and can now write a
> GDAT chunk safely.

All right.

[...]
>>> diff --git a/commit-graph.h b/commit-graph.h
>>> index f78c892fc0..3cf89d895d 100644
>>> --- a/commit-graph.h
>>> +++ b/commit-graph.h
>>> @@ -63,6 +63,7 @@ struct commit_graph {
>>>  	struct object_directory *odb;
>>>
>>>  	uint32_t num_commits_in_base;
>>> +	uint32_t read_generation_data;
>>>  	struct commit_graph *base_graph;
>>>
>>
>> First, why `read_generation_data` is of uint32_t type, when it stores
>> (as far as I understand it), a "boolean" value of either 0 or 1?
>
> Yes, using unsigned int instead of uint32_t (although in most of cases
> it would be same).  If commit_graph had other flags as well, we could
> have used a bit field.

OK.

>> Second, couldn't we simply set chunk_generation_data to NULL?  Or would
>> that interfere with the case of rewriting, where we want to use existing
>> GDAT data when writing new commit-graph with GDAT chunk?
>
> It interferes with rewriting the split commit-graph, as you might have
> guessed from the above code snippet.

All right.

[...]
>>> @@ -885,6 +908,7 @@ void load_commit_graph_info(struct repository *r, s=
truct commit *item)
>>>  	uint32_t pos;
>>>  	if (!prepare_commit_graph(r))
>>>  		return;
>>> +
>>>  	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
>>>  		fill_commit_graph_info(item, r->objects->commit_graph, pos);
>>>  }
>>
>> This is unrelated whitespace fix, a "while at it" in neighbourhood of
>> changes.  All right then.
>>
>
> Reverted this change, as it's unimportant.

Actually I am not against fixing the whitespace in the neighbourhood of
changes, so you can keep it or revert it (discard).

>>> @@ -2192,6 +2216,9 @@ int write_commit_graph(struct object_directory *o=
db,
>>
>> ...
>>
>> It would be nice to have an example with merging layers (whether we
>> would handle it in strict or relaxed way).
>>
>
> Sure, will add.

Thanks.


Best,
--
Jakub Nar=C4=99bski
