Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2061BC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 22:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353968AbiETWwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 18:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiETWwp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 18:52:45 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28840A88BB
        for <git@vger.kernel.org>; Fri, 20 May 2022 15:52:44 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id k8so8225333qvm.9
        for <git@vger.kernel.org>; Fri, 20 May 2022 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WLpSHLoWQcHR/C7lF8yuOjyK4A0DN+v8cYrUww5VUS4=;
        b=IANkljYVQ5eC2qZc2d9u7IuyERRm/U7zksuzmTwQh4ZKSJsRdYoBuHF2plVcrhjvNF
         z8Pbf3Gavsdt5Hcbeh7N0kq/cPXSVM18VEablt+SSbvt4Ji6D0KMUToPeO+SRYvTYILm
         GyqMQ/QOD/j3hzCOeLxMdiSjBSanbbD0lM0qqlK4Ho/MYXkuw/iO/3W1E8niM5/oyUqi
         wrDKriI3jpvyQElQeJGeBt0wfc7Q/3gZu9GSYpxX4rYyUuXAZ/5oYB/xyNntgb/jIHUS
         5kagFEgT55S2EpdgChhc8xBSM6ymiumxauyob17w1qs7T16gGnXrYa4soMPgLCRhAjST
         1YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WLpSHLoWQcHR/C7lF8yuOjyK4A0DN+v8cYrUww5VUS4=;
        b=N40m1KA95QE+iO8s3WSREJH5qgYGz8XiabWuHXnQglPDLCEwLYBhGS0ESRJlM5l5Gn
         FdEYUCuLG6+eO9OTq9QdK4Y2zSDJQn6v0wXTOTjhqmLf9FCWC2uKXcsf5wwawawZJWr9
         1JFFOS7xGpYrbtOini28dapEEScDE6313NqyOzf8PTDkL0zGg9lpbA8nEQ9y7K9MJs9X
         j8Nu7FygMxDYS5bKTDf03PO6QAjcvPy7XdlRkuONo7zDyiK7yo45UInBvZCM042Vbec1
         jNJpW5u/l/ZIXPG/9BkranNC0IbuCtzLf9GQq8bmyiCMCY7/jc3jdtX5jDQTcrNhahEq
         99Hw==
X-Gm-Message-State: AOAM533Xw9ZQjQ4B930Nud6tVUn4vmF7vcLBWOIcCmXOInDyyHAzXvZK
        t57G5jbuKRTZ2AquTKBxes+Zug==
X-Google-Smtp-Source: ABdhPJykIbGV5ZtemPyp7sJA8wcIv1ngElVeYFQxiP6NbhajTEcTYbpFm0UYTYtLCpE9VFjnJ6sQnw==
X-Received: by 2002:ad4:4e31:0:b0:461:c420:fed0 with SMTP id dm17-20020ad44e31000000b00461c420fed0mr9595144qvb.14.1653087163321;
        Fri, 20 May 2022 15:52:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 4-20020a05620a06c400b0069fc13ce21esm386693qky.79.2022.05.20.15.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:52:43 -0700 (PDT)
Date:   Fri, 20 May 2022 18:52:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 08/17] builtin/pack-objects.c: --cruft without
 expiration
Message-ID: <YogbupkkDSysm6Yw@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
 <94fe03cc65716b6102e2d71df49d4ae5a1a60dc7.1652915424.git.me@ttaylorr.com>
 <xmqq7d6hsusd.fsf@gitster.g>
 <xmqqv8u1r1r2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8u1r1r2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 19, 2022 at 08:16:49AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> >> @@ -3870,6 +4034,20 @@ static int option_parse_unpack_unreachable(const struct option *opt,
> >>  	return 0;
> >>  }
> >>
> >> +static int option_parse_cruft_expiration(const struct option *opt,
> >> +					 const char *arg, int unset)
> >> +{
> >> +	if (unset) {
> >> +		cruft = 0;
> >> +		cruft_expiration = 0;
> >> +	} else {
> >> +		cruft = 1;
> >> +		if (arg)
> >> +			cruft_expiration = approxidate(arg);
> >> +	}
> >> +	return 0;
> >> +}
> >
> > It is somewhat sad that we have to invent this function, instead of
> > using parse_opt_expiry_date_cb().
>
> I failed to mention that this one does more than the bog-standard
> callback so the latter cannot be reused as-is, and that is what I
> meant by "somewhat sad".  If we can find a way to reuse the
> parse_opt_expiry_date_cb() for the purpose of the user of this
> function that would be ideal, but only if we can do so without
> making the caller too unnatural.  Having two separate values, "did
> we get --cruft-expiration option?" and "what's the value of it?",
> does benefit the current caller and we do not want to twist it just
> for not adding a similar callback---that's a tail wagging a dog.

I agree, though I'm not sure such a cleanup is possible: if the caller
specified `--cruft-expiration=never`, how would we distinguish that from
"the caller did not want to generate cruft packs"?

In that case, approxidate() would set our `cruft_expiration` variable to
`0` there, which makes "generate a cruft pack without expiring any
objects" indistinguishable from "do not generate a cruft pack" without
the additional bit of information stored in the "cruft" variable.

For now we're just recycling the pattern from the callback immediately
above this one: option_parse_unpack_unreachable().

Thanks,
Taylor
