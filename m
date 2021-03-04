Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C07C433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 09:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C440264F2D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 09:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbhCDJyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 04:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbhCDJxs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 04:53:48 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32EEC061760
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 01:53:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p8so21824016ejb.10
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 01:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PyBIv+NGY0r7TbDKXPeSXkayErtE3Db3q7Q+e0N7uKM=;
        b=btQvE1ZZlznSBaz+2x8Ultp+tdSAjCwyj9S5tgh7X9lfaB+FIIk0h51N5HUeAN9vMv
         A1rmsDiH9YFTwhQutcjcNnkCXOR6mpQAljuhccejtuMUs6UOVmbyHSNpwehzZEv3Ks8H
         AucfmlQPX9g0Ldjx8WcdmuXk1GlFJEwhswaCu8e1e0jvKktFw1sw9s4kJHiPAIOHxqMM
         YlY+aDChHtLjhKiq0Brq9HmkJV9mCrBZWhg43GDyHbJbFk0nU3j2AFfcB/VmrLwuegM2
         3fdZPDuYPCZiHG/U1zZgHWgQ8O9ABG0Qd9v2PT/tsQ5ROxlahWRysVvx4w70Ltq1RX2x
         E1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PyBIv+NGY0r7TbDKXPeSXkayErtE3Db3q7Q+e0N7uKM=;
        b=JHNq9PFJVFgfiuqnDLYLFae3mJE91QRXbRqB9luRhFOgHLapm2mVcxdfd8DHkXZq3A
         Ti01JYZtj5glY9cz5ffRdRtaH8CW73TSSjxgVgXm7Br3sQMPQ8GlFvfUogkJ5o5ai2Ci
         0pqR9ow5YhBylvhcMiu0EexgsuXk8cCjHCr9QfidcwWT9lTxDBndrY4IdnOhr9kMbsg8
         OKqx8EdQguio4Q+g9zPnESLmUz8YYx0yDLuyPM32e9qXafObo58+tcJdg3A3GG7gXv8l
         6gj8Z91ZvGWUQFm7ZlRcMs3cAG1xUHpG/A+8fv9k7wuLQSRaNkCgO5Wud9Wpg5d3vbJT
         kw+A==
X-Gm-Message-State: AOAM530O99+Go0ovC1ueUMEPOblbIzKvLdwOp6DJQ1jYUSLf3rBB0fng
        uxgr8AhPIgXREom9n78nkxKVi/fBPz3nfwbCQHYiDqiWIpA4SA==
X-Google-Smtp-Source: ABdhPJx+haQ9J/jp7zYa8+MnNT3wdmRUrmwvdRPciM2DxPqkVBVQV+y4Sj0i8GLizAbgOONatoS1p0hxZKslHLhaevk=
X-Received: by 2002:a17:906:5849:: with SMTP id h9mr3336697ejs.551.1614851586526;
 Thu, 04 Mar 2021 01:53:06 -0800 (PST)
MIME-Version: 1.0
References: <CA+cU71=FfReSG411Feo=vmkw4MdK4KDgokP1jH6uwOkC_0AbYA@mail.gmail.com>
In-Reply-To: <CA+cU71=FfReSG411Feo=vmkw4MdK4KDgokP1jH6uwOkC_0AbYA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 4 Mar 2021 10:52:55 +0100
Message-ID: <CAP8UFD1gFA2DyyjyfJ7pKNRyqO2=Y2BOyF0Aeni3GXvgeL8Wtg@mail.gmail.com>
Subject: Re: Can I convince the diff algorithm to behave better?
To:     Tom Ritter <tom@ritter.vg>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 4, 2021 at 8:37 AM Tom Ritter <tom@ritter.vg> wrote:

[...]

> Obviously there's nothing incorrect about the former diff, I just wish
> it was the latter rather than the former.
>
> I know that git includes four diff algorithms; in my testing patience
> or histogram exacerbated the problem; and none of them improved upon
> it.  If anyone has suggestions I'd be curious to know if there's
> anything that could be done...

It's not so easy to implement good diff algorithms. You might want to
take a look at the "v2.11 new diff heuristic?" article in:

https://git.github.io/rev_news/2016/12/14/edition-22/

Best,
Christian.
