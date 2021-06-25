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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D354C49EA5
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 00:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BE36008E
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 00:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhFYAHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 20:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFYAHl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 20:07:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6DDC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 17:05:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id he7so12177905ejc.13
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 17:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VvGE3k2b9Kp+GHKlhGAh5QXTOoboIEE5O/WvrA2sHhU=;
        b=vZO++eyuQqLiWLGr25HFT6MuqB3JES826zwYbozFKn4gYyfOIZdp3QlvqmBcVUYNKu
         Fu6FhVs+5wjZUabtGI3qbjpoDgeVylaxj7bZ1EW/S26Z6EgJfJBX54aLnJr9UVILkNSb
         GhL755nvypAPPh2wTCESFFo/ISxwSKM3KJkiYLUbahZDt7uakh4UByvhe3YbKKmDyq+S
         7V7UmohZQLLcx5fDjioxQ0ml1aSXlQn6RUk+o+UOmxWwUR3p914b5UHChEdRtyskJhpt
         FN9Us5xMxQNh4nwsTKznt7A+tRgJ57bCgxdaWM+NIhyu++vH9rs9elDzyq+BrqDbE597
         Fdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VvGE3k2b9Kp+GHKlhGAh5QXTOoboIEE5O/WvrA2sHhU=;
        b=cBfytcb/iP9nX+YXDIr7RwN3wyI9lArEIEQd1u10OJOfL9JRIxenmOA2MLeCPFqD/E
         oxKO2nCPZITYmDGJ5ARHOJentznPBRaD+NGgnT8BlaAx1BeEJt/6CDbEc5hUjlZfJn6C
         iLkemfzxvON5PrT0ttrGgLRLTu4s2MndcrfGbNrGKvXHgrsOjT+GBuPCSKFPAYz6UgYA
         2y13kmB/C8iCHk2QNDTNMEBghhBjBr2Dkf5q5nOIfjkDRpp+8R9zQ7tunnNFyAnlOtL5
         DNv+BSWfHGjaaBff2Jw0MkVBFiAEfBWsgx7YJzrRjqHTNHkPoKwF5NlFLZ5sEYBqt3N7
         /qkA==
X-Gm-Message-State: AOAM531U3r2q1HmvofJTy2JJL0g4qv0kAQNPqDyy4R7FxsWmkn84F0hB
        jOVN7PEFXLHgJKK4RwQt/l4=
X-Google-Smtp-Source: ABdhPJxAM5OZKboiFFooejy++Jdq03u6IUvzeNMWzoMjV2hREfT6CW2bGt0Yo9k0kb7Yt4//le+i1Q==
X-Received: by 2002:a17:907:2941:: with SMTP id et1mr7620037ejc.394.1624579518720;
        Thu, 24 Jun 2021 17:05:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y10sm2645272edc.66.2021.06.24.17.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:05:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 22/24] midx: respect
 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
Date:   Fri, 25 Jun 2021 02:03:24 +0200
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <00418d5b096c049ddfc738b5d51ef65eae019607.1624314293.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <00418d5b096c049ddfc738b5d51ef65eae019607.1624314293.git.me@ttaylorr.com>
Message-ID: <87zgveyfk2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Taylor Blau wrote:

> Introduce a new 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP' environment
> variable to also write a multi-pack bitmap when
> 'GIT_TEST_MULTI_PACK_INDEX' is set.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/repack.c          | 13 ++++++++++---
>  ci/run-build-and-tests.sh |  1 +
>  midx.h                    |  2 ++
>  t/README                  |  4 ++++
>  4 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 5f9bc74adc..77f6f03057 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -515,7 +515,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		if (!(pack_everything & ALL_INTO_ONE) ||
>  		    !is_bare_repository())
>  			write_bitmaps = 0;
> -	}
> +	} else if (write_bitmaps &&
> +		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0) &&
> +		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0))
> +		write_bitmaps = 0;

Style nit: more if/else/elseif some with braces, some not...
