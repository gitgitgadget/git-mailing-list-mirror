Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11951C433E3
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 11:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA5EF20771
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 11:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGmUmhEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgHKLFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgHKLF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 07:05:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44222C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 04:05:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so2383686pgl.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 04:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6KAy+MZ/fP9ZKGQ011G9IQ0c04mO/SPyl2dCMvLjnjY=;
        b=BGmUmhEPHuvT8cLlMOT+vfibnN9xtI4b69tvKH0tIDUO4vG3l8b6BrXtNzn2uIEMhZ
         QmXZs5K1w2L607gkes6X25mTSjjt2KX8CTOGFWfiibuN5az2N7fRSMNZxLisvQ/zmP9d
         e3nzbb0Ikdd2MyyPhCo4tXj4VAtW4vCuyxtkVHGVeHQ6VBNTXXhmrOzhEAjXkwHn9Pwj
         RbD6AKz5017e87z/cPiqQofN0/WWIM3P4ev3brjUmVx2RCQnVSKvctMn4CwzZFiQqkC4
         rxS28kO262nGOUodvhHuu1EjU3exXLnZmrhvlgMTb4ern7G0K9biqI00IfGpJYy9sVw9
         1O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6KAy+MZ/fP9ZKGQ011G9IQ0c04mO/SPyl2dCMvLjnjY=;
        b=sqyhh/uer/iEnd0B1iaMfRhyE9P1BzX5Mt323l7HrWZAchhsCJ61DY962BJTP50Ybl
         eP3YsOc8TytV+vRxlJcsCEb0nozOYpP6xkfmkaFJZdB5s3S9RIFCq1uMZvzieS3QZDfA
         kgZeX2FKOvS9krbynON/v5DFb3VB69wBMahMfduh9fWutABWqcuC9F9gYqIV21QV2kYz
         fPIcmJhF+4ymwp8x9wdERYWSqUT5pB8hybNyZ8bIfg5aa2yyJh0lvhB7fb4BpKC6R2pj
         XXwHxBczrgV/LuwqSdx8d6zWexBcFWqbHTfGDzvM+I9gr7fV1p9QYcDhndzuYPmQBU3Y
         vBkg==
X-Gm-Message-State: AOAM531BSzksixYfXPgPpSODNbpN6iijT56ghElk/oR69vmgatXZJa1M
        yT73pEWuddb1qO+hW3I/ZU0=
X-Google-Smtp-Source: ABdhPJy1/wVQ1Owx4ymIO7qTmzIgWfnhzfrCGeOBjByJIDvqlOoHSdCWfVYxbK/L9HRbCIqPw1C0cw==
X-Received: by 2002:a63:7505:: with SMTP id q5mr349704pgc.312.1597143928595;
        Tue, 11 Aug 2020 04:05:28 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:609:de5a:309a:8147:c746:a173])
        by smtp.gmail.com with ESMTPSA id g10sm25366844pfb.82.2020.08.11.04.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 04:05:27 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:33:16 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     jnareb@gmail.com, abhishekkumar8222@gmail.com, git@vger.kernel.org,
        me@ttaylorr.com, gitgitgadget@gmail.com
Subject: Re: [PATCH v2 05/10] commit-graph: implement generation data chunk
Message-ID: <20200811110316.GA3220@Abhishek-Arch>
Reply-To: aee0ae56-3395-6848-d573-27a318d72755@gmail.com
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <cb797e20d79e9dcd3e0b953e0db3ed1defb9aa7c.1596941625.git.gitgitgadget@gmail.com>
 <aee0ae56-3395-6848-d573-27a318d72755@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aee0ae56-3395-6848-d573-27a318d72755@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 12:28:10PM -0400, Derrick Stolee wrote:
