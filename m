Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B89C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 10:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6B62068E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 10:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlTgQcad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgHYKHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgHYKHV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 06:07:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FBCC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 03:07:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i10so13126465ljn.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 03:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ollj2tdMTim5CjH0ZjHuzAADtmp3FtUCskfJ84IqPIE=;
        b=mlTgQcadf9+r3YXve1coTBHsyQVUt6PAemmE1DEsymiR2V36NdywmPjIxDDDpcndc0
         UMgf9CfdxgzLT27/U2ACZG+dy6VtufDBdVQLNyKhHc0wJZ8VYfgcOe+5Hp9TxeEMjDXe
         VeijQFhcENpWS44m5jdLjW7jGqHsAFLSR+pDr2cevf3NVILr7OLN1kJBiNjxYDDCZhab
         KEvZesOoaT9Elfl8HFWM8UnW3HVARIe2gVb390/AHgrxup5jQhP8nFeUiEXVq97K+IVq
         V01XBEjb+HBZ34gb3EXFg8WfF690rA/Udpxi3nOPhboAoWlQsDGtnfYV8j+0NxJg50dE
         tyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Ollj2tdMTim5CjH0ZjHuzAADtmp3FtUCskfJ84IqPIE=;
        b=Td7AxURf6u3ZILzZnxLnSnKPIaqMcG4pr4XPXwzPdJ1lI/XeXBWTEXHD1228jgTTaC
         Rj+Xb+BWo9cW9f50M8TpBiD9ikyq4T2dSgGkutQ40px7ejGZ3Y7vLvd9k0rQIljdSlpV
         EhJCA31EOjE3eZs6Mr8r48FaFmmzu12LiUtcmw8zVK4JfxoSYMCKUj219H1zezElthRX
         +48ZZHsqOuIoh+ejb/QHkH/Mzvu1mBBwc9aVWd9ZHp6sgUX87muskzgzOaisXFo6AS80
         V0lIggaraUCJf6gSvqgV1n3up1spsBSeQJLZr/NM9TEtYHT/ORfUghIZn5blHRvDNeQb
         RgUg==
X-Gm-Message-State: AOAM533Urnf/YVJ+4gVQJ9blCq0EeQotDYvB/KAPC3JuflfeFcHEt8Oq
        GVvlWVrTB+hGR04M4w/sm+CmXGLFOc72aQ==
X-Google-Smtp-Source: ABdhPJwDbuart6nMDxqtI39NdnIRhW2PrxFNSr6vUKk8mCOcy6OMebwDBZ7EaMdcX8QFTrYosAiS2g==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr4947607ljg.406.1598350039543;
        Tue, 25 Aug 2020 03:07:19 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id j6sm2735364lja.23.2020.08.25.03.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:07:18 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 07/11] commit-graph: implement corrected commit date
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <4074ace65be3094d35dd0aaedb89eb5a0ec98cee.1597509583.git.gitgitgadget@gmail.com>
        <85wo1rk0iy.fsf@gmail.com> <20200825064954.GA645690@Abhishek-Arch>
Date:   Tue, 25 Aug 2020 12:07:17 +0200
In-Reply-To: <20200825064954.GA645690@Abhishek-Arch> (Abhishek Kumar's message
        of "Tue, 25 Aug 2020 12:19:54 +0530")
Message-ID: <85wo1nca3u.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Sat, Aug 22, 2020 at 02:05:41AM +0200, Jakub Nar=C4=99bski wrote:
>> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
[...]
>>> To minimize the space required to store corrected commit date, Git
>>> stores corrected commit date offsets into the commit-graph file. The
>>> corrected commit date offset for a commit is defined as the difference
>>> between its corrected commit date and actual commit date.
>>
>> Perhaps we should add more details about data type sizes in question.
>
> Will add.

Note however that we need to solve the problem of storing values which
are not monotonic wrt. parent relation (partial order) in limited disk
space, that is GENERATION_NUMBER_V2_OFFSET_MAX vs GENERATION_NUMBER_MAX;
see comments in 11/11 and 00/11.

