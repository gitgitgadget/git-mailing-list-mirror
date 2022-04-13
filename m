Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78315C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 08:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiDMIjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiDMIjp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 04:39:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4284B35249
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 01:37:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id be5so1329831plb.13
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pZucN1U6MLGXz3V9CkoF9U4HsK3JpooSOvEvy97rEVg=;
        b=H1MLY5SAOHvrdkBnWx5jfVjGgqgRXn9tL9Fnsjv9W3JKbfwLDyRr3kGVwmPty1gTDN
         l/JZ0nrI89uLYKyDH7eH0Ktrc//vXmj0KrwrUqHwB0MulvO2H3EuT7VBK7Z0ZFxK2LsC
         S6Fp2FJHZKFMhHXUi8C58FpscaFU8iyViIzZaY2JLfRLA0lj61UliyL3rmveHfLgvc50
         7GTOk+tQrr/OPrMTgOXWTPFumbJr7RVOm5nWurC2VDM3C+cdVXyvm1QT72OKviZiZAy0
         wTMxjC/PqKN0HQfljK5B7cRrTp9v6IA9JBw5T4Wy5wW9IeMog4Odhqf1oshPk5i52bw9
         lNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZucN1U6MLGXz3V9CkoF9U4HsK3JpooSOvEvy97rEVg=;
        b=pH96Wfp/Lk5N/mnTVqdniFhUhNYfTkKw/ICRHwUz/1SFMvYz7i3PyCGzQ+kVTep65o
         IzM8UcHMnW7uvVL0ligGvliFur0R67xRhWvgXNZPsoqFfog4dseog+DcIJQCDjDDMdeZ
         /nAXTToIsjY5XlyZxk/2rdPQjZy0RjaU0W6dIqv/KRYQ61GGXmuWIDJoHk0/5TfcttAQ
         aBGU7cURcc/2Vhb+kq7SJUUVRDs8PgNqnkZaDQEb8OmoUZyRgsKRzYzTrLca+gOgh9N/
         Y2VTRYD2Oz4R4Cqwn/se/06Sk7ULrkzH6Xk8ol8pYi92TFeOOA92nvMnJsomq/kp01Fu
         Yh6g==
X-Gm-Message-State: AOAM5314fsy29vziIx+g6BIq1rfABPVrxu6uZO8W1cUn2t2V9fFBQ8Wo
        ZBb+JyMMzeCGTK8KS6kfY1+3QWjpJl4VMx9QWR5S4iinzQ4=
X-Google-Smtp-Source: ABdhPJzRkeDmQwTkm+KnYsTGp/XboLK4EwUsb/7Lw7/2lgF0KMtVCmON/vvuxvIpBXvlCmknnKzzkJNRnVr6SN1TchE=
X-Received: by 2002:a17:902:f54f:b0:154:5686:7616 with SMTP id
 h15-20020a170902f54f00b0015456867616mr40640481plf.125.1649839044545; Wed, 13
 Apr 2022 01:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <878rsbof6v.fsf@drac>
In-Reply-To: <878rsbof6v.fsf@drac>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 13 Apr 2022 10:37:12 +0200
Message-ID: <CAP8UFD3zZuik9VkrTLivOTjK5GWJ1kEO3hNFN-18t12OFq7Org@mail.gmail.com>
Subject: Re: git-bisect behaves differently when started in equivalent ways
To:     Christoph Groth <christoph@grothesque.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Apr 12, 2022 at 9:51 PM Christoph Groth
<christoph@grothesque.org> wrote:

> I found a puzzling behavior with git-bisect for which I was unable to
> find any explanation.  Since this might be a bug, I report it here.

Thanks for reporting this strange behavior.

Unfortunately when trying to reproduce, I don't get
"f5bba2a7147ef8a6980ff043e93dd038c14bb9bc was both good and bad" like
you, but the expected:

Bisecting: 2606 revisions left to test after this (roughly 11 steps)
[b335cf582f4a789b725cc37822d6eed42c8d9e71] add test and fix space

You are using Git 2.30.2 which is one year old. Could you try with a
more recent version like 2.35.1?

Best,
Christian.
