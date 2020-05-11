Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF1C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 18:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D44206E6
	for <git@archiver.kernel.org>; Mon, 11 May 2020 18:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv3Q3cMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgEKSgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 14:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729727AbgEKSgF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 14:36:05 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7DC061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 11:36:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so4457088pgv.8
        for <git@vger.kernel.org>; Mon, 11 May 2020 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9pFUCshZABY/fxhwSCUgRjXVx3PpsvXyOxHe7bgEn34=;
        b=Hv3Q3cMTQsFMIDq4mkh/yG0CewjrkhSceczyiN4VklU24GPDB2dPY9dIk5JLZOQB3I
         FSMRmkHq1w1dVEsvkiXwBtVD8BERWsR8LHLypu6iZUnL03A0QtixyCulMajt3VkZxhnT
         U2KKfHt8yLfqKcVXoFxyY/CPSs2sSJqhq4SwYkkYM3cqGMy9QmAj/uOEeCHjlSpqeeYy
         hIQJ0FRtBHoyXLxpsOreXLLIFxs4e/Tg2ACBgN2/Gfpa/U3ahHYkDNsEmHuhnVsKdaxL
         ZOgAjzFgdh3FtL46HIPU3iZA8HRZfchbC0Lv0GsSxpuqLQ2ObU8NXMUkdF4QrWza7Y9G
         UelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pFUCshZABY/fxhwSCUgRjXVx3PpsvXyOxHe7bgEn34=;
        b=cs8NHUFFCri3oTHVfXsbBzY5DQ6jyMjcIzgUhNAjBIhOZdyTMa5xLRKCPLCh7uzNsV
         tMDRqKfyEb6G1/a6E6WSz5QRZaPZKsKCUYYCutaV+OGTPPvaV3TjIhbud0aafN9AKblH
         66pd4vpq42z+rVOl9NjQUPFH1P0ZtOaYJDcQKErrE6wGa0oUU8K0p3CRRDGDESsk6zbE
         JQwC94th6I1KtCM4T9vQy3s4BL0+JehgbfKl+OR3cQsSvebm0MZ57DmhMmdrjwRB1k3P
         KYPB5HHLsdKtdL/VCxEwKqGXwQLutVlwwmbObIeanxDOgHCZghgDYaDDxSN/Xk1D8uFS
         LDXg==
X-Gm-Message-State: AGi0Pua6V2nElU/OfpIrgVl2+nxQ8wVO/MGUohatjIe3jcYashd6rcJg
        UA7qnTlrKf+4P/t4IOEDVQwp1PJq
X-Google-Smtp-Source: APiQypKgrOAWtrEGexylShs0sD62mEH1UtMX9oIKvwDVYeDXkfT1VOM15F90pn/WwDg7Wvyc/LjSsQ==
X-Received: by 2002:a62:528e:: with SMTP id g136mr18278314pfb.165.1589222164966;
        Mon, 11 May 2020 11:36:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id o17sm8504564pgv.83.2020.05.11.11.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:36:04 -0700 (PDT)
Date:   Mon, 11 May 2020 11:36:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: How to move forward with Reftable
Message-ID: <20200511183602.GA141481@google.com>
References: <CAFQ2z_Ne-1TWMRS88ADhzQmx4OfzNEkVUJ1anjf57mQD4Gdywg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ2z_Ne-1TWMRS88ADhzQmx4OfzNEkVUJ1anjf57mQD4Gdywg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: a few people I'm particularly interested in feedback from)

Han-Wen Nienhuys wrote[3]:

> I have noticed that not everyone is happy with the reftable series as
> it currently stands. I wanted to give some background on why it looks
> the way it does today, I want to solicit feedback on where to go from
> here, and share my worries about the negative feedback I've gotten so
> far.
[...]
> As it currently stands, the library implements the specification
> completely, including the parts that are currently probably not useful
> for Git, like support for the object-ID/ref mapping. The API between
> reftable and git is extremely narrow: it's about 20 functions, and 5
> structure definitions. It's also well tested (see coverage [2]. As of
> today, the tests are leak-free according to valgrind). This is also
> why I don't believe Johannes' argument that, because he found one bug,
> it must be full of bugs.
>
> This approach has been successful, in the sense that the libgit2
> project has experimented with integrating it, see
> https://github.com/libgit2/libgit2/pull/5462. They seem happy at the
> prospect of integrating existing code rather than reimplementing it.