> On 8/8/2020 10:53 PM, Abhishek Kumar via GitGitGadget wrote:
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > 
> > As discovered by Ævar, we cannot increment graph version to
> > distinguish between generation numbers v1 and v2 [1]. Thus, one of
> > pre-requistes before implementing generation number was to distinguish
> > between graph versions in a backwards compatible manner.
> > 
> > We are going to introduce a new chunk called Generation Data chunk (or
> > GDAT). GDAT stores generation number v2 (and any subsequent versions),
> > whereas CDAT will still store topological level.
> > 
> > Old Git does not understand GDAT chunk and would ignore it, reading
> > topological levels from CDAT. New Git can parse GDAT and take advantage
> > of newer generation numbers, falling back to topological levels when
> > GDAT chunk is missing (as it would happen with a commit graph written
> > by old Git).
> 
> There is a philosophical problem with this patch, and I'm not sure
> about the right way to fix it, or if there really is a problem at all.
> At minimum, the commit message needs to be improved to make the issue
> clear:
> 
> This version of the chunk does not store corrected commit date offsets!
> 
> This commit add a chunk named "GDAT" and fills it with topological
> levels. This is _different_ than the intended final format. For that
> reason, the commit-graph-format.txt document is not updated.
> 
> The reason I say this is a "philosophical" problem is that this patch
> introduces a version of Git that has a different interpretation of the
> GDAT chunk than the version presented two patches later. While this
> version would never be released, it still exists in history and could
> present difficulty if someone were to bisect on an issue with the GDAT
> chunk (using external data, not data produced by the compiled binary
> at that version).
> 

Yes, that is correct. I did often wonder that our inference that "commit
graph has a generation data chunk implies commit graph stores corrected
commit date offsets" is not always true because of this "dummy"
implementation. 

> The justification for this commit the way you did it is clear: there
> is a lot of test fallout to just including a new chunk. The question
> is whether it is enough to justify this "dummy" implementation for
> now?
> 
> The tricky bit is the series of three patches starting with this
> one.
> 
> 1. The next patch "commit-graph: return 64-bit generation number" can
>    be reordered to be before this patch, no problem. I don't think
>    there will be any text conflicts _except_ inside the
>    write_graph_chunk_generation_data() method introduced here.
> 
> 2. The patch after that, "commit-graph: implement corrected commit date"
>    only has a small dependence: it writes to the GDAT chunk and parses
>    it out. If you remove the interaction with the GDAT chunk, then you
>    still have the computation as part of compute_generation_numbers()
>    that is valuable. You will need to be careful about the exit
>    condition, though, since you also introduce the topo_level chunk.
> 
> Patches 5-7 could perhaps be reorganized as follows:
> 
>   i. commit-graph: return 64-bit generation number, as-is.
> 
>  ii. Add a topo_level slab that is parsed from CDAT. Modify
>      compute_generation_numbers() to populate this value and modify
>      write_graph_chunk_data() to read this value. Simultaneously
>      populate the "generation" member with the same value.
> 
> iii. "commit-graph: implement corrected commit date" without any GDAT
>      chunk interaction. Make sure the algorithm in
>      compute_generation_numbers() walks commits if either topo_level or
>      generation are unset. There is a trick here: the generation value
>      _is_ set if the commit is parsed from the existing commit-graph!
>      Is this case covered by the existing logic to not write GDAT when
>      writing a split commit-graph file with a base that does not have
>      GDAT? Note that the non-split case does not load the commit-graph
>      for parsing, so the interesting case is "--split-replace". Worth
>      a test (after we write the GDAT chunk), which you have in "commit-graph:
>      handle mixed generation commit chains".
> 

Right, so at the end of this patch we compute corrected commit dates but
don't write them to graph file.

Although, writing ii. and iii. together in the same patch makes more
sense to me. Would it be hard to follow for someone who has no context
of this discussion?

>  iv. This patch, introducing the chunk and the read/write logic.
> 
>   v. Add the remaining patches.
> 
> Again, this is a complicated patch-reorganization. The hope is that
> the end result is something that is easy to review as well as something
> that produces an as-sane-as-possible history for future bisecters.
> 
> Perhaps other reviewers have similar feelings, or can say that I am
> being too picky.
> 

I can see how the reorganization helps us avoid a rather nasty
situation to be in. Should not be too hard to reorganize.

> > We introduce a test environment variable 'GIT_TEST_COMMIT_GRAPH_NO_GDAT'
> > which forces commit-graph file to be written without generation data
> > chunk to emulate a commit-graph file written by old Git.
> 
> ...
> 
> Thanks,
> -Stolee

Thanks
- Abhishek
