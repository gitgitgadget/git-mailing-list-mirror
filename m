Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD033C6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 16:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbjH2Qbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbjH2Qb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 12:31:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5BA6
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 09:31:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59224c40275so62285517b3.3
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693326686; x=1693931486;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAFKGpqLCuDuTMUvVDhTgiRB9ERhD+bEjswm23GuZLM=;
        b=e7r0yVaXZt7/o43kPpUfichY+APJKhQ6LDSwcsjcjqkvkDTmge00gCVx6m98A44MHN
         SQmS6nXcBFXINM/SxD8OnQaTcItno84/1H4txU1Q+dKG699QowDDLFs+OopRIzGxgmcq
         ZGiXwofZq4zTepQkgeTU1BAQLf3PeESMJ/sVPovfuMdClgo2QsQ4aVZZpBuQjzrC7BmF
         8EejgsdgNIZ+7/LPjjZ95rgyGNnGUIWD/KV8JVge7X559jisVlPynhMdKSAiF/86JdEF
         tAokXyI6z5xwLJ/xHPMrCPn1V7pFxeF4pT61pt64ZmuXE/fzVt+Sz86QQRzT4dP/ZI8n
         Lm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693326686; x=1693931486;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bAFKGpqLCuDuTMUvVDhTgiRB9ERhD+bEjswm23GuZLM=;
        b=AZEndDDRPeH9IsK87+BMe+qz4gBFeHBgdhFrbhO6XgXpJL0hVDCPtD828xZj9J52bp
         B25CCtfw94Zpnh7qo1sPc1kZYMb7VRlFzpQZxcSslLWhyXzCip9NEpoLfJBXwcFkTuhf
         jid1hU2dUAypCkG+qqBXq/KE5IyaQOucMbaI7VhWz84xysjAM2qUItu5l3heWwgfWVnb
         4UvZ/RifcDP2nIIVIIVPFu3mDsLpzXcSp4Iq4ZOOqtdnU8996bGYeYazmrqR7DEhRsvh
         j77F4CDbo1noCe3ypbw+RSRon+Xi/NIKM9Yxid+k6z8nlX9hcbqbWezcXyv7y7SnmwrJ
         OIAg==
X-Gm-Message-State: AOJu0YwfwCQtMGlcBcELUuXyToTBn8xUZbV690ZL5ohOjECq6WxzwjaX
        FyTm4JYQ16IZgwEfZrq0MAZPwlzyJmSt3XWzU5gU
X-Google-Smtp-Source: AGHT+IHQ1cU5/hcZojM9C4lsnpHOmB1TdQ88LdGFqjyMqoOaiDhZX+zkIRd8K5GDfoQ1pBxS28/+1acAdWZZNpB3oEZu
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:ec07:4d48:eb22:d87c])
 (user=jonathantanmy job=sendgmr) by 2002:a81:4311:0:b0:58c:74ec:339b with
 SMTP id q17-20020a814311000000b0058c74ec339bmr946499ywa.1.1693326686415; Tue,
 29 Aug 2023 09:31:26 -0700 (PDT)
Date:   Tue, 29 Aug 2023 09:31:23 -0700
In-Reply-To: <20230826150610.GA1928@szeder.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230829163124.363157-1-jonathantanmy@google.com>
Subject: Re: [PATCH 07/15] commit-graph: new filter ver. that fixes murmur3
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> > @@ -66,7 +66,64 @@ int load_bloom_filter_from_graph(struct commit_graph=
 *g,
> >   * Not considered to be cryptographically secure.
> >   * Implemented as described in https://en.wikipedia.org/wiki/MurmurHas=
h#Algorithm
> >   */
> > -uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
> > +uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len=
)
>=20
> Nit: MurmurHash3 implementations in C/C++ (apart from the sample
> implementation on Wikipedia), and other hash functions taking data
> pointer and buffer size parameters in general, have a 'const void
> *data' parameter, not 'const char*'.

I think either works, so I'll stick with what the existing code uses.
(Well, we probably should have used "unsigned char" in the first place.)

> > +test_expect_success 'when writing another commit graph, preserve exist=
ing version 1 of changed-path' '
> > +	test_commit -C highbit1 c1double "$CENT$CENT" &&
> > +	git -C highbit1 commit-graph write --reachable --changed-paths &&
>=20
> Nit: Since there is a subshell cd-ing into the 'highbit1' directory
> anyway, it would look clearer to put these two commands into that
> subshell as well.
> This applies to some of the later test cases as well.

Makes sense, but this patch series has already been reviewed a few times
so I don't think it's worth making this change at this point in the
review process for a small increase in readability.

> > +test_expect_success 'version 2 changed-path used when version 2 reques=
ted' '
> > +	(
> > +		cd highbit2 &&
> > +		test_bloom_filters_used "-- $CENT"
>=20
> This test_bloom_filter_used helper runs two pathspec-limited 'git log'
> invocations, one with disabled and the other with enabled
> commit-graph, and thus with disabled and enabled modified path Bloom
> filters, and compares their output.
>=20
> One of the flaws of the current modified path Bloom filters
> implementation is that it doesn't check Bloom filters for root
> commits.
>=20
> In several of the above test cases test_bloom_filters_used is invoked
> in a repository with only a root commit, so they don't check that
> the output is the same with and without Bloom filters.

Ah...you are right. Indeed, when I flip one of the tests from
test_bloom_filters_used to _not_, the test still passes. I'll change
the tests.

> The string "split" occurs twice in this patch series, but only in
> patch hunk contexts, and it doesn't occur at all in the previous long
> thread about the original patch series.
>=20
> Unfortunately, split commit-graphs weren't really considered in the
> design of the modified path Bloom filters feature, and layers with
> different Bloom filter settings weren't considered at all.  I've
> reported it back then, but the fixes so far were incomplete, and e.g.
> the test cases shown in
>=20
>   https://public-inbox.org/git/20201015132147.GB24954@szeder.dev/
>=20
> still fail.
>=20
> Since the interaction of different versions and split commit-graphs
> was neither mentioned in any of the commit messages nor discussed
> during the previous rounds, and there isn't any test case excercising
> it, and since the Bloom filter version information is stored in the
> same 'g->bloom_filter_settings' structure as the number of hashes, I'm
> afraid (though haven't actually checked) that handling commit-graph
> layers with different Bloom filter versions is prone to the same
> issues as well.

My original design (up to patch 7 in this patch set) defends against
this by taking the very first version detected and rejecting every
other version, and Taylor's subsequent design reads every version, but
annotates filters with its version. So I think we're covered.
