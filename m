Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD86C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 09:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7543A23331
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 09:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbhATJAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 04:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbhATI7v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 03:59:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF7C0613ED
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 00:50:22 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h16so24777815edt.7
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 00:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=NLx3yKhfL8Y7h0ErrzQ5mjmMEqElIq95e1PSrXjozsE=;
        b=QOwkWrGvBiJEqn/ViycTakVQOcr2JKJJO9WytFvcLMUdy716nR3HyOMzAZn7q/EWXW
         6tWXnZZAhVU6uLqiTOEhcwL10ZfT1zu5pbiNT7tIrQFZGekWxrou4IWZKOSj3S9T/tRY
         Jbrr07HgKdy/cvVDNZmKGxVCKUSkxRLyBAgGOlBwRxLupKx4uM58VYK21yrJbROZpuRJ
         GAdxaUlzRKQxJ6RkOWmE92O9FjTw5UNKNXCTbGGL4vsKs/KLJMIVnpTs8EeB1I9IoSCP
         ejnaiP6UWTXSvEhnA3l8p4fJQpWcCgt/1DOTj77tpVDFWqQKkIy92fzZGAyrCOnkzHI2
         +K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=NLx3yKhfL8Y7h0ErrzQ5mjmMEqElIq95e1PSrXjozsE=;
        b=sBORC2cXoPuc6f/Hkv9DkccFjVi32QOJlvfR/CVRi1Ng0WFceO9wbwlcJXPTy8KdFC
         uqfsyGdbMH61qNwgA20ksFtittnmv758YTQK5mSMjQX8av3LfFFjKQS5Z3DiyRS3OR3S
         0cyXvPQvsEIHm7XvH5LrBO0cyfxgRSTEF2a8tWAUNsCCATVIT+BNimztMTZhRqbv30A2
         1XBOKHova6Bqt2oYq+vBmd/w43jxe0qlbmAxuZRrhf/nKt5ZTSSjLuYe9FlsNlL8gC5g
         SUgJe5jagxaQEy8ANn5N+LVTdnec9JwODg3PbK98+8nY8J26OXjtlLoUAUv9P07RdGEG
         sywA==
X-Gm-Message-State: AOAM530cyOOFCVCBUMO6DngAT6HZXuJZbjbZnPJfEDFZZVM0zSfhBp/z
        XX1x2yN2JvQxARWNmWTk2pw=
X-Google-Smtp-Source: ABdhPJydg8FMymD6cXdUqqz3Ni30p4zKO3R0BtA8g8q/cBgawvtzAa1brn9kr8ECeercYx/84G9C8Q==
X-Received: by 2002:a05:6402:3122:: with SMTP id dd2mr6455022edb.262.1611132620769;
        Wed, 20 Jan 2021 00:50:20 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id hb19sm579249ejc.16.2021.01.20.00.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:50:19 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] builtin/pack-objects.c: avoid iterating all refs
References: <20210119143348.27535-1-jacob@gitlab.com>
 <20210119143348.27535-2-jacob@gitlab.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20210119143348.27535-2-jacob@gitlab.com>
Date:   Wed, 20 Jan 2021 09:50:19 +0100
Message-ID: <87lfco801g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 19 2021, Jacob Vosmaer wrote:

> In git-pack-objects, we iterate over all the tags if the --include-tag
> option is passed on the command line. For some reason this uses
> for_each_ref which is expensive if the repo has many refs. We should
> use a prefix iterator instead.
>
> Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> ---
>  builtin/pack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 2a00358f34..2b32bc93bd 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3740,7 +3740,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	}
>  	cleanup_preferred_base();
>  	if (include_tag && nr_result)
> -		for_each_ref(add_ref_tag, NULL);
> +		for_each_fullref_in("refs/tags/", add_ref_tag, NULL, 0);
>  	stop_progress(&progress_state);
>  	trace2_region_leave("pack-objects", "enumerate-objects",
>  			    the_repository);

Not really a new problem, but it would be nice to also have a test in
t5305-include-tag.sh to check what happens with "tags" outside the
refs/tags/ namespace. I.e. if this & the existing prefix in
add_ref_tag() were dropped.

To elaborate on other things that aren't really your problem & Taylor's
E-Mail downthread we originally added this because:

    If new annotated tags have been introduced then we can also include
    them in the packfile, saving the client from needing to request them
    through a second connection.

I've barked up this whole tag fetch tree before 97716d217c (fetch: add a
--prune-tags option and fetch.pruneTags config, 2018-02-09) but really
not this specific area.

I wonder if longer term simply moving this to be work the client does
wouldn't make more sense. I.e. if we just delete this for_each_ref()
loop.
    
