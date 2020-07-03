Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3751C433DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 15:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDB2204EA
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 15:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swX6JGt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGCP6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGCP6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 11:58:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD4C061794
        for <git@vger.kernel.org>; Fri,  3 Jul 2020 08:58:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so15276055pgk.4
        for <git@vger.kernel.org>; Fri, 03 Jul 2020 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L3N4bgtHOJYp/zkcseVtOhj1BN0cJWSXu7ti/jMcC78=;
        b=swX6JGt5/9h/Qj4sdv8gEpPPdbb/93pgovAFOtSTPdkL5uQFAVuROnnjCoRd+uRd3t
         ZXhuObPkfXEzaXorfKNNYDBP53pl80PTrlElhkf0VAlzQu1yAU7BCxS+AwbfnfvmT6k5
         xJtqqzl6BEaRf5qpmBfpjWtTjbe5O42IUJh8OhH8LNFwt7nWulJrjAKjAboCM7IiuK7E
         xselQcH2qnVwYsQtbYV+Ci02h2UXIvQ9EL1hI5gLPsih2FYOLNQjgs+BNArKqBXxDOzf
         u1qjgi0OX3UmDPnZLmq1XKwre2uW3NWju1IYcEw4oOoWw3MsIdC5UuDFNzqMP8Nv+7Rk
         bzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L3N4bgtHOJYp/zkcseVtOhj1BN0cJWSXu7ti/jMcC78=;
        b=S7glfqookgIl0RfjPJSSZDZSuUzgfxyN8b5ro2ZknGP749AnS+aIq1vxNEDAZEsO7H
         WNc0xzn9a6IkxMX/gC+u8sbkdhL0R6kGm6au2xfauS3soEJL2t58m3d8pYly4FlOGUHq
         EbmuEDuDcbOfX76yW72QsxVr/evUgXpDEdy21eDZHM6jYAOk+13UjCQLslUmFe3yZfQK
         iOSfDcJjvXe4leKmibqk8ARXagI521vb2rv3HOPgo6WOgRr6weAwWrKZ7Ml6vQTZewtw
         A9epJ1oc1uqM5iztxOTN+tVUhXtMfg0i1WgA7GJq+M/HjoRRW80HIe3M9aiXc3MyA7Vc
         jwGQ==
X-Gm-Message-State: AOAM531P1pb0PV7aY8Skk3jc5TOJ3Vsi6mIrhkpPPHu7gyQDbLeFqaqP
        78WqW/LUme7Z2gRF/zXKDBA=
X-Google-Smtp-Source: ABdhPJwhBw8wxifUup7JjnL01A3n/g0hJnRSG6ucUTkahZ085Z0kHExRjVzYs0NLXEQcoDcp/MUCeA==
X-Received: by 2002:a05:6a00:15c3:: with SMTP id o3mr32484906pfu.304.1593791895634;
        Fri, 03 Jul 2020 08:58:15 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id j70sm12448554pfd.208.2020.07.03.08.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 08:58:14 -0700 (PDT)
Date:   Fri, 3 Jul 2020 22:58:12 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sunlin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v6] Support auto-merge for meld to follow the vim-diff
 behavior
Message-ID: <20200703155812.GA4087@danh.dev>
References: <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
 <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com>
 <xmqqv9j5bc4o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9j5bc4o.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-02 18:50:15-0700, Junio C Hamano <gitster@pobox.com> wrote:
> So, if we do not know yet, then...
> 
> >  	then
> > +		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
> > +		case "$meld_use_auto_merge_option" in
> > +		[Tt]rue|[Yy]es|[Oo]n|1)
> > +			meld_use_auto_merge_option=true
> 
> This is sloppy.  TRUE is also a valid way to spell 'yes'.
> 
>     if o=$(git config --bool 2>/dev/null mergetool.meld.useautomerge)
>     then
>     	meld_use_auto_merge_option=$o
>     elif test auto = "$(git config mergetool.meld.useautomerge)"
>     then
> 	... auto detect ...
>     else
> 	meld_use_auto_merge_option=false
>     fi

Something like this should work if we don't write anything to stderr,
except the complain from git-config:

> fatal: bad numeric config value 'auto' for 'mergetool.meld.useautomerge': invalid unit

	if o=$(git config --bool mergetool.meld.useautomerge 2>&1)
	then
		meld_use_auto_merge_option=$o
	else
		case "$o" in
		*"'auto'"*) ... auto detect ... ;;
		esac
	fi

This code block is likely broken if git-config is chatty (trace).
I don't know if we have a reliable ways to tell Git to not chatty,
though.


-- 
Danh
