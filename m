Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08056C43381
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 22:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDDC9222BB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 22:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgL1W6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgL1W6U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 17:58:20 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BDDC061793
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 14:57:40 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id c22so8093804pgg.13
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 14:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LZOKo/tY/u5toRIq9/2/3MHSsyC67s3S57IS7g8hcmY=;
        b=D9oGeMDStvPTxa0xOxQGMH8iL+wxBiPrsEGzc7D+4q2uXRg1JE6/G08iEOsu+ssTvV
         4JROjjtZyuzFVoIu1uxr5yNz2D/e4coebH6A0IQ44bS6hmgActYHUy9YHxJd82E4eN03
         rTpYJ8oky0/fRcw528F2SX9qTsUDqWSe/lhSZDN2VHrGikk/ZbYahreC5t+4c97GZGYD
         HeDXWZZ/cZPduPYsyp7PmO8W3U69H1VFl1zBGqq4sMz/uO6DlAa91VP+Fa1bhKT0+sFm
         tcT/9cxrSwSFC82zSXx/9rgUYgJXpUeh9e5vr4eTcqqjw+UdZMcCYezjkQAAwTK37+4q
         KAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LZOKo/tY/u5toRIq9/2/3MHSsyC67s3S57IS7g8hcmY=;
        b=doudbOkdY8BzQzsx1/cgPqq2t2uKnaRq743XmES2VUphOfzq0LFUegLLr0Utq04t2T
         jhQZBTsD1XH6aPucp4v/WLUdV3w+wUdZ+WCWR1h4If6OLiiXKjvAdh85TPCGDo9/3w8q
         PQS6qHTB68P+56KBi5ekaXdMSluqFutyaCHxlco42ulo1ui7hzoyhcjuyaA3wutxOKhD
         S2ddeRdD+rlVc3FEHxE9Fpp2/DJGHD0LLEX4ze6ngvYe/oPIvw8tNRDXIdUddyVBEy1h
         PPWlJXecDOcLkUk0Fk0swf2o4XBuIxjeuH7kwFum9fdaOy+00W6+sAc2bsj93n9Ila3W
         uaCA==
X-Gm-Message-State: AOAM532CsQI6sdfWrmQv4njA1C/nEYtGyksTgok7fMr7NCGaNWPOH1Sz
        QfnNJNvX7IflM1SpK7uHTHI=
X-Google-Smtp-Source: ABdhPJxpmict34IPDZewxyjAgZj6fRbDMGm/U73swvzUCzZwKYopsSSXlKCdgcL4gGcwA+jspcXUsA==
X-Received: by 2002:a63:4404:: with SMTP id r4mr30452780pga.149.1609196259670;
        Mon, 28 Dec 2020 14:57:39 -0800 (PST)
Received: from generichostname (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id o193sm31859053pfg.27.2020.12.28.14.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 14:57:38 -0800 (PST)
Date:   Mon, 28 Dec 2020 14:57:36 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] test: completion: add tests for __git_complete
Message-ID: <X+pi4NoR116Js/XI@generichostname>
References: <20201228192302.80467-1-felipe.contreras@gmail.com>
 <20201228192302.80467-2-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228192302.80467-2-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

On Mon, Dec 28, 2020 at 01:23:01PM -0600, Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index a1c4f1f6d4..2e59fe4de0 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2380,4 +2380,11 @@ test_expect_success 'sourcing the completion script clears cached --options' '
>  	verbose test -z "$__gitcomp_builtin_notes_edit"
>  '
>  
> +test_expect_success '__git_complete' '
> +	__git_complete foo __git_main &&
> +	test "$(type -t __git_wrap__git_main)" == function &&

s/==/=/ for this and the other patch.

-Denton

> +	__git_complete gf _git_fetch &&
> +	test "$(type -t __git_wrap_git_fetch)" == function
> +'
> +
>  test_done
> -- 
> 2.30.0.rc2
> 
