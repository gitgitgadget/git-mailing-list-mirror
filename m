Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F7DC27C76
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 00:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjAZASe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 19:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAZASd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 19:18:33 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC435142D
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 16:18:32 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z31so176278pfw.4
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 16:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asqg/K3OGZlQf4OewCJ3O0cLOnfXMelFaoJwcpMEcSU=;
        b=fydCPwY9LLRy8KZ1Z2ZgGPeVCHeFbodFF211l7ymScaNodDiSrl6L1h3ZAVQ5Tiq02
         kRPqkMYT4Oc2X8rICXiDFxFGV6xCqhVvA2Pch5VjdVkXsamlvCykLpMBTRFN75o3tE5G
         Th+XzhbuhqCsmpK9DklxTcTPStjGPObiODm08WTY6XeczpPo0iwJcgM+aTqPcRe4WKd/
         r+2NyIceHALvmO3udIZRk7xaPzL0s/DsSfMKbdrtcAgm9D4laP1HawPrb2a5c1q6+BUo
         mFM16wBDwG8D4Uk2ccV3bFqpMWqE38UgNTusyF/9o2K8/5S9ooatb+Hh7ZNDPFwUwEge
         f8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=asqg/K3OGZlQf4OewCJ3O0cLOnfXMelFaoJwcpMEcSU=;
        b=nL/bF9POndVSZd6TwRCxrcUr7G3xJjA/2IKdy5OeqDaYwV8y6aS7S0acGI/YpvjzfN
         oIAqgkQP4/zGLPE+CkDKfIUgjtRBZPC+M4kHwu1txhwJHB0ZlqKEr5yFoqaQN0AfI1ks
         wv9vWGWDn+S/Z7cl8cScKqlrtoo5zBtAcKgVovw7N5LQw3GbkJWUdLrGNWnbC6/70wNo
         1BaOiOgLB/gJ+CPesj+YTnQHMUBwKz6hoaJMfqcRgqxkLRUnupQmt/NitjcAG9JpnM+v
         XrdtadIu8XJaStYj3gLocRmoXI+xHUDbMINpuzWzd3monZuPgFANpWYHnk2HJE1/9bZ/
         fFyA==
X-Gm-Message-State: AFqh2kpHXrwiV07wkWtIaErnQy2s9/mRz1UP4CllylWqZE9Wv9lyn+zD
        u9pYHOL4/jFiOGceyhg+VuK1wvV5clE=
X-Google-Smtp-Source: AMrXdXvIlHHXHGmDCuMIV1Zmcbo4Dox1pTrP1I6mnuSQwGXLI8UCyVtizQP/9hXUotqt1wa3wlxjcA==
X-Received: by 2002:a05:6a00:300f:b0:58d:94a2:f404 with SMTP id ay15-20020a056a00300f00b0058d94a2f404mr38217728pfb.12.1674692311932;
        Wed, 25 Jan 2023 16:18:31 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id d11-20020aa7814b000000b00587c11bc925sm4202755pfn.168.2023.01.25.16.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 16:18:31 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] request-pull: filter out SSH/X.509 tag signatures
References: <20230125230117.3915827-1-gwymor@tilde.club>
        <20230125234725.3918563-1-gwymor@tilde.club>
Date:   Wed, 25 Jan 2023 16:18:31 -0800
In-Reply-To: <20230125234725.3918563-1-gwymor@tilde.club> (Gwyneth Morgan's
        message of "Wed, 25 Jan 2023 23:47:27 +0000")
Message-ID: <xmqq4jsedu7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gwyneth Morgan <gwymor@tilde.club> writes:

> git request-pull filters PGP signatures out of the tag message, but not
> SSH or X.509 signatures.
>
> Signed-off-by: Gwyneth Morgan <gwymor@tilde.club>
> ---
>  git-request-pull.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index 2d0e44656c..01640a044b 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -153,7 +153,7 @@ for you to fetch changes up to %H:
>  if test $(git cat-file -t "$head") = tag
>  then
>  	git cat-file tag "$head" |
> -	sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p
> +	sed -n -e '1,/^$/d' -e '/^-----BEGIN \(PGP\|SSH\|SIGNED\) /q' -e p
>  	echo
>  	echo "----------------------------------------------------------------"
>  fi &&

Thanks, queued.
