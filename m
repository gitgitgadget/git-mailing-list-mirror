Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C403BC433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 08:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903E264ECE
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 08:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhCMH7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 02:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhCMH70 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 02:59:26 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71892C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 23:59:26 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d23so9769371plq.2
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 23:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RsN8cfXkelGxR4yS2HLvvNXS872Hifq8Rg8Y2Ng9oWE=;
        b=ZNF2lSw2VkMY8/VmDRC8rWUL3EX2xYpaEiSZ4b4mstlbcy+lB/eS8/bOScXYGUe5zQ
         EV63MnJACjv1ONwx9oy5ex6TuII7ktdrfhuW3sVT4YhTb03xFI0OFmCEMva2IEnbGp0u
         u+7RbWwHlg2Pf1edL2W8BCpariajHVOMxRLSbb9ecqfqiMkXPvjsKmR0K57wqmTHIKhR
         0PMYW7qOnq2cAEFbOUI/b74RLr2HehxmaeD12g/LbldGoYQdBjOOajMGWXJfs/DdJ2DV
         FTjmumZQyyXJveon1lYR04Qlq1rQWhEkb+kqQ3XA8YF1FwFoL+3s9mcTYYJjUOdZZji+
         yz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RsN8cfXkelGxR4yS2HLvvNXS872Hifq8Rg8Y2Ng9oWE=;
        b=SSHpw3xIz7kjHlxZ5YUlYrfwb9echrD4qv6461MKC0AmEFpJIy0RZPduP+q09Gcicr
         i8mwc9XhdtKBcAfCeUXxICcS5QyiPaivXMqRGaWIsM7sny9g8y051sNcY4qCP+Ey6ufk
         SXrWCT2u/VIQC8GIkZ0vU5UqE6+LfvcuxpWodNVs4ped/0HA9RLT207+1/zhUTPKIMUG
         iXCXkpcaByxQGI0JJV85IyOvUA5P4t0XbE1tVXJaZj6vbpOsLjpIxyYtdwSToMtrFf2O
         DutEDaKj0hT4kqbARuLc3dIgCUUdeJYUDgvkGweSNbJnTAPsa9W88CJ4+gF5pAQvOIxP
         trHw==
X-Gm-Message-State: AOAM5317vPim5vC9K4vVCvpS2OzI2IuY6vSZjIZbmop5JRn0KoFBOkov
        oVnRDx9RUkCfkkJ5rzfoGyu+MkWMLpk=
X-Google-Smtp-Source: ABdhPJwOrVDUDaTb6Cckn1/qTefXY7oycC7ftUlAcN1EzGJuu3FjxUdv9p6vtoqIr/P2RKo17RQ8Uw==
X-Received: by 2002:a17:903:102:b029:e5:fc29:de83 with SMTP id y2-20020a1709030102b02900e5fc29de83mr2328301plc.31.1615622365989;
        Fri, 12 Mar 2021 23:59:25 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a1e7:6707:cbf6:696d])
        by smtp.gmail.com with ESMTPSA id gt22sm4394632pjb.35.2021.03.12.23.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 23:59:25 -0800 (PST)
Date:   Fri, 12 Mar 2021 23:59:23 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Fabien Terrani <terranifabien@gmail.com>, git@vger.kernel.org
Subject: Re: remote.<name>.merge missing from the git-config man page?
Message-ID: <YExw20PVRmwumMBx@google.com>
References: <xmqqlfax7dya.fsf@gitster.c.googlers.com>
 <YEZwY0721KvQNkK+@nand.local>
 <87pn092yja.fsf@igel.home>
 <YEaI5JIobsbtBQO1@nand.local>
 <87lfax2xat.fsf@igel.home>
 <YEaM7ruZCvaQQbPI@nand.local>
 <87h7ll2wiz.fsf@igel.home>
 <YEaRw5x5hnh9RRyM@nand.local>
 <87a6rd2tp8.fsf@igel.home>
 <xmqq5z1w542n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5z1w542n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> From: Taylor Blau <me@ttaylorr.com>
> Date: Mon, 8 Mar 2021 13:43:47 -0500
> Subject: [PATCH] Documentation/git-push.txt: correct configuration typo
>
> In the EXAMPLES section, git-push(1) says that 'git push origin' pushes
> the current branch to the value of the 'remote.origin.merge'
> configuration.
>
> This wording (which dates back to b2ed944af7 (push: switch default from
> "matching" to "simple", 2013-01-04)) is incorrect. There is no such
> configuration as 'remote.<name>.merge'. This likely was originally
> intended to read "branch.<name>.merge" instead.
>
> Indeed, when 'push.default' is 'simple' (which is the default value, and
> is applicable in this scenario per "without additional configuration"),
> setup_push_upstream() dies if the branch's local name does not match
> 'branch.<name>.merge'.
>
> Correct this long-standing typo to resolve some recent confusion on the
> intended behavior of this example.
>
> Reported-by: Adam Sharafeddine <adam.shrfdn@gmail.com>
> Reported-by: Fabien Terrani <terranifabien@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-push.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index ab103c82cf..a953c7c387 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -600,7 +600,7 @@ EXAMPLES
>  
>  `git push origin`::
>  	Without additional configuration, pushes the current branch to
> -	the configured upstream (`remote.origin.merge` configuration
> +	the configured upstream (`branch.<name>.merge` configuration
>  	variable) if it has the same name as the current branch, and
>  	errors out without pushing otherwise.

From the discussion it seems this sentence has further room for
improvement, but that shouldn't block this straightforward typofix
patch.

A few ideas for further improvement:

- I think "the configured upstream" would read more clearly as "its
  configured upstream"

- the parenthesis could be a little clearer by adding a verb --- e.g.
  "as determined by the `branch.<name>.merge` configuration variable".
  Alternatively, is that implementation detail the right thing to
  mention?  Perhaps we could instead say something like "as configured
  using git branch --set-upstream-to" as a way to introduce the
  concept of a branch's upstream.

- the "it" in "it has the same name" is vague.  Does a branch's
  upstream represent the remote-tracking branch (e.g.,
  refs/remotes/origin/main) it merges or rebases against, or does it
  represent the remote branch (e.g., refs/heads/main in the remote
  repository pointed to by origin) it pulls from?

Putting those together, I could imagine something along the lines of

	Without additional configuration, this first checks that the
	current branch's configured upstream (see git-branch(1)
	--set-upstream-to) is a remote branch with the same name and
	then pushes there.  If there is no configured upstream or
	the configured upstream has a different name, it errors out
	without pushing.

Thanks,
Jonathan
