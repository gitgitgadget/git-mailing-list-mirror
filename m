Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F729C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 20:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjCHUsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 15:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCHUsE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 15:48:04 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95AC14986
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 12:48:01 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id bf15so7308638iob.7
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678308481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6GWQFf+F9JbmsLKjadC5GIMzgo241njZiYLNsiifgY=;
        b=J78k0DwycxGuIAS7Cey4boq7tVikWUnL//eVSFynTrWvVCjxF05xWl/5QsOCiEIfwV
         Tj19YiMcXVTmGoKJLbnXGZeSYj1i4opi0KJ3YqMJlWfS8EKt/D/GoQAUQ5i4Qz0iOE+5
         MtTZ4/j5i0C0zYiEKof0x7IKX6/pE6jK1fM2u+K5ActuqB+xx7KrvABthT1VZDvl6hh0
         fw/HDgc+bzSmztRRmoLVSdsSGkAAy43ZGBWTZBcAVwbc7T8H5PNaIgtWbXw53MwBwFMT
         ChRvNvPal899OKp2Bec2KwJnVn8r1uSmUqW1StarPkY5OjmeqP1LvlfpPAqqvsk6iu0W
         yyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678308481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6GWQFf+F9JbmsLKjadC5GIMzgo241njZiYLNsiifgY=;
        b=t5/OfLm5fWj+1z1vvEhkZ25z0Ie1rVo5Wg8Ke4eRFpYkrwBCDzeosWaKm9U4yngpVa
         oj71vHf8mJwJaS2dM56jU/SmuYgsfJyXOa2F0xONnpe+qdjCoquo0leVYL8nel8RtsZ3
         PN/mBxHYV7cX8d3vKFtkb9O/GR8ATDV/uMH7RGxWb1Kibpv1w7wp4VcWJQCRy3frOBF6
         hBI/Yd6/esJwwkLvm+vd8uGSxkvGrbioRKnDqgHxgyysF8y8bT/3hnvEQo0K3JHKMkie
         99DmmbvplpimgIgIQfmJesAUK/BmMDGQ17IohprS9edWKxN7FCxpVw2BByN+laX5rbs2
         3DLg==
X-Gm-Message-State: AO0yUKXVn19cHMG1TyL3mOEYY6HMNTlO1ueQ43sixAMdvCFsLIFbwEn6
        pvCsHMj4rAo2AgC207ZwJR2yDg==
X-Google-Smtp-Source: AK7set+B+EbXQBOKhAicNo3pLSBEDqUwnZHXvhYOBb6svz6RC8KJboOMXk4QtN4xj/DBstbPtoApgw==
X-Received: by 2002:a6b:6006:0:b0:734:e7c0:2058 with SMTP id r6-20020a6b6006000000b00734e7c02058mr410908iog.9.1678308480963;
        Wed, 08 Mar 2023 12:48:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y21-20020a02bb15000000b0035678e2e175sm5101171jan.50.2023.03.08.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:48:00 -0800 (PST)
Date:   Wed, 8 Mar 2023 15:47:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] object-file: reprepare alternates when necessary
Message-ID: <ZAj0f906l/7xGFAl@nand.local>
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
 <pull.1490.v2.git.1678301252360.gitgitgadget@gmail.com>
 <xmqqedpzt4t1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedpzt4t1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2023 at 11:35:06AM -0800, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Derrick Stolee <derrickstolee@github.com>
> >
> > When an object is not found in a repository's object store, we sometimes
> > call reprepare_packed_git() to see if the object was temporarily moved
> > into a new pack-file (and its old pack-file or loose object was
> > deleted). This process does a scan of each pack directory within each
> > odb, but does not reevaluate if the odb list needs updating.
>
> Very well explained, except I do not know what is meant by
> "temporarily", which to me implies what was moved is moved back
> later.  Without "temporarily", it reads perfectly well.  While I do
> not think of a good word to use to tell the readers that the moving
> is done by somebody else while we are trying to find the object, if
> there were one, that would replace "temporarily" very well.
>
> But other than that tiny nit that does not have to be addressed at
> all, everything in this patch looks good.

s/temporarily/concurrently?

I think that concurrently conveys that another process was doing the
moving. But I agree that it doesn't matter here to aid in the overall
understanding of what's happening in this patch.

So I'd be fine with this patch as-is, with s/temporarily/concurrently,
or with s/temporarily//.

Thanks,
Taylor
