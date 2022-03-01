Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44A6C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 07:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiCAHJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiCAHJL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 02:09:11 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7650C616A
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:08:31 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id d26so15624041vsh.0
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYcrCEGnFT7fVonbc67KMiZZ769zhdlbt6MgHFFngBw=;
        b=UTm7tllRtX5gq98pDf/u50+yV0WWAXgh+VoZQz5nRFEASINAwJZ5wwuVUGvu7R0rfP
         UVuE0GVHK4x5CGsTmL10ToiVWgfFoOIClTnxeOiDhKcqvEk0P8j8/KdUB9+q9SLHenLV
         27RzqGHxfqZiCeLq81wWfLAJk9ik4tEVeEqAjoPT55J1JibPLTuYlAbzZ7M4pZYD61MI
         V52h1G/+wh819BBzyIkzJE1NdI4NVkuVBZkyTdduuSp3Fhg5stl+1ozcYRawaOR6RGjD
         CKgNEwh/pojYUG79QL8zWkAghSL/K0WrpWaLqny5AKtNkT+IA7/z6B5N05+tSzFxgazO
         v5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYcrCEGnFT7fVonbc67KMiZZ769zhdlbt6MgHFFngBw=;
        b=a0wD3kXLMZZba9iUzlQ7+cywQ9dFNIgooT6aHvv64qoL3ZOM7BSb9FCtmYuseyV150
         wvLfuy79JtfFFChKHDvRhvNHf/DMU3tJT5xLvqFqNUOfxFJNQEQn3JXG/q8S3zN2pPLk
         1bXiw6hIZTl+qCIXaghdcxMLd3vpI7JuuHBI5zp8XRSBTW/TzjZtvW1uXg1p/4KoTBnz
         K8voFlA7R1e2Qexl+nYaTdRCYESsfsG9nRjFCqPVJZ54QOxkVuLEJK/1i/QHO1ogD3qQ
         /wfsptXBEcUyHkug/r5OTxcy5TvT5iz3wW8vbDBtuFe7Ql/r6WaUdtUd5HBrEIQRnwLR
         n55Q==
X-Gm-Message-State: AOAM533xNoKWWln83eOaW0t2l4anUBGwtvtiJQ6t3k6hNsWLpHtbbRvV
        oUf/zdOPDJgFlizAbmWsdwDNzA7EiEL1uRdQE6I=
X-Google-Smtp-Source: ABdhPJynopDeGy8gNn6hFUOMTORux0j5CpLU+p4OMMALNo2qdq8j8Kn7Kzx4Zn4nR0uLtSx5Nn3Izl0tD9tm68A0fwE=
X-Received: by 2002:a05:6102:3712:b0:31e:af66:6316 with SMTP id
 s18-20020a056102371200b0031eaf666316mr1209187vst.87.1646118510385; Mon, 28
 Feb 2022 23:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
 <20220228215025.325904-3-jacob.e.keller@intel.com> <xmqqpmn6wg98.fsf@gitster.g>
In-Reply-To: <xmqqpmn6wg98.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 28 Feb 2022 23:08:19 -0800
Message-ID: <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
Subject: Re: [PATCH] name-rev: use generation numbers if available
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > +test_expect_success 'name-rev without commitGraph does not handle non-monotonic timestamps' '
> > +     test_config -C non-monotonic core.commitGraph false &&
> > +     (
> > +             cd non-monotonic &&
> > +
> > +             rm -rf .git/info/commit-graph* &&
> > +
> > +             echo "main~3 undefined" >expect &&
> > +             git name-rev --tags main~3 >actual &&
> > +
> > +             test_cmp expect actual
> > +     )
> > +'
>
> I doubt it is wise to "test" that a program does _not_ produce a
> correct output, or even worse, it produces a particular wrong
> output.  This test, for example, casts in stone that any future
> optimization that does not depend on the commit-graph is forever
> prohibited.
>
> Just dropping the test would be fine, I would think.

Stolee mentioned it. We could also convert it to a
"test_expect_failure" with the expected output too... But that makes
it look like something we'll fix
