Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD7CA0FF6
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 20:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbjIAU4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 16:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjIAU4W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 16:56:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23E210F3
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 13:56:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7ba833ef2aso2183809276.0
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693601778; x=1694206578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4m77+gmenWIEbq/dVck0ke/lmi2bj1kqJcNPHtDghoY=;
        b=TTGGZMjHZdJZb0Zfkr4AUIupxFd9X7WBXSzrOOemMZggf3IEsNV34BQ4W2UBASX0zG
         MYblM2sZ+tWip9913N44+fFfN35+qKxGmYKeUshbiCuNt6BjwDK1V+KVNi7H2YQKXlMG
         T2IIppi3tLSjnE+zI5DDoGPLjdhEcDqruuImaNi6pq8swZorCP7HTutiQWwOxXAH6Rmf
         sQ8yOJ9+PUlgJe6V23ocXs+mdeOmffO2EgC0ctE3rC+S3vpTv3rv4/fL2WGokI5mv884
         2F0qlWJ67LuUnJ5l/1kPzOueOAbLYFk6h6p6gx8WpUgjJcaOvKz3v3x1pev7VdAxYm7d
         m2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693601778; x=1694206578;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4m77+gmenWIEbq/dVck0ke/lmi2bj1kqJcNPHtDghoY=;
        b=boPz5oibxyVQf7c0E3Kx8xMM7RJUu6eFmeWUQru4mQ6u6vtYo2jzXluwSkb7inKW4d
         12dRyWeUEZU9IC54sLAV+5AjBN1aTYH7JLirMekg/JxBjYV+LYoStZ3Bk4BOTYoR0sXo
         Cx+LsKJk8gR25rsssYbPX6A7ZHM5wrQ3GN9J31eolOHaWrjf+HtztcyNXhcOdVdBwW/T
         4F31Giyg78yDJbQhxp+2BJjjDHrQ4vh+0UczRTZwRFbpt+QSYZxkzwj4nBbAs+K3okTc
         4fQdw0qRYTmxy9VgjXyRYvKsq1qiuamqdeiU5DvBKHaXIw29DKUtlBBWpwpSbzoLQxcT
         g4vA==
X-Gm-Message-State: AOJu0YxZ1XtnSWtUVElrl1jnZ0+xoVUm8MRudF7Av62FDwT2+PAXkvxG
        9ylmDvwyRKAVJb3mqJJ5lqSWX6n5lIajr4EV96G4
X-Google-Smtp-Source: AGHT+IE8anh0uuJ84YTlfqL//CjP1dMibdhw7YH+RTEZSHHhjjseeEpDnN58w8eF6hCjXSt6ihSaIJyztlRB/Rf3hK6V
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:b036:168a:a330:172d])
 (user=jonathantanmy job=sendgmr) by 2002:a25:e68c:0:b0:d7a:bd65:18ba with
 SMTP id d134-20020a25e68c000000b00d7abd6518bamr94470ybh.3.1693601778111; Fri,
 01 Sep 2023 13:56:18 -0700 (PDT)
Date:   Fri,  1 Sep 2023 13:56:15 -0700
In-Reply-To: <20230830200218.GA5147@szeder.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230901205616.3572722-1-jonathantanmy@google.com>
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
> I'd prefer to leave the test cases unchanged, and make the revision
> walking machinery look at Bloom filters even for root commits, because
> this is an annoying and recurring testing issue.  I remember it
> annoyed me back then, when I wanted to reproduce a couple of bugs that
> I knew were there, but my initial test cases didn't fail because the
> Bloom filter of the root commit was ignored; Derrick overlooked this
> in b16a8277644, you overlooked it now, and none of the reviewers then
> and now caught it, either.

I agree that making the revwalk look at Bloom filters of root commits
is an urgent matter for the reasons you describe (it's something
easily missed that slows down future development and/or makes future
development error-prone), but so is moving to a correct murmur3
implementation, I think, and one shouldn't stop the other. There could
be an argument that because the revwalk doesn't look at root commit
Bloom filters, any development on a new Bloom filter hash version is
suspect, but I don't think that has to be completely true.

> > My original design (up to patch 7 in this patch set) defends against
> > this by taking the very first version detected and rejecting every
> > other version, and Taylor's subsequent design reads every version, but
> > annotates filters with its version. So I think we're covered.
>=20
> In the meantime I adapted the test cases from the above linked message
> to write commit-graph layers with different Bloom filter versions, and
> it does fail, because commits from the bottom commit-graph layer are
> omitted from the revision walk's output.  And the test case doesn't
> even need a middle layer without modified path Bloom filters to "hide"
> the different version in the bottom layer.  Merging the layers seems
> to work, though.

For what it's worth, your test case below (with test_expect_success
instead of test_expect_failure) passes with my original design. With the
full patch set, it does fail, but for what it's worth, I did spot this,
providing an incomplete solution [1] and then a complete one [2]. Your
test case passes if I also include the following:

  diff --git a/bloom.c b/bloom.c
  index ff131893cd..1bafd62a4e 100644
  --- a/bloom.c
  +++ b/bloom.c
  @@ -344,6 +344,10 @@ struct bloom_filter *get_bloom_filter(struct reposit=
ory *r, struct commit *c)
  =20
          prepare_repo_settings(r);
          hash_version =3D r->settings.commit_graph_changed_paths_version;
  +       if (hash_version =3D=3D -1) {
  +               struct bloom_filter_settings *s =3D get_bloom_filter_sett=
ings(r);
  +               hash_version =3D (s && s->hash_version =3D=3D 2) ? 2 : 1;
  +       }
  =20
          if (!(hash_version =3D=3D -1 || hash_version =3D=3D filter->versi=
on))
                  return NULL; /* unusable filter */

[1] https://lore.kernel.org/git/20230824222051.2320003-1-jonathantanmy@goog=
le.com/
[2] https://lore.kernel.org/git/20230829220432.558674-1-jonathantanmy@googl=
e.com/

> Besides fixing this issue, I think that the interaction of different
> Bloom filter versions and split commit-graphs needs to be thoroughly
> covered with test cases and discussed in the commit messages before
> this series could be considered good for merging.

Regarding commit messages, I can see that in "commit-graph: new filter
ver. that fixes murmur3", I could add "(the first version read if there
are multiple versions of changed path filters in the repository)" after
"automatically determined from the version of the existing changed path
filters in the repository". Taylor's patches already inherently cover
multiple versions, I think, since Bloom filters are annotated with their
versions, individually.

Regarding tests, yes, we could add the one you provided.

If you (or anyone else) can spot anything else that should be added,
please let us know.
