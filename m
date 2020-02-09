Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FFDC2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94199207FF
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="KuT34R7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgBIXD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 18:03:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40052 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgBIXD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 18:03:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id z7so2881794pgk.7
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 15:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xO8vycCCZf7pi7VwMuEi/cKG8phmCf9+lh4zlN2B3ek=;
        b=KuT34R7wHlLbHSl5ac8sbjBbUqJ1Xmcj5YlKh9UwLGlE9WqyneuVpoQ4560q7C8Ro9
         xW6TfhjPqwMEFrstp41/1NIjw5Ub5ueocLOsnLc2hg033VeK2lhihvM1XdRL052bnzF1
         n4n2bXlYRx29WsjoCNSNxXAqUsbkKhrXMUNGIC/R+WplJuWYTyDJN4aOeSh2NxOqGbBx
         nYmS/SjKb19jOpoOVRtB4EvxmUdx5G899PKuWi/xV6XwSFU2vt7PfPue5G0aqKapWyBO
         +jdwVXpEY34PDYH2gtYQaWMOtDL4p6e8Lv5ae9Z+LLv6gvFdpyNZbjKqvpa/82hnbaDx
         VW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xO8vycCCZf7pi7VwMuEi/cKG8phmCf9+lh4zlN2B3ek=;
        b=t36NW3Yb76n35E1OAb+I6D+Fp175WcJvzfJrnk8WTPpY3CpAD13oRyhw/IEMVVPsV9
         5Aru5SylErhPOqbk31OAS8PWXGc6oIec6foX9f/s9oNwLy7w2i70uC2ckW6D+7LEx7rr
         yBa/JdtaiK8DaqgA8YN2OZLbeaYf2yq7r/Bbfm3BvrT5jF6zBPUdnZtim5wh6kkRCWSi
         AhzKZKHTTuanV1dZ7gqgmD757H9ZUNCNdHv72xY0uSnjryeXdJcM/4gDNcmEYfjWmxp6
         7lk0W/9Pk72k+70mhNGTR6y3KVL6UWPnYQwt9lP2BNARDCftvPJGxEV1mFoYgWsCHlup
         szCA==
X-Gm-Message-State: APjAAAVT8GJ44c9TxQ/GBf5YBEqHkQPYS+JVmplSEQpTtPygbf/bV7Sl
        mtM7EVkIz51WskfYO/uryN3Fo3zjDP1Wl1O3
X-Google-Smtp-Source: APXvYqzRQdMkep/eeMj6ITUwuLkhmu2ObbMEdATy5lxP/jUnsjwaHV6iSDY10j1s05X2L+NB5vKKmQ==
X-Received: by 2002:a62:ed19:: with SMTP id u25mr10414381pfh.173.1581289403876;
        Sun, 09 Feb 2020 15:03:23 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:317f:c53e:b83c:7fcb])
        by smtp.gmail.com with ESMTPSA id h3sm9956658pfo.102.2020.02.09.15.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 15:03:23 -0800 (PST)
Date:   Sun, 9 Feb 2020 15:03:22 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: ignore rubygems warning in the "Documentation" job
Message-ID: <20200209230322.GA4530@syl.local>
References: <pull.707.git.git.1581287776574.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.707.git.git.1581287776574.gitgitgadget@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Sun, Feb 09, 2020 at 10:36:16PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> A recent update in the Linux VM images used by Azure Pipelines surfaced
> a new problem in the "Documentation" job. Apparently, this warning
> appears 396 times on `stderr` when running `make doc`:
>
> /usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb:10: warning: constant Gem::ConfigMap is deprecated
>
> This problem was already reported to the `rubygems` project via
> https://github.com/rubygems/rubygems/issues/3068.
>
> As there is nothing Git can do about this warning, and as the
> "Documentation" job reports this warning as a failure, let's just
> silence it and move on.

Thanks for explaining, and for taking time to silence errors such as
these that we can't do anything about. Everything as explained makes
good sense to me.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Fix CI/PR failures in the "Documentation" job
>
>     It would probably make sense to apply this to maint, too, as it will
>     cause CI failures even if there is nothing actionable to be done to
>     really fix this on Git's side.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-707%2Fdscho%2Fworkaround-for-rubygems-using-deprecated-component-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-707/dscho/workaround-for-rubygems-using-deprecated-component-v1
> Pull-Request: https://github.com/git/git/pull/707
>
>  ci/test-documentation.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> index b3e76ef863..de41888430 100755
> --- a/ci/test-documentation.sh
> +++ b/ci/test-documentation.sh
> @@ -7,6 +7,7 @@
>
>  filter_log () {
>  	sed -e '/^GIT_VERSION = /d' \
> +	    -e "/constant Gem::ConfigMap is deprecated/d" \
>  	    -e '/^    \* new asciidoc flags$/d' \
>  	    -e '/stripped namespace before processing/d' \
>  	    -e '/Attributed.*IDs for element/d' \
>
> base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
> --
> gitgitgadget

Thanks,
Taylor
