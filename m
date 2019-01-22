Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3AAF1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 17:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfAVRxE (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 12:53:04 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36741 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVRxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 12:53:04 -0500
Received: by mail-ua1-f67.google.com with SMTP id j3so8375766uap.3
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjCCNg+bO+pmMEXFNbvWSDAVEZJxOA56Pbh24Hv/tiE=;
        b=by633jE9d2Ltb24Jww/9G1XmSbsFRYEd8tFfKDOwVEG7Z/n2oXgr6I2tgePZybrlT5
         yBTFiNnDA80OX3vIuZLJL78R7I9i9SC2bkaPqTXnCeP0+j9BpkdPdmfz+Ncl2+jbmN5f
         YQHHyRT7pOjwfN4rd21c+3HITkXDsNAD4GETvmu/HUfwigqHh5Dx1AhplZ/uTiq5nawa
         o50T9LklXh1tAGFc2XQSPL2NNotwqtQWK2YLdJNuegWZma1Wf+ySGh36kkFzjET6RISk
         k8HI+ncgJe6BQztGqpeKFuIvziyONdHb4udYnJUxlj3RI/vrESVuNm2R77LkiMu+8uRK
         1C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjCCNg+bO+pmMEXFNbvWSDAVEZJxOA56Pbh24Hv/tiE=;
        b=TtNjs2QZ+bP0RnmGynvl3Lyd2b/DMIiMk9rFkvA66UXaGWd+aMFitSKiw33qcJ0hOY
         dUIEX2wUfH+R158eqOT0WlYmBgW3zrRBBt85rZ6N7zHo/0LwNX/Ut2ewpUUDUeGuR28C
         athdYnzEwC0aFxcfX33Vm5tPSzCVGHRa/MX1UUpuGonKw12Hz7NuZO4jAOyt7AJ+Lq/F
         hjFfNtscVeJNwJCk7H3JKkDoCIboqo+ecdYtK3QQWb0CyTE+IhiHYr3A1wqUZaK6ZHTH
         Q6uh10XZOol/uD8FliI150xxGcNtDKHpbyjRSwnRBfx+iWGOhoDmpW+pkyCi0g8OkIAA
         d9hw==
X-Gm-Message-State: AJcUukdtQBgQ4Wky9yTWEC6ar1QOiVw/zCRf1Rkerr4FNVz+PmoWqXIw
        sg66R5njv15q1r4ccGIFk1uVIWxwH6No5a7SJr5Rgw==
X-Google-Smtp-Source: ALg8bN51CIaO8x9MzO7OVIZWETLx/NQO41EMJ5+vEOlF7xF9V1O/UTolmUEUhWksvEWqPAZSkVbdmKTF/ps3ef5h0w0=
X-Received: by 2002:ab0:744f:: with SMTP id p15mr14072816uaq.19.1548179582910;
 Tue, 22 Jan 2019 09:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20190119154337.6556-1-phogg@novamoon.net> <CACsJy8AWCP+enBVVVga7jJZ-gxD=fxcushrk0D+xGSRAcZw_qg@mail.gmail.com>
In-Reply-To: <CACsJy8AWCP+enBVVVga7jJZ-gxD=fxcushrk0D+xGSRAcZw_qg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Jan 2019 09:52:49 -0800
Message-ID: <CABPp-BFmHkf3ftgKxEA5tx_fngPu7WypP_aYyYUvNVmrAibqtw@mail.gmail.com>
Subject: Re: [PATCH v2] pack-objects: Use packing_data lock instead of read_mutex
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Patrick Hogg <phogg@novamoon.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 21, 2019 at 2:02 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sat, Jan 19, 2019 at 10:45 PM Patrick Hogg <phogg@novamoon.net> wrote:
> >
> > ac77d0c37 ("pack-objects: shrink size field in struct object_entry",
> > 2018-04-14) added an extra usage of read_lock/read_unlock in the newly
> > introduced oe_get_size_slow for thread safety in parallel calls to
> > try_delta(). Unfortunately oe_get_size_slow is also used in serial
> > code, some of which is called before the first invocation of
> > ll_find_deltas. As such the read mutex is not guaranteed to be
> > initialized.
> >
> > Resolve this by using the existing lock in packing_data which is
> > initialized early in cmd_pack_objects instead of read_mutex.
> > Additionally, upgrade the packing_data lock to a recursive mutex to
> > make it a suitable replacement for read_mutex.
> >
> > Signed-off-by: Patrick Hogg <phogg@novamoon.net>
> > ---
> >
> > As I mentioned in the prior thread I think that it will be simpler
> > to simply use the existing lock in packing_data instead of moving
> > read_mutex. I can go back to simply moving read_mutex to the
> > packing_data struct if that that is preferable, though.
>
> In early iterations of these changes, I think we hit high contention
> when sharing the mutex [1]. I don't know if we will hit the same
> performance problem again with this patch. It would be great if Elijah
> with his zillion core machine could test this out. Otherwise it may be
> just safer to keep the two mutexes separate.

Testing...
