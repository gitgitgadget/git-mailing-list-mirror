Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4CCC35242
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 23:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8706C2080C
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 23:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAjWk/Lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgBHXEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 18:04:53 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34423 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgBHXEx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 18:04:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so3108012ljc.1
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 15:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kzyIVQur6cpxQUwHltfvfrsWzf4pGBFHtEs6QhY0mx4=;
        b=vAjWk/LjKgNWfIhP86Luo+Vp0ZDG7dI6lD85ECPuE2yNlXidDH1IUg5TVZSs5MpeIH
         W+P8o8Hw6EcCN20l7Kot+atYuU7VnD3U8RfdCX97D8RVzTHgDFw5jJOVhPlrEyOygKDQ
         8lORrG6tsNPafvMeECnG1HAp3H+4AXQ51uMDOH7kOnfp+LETN2kLcJkoipwWzEVoZBNP
         jg98+n0+b/2Ksn0/DaCkrdC72+EyZu990meLtI4JOT1u3P4kPJ1oZdtamW1k8SExA2zs
         IWWiIrRZ/CETeONS1WJQ2MZxLyi78ZnD2kCqNdmfvcalcK64imvROCq47Zj+OY8Np8lH
         wTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=kzyIVQur6cpxQUwHltfvfrsWzf4pGBFHtEs6QhY0mx4=;
        b=CjuHAsuP1RoU4BvWdEa5AOLMNDvkIPkGBO1CGcP3mm09sfNPN6/Ufbt3ohKpQwqoAo
         01/Ilmfu+PhK8W3/P4bKfjaEvXajzRehuhSK2p0Z3Xh+OYut/jIUpNR8Vwv1MJ0oQEcF
         p2SlhgpXzyYj8Y9JQ08qmlhzLMbiZv2tJX+mO0W1TGAaJIbmMylBwmcaIcONLeVPlQI5
         qtDP1HwsEA+t4nesLRj+CrQBQ4n2WtAcPW0Jhpr4QijW/lE+Gs9CO86tUCdR2VXHdiK1
         PyTyWookJ4U6X6OFAp2O2bCyoCciLNnY6FcChcha3CYbweYpRTGsGqNASj2q/Hc1nSoD
         NllA==
X-Gm-Message-State: APjAAAXrjRm++6r5o4iBEiDrdy0bQ/ISka09+Wwwpd8OUEYSg+/MCtOj
        7CXn4ec+oidhQx/KnKEmsPc=
X-Google-Smtp-Source: APXvYqw0bhCbFFsJHLeayTfTmZb01n81QuRcgn4WVR85a2QlfKsDKAjqNcxVHi8uejeZIbNV9E7mqQ==
X-Received: by 2002:a05:651c:1183:: with SMTP id w3mr3878893ljo.232.1581203090429;
        Sat, 08 Feb 2020 15:04:50 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id u11sm3101061lfo.71.2020.02.08.15.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Feb 2020 15:04:49 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Garima Singh <garimasigit@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 00/11] Changed Paths Bloom Filters
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
Date:   Sun, 09 Feb 2020 00:04:41 +0100
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com> (Garima Singh
        via GitGitGadget's message of "Wed, 05 Feb 2020 22:56:19 +0000")
Message-ID: <86a75swuie.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Hey!=20
>
> The commit graph feature brought in a lot of performance improvements acr=
oss
> multiple commands. However, file based history continues to be a performa=
nce
> pain point, especially in large repositories.=20
>
> Adopting changed path Bloom filters has been discussed on the list before,
> and a prototype version was worked on by SZEDER G=C3=A1bor, Jonathan Tan =
and Dr.
> Derrick Stolee [1]. This series is based on Dr. Stolee's proof of
> concept in [2].

Sidenote: I wondered why it did use MurmurHash3 (64-bit version), which
requires adding its implementation, instead of reusing FNV-1 hash
(Fowler=E2=80=93Noll=E2=80=93Vo hash function) used by Git hashmap implemen=
tation, see
https://github.com/git/git/blob/228f53135a4a41a37b6be8e4d6e2b6153db4a8ed/ha=
shmap.h#L109
Beside the fact that everyone is using MurmurHash for Bloom filters ;-)

It turns out that in various benchmark MurmurHash is faster and also
slightly better as a hash than FNV-1 or FNV-1b.


I wonder then if it would be a good idea (in the future) to make it easy
to use hashmap with MurmurHash3 instead of FNV-1, or maybe to even make
it the default for hashing strings.

>
> Performance Gains: We tested the performance of git log -- path on the git
> repo, the linux repo and some internal large repos, with a variety of pat=
hs
> of varying depths.

As I wrote in reply to previous version of this series, a good public
repository (and thus being able to use by anyone) to test the Bloom
filter performance improvements could be AOSP (Android) base:

  https://android.googlesource.com/platform/frameworks/base/

which is a large repository with long path depths (due to Java file
naming conventions).

>
> On the git and linux repos: We observed a 2x to 5x speed up.
>
> On a large internal repo with files seated 6-10 levels deep in the tree: =
We
> observed 10x to 20x speed ups, with some paths going up to 28 times faste=
r.

Very nice! Good work!

What is the cost of this feature, that is how long it takes to generate
Bloom filters, and how much larger commit-graph file gets?  It would be
nice to know.

>
> Future Work (not included in the scope of this series):
>
>  1. Supporting multiple path based revision walk

