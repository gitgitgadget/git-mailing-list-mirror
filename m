Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC962C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E6760FD8
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbhHZVnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhHZVnz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:43:55 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D565C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:43:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e16so3450706pfc.6
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=23dmMNpgdG6WOBdJ86ef01GQEFTNBTff26VEXzsaqSY=;
        b=YpdGZ+NzSFOmoiPswQKErQfAJh5ZSG/Fz0hOiTpSoAAeWoFQM9lM8TMUkbgydR2hx9
         eqRAOBZL/WP11VQ0thwT8zgRXRIwwDqn0dymkvAsXl6WxF1sjm+Prmy6r/L+mGDoKjoL
         Ua/j0TX7koN8mItFjsmEpUEcGoYjQUIcsv73ov6Kk+B/k3PXl8ckhE+38R77ffHdmt1I
         d6hbC8C+7vU/YxUwF9JvvNUc2KzIcdm7DqND00xPMkF+za6f9iGBZ5+wWRw+eCYVc2xG
         d0Dg6wPYdHMfS0YLbaLCULat8KmRIoz7QhCoB9UKC8NxH1VKvmk55c75vexzg3e0eodB
         rUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=23dmMNpgdG6WOBdJ86ef01GQEFTNBTff26VEXzsaqSY=;
        b=iNROChQ5PSINii463C9GFiex3tI+hb9kFf+2UO1q5aQJoTqH2NC5gnC+VtDlNDXp9U
         aKF40k2dUGsQLeOA3y7mprx57keQA/Q+v8b7oJRzWXGvKeNOHI49kJN27B7peDrevCU1
         McNSUz/wQTh2hoVwsoSUdNomXdqTvY+LAyWI771mquKCcmTULzBrYKjqyfTXRaa4/bCl
         0o+tJ5YpzzNRt7dPZDGnTaox7U8RLHRxkgl8J7kKh09IouO7yQzVGT0KZ5AbNe6CIgVr
         HESnht1MUs2K0eEgPyjAE3c4Ia7fG0tgxH9zVIPGFr2wgZgrLDcDTpMVF9sBsMxsksAV
         A6GA==
X-Gm-Message-State: AOAM531UCw2z049lIq6Hp2iKSQj9DVEjTWMUOCF0rEHzYqDVnR7+d4tg
        ZpjIQUgXS0eXcW4szySZ14Sus6f2rVcQyg==
X-Google-Smtp-Source: ABdhPJz+crj+jKIMdw4KjyPCJ9BX/wwo/Y/dhQZaboMa4lhXk+1T0h1ktts8qQwzYIuiTGFFVVV22g==
X-Received: by 2002:a62:1c84:0:b029:39a:87b9:91e with SMTP id c126-20020a621c840000b029039a87b9091emr5542048pfc.7.1630014186606;
        Thu, 26 Aug 2021 14:43:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c1d9:3a1d:fe59:b07a])
        by smtp.gmail.com with ESMTPSA id q7sm9644457pja.11.2021.08.26.14.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:43:05 -0700 (PDT)
Date:   Thu, 26 Aug 2021 14:43:01 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/6] hook: introduce "git hook list"
Message-ID: <YSgK5Q4uqX8RPXXZ@google.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-4-emilyshaffer@google.com>
 <87tujeev1h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tujeev1h.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 05:08:25PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Wed, Aug 18 2021, Emily Shaffer wrote:
> 
> > +static int list(int argc, const char **argv, const char *prefix)
> > +{
> > +	struct list_head *head, *pos;
> > +	const char *hookname = NULL;
> > +	struct strbuf hookdir_annotation = STRBUF_INIT;
> > +
> > +	struct option list_options[] = {
> > +		OPT_END(),
> > +	};
> > +
> > +	argc = parse_options(argc, argv, prefix, list_options,
> > +			     builtin_hook_list_usage, 0);
> > +
> > +	if (argc < 1)
> > +		usage_msg_opt(_("You must specify a hook event name to list."),
> > +			      builtin_hook_list_usage, list_options);
> 
> Untested, but aren't we silently ignoring:
> 
>     git hook list pre-receive some extra gar bage here
> 
> I.e. shouldn't this be an "argc != 1" check?

Yeah, I think you are right. Will switch.

> 
> > +
> > +	hookname = argv[0];
> > +
> > +	head = hook_list(hookname);
> > +
> > +	if (list_empty(head))
> > +		return 1;
> > +
> > +	list_for_each(pos, head) {
> > +		struct hook *item = list_entry(pos, struct hook, list);
> > +		item = list_entry(pos, struct hook, list);
> > +		if (item)
> > +			printf("%s\n", item->hook_path);
> 
> Nit/suggestion: use puts(x) instead of printf("%s\n", x), but that's
> also a bikeshedding/style preference, so ignore if you disagree...

I was curious, because today I learned about puts() ;), so I checked
(sorry for escape gore):

  $ gg puts\( | wc -l
  217
  $ gg "printf(\"%s\(\\\\n\)\?\"" | wc -l
  96

So looks like it is indeed more idiomatic by about 2x to just use
puts(). Will switch.

> 
> > +	}
> > +
> > +	clear_hook_list(head);
> 
> Nit/API suggestion: Maybe s/list_for_each/list_for_each_safe/ and
> remove_hook() in the loop would make more sense for this one-shot caller
> than iterating over the list twice?
> 
> Anyway, currently remove_hook() is static, and it's probably good to not
> peek behind the curtain here, so on second thought clear_hook_list() is
> probably best...

Sounds like you talked yourself out of it before I could. Noop ;)

> 
> > +	strbuf_release(&hookdir_annotation);
> 
> This function did nothing with hookdir_annotation. Looks like leftover
> WIP code, but maybe it's used in (and should be moved to) a later
> commit, let's keep reading...

Ah, leftover WIP code indeed. Will drop it. I do think, though, that
"hook from hookdir" is an ugly thing to say in list(), so any better
suggestions welcome.

> 
> > [...]
> >  	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
> >  
> > +
> >  	INIT_LIST_HEAD(hook_head);
> 
> ..ditto...
ACK

> >  
> >  	if (!hookname)
> > @@ -103,8 +104,6 @@ struct list_head *list_hooks(const char *hookname)
> >  
> >  	if (have_git_dir()) {
> >  		const char *hook_path = find_hook(hookname);
> > -
> 
> ... earlier notes about whitespace churn...
> 
> > -		/* Add the hook from the hookdir */
> >  		if (hook_path) {
> >  			struct hook *to_add = xmalloc(sizeof(*to_add));
> >  			to_add->hook_path = hook_path;
> 

Thanks.
 - Emily
