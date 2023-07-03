Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7021DC001B0
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 17:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGCRWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjGCRWb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 13:22:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9DFE5D
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 10:22:30 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bacf685150cso5454655276.3
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688404950; x=1690996950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+f3As3bD9RzD6TPUbnLyPHKiU7dzBPOEXOjdDWUeFE=;
        b=lfcEWqJmtsvsnRZkZOVB8RheqWsiD7lGX2yvVtHfMvPeFX4U3S7bP2PYQWzasQZla0
         wOfyczAaTZmYRQg76j9td4uxtwKo40LF70EskUY52Gvo4vSLMM0JyHSrGJouf1pLKx8p
         ma4jLYq0wdV+/cTy5FoOjoVYameIHfaBBvJODck1LOYoN1M1nd/wuyUZWvbuGD9Q+Hl0
         tSd3vXi3isS1yyAHG5HlLZDR++wlGDMLC+cx2XkSXu74b2jolsnsBa+7RCLjj0qyLClz
         +RhHuFMnC71jS5T6xZ3ZCuxAEdZ74MOcYQlLaDIgeuaP2cdwMhk2ci3BJHrZfOr91Ino
         cCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404950; x=1690996950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+f3As3bD9RzD6TPUbnLyPHKiU7dzBPOEXOjdDWUeFE=;
        b=WN+NYyYazlhrW3BBgZ6SJG0lCCfhc9UAUHTPIv+McrCtB5hnB+GEswUUeLmQC4Nhdw
         5eXl9j5XololNhSzIdBJag6x5QCZXnW1zWU4poak3hC8kyBo27tT538EiskIp737SMlj
         YTkLhk3Uke1+ZlNlIFqt+QF6y3osJOL0kJXRCo//VZDlqm83sH3TBAozOzuoPY4n7kbc
         idmHuqiAQ5VrThTKJLEA9+RM8PvL6k4R2V9ag4j9WPCgAeEFvFuvTOugD+rqBKCgfRdB
         6xKywGrfIMW1ey74ZCLNVJ9/v+Mr+A2LzT3t5o44KUkNahw0XPT+ZyNmitnERNe54uKg
         jo9A==
X-Gm-Message-State: ABy/qLYY84Kxm/4gTn+Am/hWLJ/fCivKASv2683pQgBcpaAMg/eu9sFX
        HSwCZ9jg4MDLyw+2YwhiAmHzBA==
X-Google-Smtp-Source: APBJJlFzzydR7mS5Ih9meyYRspMIyWPlvdCnTKwD0xg4avz14EC39zdAft2SUYAU9Z9R6RmF8buuSg==
X-Received: by 2002:a25:6814:0:b0:bfe:bf77:64fd with SMTP id d20-20020a256814000000b00bfebf7764fdmr10596161ybc.12.1688404950027;
        Mon, 03 Jul 2023 10:22:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e128-20020a255086000000b00c4ec3a3f695sm977850ybb.46.2023.07.03.10.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 10:22:29 -0700 (PDT)
Date:   Mon, 3 Jul 2023 13:22:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 05/16] ref-filter.c: parameterize match functions over
 patterns
Message-ID: <ZKMD1L6rSph7vb7u@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <39e9b0f50d07cc75219325e7c7e72a801ca0cf16.1687270849.git.me@ttaylorr.com>
 <20230703052724.GE3502534@coredump.intra.peff.net>
 <ZKMCzow9EH2BJIfp@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKMCzow9EH2BJIfp@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 03, 2023 at 01:18:06PM -0400, Taylor Blau wrote:
> On Mon, Jul 03, 2023 at 01:27:24AM -0400, Jeff King wrote:
> > On Tue, Jun 20, 2023 at 10:21:21AM -0400, Taylor Blau wrote:
> >
> > > Once we start passing either in, `match_pattern()` will have little to
> > > do with a particular `struct ref_filter *` instance. To clarify this,
> > > drop it from the argument list, and replace it with the only bit of the
> > > `ref_filter` that we care about (`filter->ignore_case`).
> >
> > Makes sense, but...
> >
> > > @@ -2134,9 +2134,10 @@ static int match_pattern(const struct ref_filter *filter, const char *refname)
> > >   * matches a pattern "refs/heads/" but not "refs/heads/m") or a
> > >   * wildcard (e.g. the same ref matches "refs/heads/m*", too).
> > >   */
> > > -static int match_name_as_path(const struct ref_filter *filter, const char *refname)
> > > +static int match_name_as_path(const struct ref_filter *filter,
> > > +			      const char **pattern,
> > > +			      const char *refname)
> >
> > ...wouldn't we then want to do the same for match_name_as_path()?
>
> Yes, definitely :-). I'm not sure how I missed this, since the patch
> message even says that `match_name_as_path()` gets the same treatment as
> the other function.
>
> But in any case, I obviously agree (and the diff below makes sense to
> me). Applied.

Ah, this is missing one more spot (that we wouldn't complain about
during a non-DEVELOPER build). This needs to go on top, but I otherwise
agree:

--- 8< ---
diff --git a/ref-filter.c b/ref-filter.c
index de85904b8d..845173a904 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2176,7 +2176,8 @@ static int filter_exclude_match(struct ref_filter *filter, const char *refname)
 	if (!filter->exclude.nr)
 		return 0;
 	if (filter->match_as_path)
-		return match_name_as_path(filter, filter->exclude.v, refname);
+		return match_name_as_path(filter->exclude.v, refname,
+					  filter->ignore_case);
 	return match_pattern(filter->exclude.v, refname, filter->ignore_case);
 }
--- >8 ---

Thanks,
Taylor
