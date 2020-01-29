Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485A1C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 20:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E10820702
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 20:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6SASIzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgA2Un3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:43:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36805 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgA2Un2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 15:43:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so417371plm.3
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 12:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+pI/DMi4zn+ffn2CZHpv8pWS9oLdkGjruldoJWYFBQ4=;
        b=h6SASIzbA8Cb7jOXGHPcIjZFSA3imMi6iOQAaU2Jl3bEvJhMvhfmbRfCi1AXr8cMVR
         ps1NGnOjbtUab0SQUtBJeJ0y8UwtAjVpxQrD5k4Ljv/rpgtsl23yj42fa/yUSAdVYbZc
         RoNqku7OQXK8vvPhhf2r8RB9paN+IqugJAuYETBVXd7Ta0tamuBwvuAXex6VW849WzR/
         kFAMwM+0WE2K8GiZSExbFvApsnR6HLMXGhC75xDPsdkr+JbzWKh5DPLokLjiJRXp9IOQ
         1KOw1CGHhAJQl2CD05A55d8U+r4RXGhOWXyN0U8g1v1HqI/ZD6GmNJy+7TT2RZ1CQc4e
         xOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+pI/DMi4zn+ffn2CZHpv8pWS9oLdkGjruldoJWYFBQ4=;
        b=f+YsrcadDo/e6HgfjmP31tG8PvbMSIbF+v0p7K5xafVOdEF7LvQbofCDhILoBRME0S
         Kt4CX8CH/CsbN7UWLL2TvJ/H6zV8QQloe4aWEs6Kk0xNBJCpy3mswJPEtoGDgzcKSMyy
         UBcGKnxWKmHGaCOSTAkwmah6nmqvXiOYzj+XS+vWC5mDeDigyC51NU4ECbFGmpDYEj7D
         QI+wiJvoxjRQ6WhmoPYZtAxIZ540yEeNiUHUj1g52+cimKhrAKw+fcx1hh/9KYNF3D2/
         jIfwmn7yMKhm4QJEn85L5TUZ/U13gHU6eMa99I/XyyMXTNLJZhzhqq/Z2rVXG9hT+6sR
         +t7A==
X-Gm-Message-State: APjAAAVvod3tYvxpH6MF/G5S3Ha0P3Zonv0YnINEvFmdnBs5sQLTtMms
        7KSeCOE1oRta0F52LgcOW68=
X-Google-Smtp-Source: APXvYqwTzqb+MknDj2m3WaGPXbQiFqc4DVzUUl/2zEKUpqZ6NmXhW6mC99Bmzfv/R4V+fjSnLTRzQg==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr1126624plo.75.1580330608141;
        Wed, 29 Jan 2020 12:43:28 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id x8sm3770188pfr.104.2020.01.29.12.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 12:43:27 -0800 (PST)
Date:   Wed, 29 Jan 2020 12:43:26 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch: forgo full connectivity check if --filter
Message-ID: <20200129204326.GB17350@google.com>
References: <cover.1578802317.git.jonathantanmy@google.com>
 <be1d6aa4c4fd8868f3682b73c01a92d3830534ad.1578802317.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be1d6aa4c4fd8868f3682b73c01a92d3830534ad.1578802317.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> If a filter is specified, we do not need a full connectivity check on
> the contents of the packfile we just fetched; we only need to check that
> the objects referenced are promisor objects.
>
> This significantly speeds up fetches into repositories that have many
> promisor objects, because during the connectivity check, all promisor
> objects are enumerated (to mark them UNINTERESTING), and that takes a
> significant amount of time.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> For example, a local fetch was sped up from 6.63s to 3.39s. The bulk of
> the remaining time is spent in yet another connectivity check
> (fetch_refs -> check_exist_and_connected) prior to the fetch - that will
> hopefully be done in a subsequent patch.

Can this information (at least the speedup) be included in the comment
message?

Or even better, can we demonstrate the impact using a perf test?

> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -906,8 +906,17 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  		url = xstrdup("foreign");
>  
>  	if (!connectivity_checked) {
> +		struct check_connected_options opt = CHECK_CONNECTED_INIT;
> +
> +		if (filter_options.choice)
> +			/*
> +			 * Since a filter is specified, objects indirectly
> +			 * referenced by refs are allowed to be absent.
> +			 */
> +			opt.check_refs_are_promisor_objects_only = 1;
> +
>  		rm = ref_map;
> -		if (check_connected(iterate_ref_map, &rm, NULL)) {
> +		if (check_connected(iterate_ref_map, &rm, &opt)) {
>  			rc = error(_("%s did not send all necessary objects\n"), url);
>  			goto abort;
>  		}

Simple and sensible.  With or without a change like described above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
