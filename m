Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4F2C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 14:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239046AbiD0PAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbiD0PAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 11:00:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD19232D
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 07:57:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x18so2943576wrc.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YvQOiQJIJUYIa0xizD/ML9gGr9StIzvdnMWEXW1iK9c=;
        b=Q6MreQri+adYrgjF87sriFzBqOrbptwbOgzWmvPNQTcXB145Pv7kqwWE5gcJZylWUl
         oZNh9hdOjAm5nj7ks/fGKIF/S7oeG0BhZ0k3BV664NMM8QLSHds6FnOM9z648vOZK4ps
         Op7V3AFmbzUmCuNe4cdvpNHPp8qqaYzpRCjrXlVccKDlNv52JSpDPzyZPO8KzREFx35D
         O1US986wDQdIL3dPdgbdcyWW2A1UzHE5P44V83pTJCdXg+pnrjcha5NIhgtdFo+OznVb
         l+c5Si/+rhd+2Ulg+7IDADdWjh++mlL2I2ZVnEF9fbceYldT65/EThACH2Lz3Mel+LV7
         OgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YvQOiQJIJUYIa0xizD/ML9gGr9StIzvdnMWEXW1iK9c=;
        b=gWMUIOXqMf36N+GnU9Omit4qvnsncLPUrUOhla0pNe6yULYoKn+2W0xVB+l4FZCqCP
         CNJWkO0+mw9a/LTnhzrn7VXwbELZmMXgpxkrFVzv3Mo9uKn2bmCVof3H9zNHPTfL8JFw
         R4bDxxNgAwsdUnmE7rzdwP+pkeSHoTvvL/w2sB9MCge4bnDLDGgwM9+grEyB13Qv0SIQ
         oalNoPsXvstuwJmRbAsYtn8lgOsGK09MEqDjSj2wG/wY5sT22SekngBesGiuKGJhEedQ
         HxP7Tw2XqBepFZs+KoQcRZBdUzOqeZ1GWsgJg3pdSw2Urp4u7sPt0bj+OEBxnATA5vkp
         xjIw==
X-Gm-Message-State: AOAM5307cRqa/S+Fvfj5L22WXvOeX5u0Rto01PCuI8bL+Q+PR8M/l/V/
        i4yeqaYAc0xCuVTqcmOk4Us5fRrAPzA=
X-Google-Smtp-Source: ABdhPJxipAqaMsXmhvHm9JCqvXOb2xDPIS2hmkFiJZG85CmS4MqlO25KDN4npE/kAY+9S5YWChb5lg==
X-Received: by 2002:adf:fd4a:0:b0:20a:cee3:5abf with SMTP id h10-20020adffd4a000000b0020acee35abfmr19234214wrs.522.1651071441924;
        Wed, 27 Apr 2022 07:57:21 -0700 (PDT)
Received: from localhost ([2a02:2149:8ba4:e400:b4f9:19f2:e54:30c8])
        by smtp.gmail.com with ESMTPSA id m4-20020a7bcb84000000b00389efb7a5b4sm1725897wmi.17.2022.04.27.07.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:57:21 -0700 (PDT)
Date:   Wed, 27 Apr 2022 17:57:11 +0300
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        matheus.bernardino@usp.br, mhagger@alum.mit.edu
Subject: Re: [RFC PATCH 4/6] dir-iterator: iterate dirs before or after their
 contents
Message-ID: <20220427145711.uwoa6n7kgq4okgr7@compass>
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-5-kioplato@gmail.com>
 <b75aaee8-c037-e8e0-6ee0-729922059352@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75aaee8-c037-e8e0-6ee0-729922059352@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/04/11 02:31PM, Phillip Wood wrote:
> Hi Plato
> 
> On 10/04/2022 12:18, Plato Kiorpelidis wrote:
> > Introduce a new feature to dir-iterator, using dir_iterator_begin()
> > flags parameter, allowing to control whether or not directories will
> > appear before or after their contents.
> > 
> > The new default behavior (i.e. flags set to 0) does not iterate over
> > directories.
> 
> This is introducing two changes at once adding the "AFTER" flag and changing
> the default behavior. I think it would make sence to separate those into two
> separate commits. You could change the default adding the "BEFORE" flag and
> adjusting the existing callers first and then implement the "AFTER" flag in
> a second commit.

Nice, I'll split this commit into two, like you suggest.

> It would also be nice to see the "AFTER" flag being used by changing
> remove_dir_recursively() for example.

I'll make use of "AFTER" flag to convert remove_subtree() function in entry.c
and include the conversion in v2.

Tackling remove_dir_recursively() will come later.

Thanks Phillip,
Plato

> Best Wishes
> 
> Phillip
> 
> > [...]