>>
>> Storing corrected commit date requires sizeof(timestamp_t) bytes, which
>> in most cases is 64 bits (uintmax_t).  However corrected commit date
>> offsets can be safely stored^* using only 32 bits.  This halves the size
>> of GDAT chunk, reducing per-commit storage from 2*H + 16 + 8 bytes to
>> 2*H + 16 + 4 bytes, which is reduction of around 6%, not including
>> header, fanout table (OIDF) and extra edges list (EDGE).
>>
>> Which might mean that the extra complication is not worth it, and we
>> should store corrected commit date directly instead.
>>
>> *) unless for example one of commits is malformed but valid,
>>    and has committerdate of 0 Unix time, 1 January 1970.

See above.

>>> While Git does not write out offsets at this stage, Git stores the
>>> corrected commit dates in member generation of struct commit_graph_data.
>>> It will begin writing commit date offsets with the introduction of
>>> generation data chunk.
>>
>> OK, so the agenda for introducing geeration number v2 is as follows:
>> - compute generation numbers v2, i.e. corrected commit date
>> - store corrected commit date [offsets] in new GDAT chunk,
>>   unless backward-compatibility concerns require us to not to
>> - load [and compute] corrected commit date from commit-graph
>>   storing it as 'generation' field of `struct commit_graph_data`,
>>   unless backward-compatibility concerns require us to store
>>   topological levels (generation number v1) in there instead
>>
>
> The last point is not correct. We always store topological levels into
> the topo_levels slab introduced and always store corrected commit date
> into data->generation, regardless of backward compatibility concerns.

I think I was not clear enough (in trying to be brief).  I meant here
loading available generation numbers for use in graph traversal,
done in later patches in this series.

In _next_ commit we store topological levels in `generation` field:

  @@ -755,7 +763,11 @@ static void fill_commit_graph_info(struct commit *it=
em, struct commit_graph *g,
   	date_low =3D get_be32(commit_data + g->hash_len + 12);
   	item->date =3D (timestamp_t)((date_high << 32) | date_low);

  -	graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
  +	if (g->chunk_generation_data)
  +		graph_data->generation =3D item->date +
  +			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * =
lex_index);
  +	else
  +		graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> =
2;


We use topo_level slab only when writing the commit-graph file.

> We could avoid initializing topo_slab if we are not writing generation
> data chunk (and thus don't need corrected commit dates) but that
> wouldn't have an impact on run time while writing commit-graph because
> computing corrected commit dates is cheap as the main cost is in walking
> the graph and writing the file.

Right.

Though you need to add the cost of allocation and managing extra
commit slab, I think that amortized cost is negligible.

But what would be better is showing benchmark data: does writing the
commit graph without GDAT take not insigificant more time than without
this patch?

[...]
>>> @@ -2372,8 +2384,8 @@ int verify_commit_graph(struct repository *r, str=
uct commit_graph *g, int flags)
>>>  	for (i =3D 0; i < g->num_commits; i++) {
>>>  		struct commit *graph_commit, *odb_commit;
>>>  		struct commit_list *graph_parents, *odb_parents;
>>> -		timestamp_t max_generation =3D 0;
>>> -		timestamp_t generation;
>>> +		timestamp_t max_corrected_commit_date =3D 0;
>>> +		timestamp_t corrected_commit_date;
>>
>> This is simple, and perhaps unnecessary, rename of variables.
>> Shouldn't we however verify *both* topological level, and
>> (if exists) corrected commit date?
>
> The problem with verifying both topological level and corrected commit
> dates is that we would have to re-fill commit_graph_data slab with commit
> data chunk as we cannot modify data->generation otherwise, essentially
> repeating the whole verification process.
>
> While it's okay for now, I might take this up in a future series [1].
>
> [1]: https://lore.kernel.org/git/4043ffbc-84df-0cd6-5c75-af80383a56cf@gma=
il.com/

All right, I believe you that verifying both topological level and
corrected commit date would be more difficult.

That doesn't change the conclusion that this variable should remain to
be named `generation`, as when verifying GDAT-less commit-graph files it
would check topological levels (it uses commit_graph_generation(), which
in turn uses `generation` field in commit graph info, which as I have
show above in later patch could be v1 or v2 generation number).

Best,
--=20
Jakub Nar=C4=99bski
