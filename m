Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1C4C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE93217A0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EosbqSbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404422AbgFSQPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391182AbgFSQPe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 12:15:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C7C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 09:15:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so10261359wru.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s8hcaGuHq9hYgdKwNl/ktMfUu2qKNLKHgci7irv18Ro=;
        b=EosbqSbnz1i6xn2S6OWJq758iiqjW6sj84lEYXoqkKc9si7ca5UgTJX0Y3U9+5+FEz
         xx/4V0wZQsQb+JlnbKx+/q07K/8K0KRZ95EIfSnZ5tkpkugANIKxGZReU0TfhuYHzXw8
         5J1CMtsrLt97ir9yNVxNxMrdIB6+oCvnMyGbFCHZSV2FFbrtuP+/15RDMgz6E2AUZ3v2
         I5GAwd7PdKh3dZt6lFGg/fVvtvAwBLBzmvV8f4WC5t1T74lInIxZajw4XPNUFlKM+/3g
         OyTwfprnQ0TGLZvMdjhR+aup0ACbHPmU8/GVUts5DRraEar1PAM9K57IKefOoY0eC+bv
         LKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s8hcaGuHq9hYgdKwNl/ktMfUu2qKNLKHgci7irv18Ro=;
        b=geHrY+U3klmlcNdTnReOkeyqiwLqeRJRb41G3zIy5z3moQa8bWIzmSh1/NbqC6A5mh
         fLj4D1OlN7rLMEBWmOY7teq8Fmcdpth+N2zUx9hbSBEQXjA26rllZQTvT7w9tDZ06ZTX
         kB6cmkmiRDpA0Sl6KMzBRrfAck6pGfvmuMDzBWTqGOwdjjduEkSNyQuJk/r4ybYgQ6IZ
         9JXvlf23NEEfbms9VMuQIu72Dc7mgwqFhxfthhlWYEiRBJ1bfGEdMtXeGP9tGdjhcYz4
         ZpkEV9ub1ZLQHbXAOlpLJrXaE/gOSioyTW1EQr6MmO9vuXX05Ujl6eisOg9Iytrx9Clm
         ItKQ==
X-Gm-Message-State: AOAM533ffeIRMoienDNvei5ZoHsEFmXC/EIbGTb7PriJc1ABFOwSFAGj
        ufWUp9Sxb5L0+rhgrL/wIAc=
X-Google-Smtp-Source: ABdhPJzNSej/j3YTJd4c7/IDTlBUy5i05I3UjIyzATu5VwiVyFi8vP3q9lIcfB1y6kjyfTWvW1KZTQ==
X-Received: by 2002:adf:dec5:: with SMTP id i5mr5150244wrn.16.1592583331566;
        Fri, 19 Jun 2020 09:15:31 -0700 (PDT)
Received: from szeder.dev (62-165-236-97.pool.digikabel.hu. [62.165.236.97])
        by smtp.gmail.com with ESMTPSA id s2sm7066483wmh.15.2020.06.19.09.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 09:15:30 -0700 (PDT)
Date:   Fri, 19 Jun 2020 18:15:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] git-prompt: include sparsity state as well
Message-ID: <20200619161528.GI2898@szeder.dev>
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
 <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
 <17254b30a5bcbbe3e14dd47272dfcb4c867030dd.1592513398.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17254b30a5bcbbe3e14dd47272dfcb4c867030dd.1592513398.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 08:49:58PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The current git prompt includes a lot of possible state information from
> cherry-picks, merges, bisects, and various flavors of rebases.  Add
> sparsity as another state flavor (though one which can be present
> simultaneously with any of rebase/cherry-pick/merge/bisect).  This extra
> state is shown with an extra
>     |SPARSE
> substring before the other states, providing a prompt that looks like:
>     (branchname|SPARSE|REBASE 6/10)
> 
> The reason for showing the "|SPARSE" substring before other states is to
> emphasize those other states.  Sparsity is probably not going to change
> much within a repository, while temporary operations will.  So we want
> the state changes related to temporary operations to be listed last, to
> make them appear closer to where the user types and make them more
> likely to be noticed.

I understand why some users prefer to be reminded when they are in a
repository that uses sparse checkout.  However, perhaps not all users
want to be reminded, and I'm sure that not all users want to increase
the width of their prompt by 7 characters (e.g. in standard-width
terminals).

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 014cd7c3cfc..3e7344a4014 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -421,6 +421,11 @@ __git_ps1 ()
>  		return $exit
>  	fi
>  
> +	local sparse=""
> +	if [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
> +	    sparse="|SPARSE"

Nit: indentation.

> +	fi
> +
>  	local r=""
>  	local b=""
>  	local step=""
> @@ -543,7 +548,7 @@ __git_ps1 ()
>  	fi
>  
>  	local f="$w$i$s$u"
> -	local gitstring="$c$b${f:+$z$f}$r$p"
> +	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
>  
>  	if [ $pcmode = yes ]; then
>  		if [ "${__git_printf_supports_v-}" != yes ]; then
> -- 
> gitgitgadget
