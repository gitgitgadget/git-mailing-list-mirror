Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F0F1F453
	for <e@80x24.org>; Sat,  2 Feb 2019 01:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfBBB6V (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 20:58:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35922 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBBB6U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 20:58:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so4126830plo.3
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 17:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YqI6pCt1wLomSS2F3mfrRCAcpazddjQYxhQYHasVGTc=;
        b=lhwkswu2DgORCvF93o9kDRJTYS2lQ+twFxT6uxdevWGm20fPnUXUqMosLIlmFgV7Vx
         IH8UIqiW4lvfFXno4QAWpG0Ct1F0aEb2od39cAEhxhjppJKVynRw1rLhxBsGWAwGqtwy
         qTWJ7FlBwwIxqCNgZZ114kvCYfFb6xbEamQfjQHTt5SfTuNxmjkvkLzhSx/xEl75RcB5
         k2gF8catuoYlPPkJmu+FfYq5g0C+CqLaRvdawIVwb/xoTFnBPWpBWkxm43mykDD0hbKm
         dGH+gy9Es4YmI4YMcPboXVGFqnJPnrklaTwQTcZMA1GMQzCp6S7s8syTeTHi+tKL7tjR
         Q7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YqI6pCt1wLomSS2F3mfrRCAcpazddjQYxhQYHasVGTc=;
        b=Sk8M9J1MfFjTL3OTblvQ2wMujKpftrgfqWo3lEIhnIS/6ZnoQNZSuSvFiUze78qCr4
         GO0/DZSWTlzUfsJq89ewgU06khlALJ/pNdC/r9F/oW+s5BLLfwPNRj8XNc7pKyL2Bwmb
         O4jAfB9tV7QrU3L4m30TGz6scPGtlTMKPFs6EaY7fs4hy9F5Nx+uiup6/bbWMY/zwU60
         eH2oDZ65gsGj+Hunw0TlS9qcIhKNmu/SZmhxBClB1rsrbksamPfbws+GdBBGTAY7lvsn
         0dQnTiLMqZdM3cIKqejWcWvyzwjUYn/PG/awZUdSMmAIZPQOfMwkRLAhErzCeXMzL55F
         KNcg==
X-Gm-Message-State: AJcUukdm37mZCYM7le0bKtu/SdYguTSSJDWu1aJdqtnjXEHVV31fEx6S
        /uZuXyNsYf26uzS1A9v6+bzvyBJr
X-Google-Smtp-Source: ALg8bN7JcpQCAK+OQiO1cV/63xebIvPk306rGBwBqT6EYj+vjJRdtqHxqvDpsUvIRDD9CN29yY7jGg==
X-Received: by 2002:a17:902:a40f:: with SMTP id p15mr43178711plq.286.1549072699809;
        Fri, 01 Feb 2019 17:58:19 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id t24sm11780876pfh.21.2019.02.01.17.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:58:18 -0800 (PST)
Date:   Fri, 1 Feb 2019 17:58:17 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH 7/9] submodule: migrate get_next_submodule to use
 repository structs
Message-ID: <20190202015817.GA241226@google.com>
References: <20181129002756.167615-1-sbeller@google.com>
 <20181129002756.167615-8-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129002756.167615-8-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> This patch tightens the check upfront, such that we do not need
> to spawn a child process to find out if the submodule is broken.

Sounds sensible.

[...]
> --- a/submodule.c
> +++ b/submodule.c
[...]
> @@ -1319,10 +1338,23 @@ static int get_next_submodule(struct child_process *cp,
>  			argv_array_push(&cp->args, default_argv);
>  			argv_array_push(&cp->args, "--submodule-prefix");
>  			argv_array_push(&cp->args, submodule_prefix.buf);
> +
> +			repo_clear(repo);
> +			free(repo);
>  			ret = 1;
> +		} else {
> +			/*
> +			 * An empty directory is normal,
> +			 * the submodule is not initialized
> +			 */
> +			if (S_ISGITLINK(ce->ce_mode) &&
> +			    !is_empty_dir(ce->name)) {

What if the directory is nonempty (e.g. contains build artifacts)?

> +				spf->result = 1;
> +				strbuf_addf(err,
> +					    _("Could not access submodule '%s'"),
> +					    ce->name);
> +			}

Should this exit the loop?  Otherwise, multiple "Could not access"
messages can go in the same err string a big concatenated line.

Thanks,
Jonathan
