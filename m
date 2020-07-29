Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13BFC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946E62083E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kteXPmy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgG2WXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 18:23:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA81C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:23:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id lx9so3017815pjb.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=anSHU/NvUjW9eOV9lU/1QXEcBbk+sh3BK6qUmQgm7yE=;
        b=kteXPmy3XrfsbZqqmJbQhTWCcP4h5AqrO16WMSJV1f/GeqMlRuyFJvOi265q7txExp
         4+miHMp4mmZYkLnfoQEchu66Lp3ypDeh525CinX35bbYebZhHATjdZGdc/MCGE83e83z
         gQoSv2itU7GthPBDm2Zf/wP2s3Dy+SArKsrhxjQ0YHxJ+mYxmZB9hicHdetMZH8rPf8Z
         AKS1YsgmmI/1PxxLoz9LBUJ8EaArk9CWK9tcpn5mzxjC7au547ib1WAwzuC09onEonyR
         bComfuDQ1gSynT3pbhVLMMoaV2qSMyGoELNG3KpAhY3z9PUzzA5dsnlaki6Fg6v7y9P7
         6daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=anSHU/NvUjW9eOV9lU/1QXEcBbk+sh3BK6qUmQgm7yE=;
        b=CRtzpraEgGoSMB+xJzh697HEFVJ/tioERixXZ84Jj9LdSDwxZtNsaTWZTwlDCDAbgF
         QLh2SALH5mlwDNSzMmTSj8lpCzJMZulh+Fb+CF8Al7/EIFbUi2M7qYF76C4EDrXnsspL
         fCJaCBWX5nj1Stw8ZlNKSnEzrSDwLntG59QpVJbsL1N67gGOAfUqK+M4+jjKrXC3D5ks
         dGjm0TmcB+JcrQ1TojH3uPImjRuAd/wkt7Oc67LfZr0gBGX/GCHB+TsvqdlF8WGfXM2R
         IJTeb2de9R6hYG8+FcWXarZq1N7D57pqZXlnSUFYrKyX4q972z9dJJR4Ry2J3g5Qis+l
         gMUg==
X-Gm-Message-State: AOAM531g2LIzocW7pbdMT+ZKz6irSoRdlUQUVXxz+jjHglzV9Yn364zi
        Rid/7LPSREBfc9+OM4WBLoKbfg==
X-Google-Smtp-Source: ABdhPJxJLUVDkcpkiH18Iu2o6ExSF4y78xfVXqwD790wl2HuAxvI+JzmxG/8fc4GIyc+6WSY3OyAHA==
X-Received: by 2002:a17:90b:8d0:: with SMTP id ds16mr727869pjb.2.1596061420551;
        Wed, 29 Jul 2020 15:23:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id t28sm396414pgn.81.2020.07.29.15.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:23:39 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:23:34 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
Message-ID: <20200729222334.GE2965447@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 05:56:33PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/gc.c b/builtin/gc.c
> index eb4b01c104..889d97afe7 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1021,19 +1021,65 @@ static int multi_pack_index_expire(void)
>  	return result;
>  }
>  
> +#define TWO_GIGABYTES (2147483647)

[jonathan tan] This would be easier to understand if it was expressed
with bitshift, e.g. 1 << 31

> +#define UNSET_BATCH_SIZE ((unsigned long)-1)
[jonathan tan] This looks like it's never used... and vulnerable to
cross-platform size changes because it's referring to an implicitly
sized int, and could behave differently if it was put into a larger
size, e.g. you wouldn't get 0xFFFF.. if you assigned this into a long
long.

> +	for (p = get_all_packs(r); p; p = p->next) {
> +		if (p->pack_size > max_size) {
> +			second_largest_size = max_size;
> +			max_size = p->pack_size;
> +		} else if (p->pack_size > second_largest_size)
> +			second_largest_size = p->pack_size;
> +	}
> +
> +	result_size = second_largest_size + 1;
[jonathan tan] What happens when there's only one packfile, and when
there are two packfiles? Can we write tests to illustrate the behavior?
The edge case here (result_size=1) is hard to understand by reading the
code.

> +
> +	/* But limit ourselves to a batch size of 2g */
[emily shaffer] nit: can you please capitalize G, GB, whatever :)
