Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B0CC433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 15:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbiASPel (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 10:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355727AbiASPee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 10:34:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3E5C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 07:34:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 30so13913829edv.3
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 07:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=l8d5KyIqxxLlGRBz2qzCWfWH1FqfommEZcFQ4JRcgHM=;
        b=RlTzVKFWVwSkOBDc1V8+O/gsssvHzifFw/aDGgvNI3hJ4m0S73JAMuj549/ZWTW8KB
         bNjzFEIic23GoNSYeI+Gas1rlwj0KK4QAimv7fE82RjhARMn4+Xj63sEgbMYVlHY4X0D
         Rk/pwFEYpNaCs22iDag7RpgEJatNv+HtrW+ItuqOIc5qzF+iDLIhnlTdeNG+ulL48BDq
         oexUTbIPwVMSk+0t9/tgGHan5p0ONbyvccd3Yg+YxHOuszO4EhUITkYdNc22YPPCE4nw
         I9UYdulj8nahCU0t/lHU279Z4uTvLRn/oxgJ2TiHtInMY5J97RqsthU8SoowpENuieHw
         CVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=l8d5KyIqxxLlGRBz2qzCWfWH1FqfommEZcFQ4JRcgHM=;
        b=vi3Zmvqw0/aXuafPNr/wbj8seissujr+VNtfu+PWJxRKPp8RyKXuefyG/cJdkmTOR0
         zJoVx7SxevK9nvsWMl4jjalXJvfKpu8r28n+sUz8ifQ3uRf5L0/QpzWFtQOrD4HDPs8W
         fdD5QLKA2tW2ikf4cokLbwICzvYDqnnKN7OVgSnC08zU/mqV/AbmWR9/gmOqtUhdPt/a
         +3tpclNZ9z2keKy3+clLBuAv8M75DZBLM4VTdeUu0IOfX8EHXgQ5z4iAHtfpWhOy8Utb
         9lnfEiR99rD0+IDrsL547KloF5PuClwjt6pCh02L5ASDq/RiZrJrmXin0Kdp+6Pbo/Pm
         NN+w==
X-Gm-Message-State: AOAM530HPuZ7iEm1yOv7u5gYQHAGogyCUygOl0vwWJaGAZHu236AO4hc
        Ymdbtv83CyuIWbIPoreiG5E=
X-Google-Smtp-Source: ABdhPJxwWqN+v83suZSq5jjD26OY52q3qxIBBXEMI5NH9nWLiBmpRdYp2ivIzHdy+C6/SbnS+0YhQg==
X-Received: by 2002:a17:906:7c41:: with SMTP id g1mr21561762ejp.382.1642606472798;
        Wed, 19 Jan 2022 07:34:32 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gg14sm8020ejb.63.2022.01.19.07.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:34:32 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nACyl-001nJz-DR;
        Wed, 19 Jan 2022 16:34:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 2/2] advice: refactor "action is not possible because
 you have unmerged files"
Date:   Wed, 19 Jan 2022 16:31:57 +0100
References: <20220119094445.15542-1-bagasdotme@gmail.com>
 <20220119094445.15542-3-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220119094445.15542-3-bagasdotme@gmail.com>
Message-ID: <220119.86tudzn3i0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 19 2022, Bagas Sanjaya wrote:

> Factor action names (cherry-picking, committing, merging, pulling, and
> reverting) out of the message string.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  advice.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/advice.c b/advice.c
> index 1dfc91d176..4c72856478 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -175,15 +175,15 @@ void list_config_advices(struct string_list *list, =
const char *prefix)
>  int error_resolve_conflict(const char *me)
>  {
>  	if (!strcmp(me, "cherry-pick"))
> -		error(_("Cherry-picking is not possible because you have unmerged file=
s."));
> +		error(_("%s is not possible because you have unmerged files."), "Cherr=
y-picking");
>  	else if (!strcmp(me, "commit"))
> -		error(_("Committing is not possible because you have unmerged files.")=
);
> +		error(_("%s is not possible because you have unmerged files."), "Commi=
ting");
>  	else if (!strcmp(me, "merge"))
> -		error(_("Merging is not possible because you have unmerged files."));
> +		error(_("%s is not possible because you have unmerged files."), "Mergi=
ng");
>  	else if (!strcmp(me, "pull"))
> -		error(_("Pulling is not possible because you have unmerged files."));
> +		error(_("%s is not possible because you have unmerged files."), "Pulli=
ng");
>  	else if (!strcmp(me, "revert"))
> -		error(_("Reverting is not possible because you have unmerged files."));
> +		error(_("%s is not possible because you have unmerged files."), "Rever=
ting");
>  	else
>  		error(_("It is not possible to %s because you have unmerged files."),
>  			me);

Ren=C3=A9 correctly notes downthread that we shouldn't change this, we have
plenty of these in git now to make these translatable to multiple
languages.

Just a tip that if you are refactoring something like this in that way
and we should change it, this is much nicer:

	error(_("%s is not possible because you have unmerged files."),
	     !strcmp(me, "cherry-pick") ? "Cherry-picking" :
             !strcmp(me, "commit") ? "Committing" :
             [...]

I.e. if we could do your proposed de-duplication we can also
de-duplicate this whole else if chain in favor of a less verbose ternary
operation.
