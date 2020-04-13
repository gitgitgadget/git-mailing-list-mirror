Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF7AC2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 05:43:52 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CA9206A1
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 05:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJohSgS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CA9206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgDMFnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 01:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgDMFnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 01:43:49 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABFCC008676
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 22:43:49 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id y15so4404870vsm.5
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 22:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QiF4wwb0lrk7KjlUoVufLXiQ0OCt2Z3vgXvdWmMK5Qw=;
        b=qJohSgS6Rt+ZgSD+Mr6Hstt/MBMjh4OkGBG+6/7b5EVelpkhuRD2cRRF496qkAXUZa
         5umf7zZzw8roaLhasq1DdCrB6bJ8lp5jgyHvRmSsXBgB9+g3alvkdyXL4MhQLKlU5Bdh
         afAqKGDNnDiL0Yk4BqUN25ysHQc4coM7CgKyZOf72ETJK7DwC394isRQZXoNN7jPkFON
         rQ62Zyq/AxzMrFQUV/c6maMRCOCKXHwH93VHbZ3Tuuj2cqWfV+t2miqyfdgWZN6ly0WV
         8F+NfNZmZTc4YoNahX075dPK+pRgEcpav41AOunISrPwjkWO+zXKpD5jIpo7hmt8oT6P
         kBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QiF4wwb0lrk7KjlUoVufLXiQ0OCt2Z3vgXvdWmMK5Qw=;
        b=TDyabnmBPufZ8wfohLdkZXs454Hk09d4w13/NXay3ZVmOTKBT5FWccy0h82ALO9qN7
         tspqcDJ7FHwt5+OhlgiY7CpqhbXF56s4nVFlMt8+k1ylY53nFF/8e2tjdDsM/YPag3Z6
         de2/fGqgYpOXRGxYFZJo7yuKM89xZbG+8tDRaC8+H+T+gCohH1DdictsgpcfXtm6vOI7
         bPK4hgKnr0buHVyuIwdKltEzi+iYoY2dc5qo5CcSgKexBoimCUUh6ZRQtXYcjePWMJV7
         BXVFLsDUwbH9231gYAyTtWfgT9cKYQ0W7qj/8rd0x7CWjOEBLoHtELXSyQhosqSytG9g
         VnJQ==
X-Gm-Message-State: AGi0PubuBb/S2dqlaLC2qM+x8KwZBH/oB2iuqUNdryc6auFR5g9cYP2e
        nTmO6yngzqIEd14SLiluAjzciVu2qZS7+its9uSuYLLD
X-Google-Smtp-Source: APiQypLgmLcOQKRSCgS8CrRPwV1gzYfQTjVGVsI76KLQ9RJbUfVAWUFXoJJ4wZIEVu8CL33JN4M532o6J0GhtgpCJLQ=
X-Received: by 2002:a67:6c4:: with SMTP id 187mr2740701vsg.54.1586756628504;
 Sun, 12 Apr 2020 22:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAN0heSodSeT=Sj4pnutFPgbu9jjwQ_JBtBee1iyP=D3Oc_5G=g@mail.gmail.com>
 <AE1E8050-EF04-47A0-96E0-27EEC4A0C013@anirban.org>
In-Reply-To: <AE1E8050-EF04-47A0-96E0-27EEC4A0C013@anirban.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 13 Apr 2020 07:43:35 +0200
Message-ID: <CAN0heSp+Lmyx=eGjjioCYc6dmncz4Dcwo-MCsfMMKbP6vKdOzQ@mail.gmail.com>
Subject: Re: Cherry pick a commit but with files in another location
To:     Ani Sinha <ani@anirban.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 11 Apr 2020 at 15:25, Ani Sinha <ani@anirban.org> wrote:
>
> > On Apr 11, 2020, at 6:13 PM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> >
> > Do you use "git cherry-pick", "git am" or "git apply"?
>
> Yes

I still don't understand exactly what it is you're doing.

> > (Or
> > something else entirely?) Are you aware of "-p<n>" for "git apply"
> > (and "--directory=3D<root>"?) and are wondering what similar options ar=
e
> > available with "git cherry-pick"?
>
> Yes was wondering if similar options exist for cherry pick. I wanted
> to use cherry-pick  so that cherry picks can be tracked by git.

Are you working on some repo that is publicly available, e.g., on
github/gitlab? If so, you could post a link.

What is it that you try doing? You could post the commands you execute.

What happens? You could post error messages.

What do you expect *should* happen? You could try to describe your
expectations.

Without that kind of information, it is unfortunately hard to help you.

One final thought: Have you actually tried cherry-picking the way you
want to, and have you actually encountered a problem? Or are you looking
for solutions to a problem that you're not sure you're having?

Martin
