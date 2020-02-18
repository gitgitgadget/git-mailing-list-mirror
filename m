Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E520AC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 11:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04E0206F4
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 11:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=loskot-net.20150623.gappssmtp.com header.i=@loskot-net.20150623.gappssmtp.com header.b="glW1ZsAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgBRL7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:59:14 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:32917 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgBRL7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 06:59:13 -0500
Received: by mail-ed1-f51.google.com with SMTP id r21so24536207edq.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 03:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=f+evn0Bnzz64GbFlRM/0XcJ0RH/T3GQ664AlQG3LfiU=;
        b=glW1ZsAedRqNNGts+qdB8xptoMFU3L1gQeNVEHZgPjg3p5phyvPGxUhIF6cAriZaGl
         rUjJFTOi31qdGmsN0eFsLzoa2dJ0c2XeGo12CLHpB25rk2J31nx4NILzR0s15tOnq6+R
         HfTnG7FU78WMRPP/v4hVJ4+fjOEcl/XGyS5TBO9VSVLMBXu2ycgEPlzY06MA5+Q5vYiD
         FPZDRue2VIzNjCuHeQU6aDoRRQ1BXtSlOOguctJf34QIiNn4UDLiRIEz8Zsaher5Xs/u
         FfzjGlmx6TQs7KfR2fqE5YVV2k1yK8QNAdBUlD59wHDYtyCGzcpyxceKMiA0/H5rHjrt
         hQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=f+evn0Bnzz64GbFlRM/0XcJ0RH/T3GQ664AlQG3LfiU=;
        b=nhGJ5sauR5s0LJdyCUeiJieqEM+wy80IzXp5SkUhIvLg0CTwJnJepGhPiNvJGOuATm
         f7vlzUYz4qZpSwalhBJPYXfnjPUvkwQdfmmCJIwREwTxi9dryjvVvFedvBzKvbMjZUER
         DI9tzLpHa5JhD/xLRgsSNIvFdUQTW1thwk7tDYpMx8hpvr2zvb+G7GU3mJ9DVHlYhMYf
         mYcoDbozGZw+WCHSpudLeduyNvx/tNnQ6CL7l8EbQRlM1tflg8A2Xh47BlrHJjmtqHqU
         B+Ha13nc0w6aVWJ/0omMZ00AxjG+E0hR9YHdUg8GSX65RJQe3Yul3TGjqYtkXnbjGxFC
         vN6Q==
X-Gm-Message-State: APjAAAU44mlvM4lhXlbzaYQFkKKkd9czVpafgYv/qh9jTjO0jGG0RJx2
        JW307ty/XLM65XQW0egCCpEmzW2R7g104cOKX0LpU1S331+U8g==
X-Google-Smtp-Source: APXvYqx/uuUFYGYY3IYdCKcrnwV+C2/aBoxIN88FoQoKuvIU/BZsu3MOkW5/z19EwnF3tUxxWSyaMlQmQZb4f5CGFTs=
X-Received: by 2002:a05:6402:311b:: with SMTP id dc27mr18885513edb.36.1582027151468;
 Tue, 18 Feb 2020 03:59:11 -0800 (PST)
MIME-Version: 1.0
References: <3982961582024793@vla1-a6eaa355d163.qloud-c.yandex.net>
In-Reply-To: <3982961582024793@vla1-a6eaa355d163.qloud-c.yandex.net>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Tue, 18 Feb 2020 13:00:01 +0100
Message-ID: <CABUeae8i-8VTw85XUaC_Lef_HFg5vuH6OkTsEjyu4iEZc7kuGQ@mail.gmail.com>
Subject: Re: Question git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 18 Feb 2020 at 12:26, =D0=A1=D0=B5=D1=80=D0=B3=D0=B5=D0=B9 =D0=A1=
=D0=B5=D1=80=D0=B3=D0=B5=D0=B5=D0=B2 <nevercu@yandex.ru> wrote:
>
> Hello, I have a repo - WORK.git. There are some brunches.
> =D0=A1an i view all commits working repo and all branches at the same tim=
e?

https://git-scm.com/docs/git-log#Documentation/git-log.txt---all

I must say the --all name itself is clearer than its description
which makes use of Git lingo unnecessarily for such a simple option :-)
As a Git newbie, I'd have not linked option to getting log of all branches.

Best regards,
--=20
Mateusz Loskot, http://mateusz.loskot.net
