Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E429C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 09:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9DD2071B
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 09:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCW79lPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgICJZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICJZd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 05:25:33 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318C7C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 02:25:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c2so2733710ljj.12
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fagUWaUJszYLKHmOJ1eNwdsDLk5E54tG52azLjQE0J4=;
        b=oCW79lPZZ7+yUYnnu2PypuTY/ZNME/FddHxF+oHvY+pCtuDTfjMOV6jDnqnbc9qA5Z
         gL7xqt/67j+/DVhY07ZzsyuEbux96Nqeh+jH2cCVzenoyTf57JjvNC5UDC/r5t+mEizm
         BVFkunUELKjZG+TxDTb5vfKOEtz/xsFx0kz1xd+jbwpnn7u52Int1ycMQirQIJOpTXLG
         Ddy/ppIH265ua7h20az5ge/EVgvedtusVd5dJRGe7r+iRkpuW0kW1x8OpNa7wrU3nw6g
         gdsZ46PkarbCg2ay1zcg/q/CLNG1w+lQLfnKPHjJWa/f8tu8QGx1ZpupbG8rPqweXzFK
         jP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=fagUWaUJszYLKHmOJ1eNwdsDLk5E54tG52azLjQE0J4=;
        b=t5Nze4w2aKiwGhxxD9ZVTL4LDkU+uSOU3mj87pTzBVUPgvOZYm45nFZ4AqZoPCp7se
         JEwxnZ/8yPT2LxQzZN65bS0kH4kXrB4xHv9heBQauDeN6y5YjU8l7lS6jUAGSc2Xn4st
         IUejAFykFnGE21K7GGBuIfyKtX84GhA6WR2fHI5SHiIy+UgKCBln52zSNysR+eou9qrw
         6VI6l5uzOdxoCVUvcIWOyRA4atUiqYXIgdl+k6tCvmNZsOlR9o0TmgqD4W7//gOk+oph
         L/AilUzsiMWyaywxOLla6knwrITIH6Ls8Y60apJRoNDC9Q9gPz+gohz8zarftHcwIMN2
         ZNBg==
X-Gm-Message-State: AOAM530w8nQ+x1kgdBDrwLcav+J9+DG6uaaQIrD8WTG57aLJMyClJk4O
        KDnscjwH0AUy8Msm5CXEzhc=
X-Google-Smtp-Source: ABdhPJy3kt3L0TrjpFHBxSvKD/+L/457+u+0Sp2Lw9qW11MZUyMQQ3dC0jdfEiWWC3Ofm2KSw0TOgQ==
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr763637ljj.396.1599125129359;
        Thu, 03 Sep 2020 02:25:29 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id e15sm481008ljn.49.2020.09.03.02.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 02:25:28 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 06/11] commit-graph: add a slab to store topological levels
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <b347dbb01b9254ab8d79fbbd0f7c2b637efde62e.1597509583.git.gitgitgadget@gmail.com>
        <85d03jlu05.fsf@gmail.com> <20200825061418.GA629699@Abhishek-Arch>
        <855z97dvsp.fsf@gmail.com>
        <CANQwDwdsV0mSos7M_d7UP1CjT1rCyA_GfaYarMKUZaFdDZ0WRg@mail.gmail.com>
        <20200901102624.GB10388@Abhishek-Arch>
Date:   Thu, 03 Sep 2020 11:25:27 +0200
In-Reply-To: <20200901102624.GB10388@Abhishek-Arch> (Abhishek Kumar's message
        of "Tue, 1 Sep 2020 15:56:24 +0530")
Message-ID: <85imcvb4ag.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Tue, Aug 25, 2020 at 09:56:44AM +0200, Jakub Nar=C4=99bski wrote:
>> On Tue, 25 Aug 2020 at 09:33, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
>>
>> ...
>>
>>>
>>> All right, we might want to make use of the fact that the value of 0 for
>>> topological level here always mean that its value for a commit needs to
>>> be computed, that 0 is not a valid value for topological levels.
>>> - if the value 0 came from commit-graph file, it means that it came
>>>   from Git version that used commit-graph but didn't compute generation
>>>   numbers; the value is GENERATION_NUMBER_ZERO
>>> - the value 0 might came from the fact that commit is not in graph,
>>>   and that commit-slab zero-initializes the values stored; let's
>>>   call this value GENERATION_NUMBER_UNINITIALIZED
>>>
>>> If we ensure that corrected commit date can never be zero (which is
>>> extremely unlikely, as one of root commits would have to be malformed or
>>> written on badly misconfigured computer, with value of 0 for committer
>>> timestamp), then this "happy accident" can keep working.
>>>
>>>   As a special case, commit date with timestamp of zero (01.01.1970 00:=
00:00Z)
>>>   has corrected commit date of one, to be able to distinguish
>>>   uninitialized values.
>>>
>>> Or something like that.
>>>
>>> Actually, it is not even necessary, as corrected commit date of 0 just
>>> means that this single value (well, for every root commit with commit
>>> date of 0) would be unnecessary recomputed in compute_generation_number=
s().
>>>
>>> Anyway, we would want to document this fact in the commit message.
>>=20
>> Alternatively, instead of comparing 'level' (and later in series also
>> 'corrected_commit_date') against GENERATION_NUMBER_INFINITY,
>> we could load at no extra cost `graph_pos` value and compare it
>> against COMMIT_NOT_FROM_GRAPH.
>>=20
>> But with this solution we could never get rid of graph_pos, if we
>> think it is unnecessary. If we split commit_graph_data into separate
>> slabs (as it was in early versions of respective patch series), we
>> would have to pay additional cost.
>>=20
>> But it is an alternative.
>
> I think updating a commit date with timestampt of zero to use corrected
> commit date of one would leave us more options down the line.
>
> Changing this is easy enough.
>
> For a root commit with timestamp zero, current->date would be zero and=20
> max_corrected_commit_date would be zero as well. So we can set=20
> corrected commit date as `max_corrected_commit_date + 1`, instead of the
> earlier `(current->date - 1) + 1`.
>
> ----
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 7ed0a33ad6..e3c5e30405 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1389,7 +1389,7 @@ static void compute_generation_numbers(struct write=
_commit_graph_context *ctx)
>  					max_level =3D GENERATION_NUMBER_V1_MAX - 1;
>  				*topo_level_slab_at(ctx->topo_levels, current) =3D max_level + 1;
>=20=20
> -				if (current->date > max_corrected_commit_date)
> +				if (current->date && current->date > max_corrected_commit_date)
>  					max_corrected_commit_date =3D current->date - 1;
>  				commit_graph_data_at(current)->generation =3D max_corrected_commit_d=
ate + 1;
>  			}

It turned out to be much easier than I have expected: a one-line change,
adding simply a new condition.  Good work!

Perhaps it would be better to write it as current->date =3D=3D GENERATION_N=
UMBER_UNINITIALIZED
(or *_ZERO, or *_NO_DATA,...), but current version is quite idiomatic
and easy to read.

With this change we should, of course, also change the commit-graph
format docs.


On the other hand it is a bit unnecessary.  If `generation` is zero,
using it would still work, and it would just mean that it would be
unnecessarily recomputed - but corrected commit date equal zero is
possible only for root commits.

But the above solution is more consistent, using 0 to mark not
initialized values...  it is cleaner, at the cost of one more corner
case, single line change, and possibly an insignificant amount of
performance penalty due to adding unlikely true branch to the
conditional.

Best,
--=20
Jakub Nar=C4=99bski
