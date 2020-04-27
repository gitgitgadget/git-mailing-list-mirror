Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF2C83001
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE882072D
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtcrTs7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgD0XpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbgD0XpO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 19:45:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216D4C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:45:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mq3so317586pjb.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cV9Q2QkrBxIc456TZCRtrHX0eHNrBTJNaB45+PPIbkI=;
        b=OtcrTs7MWPgjv54NQv8kUDEugh44O1GBSmzR/WXYHiGsoTu5SgSF8mMbukix50I/Iz
         9oWr1oTvq+x/oNmDfvw+gFTeoleCEUnHmVh7nsjk9c73fQfK0okkfDbqEfCnXbYXMtmX
         zs2h3i6AiD3ObFKmnumDpsu9f4yMxzt+WSf5YcM/duhnFBQqvBAoGTbE1ugmZv7QNOSh
         BmMsVIwiEAutXF+zwgIEctVgxQfcWGEEltcFA8GIMDX5gGHQMW/67Q3F80Cf5u3Y+wLQ
         nUrRQU3y6dQNACpmAxxWs10mLfDSUUW/N1zIk3FzfoeeKsqRWVlAgWloW+lcV6GofIP9
         RH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cV9Q2QkrBxIc456TZCRtrHX0eHNrBTJNaB45+PPIbkI=;
        b=sUlbZCoruM5hoj1T3gAC5g1qxVyaLXVOpcMfSC96XGfTE3l8nGthP+FlTUFCt9vYOb
         M+8Z1x6MHUaKAZdqM3JbL+LrMe1MyBD658R7I6qwFxWPVhm972jyOYgyRlIFgzxJvB9v
         yYsqoKXDQrQ+xqQBCnNFWQNujWB0oRFFhX5IDu956LiShj2sUcKhq+SlvHELNa2IiXc8
         TRyEwYSihK6FM98AcPWPlH/f0lXAtyoqmZuPhRAWOvlS+Nhq0zD236bVkpOXtDLYe8s8
         0reweFVtoZxZvyd8cfF4PVQeZmEz1UwbBafN+QVQ1aVXIPRjcpqfthRANGABdcmlYBnN
         SXrQ==
X-Gm-Message-State: AGi0PuaDz7XT4I0/alw5TZzSG/8UV3d7Y634unZ2QC7KUkwbgR4Hj6WT
        90dafqhJv4bnD3jZweFcWVk=
X-Google-Smtp-Source: APiQypKqQqf8o9WfrAs4f/UFwl41gX+LWItDmR0pSoYAVxo3fKuTAJI37rsoTBHVxxn5RhgGZR34pA==
X-Received: by 2002:a17:902:c50a:: with SMTP id o10mr20996182plx.187.1588031113574;
        Mon, 27 Apr 2020 16:45:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 28sm335300pjh.43.2020.04.27.16.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 16:45:12 -0700 (PDT)
Date:   Mon, 27 Apr 2020 16:45:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] bugreport: collect list of populated hooks
Message-ID: <20200427234510.GC36078@google.com>
References: <20200424233800.200439-1-emilyshaffer@google.com>
 <20200427233820.179891-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427233820.179891-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> --- a/t/t0091-bugreport.sh
> +++ b/t/t0091-bugreport.sh
> @@ -57,5 +57,15 @@ test_expect_success 'can create leading directories outside of a git dir' '
>  	nongit git bugreport -o foo/bar/baz
>  '
>  
> +test_expect_success 'indicates populated hooks' '
> +	test_when_finished rm git-bugreport-hooks.txt &&
> +	test_when_finished rm -fr .git/hooks &&
> +	mkdir .git/hooks &&
> +	touch .git/hooks/applypatch-msg &&
> +	chmod +x .git/hooks/applypatch-msg &&

optional: could use write_script for this

> +	git bugreport -s hooks &&
> +	test_i18ngrep applypatch-msg git-bugreport-hooks.txt

This should work even when translated, so it can use "grep" instead of
test_i18ngrep.

A few more things to test:
- that it doesn't include hooks we *haven't* installed. :)
- that it isn't confused by the default *.sample hooks
- what happens when outside a git repository?

Even without such tests,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
