Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59698C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 06:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbiFNG1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 02:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiFNG1E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 02:27:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF55275EA
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 23:27:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id me5so15219357ejb.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 23:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCYY0ZdHbRexQdGlCTjtiLjldQNujyvfh7GzT7Upz7U=;
        b=IFmYTj/IgHjv6O3nvuShRkaomuPF7l2H4xsIN/j7MTp4MahvOpJjDDVQL/qjD3obdj
         3afkhhl9JPwCFpIo7Mg4fX27wneT47BfHy/CnGWxXoAuOucsMdbA/vV1A31Lw6AoQUhC
         tIeE4mZlJ4Z8THUhsVFIRJcZ3kqX8s2R5R/F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCYY0ZdHbRexQdGlCTjtiLjldQNujyvfh7GzT7Upz7U=;
        b=aNya0XW2a0RfI/HD7oR0Frk4YJyqfEM2DTmZXLfGBNFNXqL64eEpW/KqYzW9OVnwU+
         cVr2ijElelq7kwx52PJRuxh7GSM4ZGuV8CwRX97JOTpafmWmiMnMYp3DWldwqnoaj+C+
         qzTnQpd2UOoq3Wh+z96ok4aZi18npZg/hISWS4LCWF1XOJVbTinDJnKFFsYrptZHAOvK
         wCcsok3WbxuyTR5rvmJSnOBmLlw7EC3E+KGd+nmXrB2y5nz3WCjwtrjPFiqcRch3d7wA
         O4bbC0/u2KLUXLuBajlQHjOvxDbn72Mg/WK+4dhaJqNMYwn3dAQbVdF3PyTRma3qphEq
         Uk5g==
X-Gm-Message-State: AOAM530kn0GwsazFjnFLMEPuQCvIkbeAaCbOqLINPU1yw9o8wwDbwzIB
        nxAc01FVLH3l0xEJRADGWnwFPDBx9ps+L2ILI1coqpzy4AbMWAcK
X-Google-Smtp-Source: ABdhPJxb5HMecOlfXF8Yp8AfiP7DPy6jZiVoogVu8wHlchXCLQJcMJrWFav9qTr5NS+bFIVG4WaH3zwEHdUChiM5cT8=
X-Received: by 2002:a17:907:7256:b0:711:dd35:61eb with SMTP id
 ds22-20020a170907725600b00711dd3561ebmr2777452ejc.445.1655188021254; Mon, 13
 Jun 2022 23:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
 <xmqqr13t8np7.fsf@gitster.g> <xmqqo7yw77qo.fsf@gitster.g>
In-Reply-To: <xmqqo7yw77qo.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 14 Jun 2022 08:26:50 +0200
Message-ID: <CAPMMpoi_XgJyEvKvLZ5qk69G_dBs+R0rM359HH90+RY-OGbi-Q@mail.gmail.com>
Subject: Re: [PATCH] apply: support case-only renames in case-insensitive filesystems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 8:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > And then, you could use --cached (not --index) to bypass the working
> > tree altogether, which is a good way to test the feature without
> > getting affected by the underlying filesystem.  Check both case
> > sensitive and case insensitive cases:
> > ...
> > Likewise, try both sensitive and insensitive one.
>
> As I already wrote tests for basic cases, I'm sending them out,
>
> so that you may extend them with your new cases so that new code you
> write can be checked.
>

Thanks! I'm not sure how to handle this procedurally, especially as
I'm using GitGitGadget, so my patches must always be anchored on a
commit found in the public mirror.

For now I'll add this as a new first commit in my patch, which becomes
my patch series I guess (but keeping your commit metadata
as-specified). Please let me know if there's a better way.
