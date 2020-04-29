Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E698C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731522076B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwPqemmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgD2QAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726519AbgD2QAu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 12:00:50 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E865FC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:00:49 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j16so2223548oih.10
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41mUFO4M4GChSBEgiBWm0j6qESYoo3yGQ5Ig6mxUypo=;
        b=SwPqemmJAyAkiQeWWCCjASY3t2vYGZcFTMZyJ5H8xkT7CganFIdaAP0eNDVJSK3FW1
         9mATHkOgtWcrUU1aoO+K/2VH0MQwc+NQRr6wD1kmX0YEiVnVpi8gXjA2W697I0RqFANw
         76SolTkqbIyKir9v5I2UdZEMxVAE6fLxaTXj5gKaOQySd9vH120CWqWRL+Jn6o7Z+g0Y
         FNqWOvZSU68/eqWkVl8PeDUlqURmL5fiCUqGEjuoXV/x+2xrmJXZI2ihNEy+cPeagoIW
         VyvXqW4qmk/E1rP/l7xpj9DTy8Jitw+acuMfzY5OTS0iI5CcZA3L1H8WIcTlb2zpdqfj
         tgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41mUFO4M4GChSBEgiBWm0j6qESYoo3yGQ5Ig6mxUypo=;
        b=bd2LbDr8HIt63YkEVwH1mXha8+OUuAnjW3mtMLsJqdYdpz8r0riByahWM6z67pxI2F
         dORScZZduk5hJe2FWfu95Gj9ff15NxsV0cHRUpRXrTKmNiHnIBW+dBQ2eTNHjEqlS+Ps
         +2dnGzfnzXmuWBGfGoHmM6PSRtVbdIenZrHOqVCALPfg3Djxfx5uW2Y9/HlTmBz/hD6R
         9yuDVUl2AvlPBwrD/nI0e+lVeNeuZi/MMDX8JynyW/zo097wIIie5TW9vOLCqG5X0S/F
         tkCGbS9IcfxQl6Oq5zZNJpY7cOcgfsHjm0G/RMcdvyyicfLIXUDI3HsIMJ/EyyR7Gvux
         IGVQ==
X-Gm-Message-State: AGi0PuYigZWvgmnznm19z9kfBx7pUKXPRsgGTRKE+yEk0RD77dnk305A
        Z5sD5HaVW8HiV93AN7F9ktFkn032SEuQz9suoSc=
X-Google-Smtp-Source: APiQypJGo7qLqvtZR5xD8ra909YCwKN3ITFfWKzI+s7vfeEd9t6ke6COWmVR8PwPBxtnuuomhWzHaHANlALrQWzCa2M=
X-Received: by 2002:aca:5513:: with SMTP id j19mr2095881oib.31.1588176049105;
 Wed, 29 Apr 2020 09:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com> <20200429093811.8475-3-shouryashukla.oo@gmail.com>
In-Reply-To: <20200429093811.8475-3-shouryashukla.oo@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Apr 2020 09:00:36 -0700
Message-ID: <CABPp-BG2zf8w6ouK3nn8bid_HKWh2g6Gu-UB65q3Z9V2D80X7A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] gitfaq: shallow cloning a repository
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 2:38 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Add issue in 'Common issue' section which covers issues with cloning
> large repositories. Use partial cloning to selectively clone the
> repository.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> I wanted to ask why is there no mention of partial cloning in
> the 'git-clone' documentation? Is it because it is an experimental
> feature?
>
>  Documentation/gitfaq.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 7d294306f9..6f32846e3d 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -243,6 +243,16 @@ I want to change the remote of my repository. How do I do that?::
>  One can list the remotes of a repository using `git remote -v` command.
>  The default name of a remote is 'origin'.
>
> +[[shallow-cloning]]

Why is this marked as "shallow-cloning"?

> +The repository I am trying to clone is too big. Is there an alternative
> +way of cloning it in lesser space?::
> +       A good way to save up space when cloning a repository is

"save space" instead of "save up space"?

> +       by using `partial clones`. A partial clone will clone the
> +       full history of the repository but will skip out the entities
> +       specified by the `--filter` option one uses in `git clone`.
> +       Any entity which has not been cloned to save space can be cloned
> +       on-demand. See linkgit:partial-clone[1].
> +

I like this much better than suggesting shallow clones, though you
should mention that partial clones (currently?) presume that you have
an always-on network connection to the original repository because
subsequent commands may need to fetch additional objects in order to
complete.
