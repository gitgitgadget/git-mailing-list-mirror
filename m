Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A327BC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 22:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B23320714
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 22:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSKvUSQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgC1WZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:25:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37334 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1WZv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 18:25:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id d1so16908455wmb.2
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=adslg7Rva2toOJt6zrGZm0CXN/rR705jefIbe5gYg0U=;
        b=VSKvUSQDgL4NI1giA8cX922AnbA37Ho9kV/C1L0MaPz6Qdut8DC6vEeuPh9a7RgbqD
         tlJCOZzXVSjokLmG6DI0ESfuUdja8bwbaxpO9eyloV9EuvOPYNy3vN3h0QifnCFZ3rmC
         zly8WEDdhZYaboDFtlPDnbWyE4hnqKKoFrhv20NCcQxd/2Kc+sPbqZcTDhOOcQMHmhG7
         N3/+wDjw4NCTCDdGfYL+GEsKcgBe9LFEmEl6JshRfUDFBdpUOXEdM9wha2lIaTyMjXwC
         RygS0saJ/HucgIGzNjyk6uDAvjltEIcTlmB20Xr0UVHW69Fr01vS3bS/qmSpdza5nDrv
         vuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=adslg7Rva2toOJt6zrGZm0CXN/rR705jefIbe5gYg0U=;
        b=UXTOHVq3JrPgBJJGagDMT4f74zElHv8VjJ1vmB5Hegi36ryATAKYnQJ0QX60JuCefU
         dcGJwKV0YPTa2OkJpr6gVhBL77egVc2kH9CZw2rYmzs1862DND4e1bUH2Xh1MTnTwHgs
         VEG8zlULVg7otfrIt6Ae6RFcYUuhapqzCnXVayiiXEkbYhEAtAcNea1UJ7AYYPhcCyET
         cQ0BV7UcAZzT7i3VXvMJeLbnG7XmFKOm6vNjg7jFQ92vPUJSHWiw5c65SE9oDvacVzI8
         N1CDomuzdZMs6juFpeGawgQb0+c3UYn487vbAJ9OeHm7JHN9GbrAB8RzpxgkMe4WNhWC
         oO0Q==
X-Gm-Message-State: ANhLgQ1ZIJY/U5beg99ScRpx6E8RFWC7Cr/f/STAuSicUKSEDUh/k8Ay
        Y+MEDrSdOHZScH1fH6VvZgs=
X-Google-Smtp-Source: ADFU+vuqHUuDqx8JGdOTcKGQ5gImMNLQ4qHWA8o3Xn2yhPUtW5fvOWUQnQDWlckkFmtducw8iJKSrw==
X-Received: by 2002:a1c:4642:: with SMTP id t63mr5361783wma.164.1585434348907;
        Sat, 28 Mar 2020 15:25:48 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id d13sm14435622wrv.34.2020.03.28.15.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 15:25:48 -0700 (PDT)
Date:   Sat, 28 Mar 2020 23:25:46 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/1] remote.c: fix handling of %(push:remoteref)
Message-ID: <20200328222546.gvrtzkcazf3bhjno@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Sat, 28 Mar 2020 23:23:56 +0100
References: <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
 <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
 <20200325221614.ekn56wamfgs4bwmq@doriath>
 <xmqqblohe9ip.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqblohe9ip.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Fri 27 Mar 2020 at 15:08:14 (-0700) :
> Damien Robert <damien.olivier.robert@gmail.com> writes:
> > IMHO this patch should be good to cook.
> Would love to queue it but I haven't had a time to look at it.

Sure, no worries, I was just wondering if this was on your todo list or if
the last patch version fell through the cracks (I have no idea how you
manage to keep up with the traffic of this ml).

Your message managed to invoke Jeff who suggests some improvements to the
test, so I'll reroll anyway :)
