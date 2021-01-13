Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564EBC433E9
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 19:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243FF217BA
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 19:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbhAMTPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 14:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbhAMTPi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 14:15:38 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF626C061795
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 11:14:57 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id p14so3460632qke.6
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 11:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VsSN1CzZSufgMbbB6GLAxCSPhq+MNfuXwi1ekys+vyU=;
        b=LqNy1V4VXJuONuZeDswqZpxrCjkHe3gQ8PK9ZRnEI44Vy+x/4x7SGxfUXea/EoDv4j
         w3Q24uBSzeSazQfbWwjE+GPDuYECs8mWhQHFgJ+fu3B9Nf+ZNGeOf/1rmAUz03ceSlsv
         +3wdOAguJRoletvcL4VBrGyJDUjak7LAFEMAH3OXiJYiPZa2iB2tguQV8xfoTbApt/01
         oIYF0P0VsP3tnpskuaGMsOApt3SljcCfid8Nx9LMy72Pu2yFhpyEOBQSgIhPg0pAaq6N
         sRxXq9Y3gdoCDIut6wVwgWXUTep9dzcNYDCmcVTQR7veYK/vKJJN+XscOnc0uuiYRoZp
         YaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VsSN1CzZSufgMbbB6GLAxCSPhq+MNfuXwi1ekys+vyU=;
        b=P5RhpYQnlXRh8rAulvOAWHCwmUyw+mbU99chP/ExdgCK/hPWolELESUJ7r7JHkZIW8
         eQcLLwxW4iGH36dx1etT049mS5va5jArn7TvGJwZkmQTKrrk6ofDI+EQBi/A+5ooWECW
         241Dm4XJRw19hvYU7lI/NK1MjWUJ3JrM22+YXFsId1S787/VxS5yzi+Xg78EORBtF1Ul
         f9oamQyocLBw1eN2v1PTxxhl3QYsMOntCkk6r1XnLsYRF9cxrv67ohVYRI0HW5GoFeDa
         qB/gchiM/JVZ97eXFcVxOjzU29qnkdKNqBGQZUN6hyOoCBMm18guPld27j9+tyqY+8lX
         tL3w==
X-Gm-Message-State: AOAM530URaG2KMW0zVttDSWJmeAZ9w5v++5CQ+guwHGx6j+iogfwTMsi
        4gDzAto/UndtnfbjPmfjMmjBAS07LxLJkg==
X-Google-Smtp-Source: ABdhPJyQkM/DGfeD3/URybo0lcc5ghpD5mvFR3VT9Y2nRZpQ6P5bnHzeg3XIPux8JTqWfXRZj7asqQ==
X-Received: by 2002:a37:6744:: with SMTP id b65mr3527102qkc.199.1610565297022;
        Wed, 13 Jan 2021 11:14:57 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id p6sm1517882qtl.21.2021.01.13.11.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 11:14:56 -0800 (PST)
Date:   Wed, 13 Jan 2021 14:14:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood@dunelm.org.uk, Johannes.Schindelin@gmx.de,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 5/9] sequencer: use const variable for commit message
 comments
Message-ID: <X/9GrVjBmnJUZcGn@nand.local>
References: <20210108092345.2178-1-charvi077@gmail.com>
 <20210108092345.2178-6-charvi077@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210108092345.2178-6-charvi077@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 02:53:43PM +0530, Charvi Mendiratta wrote:
> This makes it easier to use and reuse the comments.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
>  sequencer.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index cdafc2e0e8..b9295b5a02 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1736,6 +1736,15 @@ static size_t subject_length(const char *body)
>  	return blank_line ? len : i;
>  }
>
> +static const char first_commit_msg_str[] =
> +N_("This is the 1st commit message:");
> +static const char nth_commit_msg_fmt[] =
> +N_("This is the commit message #%d:");
> +static const char skip_nth_commit_msg_fmt[] =
> +N_("The commit message #%d will be skipped:");
> +static const char combined_commit_msg_str[] =
> +N_("This is a combination of %d commits.");
> +

Two nit-picks here. The line break after the '=' is a little awkward,
since two of these lines are less than 80 characters combined, and the
other two are just slightly longer than 80 characters. The other nitpick
is that its typical to see 'char *foo' instead of 'char foo[]'.

So, I'd write these as:

    static const char *first_commit_msg_str = N_("This is the 1st commit message:");
    static const char *nth_commit_msg_fmt = N_("This is the commit message #%d:");
    static const char *skip_nth_commit_msg_fmt = N_("The commit message #%d will be skipped:");
    static const char *combined_commit_msg_str = N_("This is a combination of %d commits.");

I also noticed that you suffix these with _fmt or _str depending on
whether or not there are arguments that get filled in later on. That
makes 'combined_commit_msg_str' labeled incorrectly (it should be
'combined_commit_msg_fmt').

I'm curious to see where down the road these messages will be used over
again, but I'm sure that that is coming in subsequent patch(es).

 static void append_squash_message(struct strbuf *buf, const char *body,
 				  struct replay_opts *opts)
>  static void append_squash_message(struct strbuf *buf, const char *body,
>  				  struct replay_opts *opts)
>  {
> @@ -1745,7 +1754,7 @@ static void append_squash_message(struct strbuf *buf, const char *body,
>  	if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
>  		commented_len = subject_length(body);
>  	strbuf_addf(buf, "\n%c ", comment_line_char);
> -	strbuf_addf(buf, _("This is the commit message #%d:"),
> +	strbuf_addf(buf, _(nth_commit_msg_fmt),
>  		    ++opts->current_fixup_count + 1);

This and the three below uses are good, since they still translate
these messages. Nice.

Thanks,
Taylor
