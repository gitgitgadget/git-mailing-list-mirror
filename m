Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC8C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6A661164
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351589AbhJACyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 22:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhJACyL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 22:54:11 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB7C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:52:27 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id h2so17412399ybi.13
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2GjA5xhLqCt5SM3I6kpXciyR9I1tawK45TYqXeitryo=;
        b=I2EWaBvie28xJtm/MjWJaQ+1pJUenc+UdVj7JJNUVgTB4wwZZkPrXLiH6Ki1Y8mHnl
         u6LKnFOl3R/8Sd/02IX4ovzX3q6NfKkO4JCZlW1efO6B5/qGC+uvXNEIVNqmEcYUrozj
         BH4N51jUqjG7Ad8BYoM2UmlS23qLoq7KAqT1mXVrEgoAuvynAmOO/xXbDfa0lodQuo3+
         D3evs1DjAkWgg5I8MQBEbVdd/lCBQm5LyT5LmRk3Vtrrho7l0abGL2aggHLhvhuorV5g
         ItEPNPXsqk0nAKni/6Oe1VX3IVsF6T8JRPJQ/JyQgvVaDHL5BuCBrX5pb+5dNNhRK2Nr
         UEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2GjA5xhLqCt5SM3I6kpXciyR9I1tawK45TYqXeitryo=;
        b=LZadBRTE0TjOPVNTRtsIoGSqEbErNc5OQ48HzD8YJbPVJp/ugRdtKzFMfdtcgqJ9/5
         BOWv0SLstcl8BhlzH+wfoKIcV8Z+bdjV4x0NvCWDHV1eU4F/+h91VQDWRa4fVnwjhKtz
         yrr85J9UgQyHQKnHyclbol8BleFI99m69y+zoq81+OjWUmiXw8c3JElPfQILy29L+izy
         Yul624/2ndBfh47YQium9tnLi3DHwPqr/YROCIw8yDIMdWcLoRnzgMr8HOKiBRHKbAo8
         xexbVmVDPMj0Ysxv7AodK4PXoY2/FOEcQU0aOIzbm3Y2VP9/vPWzKyIzv1h6IqwTyyhB
         jq8Q==
X-Gm-Message-State: AOAM532NorEVR0f7KJopwoGqN6Kf0nusKq2cmK9QxaXQ78rm98DKLdgr
        +AH+2XaxU+SjrSfaBVnE33XCaS17AmlIx2NRfXw=
X-Google-Smtp-Source: ABdhPJwo/DNK8ZS/S30g9sSu3XoYYQO177RaqwXQSKk524qBp9Bs7wTU5vYZSfotpxSQt4Rr3YP1qQb65U+89X6ypEU=
X-Received: by 2002:a25:188b:: with SMTP id 133mr3276535yby.80.1633056746679;
 Thu, 30 Sep 2021 19:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210930121058.5771-1-chiyutianyi@gmail.com> <20210930132004.16075-1-chiyutianyi@gmail.com>
 <xmqqczoqdn4m.fsf@gitster.g>
In-Reply-To: <xmqqczoqdn4m.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 1 Oct 2021 10:52:15 +0800
Message-ID: <CANYiYbHfw1=MLVv1+utXPUtg3mn1DoZGL0t5WH+w8sjdDrkHYA@mail.gmail.com>
Subject: Re: [PATCH v2] receive-pack: not receive pack file with large object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 1, 2021 at 12:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han Xin <chiyutianyi@gmail.com> writes:
>
> > @@ -519,6 +520,8 @@ static void *unpack_raw_entry(struct object_entry *=
obj,
> >               shift +=3D 7;
> >       }
> >       obj->size =3D size;
> > +     if (max_input_object_size && size > max_input_object_size)
> > +             die(_("object exceeds maximum allowed size "));
> >
> >       switch (obj->type) {
> >       case OBJ_REF_DELTA:
>
> Here obj->size is the inflated payload size of a single entry in the
> packfile.  If it happens to be represented as a base object
> (i.e. without delta, just deflated), it would be close to the size
> of the blob in the working tree (but LF->CRLF conversion and the
> like may further inflate it), but if it is a delta object, this size
> is just the size of the delta data we feed patch_delta() with, and
> has no relevance to the actual "file size".
>
> Sure, it is called max_INPUT_object_size and we can say we are not
> limiting the final disk size, and that might be a workable excuse
> to check based on the obj->size here, but then its usefulness from
> the point of view of end users, who decide to set the variable to
> limit "some" usage, becomes dubious.

Just like what I replied to =C3=86var, if the max_input_object_size is
greater than core.bigFileThreshold, is it save to save the size here
is almost the actual "file size"?

BTW, Han Xin will continue to resolvie the OOM issue found in
"unpack_non_delta_entry()" after our Nation Day holiday.

--
Jiang Xin
