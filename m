Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD1BC433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 16:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D05206D8
	for <git@archiver.kernel.org>; Sun, 17 May 2020 16:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDMvZ9Oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgEQQLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 12:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgEQQLz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 12:11:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25910C061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 09:11:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w19so1351219ply.11
        for <git@vger.kernel.org>; Sun, 17 May 2020 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n7C2ymR+cTGC/3YcRajdxUuCy5S0a35hxZDsiaWY3yA=;
        b=vDMvZ9Oyva71jCQwP/blhPk9xV9cwrZOKTceqfcNuFwdv3IIhzjDJPDcsY/3rYLFE1
         pzHs+DMptaYqeEgHgrmzlF6z6Od2YsPNuaogw1uYhUMTQYC6QCz3lVI3wZcPHnk9kAvP
         VO0tNbsO6VBJhPfFcfEJRc/ov04uFhctblG0GIQuje0voLXsYF59JIUBKnBJQBL3uRKF
         K2O6pqIHgSUWC9uPGU1T5LHqnZ8WFTF0D3HuGxyaRs28u2tD1huLNHJq4px9rbiF+Ml6
         GIuw1ZCyLG+xkYc3Uzm7Kk56OkFy0Dk+nL3TGrmwfsfxg4SxjvUuls9S4rrwrpEzxT5V
         Nd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n7C2ymR+cTGC/3YcRajdxUuCy5S0a35hxZDsiaWY3yA=;
        b=ZDA3ou9xyYhdFRfRN/srYMyOPMIGLWHzs2U6TxkxSavs2GBvHLp0bJgb9wjK9q7nrJ
         Ntf+OmR3lFSBvf1vFwzPGIsEjgT/ys0Qwsl8SfnhL06V7pt/SvihXQhXjvQBomWB8uuL
         vvbuXVUAmzIkLUxxUhHvFvitADWmPfI9wAin8SbBwx128yIA93J5mytIdFElIKvS27GG
         yb2T6c8OHGZaaR54L3E5gY35KVuza0PWpn8wRamnf5JrKf1vaQ1PWB7uf1j4yGsI4FlB
         4VbQ63MQ+2BPbVtuZo8wnJdDzn18D/t3RHtPvMiZsm8EV1mDxwAfsGkPPM5Z4hyyHMi5
         MK9g==
X-Gm-Message-State: AOAM532MCWv/bUSyVjq/gAMai3+x/7hNGVMEsiuRvHNn4Hk8HXYc4byd
        bAqtLmtSY+eONo8ZBi/lV59jRzpu
X-Google-Smtp-Source: ABdhPJyMsLosvlzFfWjXhTh+xfI+53DZNNHoXLAZjdglt9hl3+3mMHCcSy21BMPXVQI6QRSb9IykpQ==
X-Received: by 2002:a17:90a:248a:: with SMTP id i10mr15536297pje.174.1589731914472;
        Sun, 17 May 2020 09:11:54 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id 9sm6192200pju.1.2020.05.17.09.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 09:11:53 -0700 (PDT)
Date:   Sun, 17 May 2020 23:11:51 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] submodule: port subcommand 'set-branch' from shell
 to C
Message-ID: <20200517161151.GA30938@danh.dev>
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-14 01:47:36+0530, Shourya Shukla <shouryashukla.oo@gmail.com> wrote:
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 39ebdf25b5..2438ef576e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -719,7 +719,6 @@ cmd_update()
>  # $@ = requested path
>  #
>  cmd_set_branch() {
> -	unset_branch=false
>  	branch=
>  
>  	while test $# -ne 0
> @@ -729,7 +728,7 @@ cmd_set_branch() {
>  			# we don't do anything with this but we need to accept it
>  			;;
>  		-d|--default)
> -			unset_branch=true
> +			default=1

Hi Shourya,

Thanks for your hard work,

I skimmed over the current code, it seems like this:

	default=1

is new.

If my understanding is correct, please reset its value
in the beginning of this function, to avoid:

- a side effect from an assignment in get_submodule_config
  (if there's such a side effect, I'm NOT really sure).
- effect of an environment variable, c.f.
  https://lore.kernel.org/git/20200402084251.85840-1-zhiyou.jx@alibaba-inc.com/


-- 
Danh
