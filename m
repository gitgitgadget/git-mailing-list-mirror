Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D53C77B7E
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 19:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346433AbjD1TDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 15:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344155AbjD1TDA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 15:03:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FBC1BE7
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 12:02:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b8b19901fso416605b3a.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682708579; x=1685300579;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VP6S/96ZkkOJdcJkD/HQJiYzAJQ3p/HH3nduNGu5Vg=;
        b=fByb3ctrow49QveyIysTAkFdXtHaIE643twJi2kY90btTut8TmMxOJldZx2obTUuID
         CDlwU/8kDAd6UxJUl7d2JhMBi2wLouHpXavSk/OihlfWc4XTvxs/fHITNm61/OcvxbAY
         IzqnhT5wOreXIqLREPhLdS90KuDsUmAy0B3t0ZAdsuwyzBOjviINtlRFRFuM+bKumXe9
         yY+d/QnPpu4os10i7sqeZLHaJd9Gi3sqcckdm00J2vhy4JuXUGCkmVPrS2w7w/yYBpqB
         b11q2iV2BY0dTZupQ+ysYzVVDOsF0ulDK6E26i73alrAdgSbcDFsJmL8+JCX5bAUQQ41
         v+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708579; x=1685300579;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6VP6S/96ZkkOJdcJkD/HQJiYzAJQ3p/HH3nduNGu5Vg=;
        b=kQMH+9rZor9uDmz7B7HModfcwbfP6Vp7w5NsmyKrhaCCNDDftmKY19qyL8yFN8WaTj
         dd1n+oXWDbSEN07CmZc0Bz77EyXL6PhblcHUyDFtHNmOYYLCSPo1OOdQSNybQNKw7UbB
         buKJ0KE59vVqfPqLZAgPRCfxfUjzMmzDT0SGSm7saop5UDizY+CAjYhGHmc+aLJ2+59m
         8GY2588qiRobgnl0Oe52WN0bNMAz5M3344i6y38/c3Wy+GH6LVFUaZ9cGeDCCCPiZ/UG
         txm25h31wFSxA7ZERy0iphsfVS6jVPKug+Tn225JAdjBxaxXvGlOyRc/3z9UG0v2j8zT
         4Rmw==
X-Gm-Message-State: AC+VfDy+/H72Cl5qyJXvUlzm3nsEtXP+5yMrdl1DGXqZdI0o2ueT/lLj
        llBFMZ8LKsYKxJpbHwXG1RA=
X-Google-Smtp-Source: ACHHUZ5MHeXCX4ylgkdzM4DpaYID7ZVTIU8zcZsKyxn3HUK+uGH3raNVPuGdc/3lOWkVEI9iHR5Q1g==
X-Received: by 2002:a05:6a00:2d84:b0:63b:e4:554 with SMTP id fb4-20020a056a002d8400b0063b00e40554mr10722914pfb.4.1682708579180;
        Fri, 28 Apr 2023 12:02:59 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78494000000b0063b7c42a070sm15540492pfn.68.2023.04.28.12.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:02:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sequencer: actually translate report in do_exec()
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
        <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
        <20230428125649.1719796-2-oswald.buddenhagen@gmx.de>
Date:   Fri, 28 Apr 2023 12:02:58 -0700
In-Reply-To: <20230428125649.1719796-2-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Fri, 28 Apr 2023 14:56:48 +0200")
Message-ID: <xmqqcz3nde3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> N_() is meant to be used on strings that are subsequently _()'d, which
> isn't the case here.

Good eyes.

>
> The affected construct is a bit questionable from an i18n perspective,
> as it pieces together a sentence from separate strings. However, it
> doesn't appear to be that bad, as the "assembly instructions" are in a
> translatable message as well. Lacking specific complaints from
> translators, it doesn't seem worth changing this.

True that we frown upon sentence Legos like this.  At least the
original message in C locale does not break the flow too badly, so
hpoefully all the supported languages are happy with the existing
composition.

Will queue.

Thanks.


>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> Cc: Junio C Hamano <gitster@pobox.com>
>
> ---
> v2:
> - mention the word puzzle in the commit message
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 3be23d7ca2..0677c9ab09 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3628,7 +3628,7 @@ static int do_exec(struct repository *r, const char *command_line)
>  			  "  git rebase --continue\n"
>  			  "\n"),
>  			command_line,
> -			dirty ? N_("and made changes to the index and/or the "
> +			dirty ? _("and made changes to the index and/or the "
>  				"working tree\n") : "");
>  		if (status == 127)
>  			/* command not found */
