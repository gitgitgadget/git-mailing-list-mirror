Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A33EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 10:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFUKyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjFUKxk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 06:53:40 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CCE10F1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:52:53 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5700b37da3fso52919197b3.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687344773; x=1689936773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiC4/AeLFqFAtzfmDpLhfUSHSl4suJvdQUefMRlDgaE=;
        b=kOTBGCgKNeXkhq/izbhgZ9YwcbWjzxlqsq3KVO50ausH3R9NUe9c13GeSajcd45Ft5
         C5HF7QA/tG3XgsRFruo45w7Jgee592YfiHRLFaCtmlZHzN2LiBjJeaMdZH+3j3L+PMp3
         ncGNpT5D2WtuGVoioWdwyTPEPx8Ym5hSZL9EfaINVOA8v0FFls9+UvzGQaAjIZP2RS5k
         VNCO9syxM0xhaNplITEnsRlIcn52UWQA7EKXGzUSHzrV/sHeBIDTZMHuAHwCEVQTgpir
         uIvw9koPkEg2FcxkMYiP3AQxTz+ZGx5JMSok/rYDWqU6M5lLYwWt28zssLvhxlK8GknD
         2dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344773; x=1689936773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiC4/AeLFqFAtzfmDpLhfUSHSl4suJvdQUefMRlDgaE=;
        b=Aabfj88PNM7nCSFYiO2wCCuLVPrwf+KU9DkqU5eUxlD3VuSRWfgZJUbEQgpOfxdKhN
         J4QBgXluHnqWJLPN8Rm047hEW2URMrEem1xhZ2tqQU/hmxZWk7GDq/GiPl5GPSdEsjSx
         5yaKBHg0c2v/q3FI/bWvsJX9wXm6t+9BMpucfjIm6WK3YV6E0RCRpmhRkubajVny1R4Y
         rR35yJArBjF/kv3uT136Y//1qvbI9Cpc9dXC82FJOl1FOqHgrF2kVdvLFbMwOlskSx3Z
         nscs0Z+J8PT3jRHHX3H3sdo6lSsQIKvm3YOzRGuruynqATCDIfUdm4noL0OTFLGvVWWj
         UtWg==
X-Gm-Message-State: AC+VfDz2ahhKliVCEYOmozKyWklFsjRLFNgIxS43Gzq838XTncMJwkMC
        YCyvMw4h6oAOzvWFQ30v4lLfGA==
X-Google-Smtp-Source: ACHHUZ7oDI/b+qmcaBo/+wmGWhemwTmFLeDtbwouZ0NV7W23GBk43Y3Bc+VJ7fCC9Q/D8dP7hWywNA==
X-Received: by 2002:a81:a007:0:b0:570:22f:7f94 with SMTP id x7-20020a81a007000000b00570022f7f94mr5725773ywg.27.1687344773163;
        Wed, 21 Jun 2023 03:52:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n20-20020a819e54000000b005705cbba0bcsm1029883ywj.98.2023.06.21.03.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:52:52 -0700 (PDT)
Date:   Wed, 21 Jun 2023 06:52:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/9] pack-objects: add `--print-filtered` to print
 omitted objects
Message-ID: <ZJLWgfCNoqE6xNqq@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-3-christian.couder@gmail.com>
 <xmqq7cs4uyqe.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cs4uyqe.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2023 at 03:50:17PM -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
> > When using the `--filter=<filter-spec>` option, `git pack-objects` will
> > omit some objects from the resulting packfile(s) it produces. It could
> > be useful to know about these omitted objects though.
> >
> > For example, we might want to write these objects into a separate
> > packfile by piping them into another `git pack-object` process.
> > Or we might want to check if these objects are available from a
> > promisor remote.
> >
> > Anyway, this patch implements a simple way to let us know about these
> > objects by simply printing their oid, one per line, on stdout when the
> > new `--print-filtered` flag is passed.
>
> Makes sense.  It is a bit sad that we have to accumulate everything
> until the end at which time we have to dump the accumulated in bulk,
> but that is a current limitation of list-objects-filter API and not
> within the scope of this change.  We may in the longer term want to
> see if we can make the collection of filtered-out objects streamable
> by replacing the .omits object array with a callback function, or do
> something along that line.

Hmm. I think it is possible to use something like `git pack-objects`'s
`--stdin-packs` mode to accomplish this without needing to keep track of
the set of discarded objects (i.e. those which don't match the filter).

IIUC, the set of objects which don't match the filter is the same as the
set of all objects in packs beforehand, differenced with the set of
objects that shows up in the pack containing objects which *do* match
the filter.

If you mark all of the "before" packs with `-` in the input to
`--stdin-packs`, and then pass along the pack containing the filtered
set without `-` (to indicate that the resulting pack should not contain
any objects which appear in that pack), I think you would end up with
the set of non-matching objects.

Thanks,
Taylor
