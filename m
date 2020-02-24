Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EB4C38BF9
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64B720CC7
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sw3C5cRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgBXWEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:04:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45260 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXWEV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 17:04:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so6031125pfg.12
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 14:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGVDRPwTauv6VbvUYoepGs7y8/zUNVZ8coe1JyRube0=;
        b=Sw3C5cRoUrDKRCsPYz9eSfQ2GnRMgY2ZojfsCEx8RegY5aAPwTfY2eG2K8T5MbRyZz
         Lwq69fzKiJwAd5SHKY9x+OWaNEZy1ltZ7vLcNhZ060PcSGGhOUA+7ZN+0z49fRPfb7aP
         o7ScbgqN4GVdgLfONcaD7qVRNonTxqZYocjA6nWwIjx1HSUJt6rJzCmnBzLYa67iO/be
         NXEkZ2fl0Z1u5gWbHzbD8yMDBz/ElQuw9eXgrI0il016FiHGAyangMSsP7rJkOv6pYVa
         2qtxjlBOq4+SBgTKNLK9k6Ocf04kRB7Fi1b/LaPJ++0lSGRBuay5IxEuDIiKmlPsnKKc
         DPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGVDRPwTauv6VbvUYoepGs7y8/zUNVZ8coe1JyRube0=;
        b=lYweWCyLVbgQPZV+aoB8f2vTbpF6ki/vEsQRomJ0dSeG/x9Yc8aOJjEfABRW4sL2KA
         A8vXSdVV2EzAoRnWYAu3jDVI4OOAZmufxdtPKEjh+p4MqXZ7d3qLdMYZi996pZ+jmI38
         Lv7iIfDjOKz27LLf5qikybwjErRJTEmsjhaL+4kjSSuIVb2sQNUFBpzQc8oi9KhX1HCQ
         JHVmS6L1cP91E8bK6Tw3tr9Kds2afDtq9FVFGw0szIkUUUpHhh5EKymCQEdegE21W8A8
         bCDJMikJ9JGnE3wcMWyMxyF8Exb5PzMSM7seimsLp4hh4i+myq5aHs2uH1/0F/wqXnK1
         2kAw==
X-Gm-Message-State: APjAAAVwcF+CpHcLVkfwrSgUrnxRs143HV02zulRPJx3InXUnsqbLISV
        Cu+m6iJ1qlj5wRydi1G9g8Fcig==
X-Google-Smtp-Source: APXvYqy9B2JUflsgNZzcRoAgcpMiFdRTUJGxdkcP72rSh55imHaY7LpW2f6Od2EpNX9KG2gGVg2b1Q==
X-Received: by 2002:a63:8f5c:: with SMTP id r28mr54717170pgn.351.1582581860754;
        Mon, 24 Feb 2020 14:04:20 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id p21sm13886436pfn.103.2020.02.24.14.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:04:20 -0800 (PST)
Date:   Mon, 24 Feb 2020 14:04:15 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v4 1/3] advice: extract vadvise() from advise()
Message-ID: <20200224220415.GA255447@google.com>
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
 <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
 <f668d9b7ca04da1d8adf0a146b48a46559471501.1582557199.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f668d9b7ca04da1d8adf0a146b48a46559471501.1582557199.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 03:13:16PM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> In preparation for a new advice method, extract a version of advise()
> that uses an explict 'va_list' parameter. Call it from advise() for a
> functionally equivalent version.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Heba Waly <heba.waly@gmail.com>

This seems very straightforward and now appears to be in the right
commit order.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

> ---
>  advice.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/advice.c b/advice.c
> index 249c60dcf32..fd836332dad 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -96,15 +96,12 @@ static struct {
>  	{ "pushNonFastForward", &advice_push_update_rejected }
>  };
>  
> -void advise(const char *advice, ...)
> +static void vadvise(const char *advice, va_list params)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	va_list params;
>  	const char *cp, *np;
>  
> -	va_start(params, advice);
>  	strbuf_vaddf(&buf, advice, params);
> -	va_end(params);
>  
>  	for (cp = buf.buf; *cp; cp = np) {
>  		np = strchrnul(cp, '\n');
> @@ -118,6 +115,14 @@ void advise(const char *advice, ...)
>  	strbuf_release(&buf);
>  }
>  
> +void advise(const char *advice, ...)
> +{
> +	va_list params;
> +	va_start(params, advice);
> +	vadvise(advice, params);
> +	va_end(params);
> +}
> +
>  int git_default_advice_config(const char *var, const char *value)
>  {
>  	const char *k, *slot_name;
> -- 
> gitgitgadget
> 
