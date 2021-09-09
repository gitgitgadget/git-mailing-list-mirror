Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C3C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 08:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24C460FC0
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 08:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhIIIfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhIIIfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 04:35:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107F3C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 01:34:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bt14so2000265ejb.3
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 01:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BHU8lk2ic2sv/nLAy/CSkpkatY1rTX4S3uz/l0gFHQU=;
        b=B7YhBvd7fgnBWRJaPvWzHHK9h35TK6Q5090URgFE4Rgxzg/SqA6F+qhDyxS9l3VP93
         Oh0zsElPaLdkzVwIkTSGf+RkzOI8NuszCUSY65yQgcE1rH9V/qA34XBpXvBUnYxLX3fW
         I0PpNgIXr/T4OTazsh7vZD6IvItJYjyuoY86Im9cDXoyfNYTkgUS611cslXRNon/cY/e
         BnT7wQND42qv6Xmo4YfM68S5UFX8t1uaA+eTStWeWR6Ncf/IG4/nSC2KSxedvx5GNBc2
         u4y5bj7cwCtHbXQOSXaY+4fe4sAiRHX5pgejEgdaZqUnTUASxBveYbDO23VOs655Pr6l
         TVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BHU8lk2ic2sv/nLAy/CSkpkatY1rTX4S3uz/l0gFHQU=;
        b=cI7sYLVMRlXqf+fx6qwf1hzZjfgZHPyB5VzF9hDx44Xvdph6eEOYFjA1Ok5DqL/6IC
         /ImIb4yg3FYcFvah+tWrA1di7ICeO+alWKfuLUb+z+qDjBkBuz04CrwUBdfHEJuAZMYC
         FOn0hOXrgYMCckSYUHNM+l8wiCw+XdA0eCqAMOdGIoyaOFMIRCNOxDiFEdjAzV9Q1yFJ
         dAol9+Xd+U1lGWoPzWmDsGtrtIX1hSdetPqy+sjuwLiHEfaOaxgm532wK3amB+UDuST2
         FQRwGiyqW21KKy4qbenoBfd1OwDHSxsvzYgswOdev2r7oJb78uxhUpYiZohmGozyVQj7
         eEFw==
X-Gm-Message-State: AOAM532EIxjhLrAVM7gv20yAUreW6il8MGZtPLlELipGXIp8eXC2CZ1P
        qwoHa5ZzNqjyVUjTBbk8LLiFF1UIoPzhjA==
X-Google-Smtp-Source: ABdhPJw7E7IZuI7TujFFSokaHMeCDx5WBYRFooyTW1BZ+mGwYxgCUNUs8TM9gvd7uKIdapVms5TVNQ==
X-Received: by 2002:a17:906:3809:: with SMTP id v9mr2151793ejc.355.1631176443489;
        Thu, 09 Sep 2021 01:34:03 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m12sm545861ejd.21.2021.09.09.01.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 01:34:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/4] midx.c: respect 'pack.writeBitmapHashcache' when
 writing bitmaps
Date:   Thu, 09 Sep 2021 10:18:10 +0200
References: <cover.1631049462.git.me@ttaylorr.com>
 <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
 <874kavkfjg.fsf@evledraar.gmail.com> <YTgfuAKJv1rXXm7i@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTgfuAKJv1rXXm7i@nand.local>
Message-ID: <87zgsmdu6d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Taylor Blau wrote:

> On Wed, Sep 08, 2021 at 03:40:19AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Tue, Sep 07 2021, Taylor Blau wrote:
>>
>> > +static int git_multi_pack_index_write_config(const char *var, const c=
har *value,
>> > +					     void *cb)
>> > +{
>> > +	if (!strcmp(var, "pack.writebitmaphashcache")) {
>> > +		if (git_config_bool(var, value))
>> > +			opts.flags |=3D MIDX_WRITE_BITMAP_HASH_CACHE;
>> > +		else
>> > +			opts.flags &=3D ~MIDX_WRITE_BITMAP_HASH_CACHE;
>> > +	}
>> > +
>> > +	/*
>> > +	 * No need to fall-back to 'git_default_config', since this was alre=
ady
>> > +	 * called in 'cmd_multi_pack_index()'.
>> > +	 */
>> > +	return 0;
>> > +}
>> > +
>> >  static int cmd_multi_pack_index_write(int argc, const char **argv)
>> >  {
>> >  	struct option *options;
>> > @@ -73,6 +90,10 @@ static int cmd_multi_pack_index_write(int argc, con=
st char **argv)
>> >  		OPT_END(),
>> >  	};
>> >
>> > +	opts.flags |=3D MIDX_WRITE_BITMAP_HASH_CACHE;
>> > +
>> > +	git_config(git_multi_pack_index_write_config, NULL);
>> > +
>>
>> Since this is a write-only config option it would seem more logical to
>> just call git_config() once, and have a git_multip_pack_index_config,
>> which then would fall back on git_default_config, so we iterate it once,
>> and no need for a comment about the oddity.
>
> Perhaps, but I'm not crazy about each sub-command having to call
> git_config() itself when 'write' is the only one that actually has any
> values to read.
>
> FWIW, the commit-graph builtin does the same thing as is written here
> (calling git_config() twice, once in cmd_commit_graph() with
> git_default_config as the callback and again in cmd_commit_graph_write()
> with git_commit_graph_write_config as the callback).

I didn't notice your earlier d356d5debe5 (commit-graph: introduce
'commitGraph.maxNewFilters', 2020-09-17). As an aside the test added in
that commit seems to be broken or not testing that code change at all,
if I comment out the git_config(git_commit_graph_write_config, &opts)
it'll pass.

As a comment on this series I'd find 4/4 squashed into 3/4 easier to
read, when I did a "git blame" and found d356d5debe5 I discovered the
test right away, if and when this gets merged someone might do the same,
but not find the test as easily (they'd probably then grep the config
variable name and find it eventually...).

More importantly, the same issue with the commit-graph test seems to be
the case here, if I comment out the added config reading code it'll
still pass, it seems to be testing something, but not that the config is
being read.

> So I'm not opposed to cleaning it up, but I'd rather be consistent with
> the existing behavior. To be honest, I'm not at all convinced that
> reading the config twice is a bottleneck here when compared to
> generating a MIDX.

It's never going to matter at all for performance, I should have been
clearer with my comments. I meant them purely as a "this code is hard to
follow" comment.

I.e. since we read the config twice, and in both commit-graph.c and
multi-pack-index.c munge and write to the "opts" struct on
parse_options(), you'll need to follow logic like:

    1. Read config in cmd_X(), might set variable xyz
    2. Do parse_options() in cmd_X(), might set variable xyz also
    3. Now in cmd_X_subcmd(), read config, might set variable xyz
    4. Do parse_options() in cmd_X(), migh set variable xyz also

Of course in this case the relevant opts.flags only matters for the
"write" subcommand, so on more careful reading we don't need to worry
about the value flip-flopping between config defaults and getopts
settings, but just in terms of establishing a pattern we'll be following
in the subcommand built-ins I think this is setting us up for more
complexity than is needed.

As far as being consistent with existing behavior, in git-worktree,
git-stash which are both similarly structured subcommands we follow the
pattern of calling git_config() once, it seems to me better to follow
that pattern than the one in d356d5debe5 if the config can be
unambiguously parsed in one pass.
