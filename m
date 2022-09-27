Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40104C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 08:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiI0IKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 04:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiI0IKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 04:10:09 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C1FB6562
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 01:04:01 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-324ec5a9e97so92604187b3.7
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eQ6dt5d/02hKQ0Y1y513jzIZa19YOXc1oLwgFUVXg0o=;
        b=OwTUZfKhRQoXyHadSshWo6VcHmoVL5beZ3Wg2zAqLRFKWAIHBv/8rI/9u1Q+vWHnsu
         RtBUvkhnOeXFN7mwTrsRqAdHs5Gv29ADTYgb8cttR/ywC8tJ8EG96tnorZs7b/LaA+lO
         eGzQC4oog+590UIv5dIDkl8FmYp9260jNJc1vQk+H4EXFW9vnbuK7l/lTA6Ct4RrxID0
         FwmrO9Ek7lY2GyKcnlkNvIWvND7jBXlv2QTR2qQLelp/MgSXhADbtdMTuwZF6dGRZ1Xl
         ifJfpYYRGdwNm/5LtWYFX3dbwSPguVa+JnXukgyOnnKh/jjwyrK0wNToeqqI/t7gz+qY
         PStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eQ6dt5d/02hKQ0Y1y513jzIZa19YOXc1oLwgFUVXg0o=;
        b=X7vHHgUUdiJhQQrb0zWXs8KGtmK3NxpCtZ0NHDmuKQN/prcIre3w9QV1foADxoCGNa
         r9wgtby8VCU+iFB/CzR8/Z3FFLrU4UTzvryGDhlvWF4XOd3+DWyztLornrKDEycMab68
         s8HmoK9LlD9gYmQSoZaUpXCJX9A93dVVLvYaVcg3fDwE7MZWSRApAGWiHQMXHr3RscAu
         F4gBMqxYRJBbdsN329RkO2d23ErI/UfTPPL3Y8qcm6Ub6mHc6nxo9c6W7gSzpZ3WiRW4
         ZpDZPjj6D3Wth9A6Z315nWlLcNypZbStAY+d62eKH/JAPCbByiKYTfXxmPSvXA5Vo2Cx
         Ndlw==
X-Gm-Message-State: ACrzQf0bikZd8LwLOJFWkZV562LOJkhtgvIo6QtEDZ9UidypuZTlGkks
        aRjROMCgtMeHuAUGuhiw5RS7VpOgqSGSWNS3xfc=
X-Google-Smtp-Source: AMsMyM5FDnF9TDpiMagmSqAA442kS4AYzZgvieU5pebNiT8PGfSrKQGKgZKDu/D6MtNzRAIYgGVL22XqQIJk2i8UluE=
X-Received: by 2002:a0d:d481:0:b0:352:739d:9408 with SMTP id
 w123-20020a0dd481000000b00352739d9408mr85096ywd.365.1664265840975; Tue, 27
 Sep 2022 01:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <Ywzv7Dl6n+LcY//n@nand.local> <CAP8UFD2gUTuae0nRp2jHHoD3yLsVSGTBzEuHkv8QLDGJVAZ-MQ@mail.gmail.com>
 <CAP8UFD0+qW9aRVbXeKkvZKKi-6rge851FdT3FxPW98_JH_KLRQ@mail.gmail.com> <CA+CkUQ9xOF3UfSO_Zim-JT0020U_3eS7GeEVrH8UDDqQbhN9Rg@mail.gmail.com>
In-Reply-To: <CA+CkUQ9xOF3UfSO_Zim-JT0020U_3eS7GeEVrH8UDDqQbhN9Rg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 27 Sep 2022 10:03:48 +0200
Message-ID: <CAP8UFD245D3de-QK5_Jv449QpWCwbFEHrKg9C_B3OFRB9N-JmA@mail.gmail.com>
Subject: Re: Git in Outreachy? (December 2022)
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Sep 26, 2022 at 7:52 PM Hariom verma <hariom18599@gmail.com> wrote:
> On Mon, Sep 26, 2022 at 3:21 PM Christian Couder

> > If there are many possible co-mentors we can still submit more project
> > ideas into Outreachy's website before the deadline next Thursday.
>
> Sorry I missed the discussion on the mailing list. But count me it.
>
> I would be happy to co-mentor.

Great, thanks Hariom!
