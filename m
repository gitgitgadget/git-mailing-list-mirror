Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E66CC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 01:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B8264E5B
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 01:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhBJBwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 20:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbhBJBu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 20:50:27 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FECC061574
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 17:49:47 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v3so525952qtw.4
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 17:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z2jF2eWCxTqlAy/rpRyINQ7kTxHQcRMarJca+FW02TM=;
        b=GUmMzATei8MQzsqe41lu2qake0ZbSdvKsw/0zjBHuvv3pEQS0AMXJc6/tATtc9V0Si
         jFXNo71gBWihwYMjU8WTO/MdQj/c9hcHCOWnH3E8lliLDSYRywGzH7wSFn/8yl/ypIKK
         aES3bocrrMd1dOjiWW3lS8EsmWeKGKvq3G5SDd0qyYJYgmufwZWKkQndgTzHJJSfeyuS
         vT3lkoPOyG7uhG3k3U9dDvmP5K1Yyw0tCwdOxxpgS70eoyHasWPJ6cPe7X2ENkQc8VeB
         0t/XlwbYaHG2xNEE1W623UmhATZgLmg3hSfkSP012nsdBPJAyYDLUyddBjC1spYSFIW3
         GSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z2jF2eWCxTqlAy/rpRyINQ7kTxHQcRMarJca+FW02TM=;
        b=CU9shn8Zj/yOuXF/EbfOFASn2RjbBraA0woDfF4AxjRkLHjR0dXX2bmpYm57swuC2q
         tlraoQl1gReYJKOeP6JhIPe1dgNznsjp7gkxCjdlY1lV2v6X8irUX8S3gSxB1jVc39RS
         b9pB6JcNq21woxQUZpWO/T5rnAuR74TAvcmNjSuSx+F/+uc8wBmfn3tbBKZBRZvHAMLm
         PldwguUWlooArLERz5qPWxGKu1tG1LtKsyhisbxFVUnviQvMat1QRzVnSfyjiiAbK0gj
         dtz33GwNordeGkzZESDbgBkPwoQikDGw8+nSMsDJPvarF6jTG56yULyuOZuU3UuC9y/C
         TuBg==
X-Gm-Message-State: AOAM532LO2iKxvt1oxo1RnplJfRwh7Xvt+HdQnFCgrVoqjQ493j4C2Ek
        37VdBuX1Pd3SE4WMbD+AsVe4mg==
X-Google-Smtp-Source: ABdhPJwY5jyDQNWJc+uk/enxSlPGCQqNRS69h9P1Bzh0p/FMo1WQ0/zyeCp+0IHEpHojDdrwEIHoLA==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr846447qti.57.1612921786382;
        Tue, 09 Feb 2021 17:49:46 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id o24sm440569qtt.36.2021.02.09.17.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 17:49:45 -0800 (PST)
Date:   Tue, 9 Feb 2021 20:49:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] rev-list --disk-usage
Message-ID: <YCM7t3buBR6sL/lh@nand.local>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
 <xmqqh7mkycno.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7mkycno.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 04:44:27PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > Here's a re-roll of my series to add "rev-list --disk-usage", for
> > counting up object storage used for various slices of history.
> > ...
> >  t/t6114-rev-list-du.sh             | 51 +++++++++++++++++++
> >  t/test-lib-functions.sh            |  9 +++-
> >  7 files changed, 199 insertions(+), 8 deletions(-)
> >  create mode 100755 t/t6114-rev-list-du.sh
>
> I relocated 6114 to 6115 to avoid tests sharing the same number.

Thanks.

> I am getting these numbers from random ranges I am interested in,
> but do they say what I think they mean?  Was the development effort
> went into the v2.28 release almost half the size of v2.29, and have
> we already done about the same amont of work for this cycle?
>
> : gitster git.git/seen; rungit seen rev-list --disk-usage master..next
> 83105
> : gitster git.git/seen; rungit seen rev-list --disk-usage v2.30.0..master
> 183463
> : gitster git.git/seen; rungit seen rev-list --disk-usage v2.29.0..v2.30.0
> 231640
> : gitster git.git/seen; rungit seen rev-list --disk-usage v2.28.0..v2.29.0
> 334355
> : gitster git.git/seen; rungit seen rev-list --disk-usage v2.27.0..v2.28.0
> 182298

I think you are surprised by these numbers because you're only counting
disk usage of commit objects in those ranges. v1 of this series implied
--objects by default, but this changed in v2 due to my suggestion.

Passing --objects to count the disk-usage of all objects in those ranges
gives more reasonable numbers (and match my rough guesses, i.e., that
2.29 was busier than 2.30, and so on):

    $ for range in origin/master..origin/next v2.30.0..origin/master \
        v2.29.0..v2.30.0 v2.28.0..v2.29.0 v2.27.0..v2.28.0
    do
      printf "%s %d vs. %d\n" $range \
        "$(git rev-list --objects --no-object-names $range |
           git cat-file --batch-check='%(objectsize:disk)' |
           paste -sd+ | bc)" \
        "$(git.seen rev-list --objects --disk-usage $range)"
    done
    origin/master..origin/next 671380 vs. 671380
    v2.30.0..origin/master 1618815 vs. 1618815
    v2.29.0..v2.30.0 3308295 vs. 3308295
    v2.28.0..v2.29.0 4080789 vs. 4080789
    v2.27.0..v2.28.0 2846196 vs. 2846196

Thanks,
Taylor