Shouldn't then tests that were added in v2 mark use of Bloom filters
with multiple paths revision walking as _not working *yet*_
(test_expect_failure), and not expected to not work (test_expect_success
with test_bloom_filters_not_used)?

>  2. Adopting it in git blame logic.=20
>  3. Interactions with line log git log -L
>
>
> -------------------------------------------------------------------------=
---
>
> Updates since the last submission
>
>  * Removed all the RFC callouts, this is a ready for full review version
>  * Added unit tests for the bloom filter computation layer
>  * Added more evolved functional tests for git log
>  * Fixed a lot of the bugs found by the tests
>  * Reacted to other miscellaneous feedback on the RFC series.=20
>
> Cheers! Garima Singh
>
> [1] https://lore.kernel.org/git/20181009193445.21908-1-szeder.dev@gmail.c=
om/
> [2] https://lore.kernel.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmai=
l.com/
>
> Derrick Stolee (2):
>   diff: halt tree-diff early after max_changes
>   commit-graph: examine commits by generation number
>
> Garima Singh (8):
>   commit-graph: use MAX_NUM_CHUNKS
>   bloom: core Bloom filter implementation for changed paths
>   commit-graph: compute Bloom filters for changed paths
>   commit-graph: write Bloom filters to commit graph file
>   commit-graph: reuse existing Bloom filters during write.
>   commit-graph: add --changed-paths option to write subcommand
>   revision.c: use Bloom filters to speed up path based revision walks
>   commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
>
> Jeff King (1):
>   commit-graph: examine changed-path objects in pack order

The shortlog summary is a fine tool to show contributors to the patch
series, but is not as useful to show patch series as a whole: splitting
of patches and their ordering.

I will review each of patches individually, but now I would like to say
a few things about the series as a whole.

- [PATCH v2 01/11] commit-graph: use MAX_NUM_CHUNKS

  Simple and non-controversial patch, improvement to existing code with
  the goal of helping future development (including further patches).

- [PATCH v2 02/11] bloom: core Bloom filter implementation for changed paths

  In my opinion this patch could be split into three individual pieces,
  though one might think it is not worth it.

  a. Add implementation of MurmurHash v3 (64-bit)
=20=20
  Include tests based on test-tool (creating file similar to the
  t/helper/test-hash.c, or enhancing to that file) that the
  implementation is correct, for example that 'The quick brown fox jumps
  over the lazy dog' with given seed (for example the default feed of 0)
  hashes to the same value as other implementations.

  b. Add implementation of Bloom filter

  Include generic Bloom filter tests i.e. that it correctly answers
  "yes" and "maybe" (create filter, save it or print it, then use stored
  filter), and tests specific to our implementation, namely that the
  size of the filter behaves as it should.

  c. Bloom filter implementation for changed paths

  Here include tests that use 'test-tool bloom get_filter_for_commit',
  that filter for commit with no changes and for commit with more than
  512 fies changed works correctly, that directories are added along the
  paths, etc.

- [PATCH v2 03/11] diff: halt tree-diff early after max_changes

  I think keeping this patch as a separate step makes individual commits
  easier to understand and review.

- [PATCH v2 04/11] commit-graph: compute Bloom filters for changed paths

  Here we compute Bloom filters for changed paths for each commit in the
  commit-graph file, without writing it to file; as a side-effect we
  calculate total Bloom filters data size.

  This doesn't make much sense as a standalone patch, but it is nice,
  easy to understand incremental step in building the feature.

- [PATCH v2 05/11] commit-graph: examine changed-path objects in pack order
- [PATCH v2 06/11] commit-graph: examine commits by generation number

  Those two are performance improvements of previous step.  It is good
  to keep them as separate commits, makes it easier to understand (and
  easier to catch error via git-bisect, if there would be any)

- [PATCH v2 07/11] commit-graph: write Bloom filters to commit graph file

  This commit includes the documentation of the two new chunks of
  commit-graph file format.

  I wonder if the 9th patch in this series, namely
  commit-graph: add --changed-paths option to write subcommand
  should not precede this commit.  Otherwise we have this new code but
  no way of testing it.  On the other hand it makes it easier to
  review.  On the gripping hand, you can't really test that writing
  works without the ability to parse Bloom filter data out of
  commit-graph file... which is the next commit.

- [PATCH v2 08/11] commit-graph: reuse existing Bloom filters during write

  This implements reading Bloom filters data from commit-graph file.
  Is it a good split?  I think it makes it easier to review the single
  patch, but itt also makes them less standalone.

- [PATCH v2 09/11] commit-graph: add --changed-paths option to write subcom=
mand

  One thing we could test there is that we are writing two new chunks to
  the commit-graph file (and perhaps checking that they are correctly
  formatted, and have correct shape).

- [PATCH v2 10/11] revision.c: use Bloom filters to speed up path based rev=
ision walks

  This is quite a big and involved patch, which in my opinion could be
  split in two or three parts:

  a. Add a bare bones implementation, like in v2

  This limits amount of testing we can do; the only thing we can really
  test is that we get the same results with and without Bloom filters.

  b.1. Add trace2 Bloom filter statistics
  b.2. Use said trace2 statistics to test use of Bloom filters

- [PATCH v2 11/11] commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS te=
st flag

  This one is for (optional) exhaustive testing of the feature.


Feel free to disagree with those ideas.

Best,
--=20
Jakub Nar=C4=99bski
