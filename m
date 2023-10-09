Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6647E95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 08:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjJIIXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 04:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjJIIXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 04:23:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E6DAC
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 01:23:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c3c8adb27so714466466b.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839786; x=1697444586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj/Ew085kwpdeWDXyoWnpq0lcxtRXIsWqZJ4Q7q0fUk=;
        b=Bj2/VDTPffxr7jMXBjuDNHH18dqd3uZf5S3T+rM0HGqWkwtXO4lRsS5XgOqXKhXj33
         cagpCTfgvpXbJIIP9blpubkosgTor3E8OR31/PZ5m5Qy1Zbo2F82PGwzVnRZVqKRS/P3
         CzVohO5icaOiUmZdronju1zzY68l5vbscwzXhKiP8JIM+t0ZPPN96CTyvZ+EHUltO9p7
         y3MBDgk0AzQjcQIbMrWhcfAqMwXvAik+H+0VBQYdIDRxGY5biF069QTBaZMGxqaaKDtL
         HNx3tZO/Y/ahRIYkYSSe4LMC6II1DEmzHgBgFeIuBChrv3nWL4KER9r3NfBSIs8omud3
         fnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839786; x=1697444586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qj/Ew085kwpdeWDXyoWnpq0lcxtRXIsWqZJ4Q7q0fUk=;
        b=I4mXtbxs4vanwuYU6RV5p+gLNC2QUbCG4jlEPeiDrLYbR/iHFDLrdaEvx3iRVumbrB
         t3kny5GMIQaw5l29TrCyLxrLYjiRW7d9LXbTxmlyACBVyfbSrdcvdCYQz0Ld7At8eCje
         YcqpZwWyjmDA4+bIIJXD/4vu4yNhqGhc0dAhtAOjFDZlOvFQfISl+A0kumH7kFDbYb4j
         Rtbzu44ajF/E/sWGenSQjBETvHga8WZ9drFNtsVBiEs543rEknNW/M7IL2gEWmAgMN0Y
         S4ajTOR+bGoZ6aaOosDWWYzM2priOoqXOXUV+FBzqODdpRACINdkOJp2g6XuaCuFjVFZ
         xJDA==
X-Gm-Message-State: AOJu0Yx4MpP7+hOeIDDDqnUoWGr/18YALTXhEwSdIMYg+vvq4+GCh9k2
        O6Js7hmnTC/BIRU2OPvnBwpM+8BMPrjBGizzSY8=
X-Google-Smtp-Source: AGHT+IGjhkVrW9CUg91q0Ve3bWREbTLAwbJvKMHmZiJ0EzWDf4Vh7tOR0H/7QY1yptZZnBDjBmsn34S8TiSDwr23Ffw=
X-Received: by 2002:a17:907:1dd8:b0:9ba:13f1:5a6f with SMTP id
 og24-20020a1709071dd800b009ba13f15a6fmr3038219ejc.75.1696839785900; Mon, 09
 Oct 2023 01:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231009011652.1791-1-naomi.ibeh69@gmail.com> <CAP8UFD35DBBwQ1Mgc+NGVoh1ReLncAz9OJF3Yj++FFrESw8rtw@mail.gmail.com>
 <CACS=G2zcU+o6av=CQy7WAG7DZmNEERcPqB_W3Cmub4w25V3K4g@mail.gmail.com>
In-Reply-To: <CACS=G2zcU+o6av=CQy7WAG7DZmNEERcPqB_W3Cmub4w25V3K4g@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 Oct 2023 10:22:53 +0200
Message-ID: <CAP8UFD2hCPh2cVZ_xUeJU0OLw9RzJwGiT9TperzRyYwcw4uvPQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to guidelines
 when using die() listed in issue #635
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 9, 2023 at 9:57=E2=80=AFAM Naomi Ibe <naomi.ibeh69@gmail.com> w=
rote:
>
> Thank you very much for the feedback Christian, I'd definitely keep
> this in mind the next time I'm creating/sending a patch.

Great!

> You also said asides working on my commit message, the patch looks
> good,

Yeah, but first others might find some issues in the patch itself,
also, as I say elsewhere, I think it's worth it for you to send a
version 2 of the patch that fixes the commit message issues I pointed
out.

> but as I'm applying to Outreachy, I need to send in my proof of
> contribution as a link of a task I worked on.
> Would sending a link of the mailing list , with the url of this patch
> I just worked on suffice?Something like this :
> https://public-inbox.org/git/20231009011652.1791-1-naomi.ibeh69@gmail.com=
/T/#u
> I ask because since I used patches to send to Git , I have no pull
> request link to submit.

Yeah, links to the emails you sent in a mailing list archive (Public
Inbox or lore.kernel.org/git) are fine.
