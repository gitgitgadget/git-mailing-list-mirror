Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A90C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 22:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiEXWM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiEXWM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 18:12:56 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8465DD26
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:12:55 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id p12-20020a9d4e0c000000b00606b40860a3so13174035otf.11
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OC8cb9QO7AUWsbzZryCXzMG7m0ws7DmIVKLxdIsrgBA=;
        b=Xr9lqmjvZjrNVjmP1Kf+K9dHxWwUsnRzQZQxe8eaVTVYb23DlPAaHfq4B5WnRHupem
         VT6aVCAsWm81KEU+Vq+aXDvBYiaNAs+qhwT6SanIq4EfTaNbQhR1cCqEvgUJswnrNnGX
         gtp51MQjnhfeuwToT6Iz7gbiZSHmDqbqW8+P8pJkxG7MDz387jf9aH4gl0oEiM+/cI8e
         0UUO8KLJv0AzzBIuNnbIITHwWdnfWVvD1Z7S+/9b0HL+Mqf2US9Ix/uz3Xzs4SHVIZu6
         9fyFBRKhjgmNELp/+/7/Vu0OSMtanf1CKLHceOKdzyaNOA3IAMrTVv9OLqZ4bE/Rx6Xs
         D9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OC8cb9QO7AUWsbzZryCXzMG7m0ws7DmIVKLxdIsrgBA=;
        b=IpdSfiWj6xC3vedxCeWs5e0HqdiA7luZSaQbcSwamxFgA5a/TnYvOGGtIAVlUWd3HT
         iYTWF2jZ7tT3dM/5l+aJiuOc0m8K0ecENvxveOoOfyQl00CZ0lpM73N8DP5pToFYlA0m
         xnInYAEr7NqLNHvzuWYG/JRsftZrQza9F83aJpuJsqQcj10WRumM82xVxkNGZST26og+
         y3NngHqC2vLGJxUSie5zoPDYNtc9QZdwhiokqZeAzJcL/60fDSdF2AUl9wJ9nnyKBn6U
         eNZYTMDM1eFLI6LSSfQJLqw1BClA9uVQvHUhWV4yd6O2jJj2HLGs7rFSc9T+Oci3/0jT
         5niQ==
X-Gm-Message-State: AOAM531eSSX1rXXS3K058j7E8jGNxH4gXv7FkVB5lZ1eMjXHjBZMpwSy
        w3J5rjKfTiQygpscvFv5Pavu9w==
X-Google-Smtp-Source: ABdhPJwI9IPcQwe+Q3XTmHb4wDkDL/LLEa4wVN+B38aQ2ve4xZpNLBlZ3Z6uAS7ehLmjDhfOaXLfBw==
X-Received: by 2002:a05:6830:4c3:b0:60b:2c2a:7d4b with SMTP id s3-20020a05683004c300b0060b2c2a7d4bmr907635otd.371.1653430375181;
        Tue, 24 May 2022 15:12:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n3-20020acabd03000000b003264a325ecdsm5574904oif.5.2022.05.24.15.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 15:12:54 -0700 (PDT)
Date:   Tue, 24 May 2022 18:12:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 00/17] cruft packs
Message-ID: <Yo1YZM2dI6t+RsWv@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <220521.868rqv15tj.gmgdl@evledraar.gmail.com>
 <Yo00X0NEu8N0MnZV@google.com>
 <Yo1TIQqvlxhvLZ58@nand.local>
 <220525.86sfoytwjn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220525.86sfoytwjn.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 11:55:02PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, May 24 2022, Taylor Blau wrote:
>
> > On Tue, May 24, 2022 at 12:39:11PM -0700, Jonathan Nieder wrote:
> >> Ævar Arnfjörð Bjarmason wrote:
> >> > On Fri, May 20 2022, Taylor Blau wrote:
> >> > 	On Mon, Nov 29 2021, Taylor Blau wrote:
> >>
> >> > 	> +static void write_mtimes_header(struct hashfile *f)
> >> > 	> +{
> >> > 	> +	hashwrite_be32(f, MTIMES_SIGNATURE);
> >> > 	> +	hashwrite_be32(f, MTIMES_VERSION);
> >> > 	> +	hashwrite_be32(f, oid_version(the_hash_algo));
> >> > 	> +}
> >> [...]
> >> > 	But since this is a new format I think it's worth considering not using
> >> > 	the 1 or 2 you get from oid_version(), but the "format_id",
> >> > 	i.e. GIT_SHA1_FORMAT_ID or GIT_SHA256_FORMAT_ID.
> >> >
> >> > 	You'll use the same space in the format for it, but we'll end up with
> >> > 	something more obvious (as the integer encodes the sha1 or sha256 name).
> >>
> >> Agreed.
> >
> > I know we recommend using the format_id for on-disk formats, but I think
> > there is enough existing uses of "1" or "2" that either are acceptable
> > in practice.
> >
> > E.g., grepping around for "hashwrite.*oid_version", there are three
> > existing formats that use "1" or "2" instead of the format_id. They are:
> >
> >   - the commit-graph format
> >   - the midx format
> >   - the .rev format
> >
> > Moreover, I can't seem to find any formats that _don't_ use that
> > convention.
>
> It's used in the reftable format.

Ah, thanks for pointing it out. Still, I think there's enough uses of
"1" and "2" over format_id that I'm not convinced here.

> > So I have a vague preference towards using the values "1"
> > and "2" as we currently do in these patches.
>
> I suspect that's less "vague" and more "c'mon, I'm using it in
> production already" :)

No, this wasn't a veil over anything. Yes, GitHub is using this in
production already, but that isn't why I'm opposed here. I'm opposed for
the reasons I explained in the quoted bits (and would happily carry a
small amount of custom code in GitHub's fork to continue to recognize
the "1" or "2" values if this ever changed to use format_id).

> Anyway, I'm fine with leaving it be as you have it currently. I'd first
> encountered this magic with reftable I think, and only recently found
> that we use 1 and 2 in these other more recent places.

Sounds good. Unless others have a very strong opinion, let's leave it as
is.

Thanks,
Taylor