Separate from the integration aspect is that this is not yet
battle-tested code.  One benefit of sharing code is to be able to share
the benefit of users testing it.

Since the ref system is fairly modular and this is about a non-default
backend, it's likely okay to integrate it initially as "experimental"
and then update docs as we gain confidence.

> Johannes had suggested that this should be developed and maintained in
> git-core first, and the result could then be reused by libgit2
> project. According to the libgit2 folks, this what that would look
> like:
>
> """
>     - It needs to be easy to split out from git-core. If it is
>       self-contained in a single directory, then I'd be sufficiently
>       happy already.
>
>     - It should continue providing a clean interface to external
>       callers. This also means that its interface should stay stable so
>       we don't have to adapt on every update. git-core historically
>       never had such promises, but it kind of worked out for the xdiff
>       code.
>
>     - My most important fear would be that the reftable interface
>       becomes heavily dependent on git-core's own data types. We had
>       this discussion at the Contributor's Summit already, but if it
>       starts adopting things like git-core's own string buffer then it
>       would become a lot harder for us to use it.
>
>     - Probably obvious, but contained in the above is that it stays
>       compilable on its own. So even if you split out its directory and
>       wire up some build instructions, it should not have any
>       dependencies on git-core.
> """
>
> (for the discussion at the summit:
> https://lore.kernel.org/git/1B71B54C-E000-4CEB-8AC6-3DB86E96E31A@jramsay.com.au/)
>
> I can make that work, but it would be good to know if this is
> something the project is OK with in principle, or whether the code
> needs to be completely Git-ified. If the latter happens, that would
> effectively fork the code, which I think is a missed opportunity.

There's been some discussion about use of strbuf versus the module's
own growing-buffer "struct slice".  Is that the only instance of this
kind of infrastructure duplication or are there others?

> I have received a lot of negative comments, and I can't gauge well
> what to make of them, but they kindle several worries:
>
> * The git community decides they don't need the object reverse index,
>   and do not write 'o' section in reftables, because that culls 1000
>   lines of code. This generally works, but will cause hard to debug
>   performance regressions if command-line git is used on a gerrit
>   server.
>
> * The git community looks at this, and decides the standard is too
>   complex, and goes off to create a reftable v3.
>
> * The git community asks me to do a ton of superficial work (eg. slice
>   -> strbuf), and then decides the overall design needs to be different,
>   and should be completely rewritten.
>
> Jonathan Nieder said I shouldn't worry about standards compliance,
> because the Git project has already ratified the reftable standard,
> and wouldn't want to break JGit compatibility, but it would be good to
> have the community leaders reaffirm this stance.

Recording from today's IRC standup for easy reference later:

  <gitster> jrnieder: that might have been solved already by me declaring
  that whether they like it or not, reftable must be in git-core to match
  what JGit has.

> For my last worry, it would be good if someone would make an
> assessment of the overall design to see if it is acceptable.

Thanks.  I think Peff did a little in this area; help from others
would be welcome as well.

> Once we have a path forward we can think of a way of integrating the
> code. I think it may take a while to shake out bugs. Not bugs in the
> reftable library itself, but Git is not very strict in enforcing
> proper use of the ref backend abstraction (eg. pseudorefs [1]). Many
> integration tests also don't go through proper channels for accessing
> refs.

Yes, I'm *very* excited that the series includes a knob for running
the testsuite using the reftable ref backend, providing a way for
anyone interested to pitch in to help with the issues they reveal
(both in Git and in its testsuite).

Summary: thanks for writing this.  I personally think your proposal is
a reasonable one, but I'm looking forward to hearing from others as
well.  I'm also looking forward to discussing "struct slice" and the
overall architecture in the context of the patches[4] and making some
more progress.

Sincerely,
Jonathan

> cheers,
>
> [1] https://lore.kernel.org/git/CAFQ2z_NZgkPE+3oazfb_m0_7TWxHjje1yYCc0bMZG05_KUKEow@mail.gmail.com/
>
> [2] https://hanwen.home.xs4all.nl/public/software/reftable-coverage/

[3] https://lore.kernel.org/git/CAFQ2z_Ne-1TWMRS88ADhzQmx4OfzNEkVUJ1anjf57mQD4Gdywg@mail.gmail.com/

[4] https://lore.kernel.org/git/pull.539.v12.git.1588845585.gitgitgadget@gmail.com/
