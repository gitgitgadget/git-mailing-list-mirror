Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5378C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 11:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbiFCLFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 07:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243922AbiFCLFM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 07:05:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD3D3BFB6
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 04:05:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id me5so14706822ejb.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 04:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vEWpEx1DRGpJiqSxIzl5ZYiHg+OJPzX29BXYKF+R8G0=;
        b=G37/aAvWta+EKDpNmM9oIC7SEDIxy1kxyZUU+qoJtg9kHYJ/nkf801SacGOQhFYzPn
         Cvz6jwW1YRqTMxML38aHGsV5GwED6aFbjQtKrXmBs49rbKZC931EgI45jJ8aRzzxqWCI
         Zd1npFWOHKmkvhN7QfnQ0RVr1Txl0AwbjI373wkz3YSRJ70w0t5w3YdPElqmXxp2vsuT
         sxy7PVeCtjWpeCOjW3oGT8vyVFnvNC5Wk8zw8Q1B5t9F9ka2iXsaO9F/UDM5wPK5ri9Z
         ACCNMYg/iIJlV5FDvUs3crCBxbx9iD/EM50idoSqvzIC2ftWPypp0d+RCk8ObCXsOCFb
         2yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vEWpEx1DRGpJiqSxIzl5ZYiHg+OJPzX29BXYKF+R8G0=;
        b=vWZJOul1+AaJTJjbwQPFWDwzNYVavRmuAMUg80d+KerdAHSci2RWRCL+1oJYouLtZP
         IYSbgmTWteihAejx92Nwz/lZz6wDs3MD4DQZp+m5qXolvnRZWUAzqO2u+1FoB2XrODV/
         XfswVDR87RNOk753tZDiJzj+B2Bb1BTt60xuSQrKbkWCzg2OcKz6eLr3ZIv83UMNEUfJ
         BFbiHd0DnN1Lu6mRyhMnu4WzIMgZcz/xkZKc4nnZXoUuxRY1uSSNMNsGmdB1C67ihdDd
         WG9HZczpC939mWFcYshbdXt+3Zvv/5CjT9wSRdu64nz/8Dp7CG3P3KBu4f46LuoRWHwQ
         +KNA==
X-Gm-Message-State: AOAM531L8gm9/6/eo9GFxZwRq95bqKE8o0xgf/ZkxpVjQahoj+i06/N5
        BIzK42G3+HwoprClNQNKz14=
X-Google-Smtp-Source: ABdhPJwnZL01Hzo3Gc7/doTQG37YhjneSfnRt93IKoVViwoso7RXuSiCFRQQTvuRTTfkr8e2Jxi6Ww==
X-Received: by 2002:a17:906:1c04:b0:708:a007:5a77 with SMTP id k4-20020a1709061c0400b00708a0075a77mr8325080ejg.566.1654254309184;
        Fri, 03 Jun 2022 04:05:09 -0700 (PDT)
Received: from localhost (78-131-17-130.pool.digikabel.hu. [78.131.17.130])
        by smtp.gmail.com with ESMTPSA id s23-20020a170906501700b006fefd1d5c2bsm2763190ejj.148.2022.06.03.04.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 04:05:08 -0700 (PDT)
Date:   Fri, 3 Jun 2022 13:05:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de, Guy Maurel <guy.j@maurel.de>,
        Randall Becker <rsbecker@nexbridge.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 2/4] git-compat-util: avoid failing dir ownership
 checks if running privileged
Message-ID: <20220603110507.GA1749@szeder.dev>
References: <20220510174616.18629-1-carenas@gmail.com>
 <20220513010020.55361-1-carenas@gmail.com>
 <20220513010020.55361-3-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513010020.55361-3-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2022 at 06:00:18PM -0700, Carlo Marcelo Arenas Belón wrote:
> bdc77d1d685 (Add a function to determine whether a path is owned by the
> current user, 2022-03-02) checks for the effective uid of the running
> process using geteuid() but didn't account for cases where that user was
> root (because git was invoked through sudo or a compatible tool) and the
> original uid that repository trusted for its config was no longer known,
> therefore failing the following otherwise safe call:
> 
>   guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
>   [sudo] password for guy:
>   fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by someone else)
> 
> Attempt to detect those cases by using the environment variables that
> those tools create to keep track of the original user id, and do the
> ownership check using that instead.

Thanks for working on this!

Unfortunately, I haven't been able to follow the discussion on this
patch series at all, but by a cursory look now I didn't notice any
discussion about what should happen if someone were to use 'sudo' to
access a repository owned by root.  I think it should work, and it did
in fact work in the past, even after bdc77d1d685, but this patch
broke it.

Case in point are tools like 'etckeeper', which keeps track of '/etc'
in a root-owned Git repository, and hooks into package managers to
automatically create a commit when a package installation/update
changes something in '/etc'.  After this patch when 'sudo apt install
<pkg>' invokes 'etckeeper', it complains about the unsafe repository
in '/etc', and doesn't make that commit.


>  static inline int is_path_owned_by_current_uid(const char *path)
>  {
>  	struct stat st;
> +	uid_t euid;
> +
>  	if (lstat(path, &st))
>  		return 0;
> -	return st.st_uid == geteuid();
> +
> +	euid = geteuid();

Perhaps all we'd need is just a simple condition here:

        if (st.st_uid == euid)
                return 1;

which does make it work again in my manual tests, e.g.:

  $ id -u
  1000
  $ sudo ./git -C /etc/ rev-parse --absolute-git-dir
  /etc/.git

Alas, I couldn't get 't0034-root-safe-directory.sh' work for me at
all, so I'm not sure it doesn't break something else.

And it would also allow 'sudo -u somebody git ...' to access a
repository owned by that somebody, which, I think, should work as
well.

> +	if (euid == ROOT_UID)
> +		extract_id_from_env("SUDO_UID", &euid);
> +
> +	return st.st_uid == euid;
>  }
>  
>  #define is_path_owned_by_current_user is_path_owned_by_current_uid
