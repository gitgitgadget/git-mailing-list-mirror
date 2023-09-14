Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02606EDE9A5
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 11:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjINLK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 07:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjINLK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 07:10:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728811AB
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 04:10:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c93638322so185326166b.1
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694689851; x=1695294651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uvmw6f7G0IjblukEintdsgrsFaSPJIQCaDCYE96POxQ=;
        b=WLHUSqrkvXlKebinEE6NQS8XyKHII2hQ55eulWXfeMAiICqKh2E3dTGsWZ5pbOSoiI
         qWO1aKx4mM6r4yoJc59XtEc0qpTnvdAxGcQpIx+8p4z/r0okFt+d/lk5mu9L8OL+eAPR
         x4clVPXazmuAo7goprS7X86Lpc20U3OIhcgbmOP4dD7dJFq2l3OPC38Ipgsc3izcWvg9
         r/h/RAu6I6QIxJgeybuqsPd7bzx6IsXaxOeAfs9AYS/4FNHlHZzRXft0/5MtVMLOUcke
         fjVIlKP/3jrAU+UAXdmtJTFQV7Mfy3TtiCaKbWQfW7kA7VNB7CmVonIgzv3kcrkNsuy2
         Jtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694689851; x=1695294651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uvmw6f7G0IjblukEintdsgrsFaSPJIQCaDCYE96POxQ=;
        b=Iw0V0wlxdOl8ABxBRXXW7kiLbECDPSxZXv4qsDW5UCGukN2GBmZUrDKH79UIvELNMn
         mpwdWXjzbcwW1rqPwV/ru1zQ99zbWoBahtRaHrb630JYecONc6bgnTuIDOf2IlznBLCz
         jKnUrba1kf2N1b2JYhQzIFrZHGxfcxyXR7+nCHtcQAl3keNdXBuyuTExSODs0C0UweRL
         jhJEovjvB/oB/SPYHAYITp+skD3DhuuCDwe2lv5EnEAQjM8Zz5c6Yr5jGPttZITyAHvf
         eaM0WWnbiuJ5h/nRayz7ssLA0rnTvS7Z5tEFz1hV+el003UNN/z4nLC+WZwjsZcWfYix
         DpDg==
X-Gm-Message-State: AOJu0Yxg+qsmp/7/VYY75oBLY3g8M7EActJR4JmwGhMEfzIa7vicIEnp
        veuuJCjsie2CaQUNGgZ12oUJZeZvbalZfoD0f++GkLXIIGQ=
X-Google-Smtp-Source: AGHT+IGJjkG3Cee/IyVyXC9oQRFAsZDHfiQJxeZ+0G7XQoL357vRgWyWl63wElaaQNzaksy6UXdykkIo7ai+dWNQtAo=
X-Received: by 2002:a17:906:d54f:b0:9a5:ca06:6a25 with SMTP id
 cr15-20020a170906d54f00b009a5ca066a25mr2045353ejc.16.1694689850604; Thu, 14
 Sep 2023 04:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693946195.git.me@ttaylorr.com> <cover.1694632644.git.me@ttaylorr.com>
 <xmqqa5tpluyj.fsf@gitster.g>
In-Reply-To: <xmqqa5tpluyj.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Sep 2023 13:10:38 +0200
Message-ID: <CAP8UFD1rDb-iYf4LYb7n=K4KpQ-JR-JK4TkQpGJ-TCfTNFFbnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] repack: refactor pack snapshot-ing logic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2023 at 9:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Here is a small reroll of my series to clean up some of the internals o=
f
> > 'git repack' used to track the set of existing packs.
> >
> > Much is unchanged from the last round, save for some additional clean-u=
p
> > on how we handle the '->util' field for each pack's string_list_item in
> > response to very helpful review from those CC'd.
>
> The change to [7/8] was as expected and looking good.  Let's see if
> we see additional reviews from others, plan to declare victory and
> merge it to 'next' by early next week at the latest, if not sooner.
>
> Christian, your cc/repack-sift-filtered-objects-to-separate-pack
> topic will have to interact with this topic when merged to 'seen',
> so it would be good for you to give a review on these patches (if
> only to understand the new world order) and optionally make a trial
> merge between the two to see how well they work together and what
> adjustment will be needed when you eventually rebase your topic on
> top.  Actual rebasing can wait until this topic graduates, but trial
> merge is something you can immediately do in the meantime to prepare
> for the future.

Ok, I will try to review and merge this with
cc/repack-sift-filtered-objects-to-separate-pack soon.
