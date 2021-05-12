Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E57C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A50611AB
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353016AbhELUhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382753AbhELTpv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 15:45:51 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1816AC06174A
        for <git@vger.kernel.org>; Wed, 12 May 2021 12:42:19 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u16so23329272oiu.7
        for <git@vger.kernel.org>; Wed, 12 May 2021 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=IVPoWEvIntZVKqOM1KqAuacBVj1dJgZqqk2FfTBhYfA=;
        b=pN/TJQacnfu8R7AMAtGZ+PUHu4g4VCdI93H6C6INkA8jO+eHpUL5iwL0zeKW2yS/ug
         6e5kbrAtaRm9OtaA748Q/mS54U4wmnuIFPLL8Xdr0hA8AGPDkS02diFNUFOqtsq/iIUY
         cfyb6lCUXRFH1edB1KAQgxqohOSuOY2/Z2VNzhEiQKk7E95xVzYNaebK0O1k+z5F1OLB
         qNkocMyzT5laHVhwzrGMbt3vwUR1fIm8C9nFy3O2AVYR+PRfHQgEV7oKyi1mNf1K0jAk
         dTiBk1WZsV0oEj+3FVkEDxq/zCp4n7Ur5xVpWFSRByNqbhvJg+mE2WQUZkUPyyk0kfj1
         1ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=IVPoWEvIntZVKqOM1KqAuacBVj1dJgZqqk2FfTBhYfA=;
        b=h8KlobPssGpdDz0UdDiERsxBMNeaWqsSUippJ6JwLNWaCImQBHI4JWWzhBVq2iQweR
         qzw1hpcSpm4OwfvLPfOdnEfJgAN8rZ/Y4+umg9V7MOaLu2dTQk0uf05Jklkttx7k6fCp
         d2kFYd34gOkvpwUZdD9NuhMLwsYyPbjHODPXCYXQw8v9VKph2+t9UMkODfa2bZ3Q/wN/
         PX99Py1n5vpg7akSAyzq3kkXFm3RqZQs9WHPSrafLgfbJo3AOGcnObYcdWf7o4bkpuS8
         f57970Hx49UFzZARE4TJj+8dLO40JJHwVpTCmeRD623pAlKNBh7y0UIZc0gvd3LR9c/z
         kqMg==
X-Gm-Message-State: AOAM532fr28JoP5d+XkljH8FvEVbOa6yyR4lc3lV4JCEZfyGK9N18DF5
        cMuvEs9tZumk15YXiOvIhUk=
X-Google-Smtp-Source: ABdhPJz7suZyyDm8xEfNQ38gZhq9RXkOJ2dYVnJXDfmyvUzUFBWYW4eIoEPEclBkA2YB0z1BeHP0+g==
X-Received: by 2002:a05:6808:b35:: with SMTP id t21mr7897829oij.18.1620848538562;
        Wed, 12 May 2021 12:42:18 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id w3sm144025otg.78.2021.05.12.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 12:42:18 -0700 (PDT)
Date:   Wed, 12 May 2021 14:42:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Message-ID: <609c2f98932f3_71bd120840@natae.notmuch>
In-Reply-To: <20210512180418.GF8544@kitsune.suse.cz>
References: <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz>
 <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Wed, May 12, 2021 at 12:32:16PM -0500, Felipe Contreras wrote:
> > Michal Such=C3=A1nek wrote:
> > > Yes, I am not opposed to the change in principle.
> > =

> > Good, so you accept you see nothing wrong with "affect".
> > =

> > > You just failed to provide any valid reason.
> > =

> > *In your opinion*.
> > =

> > In my opinion the problems with the word "impact" have been clearly
> > explained.
> =

> However, you only brought your personal opinion for the case that
> 'impact' is somehow wrong and should be changed.

No I didn't. I used dictionary definitions to explain why it's wrong to
use it the way git uses both as a noun and a transitive verb.

> 'impact' and 'affect' are equally good based on the past discussion so
> you will not bring change based on the 'badness' of 'impact'.

That is your opinion, and its not shared by everyone.

It's extremely disingenious to elevate your opinion as fact, especially
when this is precisely the thing we are discussing.

> You claim that people who do not want to change 'impact' ignore your
> opinion.

No I don't.

I clam *you* pretend other opinions don't even exist.

> Don't you equally ignore the opinion of people who think 'impact' is
> fine by insisting that the wording be changed based solely on your
> opinion?

No, unlike you I acknowledge there's other people with different
opinions.

However, that opinion is that "impact" is fine, *not* that "affect" is
bad.


If you and your wife are deciding what to eat for dinner, and you have
two opinions:

  1. Whatever is fine
  2. I really would like pizza

What do you think you should order?

-- =

Felipe Contreras=
