Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C64C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F36220747
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbtM6Swl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgEFSMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgEFSMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 14:12:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FF5C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 11:12:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ms17so1269469pjb.0
        for <git@vger.kernel.org>; Wed, 06 May 2020 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l8tjucSLstlQXOtk7yvINX1NIDO9972zjzvXccwDKw4=;
        b=HbtM6SwlNsOi3jwhKHs5xjXQqEyuinCuCXcguKjXyGj1cEHmbVy3RQfW8zoERmC/Z4
         EH5TGQPzJQbqDvSjAESKZLO6VYCvhdNINhLtKjgri7sQhK+t2SH/6muaSIWMK61B+7+2
         IxBqoKKC7UZga0tNr2ksQkdTY/7YruLl+VendO4GHYw9iDCT9NUZwtAPYotzgmzD2B7U
         zSI5Yfs6nvNFj/xkbHPCEumAHlhDmby3hcU6f+5DYOWMpf2/DpfGJOgGzcs+dcuzkXK+
         swnzACVjFIlzhbKc7zNPOFomzU+N68jwtax8YQ1thtNTlH3TUu34LsFK9oEzmKYzKeOL
         UJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l8tjucSLstlQXOtk7yvINX1NIDO9972zjzvXccwDKw4=;
        b=h9HCBLWryR8T2KZfz3Q71GJu9AuPGXaA71xtxzBSUkhkrcEVJiL9fm0vNh/YFPARzA
         asRSRZKr8wta2TmaSVi5CaI5JTCHP2muB1lGgI4RSZu3KFHWuBQWs1qx5mJVDBhgmUGc
         RjsDern/01WnOWGqL1HAH6WWo7vyNFeVjyojfqWIOHCgXau/q0Q01Ot+8WNJwIToAnTU
         Nkf9RA3OFbWIMT7gLTVpBu2KboEIMB0oAy7v96VYGCzlQ52HIVDjZARIqhnkuvtdc+oO
         b/F3Xy87tjv/a0ByR/RfH/gcKB77DnDZV++rpA+KgRxAFLcr0kFUBfhKEwG7xQKcXfSk
         fvDg==
X-Gm-Message-State: AGi0PubJAEG4o7YZmz2+OT/YcOksOuOSJpBoVcX3uFWriN7kdUffWr8t
        17TNSHKWfpiyTljBRtfMu3vzFbgbTVZPKdid
X-Google-Smtp-Source: APiQypLGM+DLp+kI+y4Tu//WZOzZ0d54RxbSr6pEJZPq1nq7TGVspz5ce6CXw1iiJL+0E5QdeyD/JQ==
X-Received: by 2002:a17:90a:2170:: with SMTP id a103mr10583121pje.181.1588788766116;
        Wed, 06 May 2020 11:12:46 -0700 (PDT)
Received: from konoha ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id h6sm5490769pje.37.2020.05.06.11.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 11:12:45 -0700 (PDT)
Date:   Wed, 6 May 2020 23:42:39 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com
Subject: Re: [PATCH v4] submodule: port subcommand 'set-url' from shell to C
Message-ID: <20200506181239.GA5683@konoha>
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
 <xmqqtv0t6l84.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtv0t6l84.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05 10:12, Junio C Hamano wrote: 
> > +static int module_set_url(int argc, const char **argv, const char *prefix)
> > +{
> > +	int quiet = 0;
> > +	const char *newurl;
> > +	const char *path;
> > +	struct strbuf config_name = STRBUF_INIT;
> > +
> > +	struct option set_url_options[] = {
> > +		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
> > +		OPT_END()
> > +	};
> > +
> > +	const char *const usage[] = {
> > +		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
> > +		NULL
> > +	};
> 
> Hmph, do we really want all the blank lines in the above?

Apologies,will amend.

> There is only one "struct option" the code in this function needs to
> be aware of and worried about.  Isn't naming it set_url_options[]
> overly redundant?  Calling it just options[] would save lines here ;-)

I was actually following the format of the other subcommands, will
surely change it.

> > +	argc = parse_options(argc, argv, prefix, set_url_options,
> > +			     usage, 0);
> 
> 	argc = parse_options(argc, argv, prefix, options, usage, 0);
> 
> > +	if (argc!=2) {
> 
> Style.  SP around all binary operators like !=, i.e.
> 
> 	if (argc != 2) {
> 
> By the way, looking at print_default_remote() that takes no
> arguments wants argc to be 1, and resolve_relative_url() that takes
> only one or two arguments checks for 2 or 3, shouldn't this be
> checking if argc is 3, not 2?

Aren't `path` and `newurl` the only arguments we should worry about
here as 'parse_options' will parse out the other arguments ('git
submodule--helper' and the 'quiet' option) leaving us with only the
aforementioned arguments. Am I missing something here?

To add on, checking for `argc!=3` results in a failure of t7420.
If we have anything but 2 arguments (either less or more) we should have
a failure.

I think that we will do a check for 3 if we pass the macro
`PARSE_OPT_KEEP_ARGV0` in `parse_options()`. So the final code segment
would look like:
	
	argc = parse_options(argc, argv, prefix, options,
			     usage, PARSE_OPT_KEEP_ARGV0);

	if (argc != 3) {
		usage_with_options(usage, options);
		return 1;
	}

	path = argv[1];
	newurl = argv[2];

which does pass t7420. Therefore a stricter check could be:
	
	argc = parse_options(argc, argv, prefix, options,
			     usage, 0);

	path = argv[0];
	newurl = argv[1];

	if (argc != 2 || path == NULL || newurl == NULL) {
		usage_with_options(usage, options);
		return 1;
	}
which passes t7420.

> I thought I pointed it out in my very first review of this series.
> 
> 	... tries to go back and check, notices that this v4 is not
>         ... a reply to v3 or earlier and feels somewhat irritated.
> 	... then finally finds the following in the v2 review.

I am very very sorry for this. I undestand how this must feel. Will
ensure this from the next version. :)
