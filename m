Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B789FC8300C
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 16:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjFHQWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjFHQWq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 12:22:46 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D850E2718
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 09:22:44 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bb1f7c5495dso895477276.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686241364; x=1688833364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMT5QsoeO55bwVBVIXGOdxZCCUCG4iWdPnEJGTuSA6M=;
        b=IC/JABcO38yiH+xQdFvGk/ycRFD5KoPaSjWNwoQ4YxY6Ce64LORmb2lgkdWm3j8vbc
         owlARSzbOYnNDCXMcTw7DOYJptOCswH6RML29dByv1tpGuTHAOdbDm51+8z2yTEtkqDS
         VceJeotKYzhhIxDtJDhCNF2QU6j64aIIpylyDGa6pI83wWFmc9h3/j6SCKNsfXlrgj6+
         Jg6O829Jq3cRP8QI53Z5vNcYBfFz9hOrEtjnPswKfxmnSV2vk1GJrMiyCD8ACCeKwIKD
         B25f7rCedYfrXgTuuHSklVj8eD4PrwhNkYMFt+kVQuscgK6nREDek3TCbwWgeS+lB6HZ
         bChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241364; x=1688833364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMT5QsoeO55bwVBVIXGOdxZCCUCG4iWdPnEJGTuSA6M=;
        b=CQvpl+tX6VY/0M9BMIpKSl61I8rLWadanMTsMX3imhZ7NVwFIdS111V140ohzjiYzR
         xo667xJLw/HSnDoYyYYd9luRYu4Fgen7/KF4QParflY0W+Hq+rtNaSbs1vEcXil6ruBl
         xEjzmG3PjOfWrXS/dIOFeEn7bxmdWrzozGtCZ/5AfK8Fzs+ATf8VGolGs/+HDumMh405
         fgOCGhxGcvFD9LzyCza1681P8AtRMhjO6G4a5tQwyS6L2Hzf2HicrVlwwm65IkUc/hex
         0lOuP9DkoF8eBGLucCYfIY5fQqd9G/lk/hmc2QQAhodp3Cknf7HI0C3lihDJaaEPaP7a
         39gA==
X-Gm-Message-State: AC+VfDzVhzwLnOuMK4m+PzabhDdvhDSfyo26nbEKtJNcOxypQ54W7SSM
        02QfNHzt2qejZPY4O6wpuvpxOmz1sMronCLSBYWx+15w
X-Google-Smtp-Source: ACHHUZ59RMWTBey/3Arivhn5yLkxdGGSZHff5YW6NBwZiodJYoF76KKQ3qmUJy3xePCM33vD9UnuGg==
X-Received: by 2002:a81:5cc5:0:b0:54f:895e:70f7 with SMTP id q188-20020a815cc5000000b0054f895e70f7mr251782ywb.9.1686241364009;
        Thu, 08 Jun 2023 09:22:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p68-20020a0dcd47000000b0055a382ae26fsm17166ywd.49.2023.06.08.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:22:43 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:22:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] shortlog: introduce `--group-filter` to restrict
 output
Message-ID: <ZIIAUAEkWNQhc5zi@nand.local>
References: <cover.1686178917.git.me@ttaylorr.com>
 <5cec04b65d350ca8b482ca14260ef118341e4039.1686178917.git.me@ttaylorr.com>
 <3778f07f-6e6f-5a39-631d-1266d61b9715@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3778f07f-6e6f-5a39-631d-1266d61b9715@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2023 at 10:34:02AM -0400, Derrick Stolee wrote:
> On 6/7/2023 7:02 PM, Taylor Blau wrote:
>
> > This means that you could easily view the hashes of all commits you
> > either wrote or co-authored with something like:
> >
> >     $ git shortlog -n --group=author --group=trailer:Co-authored-by \
> >         --group-filter="$(git config user.name)"
> >
> > When filtering just by trailers, it is tempting to want to introduce a
> > new grep mode for matching a given trailer, like `--author=<pattern>`
> > for matching the author header. But this would not be suitable for the
> > above, since we want commits which match either the author or the
> > Co-authored-by trailer, not ones which match both.
>
> One thing that is not immediately obvious from reading the patch, but
> becomes clearer in patch 2, is that your --group-filter is an exact
> string match. This differs from the --author filter in 'git log' and
> similar, which is actually a case-insensitive substring match.

Yeah, funnily enough I originally thought about adding a `--trailer`
flag to the revision machinery, but realized that it was a non-starter
since `--author` is documented as only showing commits matching that
author.

So that doesn't solve for the case of finding a commit which has the
identity you want buried in some trailer, but is written by a different
author. shortlog needs to see all commits along the traversal, so I went
with the filtering approach instead.

Thanks for the pointer on beefing up the documentation to indicate that
this is an exact search.

> This is the critical piece of code for this issue. Replacing it with
>
> static int want_shortlog_group(struct shortlog *log, const char *group)
> {
> 	struct string_list_item *item;
> 	if (!log->group_filter.nr)
> 		return 1;
>
> 	for_each_string_list_item(item, &log->group_filter) {
> 		if (strcasestr(group, item->string))
> 			return 1;
> 	}
>
> 	return 0;
> }
>
> Results in the case-insensitive substring search that I would expect
> from this parameter.
>
> This would also solve the problem from Patch 2 where we want to search
> by email address. Using '-e --group-filter="my@email.com"' works, though
> it will catch users with 'tammy@email.com' emails, as well.

Yeah, thanks for raising it. I wonder if there are other semantics that
don't incorrectly return substring matches. You could conceivably extend
the --group-filter argument to take an extended regular expression, and
then just match on whatever's inside the last "<>".

That approach was one that I considered, but feels a little heavyweight
for what we're trying to do here. One potential approach is to keep
things as-is, and then consider extending `--group-filter` to mean
"extended regular expression" in the future. Although I'm not sure that
would work, either, since fixed-string matches would suddenly match
anywhere in the string, breaking backwards compatibility.

You could add another option that specifies the behavior of
`--group-filter`, or add some extra bit of information there like
`--group-filter=egrep:<pattern>` or something.

At least there's no shortage of options ;-).

Thanks,
Taylor
