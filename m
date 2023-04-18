Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03A8C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 18:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjDRSG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 14:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRSG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 14:06:26 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD822717
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 11:06:22 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id n17so2945369ybq.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681841181; x=1684433181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoTOuubsYliORe255xd4BNhAu4+6Nob12eyqLIoA+Ps=;
        b=be7wm0XIhH53UQ4G+3WYUamSAR2/3/m6Y8Wht5jFJWOHmE17jE1VRVmpLeuQlQOAw0
         Qe6S685QoANIky6joF1/ayEdusnVzKvbVlF103RlPEYb428CSAefLeO2izZROru/AIVC
         LJTLwmd0HhmlV7K42W2x/4ykoeEsMODLI7Dlfs1C9c0l3iRm++lGVL2yfnKPXofFWqCQ
         9kPwrZF8o9OBV7FgThw9XEJUEPFAqpPHDv0/24DQdvr769tJXgmqbcrqmN2qKVXnQM4q
         FurPGD74SuULG3mySBovhV8psBNEo47dRrueF5gpmKKHcXMI7Om/gFM11zKbOnhk5A40
         qx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681841181; x=1684433181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoTOuubsYliORe255xd4BNhAu4+6Nob12eyqLIoA+Ps=;
        b=hC348crtDH0r3FOinwdmvneQyp7xQk4T74L7u7DrAXudox8fkFVkcKQqhgX1pW7mFa
         lDTERm92WLsWJCne2+288H1aAM4wT6J2Rq3Gj6X4tOztltLeie71W6EcgCIwBwL2FIkr
         cz81lIFWn5AyI3I5rsyX66eelKdxOPP/5UQ8E5a+yIrBWHn2Kd+I7YNWtNnQLZgzug+2
         R26tfZP7++gr8+TM3VEZ5N1iqIY2X68rmEqRMOwMb+7fD5mTT4yHj7GttxETQcKaTLmd
         pL2B4M8ESvvEQ8aPvBFDFNnFr7GgSEX+9jL1z4o9JSaABNQJtGzUdUyIjbNm1qZ3GhKh
         6fhQ==
X-Gm-Message-State: AAQBX9fL8uMPQewB97YXsNibdC9UO9lT+5z46T0Y5gtB7gRQc8j4q5yI
        xsMJZ27xJqLghek6u1OhOBGpeh2VcuzF3opnLyIXzA==
X-Google-Smtp-Source: AKy350apiQBIwi8IvtsySUQw4fD8yae4SsKtZvW6knhlL90b+85UUZ/1BTPfO6hisIgQ24Ygz/SpQQ==
X-Received: by 2002:a25:51c4:0:b0:b8e:ce9e:649e with SMTP id f187-20020a2551c4000000b00b8ece9e649emr16579618ybb.44.1681841181577;
        Tue, 18 Apr 2023 11:06:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bw11-20020a056902160b00b00b7767ca748csm3820177ybb.41.2023.04.18.11.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:06:20 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:06:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] t/helper/test-hashmap.c: avoid using `strtok()`
Message-ID: <ZD7cGx2zKQ2KYnLS@nand.local>
References: <cover.1681428696.git.me@ttaylorr.com>
 <0f199468a3b8375dbec0f56fdc831c3ac298eb4e.1681428696.git.me@ttaylorr.com>
 <20230418102320.GB508219@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418102320.GB508219@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 06:23:20AM -0400, Jeff King wrote:
> On Thu, Apr 13, 2023 at 07:31:46PM -0400, Taylor Blau wrote:
>
> > Avoid using the non-reentrant `strtok()` to separate the parts of each
> > incoming command. Instead of replacing it with `strtok_r()`, let's
> > instead use the more friendly `string_list_split_in_place_multi()`.
>
> Junio mentioned this offhand in his response, but I wanted to highlight
> one difference in before/after behavior here.
>
>   [before]
>   $ printf 'add foo    bar\niterate\n' | t/helper/test-tool hashmap
>   foo bar
>
>   [after]
>   $ printf 'add foo    bar\niterate\n' | t/helper/test-tool hashmap
>   foo    bar
>
> I think that's fine for this test script, but it may be an indication
> that we want string-list's split to support different semantics.

I agree that it's OK for the test scripts, but probably isn't the right
thing for all cases. In the reroll I'll send shortly, I reimplemented
this in a way that (a) doesn't change the behavior of
`string_list_split_in_place()`, and (b) allows us to easily change the
semantics for `string_list_split_in_place_multi()`.

> > @@ -159,21 +161,34 @@ int cmd__hashmap(int argc, const char **argv)
> >
> >  	/* process commands from stdin */
> >  	while (strbuf_getline(&line, stdin) != EOF) {
> > -		char *cmd, *p1 = NULL, *p2 = NULL;
> > +		char *cmd, *p1, *p2;
> >  		unsigned int hash = 0;
> >  		struct test_entry *entry;
> >
> > +		/*
> > +		 * Because we memdup() the arguments out of the
> > +		 * string_list before inserting them into the hashmap,
> > +		 * it's OK to set its length back to zero to avoid
> > +		 * re-allocating the items array once per line.
> > +		 *
> > +		 * By doing so, we'll instead overwrite the existing
> > +		 * entries and avoid re-allocating.
> > +		 */
> > +		parts.nr = 0;
>
> I think this is OK, but I wonder if we should wrap it in a function that
> makes sure the strings aren't owned by the strdup (and thus aren't being
> leaked). Something like:
>
>   void string_list_setlen(struct string_list *sl, size_t nr)
>   {
> 	/* alternatively, I guess we could actually free nr..sl->nr */
> 	if (sl->strdup_strings)
> 		BUG("you can't setlen on a string-list which owns its strings");
> 	if (nr > sl->nr)
> 		BUG("you can't grow a string-list with setlen");
> 	sl->nr = nr;
>   }
>
> That is probably overkill for these two test helpers, but I wonder if
> the pattern might escape into "real" code (especially if we suggest
> using string-list instead of strtok).

I like this suggestion. I added a new patch (for which you are listed
under Co-authored-by) which adds this function as-is.

Thanks,
Taylor
