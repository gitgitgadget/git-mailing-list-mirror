Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F7BC7EE23
	for <git@archiver.kernel.org>; Tue,  9 May 2023 20:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjEIUNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 16:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEIUNf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 16:13:35 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199892102
        for <git@vger.kernel.org>; Tue,  9 May 2023 13:13:34 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9ef06cb784so8181520276.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683663213; x=1686255213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9XoJTze7YgZPDtDyL5G7zEQqV0SWyJGe1IMI+NEgv4=;
        b=XkKFctjdNkSivZr44qkiPy2gMIwxtgAaQQEsjwIU6TGeRKizkJbZpGF1MBqOixTnLB
         lDw8jIv9sy3jLhkgAM+at7GqebIoNrg2bJ1CoCxvX371CftIp//Mwkk8LhPDwqZLD6qE
         hzo2ldYlPHqA39sexyZEifbFoysg36QOMM+AuiMz82siS3O4vhA0TH7tRzHFRtcGSR0d
         oPuYuRB69zlB4k9NlbgizuIAmFiP6w+wqqICrTgZ3/dmZHDeowca3d8JjeBrPsdEwkUF
         8N/OcVBAcFFfwJblwE8KWlNotk5tUNhJgNyXdiWEYQiY+XRv1ub1/qTgmoFRI2CqFLA/
         IwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683663213; x=1686255213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9XoJTze7YgZPDtDyL5G7zEQqV0SWyJGe1IMI+NEgv4=;
        b=KUPlsVUnZwYm6WauobwMOAsX0wgDmDPyQ6pS+Faaqsk71xRISSVBYWMGjgEbsoNCvZ
         Qldn1mwI5Bu+MZkk/RWGYc36IRHHgzDbcyf95ClL5DGbqZ9GSXPS/DljZOFOf5R/PAbZ
         kAZXYjEEQE0UkskChnis168f5Cc91zkEaHhxL1/zsLKKqbnSETWoU18lY7gIcEA9ECBC
         Le+cq39IanEg467jYb4jx6/u9KMPO4iYDAqNeWfrAxuMw4d78jWsXH1F92pUJl4lEUkx
         sdh5qvBf0yfbIWlF1BWSXfGG8nPs3d5O1jGGm48JlfZz87viBQklwNHRlWCAcPh4ImiH
         NwsQ==
X-Gm-Message-State: AC+VfDxVP21CG4RXpnMNAsUA1AL4elRG25g34lZe4p5pTWCogqJ3E/PG
        5SPG5uBa/OFZ8fkXDwPoIh7FNg==
X-Google-Smtp-Source: ACHHUZ6kmENhAjcnRZPV88YBoCRsafjEoQFiqap85THE1z/8ipPhxyDNC0MwomwbQIxNn3HnN4Vxbw==
X-Received: by 2002:a05:6902:723:b0:b92:4703:8cf5 with SMTP id l3-20020a056902072300b00b9247038cf5mr20273077ybt.50.1683663213237;
        Tue, 09 May 2023 13:13:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u9-20020a252e09000000b00b9d255709f9sm3184853ybu.2.2023.05.09.13.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:13:32 -0700 (PDT)
Date:   Tue, 9 May 2023 16:13:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 05/15] ref-filter.c: parameterize match functions over
 patterns
Message-ID: <ZFqpZrwiKARsM53t@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <c54000f5f5122c4ca3ac9b16828a8fd77050768c.1683581621.git.me@ttaylorr.com>
 <xmqqmt2e4fia.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt2e4fia.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2023 at 03:36:45PM -0700, Junio C Hamano wrote:
> > @@ -2132,9 +2133,10 @@ static int match_pattern(const struct ref_filter *filter, const char *refname)
> >   * matches a pattern "refs/heads/" but not "refs/heads/m") or a
> >   * wildcard (e.g. the same ref matches "refs/heads/m*", too).
> >   */
> > -static int match_name_as_path(const struct ref_filter *filter, const char *refname)
> > +static int match_name_as_path(const struct ref_filter *filter,
> > +			      const char **pattern,
> > +			      const char *refname)
> >  {
> > -	const char **pattern = filter->name_patterns;
> >  	int namelen = strlen(refname);
> >  	unsigned flags = WM_PATHNAME;
> >
>
> These hint that we'd eventually lose .name_patterns member from the
> structure so that we can pass pattern array that is not necessarily
> tied to any instance of a filter?

Right. We'll pass in the excluded patterns in the next commit.

> And we are not there yet, so we hoist the use of .name_patterns
> member one level up to the only caller?
>
> Without seeing how it evolves, we can tell this does not make
> anything break, but we cannot tell how this helps anything (yet).

Hmm. I tried to allude to this in the patch message with the paragraph:

    The subsequent patch will add a new array of patterns to match over (the
    excluded patterns, via a new `git for-each-ref --exclude` option),
    treating the return value of these functions differently depending on
    which patterns are being used to match.

    Tweak `match_pattern()` and `match_name_as_path()` to take an array of
    patterns to prepare for passing either in.

...but I'm happy to add detail or clarify it if you think that these
paragraphs could use it.

Thanks,
Taylor
