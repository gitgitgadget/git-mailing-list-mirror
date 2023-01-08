Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B72FC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 06:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjAHGjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 01:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAHGjm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 01:39:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA7DE93
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 22:39:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y1so6183000plb.2
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 22:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+upVWG6VhKvLWmEeolZ/lVrnhxFZZSHhqkD+hUrr98=;
        b=IkJ3osVB8/vQ2i9OqdO/eonE8dVZ2lQNYZualeXROZT2A+LcZL0y2wOQmUsscdb+m1
         IuEl7GrhZrkjjXMOWplMwtR7M0Iv0LnfW5ZBRoA2W+W/3JFZxVZvzcTSotJTDCNynHV4
         s3+AGfcchCDDOJ++SRtY7440WnPPHfjuDbCdtIXZv1ToNt3NbpRzYg2IOFzxVAhcXI4j
         uqx9WBiwxUdfQTh6XRZ4aLMvd9mllf9tlgUVglzb69qfNUQyl4rGyzr59LIevK6kiR7J
         k88rNuRkc8cIsweIRaccE0JDd/ohd+K5m4qy9HjhNIHW8erDfllm4Gz5PbYOVlH9KMJ+
         1mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+upVWG6VhKvLWmEeolZ/lVrnhxFZZSHhqkD+hUrr98=;
        b=SFmvpyhnB0UjsPDme4jeaH5FJoI8JgYL0HSv24NsJabmNQdqOlu/49HG/1LwOC3Xh7
         hCD3h8Zmf12PyNz6RHmFZVSL0sk73neM1z8ETFOMcozTvDglRHc4upVOET4459VbFkca
         zH18mJoBMsTTvEYoRB8Gdn8xgZEpq98/6ZBKWUxJVKuzeXIQte03vMDOM5Co+6J3b8Od
         exPIRIgxA3TYk+1oHOI7fwB3VFLpsxqdGbVU1OzVD2l+kagSdo/ktcOmrZt9NO9HmP2Z
         bHov40zs7bNWVA9ew33fT2LOf0fQludeDwNQqHupS0gF8L4DK2njyFQmVNyg4DfQSs0G
         mwxw==
X-Gm-Message-State: AFqh2krjAHd8zrgDw16HEnkDNTe0rweQp6XqNGI5uWtX4oL30qCc8WIX
        xE0/PN9Rv/UqOktGaFPxYEw=
X-Google-Smtp-Source: AMrXdXtGWics/WFobCvfUBWn6lKGmCSe9sy38JlsLIjLlBN5aPimrNBKfvR/ICIl9fjNXV6kQ81u2w==
X-Received: by 2002:a05:6a20:d389:b0:af:7a4c:fb7d with SMTP id iq9-20020a056a20d38900b000af7a4cfb7dmr75937930pzb.23.1673159981263;
        Sat, 07 Jan 2023 22:39:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h185-20020a62dec2000000b00580ea7211c2sm3670761pfg.208.2023.01.07.22.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 22:39:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] grep: correctly identify utf-8 characters with \{b,w}
 in -P
References: <20230108062335.72114-1-carenas@gmail.com>
Date:   Sun, 08 Jan 2023 15:39:40 +0900
In-Reply-To: <20230108062335.72114-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sat, 7 Jan 2023 22:23:35 -0800")
Message-ID: <xmqqbkn9zg0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> When UTF is enabled for a PCRE match, the corresponding flags are
> added to the pcre2_compile() call, but PCRE2_UCP wasn't included.

Would the same performance concern as

https://discourse.julialang.org/t/regex-pcre2-and-the-pcre2-ucp-ucp-flag/10930

apply to us as well?



>  	if (!opt->ignore_locale && is_utf8_locale() && !literal)
> -		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> +		options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
>  
>  #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
>  	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
