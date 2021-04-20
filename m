Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80F3C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89062613F5
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhDTV2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhDTV2G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 17:28:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35931C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 14:27:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m9so26442220wrx.3
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v0AFnZcdcRDPONa/pEWliiCGWYu3S2DTL8SaLkZSxro=;
        b=id34N6pUpOXiYFrNzWXus4I0CyNxoYbQbY0Zk2zJZ0tIYE/PRa1+WYyWKuvjWieP+p
         rKj2Z42i2ko0q/iy1X0rKP7reuewEvKGQDIrVduGao16TohDB5jbEm8O6kCsoRven5ba
         8o/q4uf/wT3CF3jgupcaykvrQOSaMLX4PvlkU26l6LaWT6vYyKmEHZG/rD9m0pirT/ag
         AXVLGYTCOal1qx4HdpFmDecJ67UrPSVvLAkYJBf6r5nD992SfmS/m5X7B3SG1q9D60fz
         LHn94QwtjGGQCvapyjZEiXPY0qEQ1+2CLB8m2TAIc5F0rmozJZwyV7G3F6psNSIfBKQR
         jatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v0AFnZcdcRDPONa/pEWliiCGWYu3S2DTL8SaLkZSxro=;
        b=Ge6bMQldB3C6ZANGlOzt4QCyPJ5WKcoTeJcRb/dWoS+SvehTvcVo/LQqtGiiEKD53E
         t+gazdqB3S0jLWnXsCOcWJ1fqBQcBrAZGcYSty2yHsSYZZu8QU+c94TVs8xx3/uR0+o9
         p/j/1jQOnsEaeUfGp0CdJivrkC7Xfm1J0S/dLXcBti2C5dluNKJNfeIdAyqBGQ4w1mqN
         pXay/f2Ga9MMUPMsD9U3WrAkYbOK2cswKFRZ9bkhsixIq5mRb1su6ghhcO9TKRUJSjgP
         G6Kh6C6QUTH8PdAD2KhVnFCHQMpJrbJVEi2FfaubfZmaLciCmlC/0sZy/TtvWqfMwHYy
         yF3A==
X-Gm-Message-State: AOAM530pXDJznqRKVS8irLKlTJAKMGLLoxHmLwwXOQdwQIwCDmLP1qWX
        cLerfDkZY2xXQdFtfaGerd8MXkKjRok=
X-Google-Smtp-Source: ABdhPJx16gK9aIGTSqgS8f2NVRH7IJAOnJ5U5DnmYONHtHdGzDLicnAMF/XlThQYHU6BF5se1py5Kg==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr22930875wrn.112.1618954053058;
        Tue, 20 Apr 2021 14:27:33 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id l20sm108445wmg.33.2021.04.20.14.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:27:32 -0700 (PDT)
Date:   Tue, 20 Apr 2021 23:27:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v2 12/12] test-lib: split up and deprecate
 test_create_repo()
Message-ID: <20210420212731.GY2947267@szeder.dev>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
 <patch-12.12-a3e20ef18f7-20210417T124424Z-avarab@gmail.com>
 <20210417154218.GS2947267@szeder.dev>
 <87h7k41t6i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7k41t6i.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 17, 2021 at 11:45:41PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >>  5. Since we don't need to move the .git/hooks directory
> >
> > Since we don't change directory anymore...
> >
> >> we don't need
> >>     the subshell here either.
> >> 
> >>     That wasn't really needed for the .git/hooks either, but was being
> >>     done for the convenience of not having to quote the path to the
> >>     repository as we moved the hooks.
> >
> > And then this dubious explanation will not be necessary.
> 
> Why dubious? That's why we had the subshell-ing. See 0d314ce834
> (test-lib: use subshell instead of cd $new && .. && cd $old,
> 2010-08-30).

That commit doesn't mention hooks at all, so I'm not sure what I
should see there.  OTOH, you did specifically write "use a subshell
instead of keeping track of the old working directory and cd-ing back
when it's done"...  which is in line with our best practices on how to
change directories in our tests in order to reliably change back even
in case of an error.

And that cd-ing back and forth was not added because of the hooks
either, but because back in the day when 'test_create_repo' was
created 'git init-db' could only create a new repository in the
current directory.

> I don't mind rewording or not including some of this verbosity per-se,
> but I wonder why you're honing in on the subshell part in
> particular. Maybe there's something I'm missing...
> 
> The goal of the commit messsage is to point-by-point tear apart facets
> of the previous behavior,

Agreed.

> and assure the reader that e.g. the
> subshelling isn't needed for some other subtle reason.

The role of moving the hooks with respect to the subshell is not a
subtlety, it is simply irrelevant.  And while you are so focused on
this irrevelancy you keep forgetting to mention the factor that
actually does matter: that we won't change directories anymore.


