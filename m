Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE22C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF1C20767
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTDd/h3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHXRui (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgHXRuh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:50:37 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7E3C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:50:37 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z23so4584373plo.8
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YPh1DkXeRRibYw+ulSCYpkpq5HBraO93HYzm9SPYn10=;
        b=oTDd/h3LPAeR/GUahK2xkJ8cwNX597e5sWpB2ioiOiY5J7yykzZB6dGHGFqnU5G87g
         PWLYDU7TfPpmDL4TmJapc6X5dD5PSvUb5oJ8R6Khc2c2nzLhnNpvR0y/Te7HIERdNnXv
         gxwofV2Z348/j8bQLeBzL3T3N6t+BMzb7TqpFOxeLta0oQ/OtxLi/t/RO3FeLNWvoBqi
         JT+8LuAQoj0v+xzJAvY/xTfOm0CMq8UD713EM+8TkW0cRvHYDw3vCVxxQ9EBIG0RO3hA
         LRsfvrYwolNwE00MEYYDDMppbHnNxrEzx8c2pixy3cBniCqz+tz957TsdWFiKL4j7v9c
         Brfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YPh1DkXeRRibYw+ulSCYpkpq5HBraO93HYzm9SPYn10=;
        b=jE/t5zCUiZ0DtMs5At6FFSWbEA9WP/mbUtcmlm8xyz4KXR+RhjN+qtDAJgI2+do1oO
         D7t7TO9fjXetlBdjnDOmvN/w09CD99ISQ0Kb6zH4ptIB0fNnMUghbRCbYc673k/Bp/Ok
         dXUlfkPb85qP3YdOautJ6/xT3KF8fFy81iKLqCxql7MyMYV9VwCXmAym8JIgAHQN4J8H
         8KCHdbNiAkzSPMBDFPWZH4u1EVgmbbj9SQpQfEzqzxemREOss6gHjmUVj6XyqhbANlYa
         MdoK5JQipJ5bC0wVRw4dxU5rp5ry3bOBrftf37P4jrtWXv7G+RPAqHtbpEhpaNdtCiF4
         RmSw==
X-Gm-Message-State: AOAM530pNPeOzLa2bzjdGM/o9Z37HwetpGDMgYbxykwNxwqDx7+A9p4k
        yFQFsF+hhyho+Bj3GeemP1g=
X-Google-Smtp-Source: ABdhPJw5DVjHDqrzc9oQNn9xAq68iOrWivAh1VDFDiKKzVMFmRY8FdgEfTCuqoe0ibTRwKp95kXu8g==
X-Received: by 2002:a17:90a:cb92:: with SMTP id a18mr341339pju.80.1598291437054;
        Mon, 24 Aug 2020 10:50:37 -0700 (PDT)
Received: from konoha ([115.97.137.47])
        by smtp.gmail.com with ESMTPSA id c207sm11486305pfc.64.2020.08.24.10.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:50:36 -0700 (PDT)
Date:   Mon, 24 Aug 2020 23:20:29 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, liu.denton@gmail.com,
        pc44800@gmail.com, stefanbeller@gmail.com
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary'
 from shell to C
Message-ID: <20200824175029.GB531246@konoha>
References: <20200824084634.GA377527@konoha>
 <a30f43ecbbc5fa64fe62eb5903d81bce7440986c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30f43ecbbc5fa64fe62eb5903d81bce7440986c.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08 04:38, Kaartic Sivaraam wrote:
> On Mon, 2020-08-24 at 14:16 +0530, Shourya Shukla wrote:
> > Or rather, we can do this:
> > 
> > -----8<-----
> > if (S_ISGITLINK(p->mod_src)) {
> > 		struct strbuf sb = STRBUF_INIT;
> > 		strbuf_addstr(&sb, p->sm_path);
> > 		if (is_nonbare_repository_dir(&sb))
> > 			src_abbrev = verify_submodule_committish(p->sm_path,
> > 								                     oid_to_hex(&p->oid_src));
> > 		strbuf_release(&sb);
> > 		if (!src_abbrev) {
> > 			missing_src = 1;
> > 			/*
> > 			 * As `rev-parse` failed, we fallback to getting
> > 			 * the abbreviated hash using oid_src. We do
> > 			 * this as we might still need the abbreviated
> > 			 * hash in cases like a submodule type change, etc.
> > 			 */
> > 			src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
> > 		}
> > 	} else {
> > 		/*
> > 		 * The source does not point to a submodule.
> > 		 * So, we fallback to getting the abbreviation using
> > 		 * oid_src as we might still need the abbreviated
> > 		 * hash in cases like submodule add, etc.
> > 		 */
> > 		src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
> > 	}
> > ----->8-----
> > 
> > Similarly for dst as well. This solution passes all the tests and does
> > not call 'verify_submodule_committish()' all the time. The previous
> > approach failed a couple of tests, this one seems fine to me.
> > 
> > How is this one?
> > 
> 
> This is more or less what I had in mind initially. But later after
> being reminded about the fact that there's a code path which calls
> `generate_submodule_summary` only when `is_nonbare_repository_dir`
> succeeds, I realized any conditional that uses
> `is_nonbare_repository_dir` or the likes of it would be confusing. So,
> I think a better approach would be something like:

Alright. I understand. The case for which we faced the problem got
called using this part:

		if (p->status == 'D' || p->status == 'T') {
			generate_submodule_summary(info, p);
			continue;
		}

But I understand your concern. I will change this.

> -- 8< --
> diff --git builtin/submodule--helper.c builtin/submodule--helper.c
> index 63ea39025d..b490108cd9 100644
> --- builtin/submodule--helper.c
> +++ builtin/submodule--helper.c
> @@ -1036,7 +1036,7 @@ static void print_submodule_summary(struct summary_cb *info, char* errmsg,
>  static void generate_submodule_summary(struct summary_cb *info,
>                                        struct module_cb *p)
>  {
> -       char *displaypath, *src_abbrev, *dst_abbrev;
> +       char *displaypath, *src_abbrev = NULL, *dst_abbrev;
>         int missing_src = 0, missing_dst = 0;
>         char *errmsg = NULL;
>         int total_commits = -1;
> @@ -1062,8 +1062,9 @@ static void generate_submodule_summary(struct summary_cb *info,
>         }
>  
>         if (S_ISGITLINK(p->mod_src)) {
> -               src_abbrev = verify_submodule_committish(p->sm_path,
> -                                                        oid_to_hex(&p->oid_src));
> +               if (p->status != 'D')
> +                       src_abbrev = verify_submodule_committish(p->sm_path,
> +                                                                oid_to_hex(&p->oid_src));
>                 if (!src_abbrev) {
>                         missing_src = 1;
>                         /*
> diff --git t/t7421-submodule-summary-add.sh t/t7421-submodule-summary-add.sh
> index 59a9b00467..b070f13714 100755
> --- t/t7421-submodule-summary-add.sh
> +++ t/t7421-submodule-summary-add.sh
> @@ -58,7 +58,7 @@ test_expect_success 'submodule summary output for submodules with changed paths'
>         git commit -m "change submodule path" &&
>         rev=$(git -C sm rev-parse --short HEAD^) &&
>         git submodule summary HEAD^^ -- my-subm >actual 2>err &&
> -       grep "fatal:.*my-subm" err &&
> +       test_must_be_empty err &&
>         cat >expected <<-EOF &&
>         * my-subm ${rev}...0000000:
>  
> -- >8 --
> 
> I suggest this as the other code path that calls
> `generate_submodule_summary` without going through the
> `is_nonbare_repository_dir` condition is the one where we get
> `p->status` as 'T' (typechange) or 'D' (deleted). We don't have to
> worry about 'T' as we would want the hash for the new object anyway.
> That leaves us with 'D' which we indeed have to handle.

Oh you did mention it here. Yeah, this is perfect.

> Note that no such handling is required for the similar portion
> corresponding to `dst_abbrev` as the conditional `if (S_ISGITLINK(p-
> >mod_dst))` already guards the `verify_submodule_committish` when we
> have a status of 'D'.

Sure I will keep this in mind.

