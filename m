Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD434C2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 12:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E411207F7
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 12:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifAW2B1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768762AbgJZMmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 08:42:38 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42620 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768636AbgJZMmi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 08:42:38 -0400
Received: by mail-ej1-f67.google.com with SMTP id h24so13230034ejg.9
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yz4c6sgxD00NUZs+pQvqE8acN+tLbZEQ5dZzgnlizLM=;
        b=ifAW2B1yN1MWsKbAOZJi9N6Lf3S9TiVDVULSHqlVN8YMoq6Y6lPA/PlqmLxlWpvtbX
         DkDdP3vlsUIywed7CYQR4/hTA9PKG0/FHIN5sJ1xsNjpn7UWMVpseOzFe7ZMVju5nyLF
         Oq9rqGlySe/Dg7vRFNPuw3Yg+dUTi3bivSqiSMfHFC+sDQRXJnLjqzWIoy4gJCn4HPVm
         wYQhBFCyUsSKbsYW/tHkvpe7Q/UxR8E7NflFreo5fKCmCxXoQNHsglkOxJSjBLv1tLLC
         mNxiNUUgACV8rihhMeX32y5LHdxENRnrxPh+pm33B/bAKec7EYlxDJEzYlplfX/PsvAY
         p8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yz4c6sgxD00NUZs+pQvqE8acN+tLbZEQ5dZzgnlizLM=;
        b=glJQPC2vaS7VU8Gq3+XAcoTw8nOxVO8c1POJIpKqvvj1NdK3XILikvwxY6UnrggJhN
         qrB2uh3l7a1tQLBUaC1P9yiI8kWZMX/qEHYbZqX+Kcwul0RHdYs8UG+TncaKFHHYeojK
         41850gWRD+giuJLUAyHY24eGRxz/14Wq7X2R6R6jjzLdWvYyksnu9uCqPwcoMMDlxZIy
         AmPN8+2b9waKw2j2T5+nZrthVvXe/lVqZ6T6/FxCH6DyCTNxrbrnEWCVjDr48XB4hbT+
         UPoH3YDhN7a1C9JVN9pL8Vf/7jo3iOJfySUrg8AvoVQt0yzj0SvXfKpyn27p8g8AoXdv
         5tQg==
X-Gm-Message-State: AOAM532IF6+Ne9vl/dP42MTgcJuuT9UBvJqOZpXk+EmdrQILIVE+q439
        EpQC+bdz9dgrjBXAOMnI19wP+ztMbLoIMtRxMd8=
X-Google-Smtp-Source: ABdhPJzbsI4IW8Y2ev/eYwXBUaCj7pNoMUNgbtEdqZG4LDvCQje3VJ0aSknUKhRp9cLsP0QxHhIGcrcZ6/QbPoh2u9g=
X-Received: by 2002:a17:906:3cc:: with SMTP id c12mr15126816eja.216.1603716156169;
 Mon, 26 Oct 2020 05:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201025212652.3003036-1-anders@0x63.nu> <20201025212652.3003036-6-anders@0x63.nu>
In-Reply-To: <20201025212652.3003036-6-anders@0x63.nu>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Oct 2020 13:42:25 +0100
Message-ID: <CAP8UFD0Fpkj_xc-UBCeayw2C_4eXCx7Kan90PCvoM-KUMVEGDA@mail.gmail.com>
Subject: Re: [PATCH 05/21] trailer: rename 'free_all' to 'free_all_trailer_items'
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 10:27 PM Anders Waldenborg <anders@0x63.nu> wrote:
>
> ); SAEximRunCond expanded to false

As already mentioned, please find a way to remove the above line in
all your patches.

> No functional change intended.

This doesn't explain much why renaming 'free_all' to
'free_all_trailer_items' is a good idea. Is the function specific to
trailer items or is it generic enough to be useful on other 'struct
list_head *head'?

> Signed-off-by: Anders Waldenborg <anders@0x63.nu>
