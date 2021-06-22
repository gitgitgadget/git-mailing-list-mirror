Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6FBC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1659261353
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhFVRNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhFVRNl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 13:13:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ECEC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 10:11:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s6so24640440edu.10
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+8w3zdO/IXVdHpykUqGHNR5kkh5Gzu3zNs4ksHgtiA8=;
        b=ScMnNEFk/yw1RSJ+M34Mo7tldoBTqo/M5vavbvEFl3erY/gH5J/u1Mwt+j/kw7GyC7
         hO9JTUlztMGeG7UcgD+UUFSB8yd+5lllFRS0djWtkqARCI+opd0E5Rn+qFm3Iwf+0U8T
         xj6TagM0SKaVxD2wvbSRtyP1K2Hb+kDE25Lv/jvG7+AfsfYY8anhyxWorN/jwyofHr7w
         W8P8dz3Q7eYojqxAKkiJIR55B5PRUXHJquXx2syb7SOBFo44OkoHxtuowPiGureS79Qw
         HbR/wzl1kxcPtjDj8Mzr73Worc3xI2apROBOKcL2W729QfVSpQiU2QcbOAocH7ScGCWN
         Rw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+8w3zdO/IXVdHpykUqGHNR5kkh5Gzu3zNs4ksHgtiA8=;
        b=Rg9FVMn1WkOMQYRed/U0NpjK4F+k5LuBBrfy/J69SLcFBEYKtGMBEgCEZYQkA3zSEL
         NaDK49JLaH7D4DaxjupZupe34dgoVEiYi4UgJbrMFe9qTVa8BiOmiDeJ41JVVUUl2dD7
         FwIRvTU0f+rORgk4y4b1LOt6204m4jeYY5lCRmNHtC3hH6ZI7ju4r9TQA+2FobnEOUMN
         p8DHe3JDMxriZ2MZN1qZS1kbzec1qtsG0FiuUk/JDn1qy9XoyNPstukMcB6ovnLX84se
         pm47Zn4+SCKtCGEE5I5Oi1Ru0CSpSm++n2P5+EbQw83o3t4mS9EgRAhn/eFiJke1c5BT
         gpHA==
X-Gm-Message-State: AOAM5322ZA0sA4ymmhN/+mjvY91qJUYptstUp98sfSFyKoPCVQRsmzNj
        lyOgyrCdZkrfHxTH4xTS18w=
X-Google-Smtp-Source: ABdhPJyfwxCeeZ/NMyexs4XZZNWcq3jwyV1tIjpwPt88Qvfk3JZePVqc6zc4aKwwYahqRTJ5MQ0CtA==
X-Received: by 2002:a05:6402:1c04:: with SMTP id ck4mr6343294edb.301.1624381882566;
        Tue, 22 Jun 2021 10:11:22 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cn10sm9101862edb.38.2021.06.22.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 10:11:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/5] load_ref_decorations(): avoid parsing non-tag objects
Date:   Tue, 22 Jun 2021 19:06:43 +0200
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
 <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
Message-ID: <875yy53juu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 22 2021, Jeff King wrote:

> When we load the ref decorations, we parse the object pointed to by each
> ref in order to get a "struct object". This is unnecessarily expensive;
> we really only need the object struct, and don't even look at the parsed
> contents. The exception is tags, which we do need to peel.
>
> We can improve this by looking up the object type first (which is much
> cheaper), and skipping the parse entirely for non-tags. This increases
> the work slightly for annotated tags (which now do a type lookup _and_ a
> parse), but decreases it a lot for other types. On balance, this seems
> to be a good tradeoff.
>
> In my git.git clone, with ~2k refs, most of which are branches, the time
> to run "git log -1 --decorate" drops from 34ms to 11ms. Even on my
> linux.git clone, which contains mostly tags and only a handful of
> branches, the time drops from 30ms to 19ms. And on a more extreme
> real-world case with ~220k refs, mostly non-tags, the time drops from
> 2.6s to 650ms.
>
> That command is a lop-sided example, of course, because it does as
> little non-loading work as possible. But it does show the absolute time
> improvement. Even in something like a full "git log --decorate" on that
> extreme repo, we'd still be saving 2s of CPU time.
>
> Ideally we could push this even further, and avoid parsing even tags, by
> relying on the packed-refs "peel" optimization (which we could do by
> calling peel_iterated_oid() instead of peeling manually). But we can't
> do that here. The packed-refs file only stores the bottom-layer of the
> peel (so in a "tag->tag->commit" chain, it stores only the commit as the
> peel result).  But the decoration code wants to peel the layers
> individually, annotating the middle layers of the chain.
>
> If the packed-refs file ever learns to store all of the peeled layers,
> then we could switch to it. Or even if it stored a flag to indicate the
> peel was not multi-layer (because most of them aren't), then we could
> use it most of the time and fall back to a manual peel for the rare
> cases.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  log-tree.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 7b823786c2..8b700e9c14 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -134,6 +134,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>  			      int flags, void *cb_data)
>  {
>  	struct object *obj;
> +	enum object_type objtype;
>  	enum decoration_type type = DECORATION_NONE;
>  	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
>  
> @@ -155,9 +156,10 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>  		return 0;
>  	}
>  
> -	obj = parse_object(the_repository, oid);
> -	if (!obj)
> +	objtype = oid_object_info(the_repository, oid, NULL);
> +	if (type < 0)
>  		return 0;
> +	obj = lookup_object_by_type(the_repository, oid, objtype);

This series looks good. I just wonder if between this and my own
lookup_{blob,tree,tag,commit}_type() in [1] whether exposing some
function between what we have now in parse_object() and
parse_object_buffer() wouldn't also do this for you.

I.e. in my patch if you pass a type into parse_object_buffer() I think
you'll get the same behavior.

To be clear I see nothing wrong with this, it's more of a musing about
how some functions in object.c discover the type on their own, others
allow passing it in, sometimes (worse before that series of mine) we
relay the not-real-but-inferred-type etc.

1. https://lore.kernel.org/git/patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com/
