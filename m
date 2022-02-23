Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC95C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244470AbiBWXiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbiBWXiU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:38:20 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB8D5A099
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:37:51 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d62so734329iog.13
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S5pvdpzUeDr5h43Pta1P6A2rQFRlsl9sLbfazJATgmA=;
        b=Z2REVIxxjSE7xYdPTmvxhKWGyY55ny7moDMxI5lLfmJwUAlfzWEGp3KoQmYf2gFlMH
         BcoC2vNLDQ7r33VeijZ1T5nDUKci3XEZwAFNmdcZYNw82lgqw6ntOPbWDrvJG9cFVrPj
         iRLb3kugsDtgEZXaE+SnIUqbEScXrn1h7ivXoPQte56B35N3a9+CmBbUTjP0DhuOvDnA
         Uu2/7mqMkv7576nl93M6LbStmoSJXnLDJ+qEjhOM5j+Tq9yQJERLsHmrjw7r6kKq4pp+
         1/RvHEG0mhdrT9e8bE8sfuALHhuGV5nT1xvyh+SjnP1CMkgbFh+i9g7b/N2oo6AljNTu
         LWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S5pvdpzUeDr5h43Pta1P6A2rQFRlsl9sLbfazJATgmA=;
        b=znCbrBYcvYWyEHSFpgkrNLcU/w9crTukaqs+sQLuNlqKooAIEryLadRP9aUj2vbR1x
         Kq+1aXH30mu259Y6x7Rul4vWKlMM/LLelZebphH5dI1DMXi7RHW5IfnXKLJQKmGLcmSY
         XD7674D+D8hDMIByE7q9r9IgshH6/PtQElyzAPcEN+DGVXgin+OoQ5BB3qNWrimgyq2E
         h49cPxndRL9c6F/Sc9D9agpSwWu//O/j7BqslRIXHzGcRC1sOtirHbDo1buZIsmCBiLp
         uWOE0dTo81w9rbQcckSAzFQI1ASTmB69BppaXYJ6KHd4t5zZtJ9p2kdneIPVi5dlM8l+
         gUWw==
X-Gm-Message-State: AOAM533e/B86oUS3NE9jFCPz9dWz1SrSmm0c1e+Ix9hI4DJWNjcKU4ox
        jhH4psSDID1yj5qErH82SPSDGA==
X-Google-Smtp-Source: ABdhPJwD9j9+BBt72sy4JGnnuskFAk+PNuUZeFBJQaXJwUMsjRMw6Rqu2AFMU46bok9GFR06aVa3wg==
X-Received: by 2002:a05:6638:190f:b0:314:f5b2:5601 with SMTP id p15-20020a056638190f00b00314f5b25601mr1528090jal.17.1645659470648;
        Wed, 23 Feb 2022 15:37:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s11sm654164ilp.68.2022.02.23.15.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:37:50 -0800 (PST)
Date:   Wed, 23 Feb 2022 18:37:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        peff@peff.net, tytso@mit.edu
Subject: Re: [PATCH 12/17] builtin/repack.c: support generating a cruft pack
Message-ID: <YhbFTYmjdci86oY7@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <a05675ab834ac5e8bc3ab72847b0621a563e0e1b.1638224692.git.me@ttaylorr.com>
 <c9437c89-9258-4034-9886-8a2aec46aa6b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9437c89-9258-4034-9886-8a2aec46aa6b@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Jumping forward a little bit while responding to your review to finish
my train of though before I log off for today...)

On Tue, Dec 07, 2021 at 10:38:05AM -0500, Derrick Stolee wrote:
> > --- a/t/t5327-pack-objects-cruft.sh
> > +++ b/t/t5327-pack-objects-cruft.sh
> > @@ -358,4 +358,157 @@ test_expect_success 'expired objects are pruned' '
> >  	)
> >  '
> >
> > +test_expect_success 'repack --cruft generates a cruft pack' '
> > +	git init repo &&
> > +	test_when_finished "rm -fr repo" &&
> > +	(
> > +		cd repo &&
> > +
> > +		test_commit reachable &&
> > +		git branch -M main &&
> > +		git checkout --orphan other &&
>
> Here is a way to make objects unreachable!

Yes, indeed. And this is the first spot where we *need* to care about
object reachability, because the set of packs that `git repack` passes
over stdin to `git pack-objects --cruft` depends on which objects are
and aren't reachable.

In the tests that exercise `pack-objects --cruft` directly, we can
pretend that certain packs contain only unreachable objects by marking
them as "discarded".

Thanks,
Taylor
