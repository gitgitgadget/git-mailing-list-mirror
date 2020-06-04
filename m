Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C36C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66B4204EF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="bWBBPH5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgFDRpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbgFDRpq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:45:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37FEC08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:45:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s88so1512796pjb.5
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+GWMGUMfXGyPmWKF8GX082+oaWaxusXMJKKLoSEEEDs=;
        b=bWBBPH5g2OfEnjgj7mdo0deAegbtX9w1Ol/v+gURzywL7YATYyZCt4mvHGrpb6bXrY
         i0VqbgB5drKrn8BCsngQkqjH8yFc11CRKUA+VCLp2oQN57Vr9Y46jrveS6rlDWGtBim5
         4r3P/JOmepxwYqsZiUU9Kxn/Eca47sGKJgoNmHKlz7yi7srw/6M16aQ/2eH7YiiR1opu
         nSW3xUAIgNmT1sDlIvks50y7Sbmmpux1J31JDidKqXS5PeA05wFDkllHfSrR2T6IGQml
         nBpghsCs8sxCtqLKT6IcoW4L/S5oPSKVLVlXg0yVrlwPtjhXVCdl9b4XMzCBlJ0QBaxj
         MR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+GWMGUMfXGyPmWKF8GX082+oaWaxusXMJKKLoSEEEDs=;
        b=WQSYIEOzOqwMjKPzbAt3OQ1PUsAVTWOIZpeRHd8NpMZRuGR2ho10U+sFXItpVZZmPE
         G2IXE0ryHGyuDrO8j1cEiD0KBkZ2w84gel6/xucKCx/RUUxe4BsnJkhgsytIewjtfJ4U
         rctfsrREPraejXcPpMHdqjeHcQhNlFb9n025OrSyiCybx1A+efAw4kn8z1m7EptNlpNx
         +v6CTtXWoGmbJw2fykWd+5OzhaDHPojfbrwLfM0hB+BuOZiiZHJXtDtI2F6YAceB2cEr
         8kKpvP+ZdD7NBREz6+a4/h89yE0xGPptDfZEB1bRILf/Y7ECcftFRaC6BbpDVZF/md0J
         tD2g==
X-Gm-Message-State: AOAM533msGRiYuq3lFsA9q1RGji4Co9rT+njMXaPkcqIvM48WyDXhqAI
        NmlRFzkmcwn2PlkQRtNHnECqy6RVZsk=
X-Google-Smtp-Source: ABdhPJwCcDyzc0RNJdNLz1N0sAtpXffehjYKNpq5s2kzkQOwkusbm+OS9+tnyZhWqoVJ5P3uklbopQ==
X-Received: by 2002:a17:90a:648b:: with SMTP id h11mr7106893pjj.59.1591292745081;
        Thu, 04 Jun 2020 10:45:45 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h15sm4735454pgl.12.2020.06.04.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:45:44 -0700 (PDT)
Date:   Thu, 4 Jun 2020 11:45:42 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jonathantanmy@google.com, gitster@pobox.com, newren@gmail.com,
        Jay Conrod <jayconrod@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
Message-ID: <20200604174542.GA58239@syl.local>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
 <20200603034213.GB253041@google.com>
 <20200603045248.GA20266@syl.local>
 <20200603051631.GA20678@syl.local>
 <20200603205151.GC253041@google.com>
 <20200603221453.GA36237@syl.local>
 <20200603230611.GA1925@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200603230611.GA1925@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, Jun 03, 2020 at 04:06:11PM -0700, Jonathan Nieder wrote:
> Taylor Blau wrote:
> > On Wed, Jun 03, 2020 at 01:51:51PM -0700, Jonathan Nieder wrote:
>
> >> --- i/commit-graph.c
> >> +++ w/commit-graph.c
> >> @@ -149,7 +149,8 @@ static int commit_graph_compatible(struct repository *r)
> >>  	}
> >>
> >>  	prepare_commit_graft(r);
> >> -	if (r->parsed_objects && r->parsed_objects->grafts_nr)
> >> +	if (r->parsed_objects &&
> >> +	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_parent))
> >
> > This is a little tricky. Why would we set substituted_parent without
> > also incrementing grafts_nr? That seems like the real bug here: if we
> > incremented grafts_nr, then we would return a non-zero value from
> > 'commit_graph_compatible' and rightly stop even without this sticky-bit.
> >
> > I don't quite understand this myself. If it's an oversight, it's a
> > remarkably long-lived one. Do you have a better sense of this?
>
> The idea here is to check for two different things:
>
>  1. Do we have grafts (either from a grafts file or from a shallow
>     file)?  If so, this repository is not commit graph compatible
>     because we could encounter one of them.
>
>  2. Have cached parsed objects taken any history modifications into
>     account?  If so, this in-memory state is not commit graph
>     compatible because we could encounter one of them.

Ah, breaking it up like this makes it clearer. The gist is that it is
possible to generate a situation which has (1) no grafts explicitly, but
(2) *does* have history modifications.

> The check (1) might seem sufficient if the set of grafts is constant
> for the lifetime of a git process.  But since 37b9dcabfc (shallow.c:
> use '{commit,rollback}_shallow_file', 2020-04-22), it is not constant
> for the process lifetime, so we need the check (2) as well.
>
> We might want a similar check for replace refs as well some day, but
> not today (there is not a way to remove entries from replace_map
> during the life of a process).

Right.

> I can try sending a proper patch with commit message and tests
> tomorrow morning (or if someone else takes care of it, that's fine,
> too).  Thanks, both, for your help --- it was nice seeing a clear
> explanation of the cause already figured out and explained when I woke
> up.

If you are interested, by all means -- I'd certainly be appreciative.
I'm on vacation next week, and so it may be better if you are able to
shepherd the patches through. Otherwise, I'd be happy to do it the week
after when I get back.

> Regards,
> Jonathan

Thanks,
Taylor