We're just saving a client from saying they "want" a tag. I.e. with the
whole thing removed we need this to make t5503-tagfollow.sh pass (see
[1] at the end for the dialog, the tag is 3253df4d...):

    diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
    index 6041a4dd32..1ddc430aef 100755
    --- a/t/t5503-tagfollow.sh
    +++ b/t/t5503-tagfollow.sh
    @@ -134,6 +134,7 @@ test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
     test_expect_success 'setup expect' '
     cat - <<EOF >expect
     want $B
    +want $T
     want $S
     EOF
     '
    @@ -146,6 +147,7 @@ test_expect_success 'new clone fetch master and tags' '
                    cd clone2 &&
                    git init &&
                    git remote add origin .. &&
    +               git config --add remote.origin.fetch "+refs/tags/*:refs/tags/*" &&
                    GIT_TRACE_PACKET=$UPATH git fetch &&
                    test $B = $(git rev-parse --verify origin/master) &&
                    test $S = $(git rev-parse --verify tag2) &&

We're also saving the client the work of having to go through
refs/tags/* and figure out whether there are tags there that aren't on
our main history.

I think that since f0a24aa56e (git-pack-objects: Automatically pack
annotated tags if object was packed, 2008-03-03) was written it's become
clear that in the wild that's almost nobody's use-case. I.e. people with
a set of refs/heads/* branches and a refs/tags/* set that doesn't refer
to those branches.

Or if they do, I think it's such an obscure use-case that if we were
designing this today we could pass that work of figuring out if there's
such tags in refs/tags/* off to the client.

It seems we might just be able to delete this code on the server-side,
per protocol-capabilities.txt:

    Clients MUST be prepared for the case where a server has ignored
    include-tag and has not actually sent tags in the pack.  In such
    cases the client SHOULD issue a subsequent fetch to acquire the tags
    that include-tag would have otherwise given the client.

I.e. in the case where the server isn't playing along and I haven't set
"+refs/tags/*:refs/tags/*". But as the test shows we don't do that
following ourselves unless refs/tags/* is in the refspec (and then it's
not really "following", we're just getting all the tags).

1. From t5503-tagfollow.sh:
    $ grep -C5 3253df4d1cf6fb138b52b1938473bcfec1483223 UPLOAD_LOG 
    packet:  upload-pack< ref-prefix refs/tags/
    packet:  upload-pack< ref-prefix refs/tags/
    packet:  upload-pack< 0000
    packet:  upload-pack> 8e10cf4e007ad7e003463c30c34b1050b039db78 refs/heads/master
    packet:        fetch< 8e10cf4e007ad7e003463c30c34b1050b039db78 refs/heads/master
    packet:  upload-pack> 3253df4d1cf6fb138b52b1938473bcfec1483223 refs/tags/tag1 peeled:c06aaaf9c64f9ef1f209bcb6d7bdba68a5e27fab
    packet:        fetch< 3253df4d1cf6fb138b52b1938473bcfec1483223 refs/tags/tag1 peeled:c06aaaf9c64f9ef1f209bcb6d7bdba68a5e27fab
    packet:  upload-pack> ddfa4a33562179aca1ace2bcc662244a17d0b503 refs/tags/tag2 peeled:8e10cf4e007ad7e003463c30c34b1050b039db78
    packet:  upload-pack> 0000
    packet:        fetch< ddfa4a33562179aca1ace2bcc662244a17d0b503 refs/tags/tag2 peeled:8e10cf4e007ad7e003463c30c34b1050b039db78
    packet:        fetch< 0000
    packet:        fetch> command=fetch
    --
    packet:        fetch> 0001
    packet:        fetch> thin-pack
    packet:        fetch> include-tag
    packet:        fetch> ofs-delta
    packet:        fetch> want 8e10cf4e007ad7e003463c30c34b1050b039db78
    packet:        fetch> want 3253df4d1cf6fb138b52b1938473bcfec1483223
    packet:        fetch> want ddfa4a33562179aca1ace2bcc662244a17d0b503
    packet:        fetch> done
    packet:        fetch> 0000
    packet:  upload-pack< object-format=sha1
    packet:  upload-pack< command=fetch
    --
    packet:  upload-pack< 0001
    packet:  upload-pack< thin-pack
    packet:  upload-pack< include-tag
    packet:  upload-pack< ofs-delta
    packet:  upload-pack< want 8e10cf4e007ad7e003463c30c34b1050b039db78
    packet:  upload-pack< want 3253df4d1cf6fb138b52b1938473bcfec1483223
    packet:  upload-pack< want ddfa4a33562179aca1ace2bcc662244a17d0b503
    packet:  upload-pack< done
    packet:  upload-pack< 0000
    packet:  upload-pack> packfile
    packet:        fetch< packfile
    
