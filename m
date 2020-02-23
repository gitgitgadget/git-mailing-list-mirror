Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDC0C35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 17:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E492D2067D
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 17:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2zdGwaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBWRe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 12:34:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38803 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgBWRe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 12:34:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so7457331ljh.5
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lMfVWxtvzaGpp0Yd89kkICgdWpdLVrmGy1xXft05SOQ=;
        b=r2zdGwaPqSLQGhE2vVTClIxyILlQzFp0P5fFxNZMOVgVKtDKcMr9w4aTVb6HiJaWgy
         4+YROYMcxHlZq1Fn6mRD+rUe/mfk/G5DrXGTqLV+wx9gg9eELVJ5ReoWRx37UNpSWdAP
         7/YFPoLz7AdhWKk8xsLH1IQpk8Y90OrHFN+1McxchesHw4WlDDAXcFS1R+MXQnSWmxPP
         EUSSRvR6/4CKkS8fmpGRuAZQe3+sz4Mk26fRSdHJOdt3HQQ0Y3th1uWldV+2NSj/93xj
         ODyFLUlIzCTGLalVBR+C57VT/8ihxyG9/ojzuvwjPmkb49pTJKxHtr3+n03TNTxk9Z6p
         uZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=lMfVWxtvzaGpp0Yd89kkICgdWpdLVrmGy1xXft05SOQ=;
        b=R0KtzUVngN1gXdKQGWttyNofeNl0qNWYIxIYO7cX5gsCuCGfaCCwitzYMrIUz9/i2J
         mBQt+oYgJ8cTf+SV5ZP3Cs+AUrJTokvZzA362j9SqZBCgiPP8ZtzecOTk9TNKI0dtWO6
         b7O8EcYa/XrlkH68aXx2N9V6XFa1u6+MdPhawvz9+uAwIjRXgxyw7Me5/zAVcmovlSCr
         kgm7KbAqQi0+QuEL907qFcA3JGPRjJmfXkDH0JTJz6YSTDkC2fKqu5MrW8LcOmUDCh+A
         fbYd0Nst8WQ4FeCg9T+nR/pMDPqP8w9NELn8pTLyPBI8cXF0kcFilaLYTDaRBmGL3M3g
         HyEQ==
X-Gm-Message-State: APjAAAW41JqZnSNBltSr+DTukTHJVN4PyPBx+sJYQqXFPC3AYyqib7YU
        DHzK0dgHzkKMCmpiSvc1qAYDX1esYbE=
X-Google-Smtp-Source: APXvYqyorZP7diM74Hz+0IQfIdci0QNsYwhBig/RytWdEWsrgW5DMuLA+R/iQNrq4BZHpYadLeQg8Q==
X-Received: by 2002:a05:651c:32b:: with SMTP id b11mr28062699ljp.203.1582479265452;
        Sun, 23 Feb 2020 09:34:25 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id y23sm4961302ljk.6.2020.02.23.09.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 09:34:24 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 04/11] commit-graph: compute Bloom filters for changed paths
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <c17bbcbc66ea77bb480391804d1f2db66ffa0926.1580943390.git.gitgitgadget@gmail.com>
        <86k14klvyb.fsf@gmail.com>
        <0f1ab477-fae8-b744-5c48-87995f7fc8eb@gmail.com>
Date:   Sun, 23 Feb 2020 18:34:22 +0100
In-Reply-To: <0f1ab477-fae8-b744-5c48-87995f7fc8eb@gmail.com> (Garima Singh's
        message of "Fri, 21 Feb 2020 19:55:56 -0500")
Message-ID: <86o8tp8axt.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:
> On 2/17/2020 4:56 PM, Jakub Narebski wrote:
>> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

[...]
>>> ---
>>>  commit-graph.c | 32 +++++++++++++++++++++++++++++++-
>>>  commit-graph.h |  3 ++-
>>>  2 files changed, 33 insertions(+), 2 deletions(-)
>>=20
>> It would be good to have at least sanity check of this feature, perhaps
>> one that would check that the number of per-commit Bloom filters on slab
>> matches the number of commits in the commit-graph.
>
> The combination of all the e2e tests in this series with the test
> flag being turned on in the CI, and the performance gains we are seeing
> confirm that this is happening correctly.

Well, the advantage of unit tests over e2e functional tests is that they
can pinpoint the source of bug much more easily.

That said, I don't think there is absolute need for unit tests here,
though it would be nice to have them.

>>>=20=20
>>>  	const struct split_commit_graph_opts *split_opts;
>>> +	uint32_t total_bloom_filter_data_size;
>>=20
>> This is total size of Bloom filters data, in bytes, that will later be
>> used for BDAT chunk size.  However the commit-graph format uses 8 bytes
>> for byte-offset, not 4 bytes.  Why it is uint32_t and not uint64_t then?
>
> Changed to size_t. Thanks for noticing!=20

Right, this is a local value (size_t may be different size on different
architectures), even though it will be stored indirectly in chunk lookup
table as pair of uint64_t offsets.

>>>  };
>>>=20=20
>>>  static void write_graph_chunk_fanout(struct hashfile *f,
>>> @@ -1140,6 +1143,28 @@ static void compute_generation_numbers(struct wr=
ite_commit_graph_context *ctx)
>>>  	stop_progress(&ctx->progress);
>>>  }
>>>=20=20
>>> +static void compute_bloom_filters(struct write_commit_graph_context *c=
tx)
>>> +{
>>> +	int i;
>>> +	struct progress *progress =3D NULL;
>>> +
>>> +	load_bloom_filters();
>>> +
>>> +	if (ctx->report_progress)
>>> +		progress =3D start_progress(
>>> +			_("Computing commit diff Bloom filters"),
>>> +			ctx->commits.nr);
>>> +
>>=20
>> Shouldn't we initialize ctx->total_bloom_filter_data_size to 0 here?  We
>> cannot use compute_bloom_filters() to _update_ Bloom filters data, I
>> think -- we don't distinguish here between new and existing data (where
>> existing data size is already included in total Bloom filters size).  At
>> least I don't think so.
>>=20
>
> This line in commit-graph.c takes care of reinitializing the graph contex=
t and
> by consequence the bloom filter data size.
>
>   ctx =3D xcalloc(1, sizeof(struct write_commit_graph_context));
>=20=20=20
> So the total size gets recalculated every time, which is correct.=20

True, I have missed this.

Best,
--=20
Jakub Nar=C4=99bski
