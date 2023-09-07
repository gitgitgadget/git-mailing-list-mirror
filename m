Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A924EC8742
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 16:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjIGQY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244980AbjIGQXn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 12:23:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1E44C16
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 09:11:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso11607885e9.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694103054; x=1694707854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvzD/fldFQKaf8kb1yG9GuK5+6b4HWZJ5ZD4Bk6TXIQ=;
        b=ObnLm6vCrBiVV2ogcTFWxYnOe3FzaCmrIh6JZapqP282x2XCc/4BupLP/jOGX1TqnP
         KC+NOWq4LHOem1cVCBtt/mmkZbrj2pHNPH/HHaJg+obQ6unJ9lHHiQK670by1V4VqAhY
         MfneKapKTbPm6HQQjOzoS7IUc0HJHWxWaBR0gwE/i9olv9FnkOBSc4Iq/7vaPNwI8PtF
         wuoKhJkwFhaDt5JPD+yO6OnlQY05aX+PmmCW7UgxENQ/zlc7TS08wqpeiEl8v5N2yXli
         4KFTDFnzU3V7X+CClVVob2VjVgUPSYCnsrgH4ncp4Qe7oon1aDujBgcNqdlM6eI5f9DR
         KdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103054; x=1694707854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvzD/fldFQKaf8kb1yG9GuK5+6b4HWZJ5ZD4Bk6TXIQ=;
        b=Dsgz8VLjQTWNvfd9iwgTXQGvNS4KtKTX+oCGwIpARmTrKSaqlKl+TUid6DBa/Pzait
         1w5+M69tZnSdof7z6qeqnYjj2b3b77rynSoAxrqqpLoiN+wG19NRupixuEL0u2pg1+rh
         BI08bfesx7oWGTUy6yU+MtnWI5VdC8emx1uYzZxKTUsQxgKXHmQ+eDlLOnwRM5SWeqEn
         uCT17oVDisZUdhgJMfCcdnEhkB56ZkYHXCauBKx/dm9377RSARBt1rolnZgX8idFU4Pv
         bFNzWOiZMvnb+7i/b++m98auv2TwjdpcGr1F+4FAcjWtm1xYrsB4OfeuXN7aDhVqBWEe
         MjtQ==
X-Gm-Message-State: AOJu0YzW0T6bem+pBNEi946NCtwm/eI56hauRqjI1UfTKzR9lmqbjExx
        Zj5CrqYA62Y1DJjz+VkkmgJivMzu33SYCW4sw3TpWynf
X-Google-Smtp-Source: AGHT+IF/7LuxvkOfkFscemDosYNIt6vMbfGjGUdOF30QsAZrAUMPzaaXWNPMZ5xkwmmPcBpw4PBNseXVYo6bNa9d0Zs=
X-Received: by 2002:a17:906:30cd:b0:9a1:d25c:55e3 with SMTP id
 b13-20020a17090630cd00b009a1d25c55e3mr4301469ejb.16.1694075537814; Thu, 07
 Sep 2023 01:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com> <20230602102533.876905-11-christian.couder@gmail.com>
 <87pm5nstli.fsf@iotcl.com>
In-Reply-To: <87pm5nstli.fsf@iotcl.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Sep 2023 10:32:05 +0200
Message-ID: <CAP8UFD3bkVGB+K9HAtGooGoJTpMck2xUv+wJzikNbvZq3nyHTQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] replay: make it a minimal server side command
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 12:01=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +                     decoration =3D decoration->next;
> > +             }
> >       }
> >
> > +     /* Cleanup */
>
> Nit: I don't think this comment adds much value. I would argue it's more
> confusing to have it, because there's a label cleanup: just a few lines
> down.

Ok, I have removed that comment in the version 4 I will send soon.
