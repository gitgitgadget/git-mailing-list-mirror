Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A200FE95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 10:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbjJHKub (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344660AbjJHKu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 06:50:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA51BA
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 03:50:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so6469044a12.2
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696762218; x=1697367018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8sZ6J9Yeund4w7KUEaQOQ6dZNr2wt8UyCXQhxEHy58=;
        b=doXlucw9XvUvMdC2Ehe6l1UAm3CYXe2g2XX0HOB0Rcoq+DuzcPDaq6HwlWJHNuIyGJ
         4TTVEDnjvY31Ay5dMQGBsKYYRO5sti88M57Pwa/6SGLBV24uxnCNVgEZwa4gqsnaxb4E
         el2YRcQBG85CM8NO6OVKNX+Pfnoqvi+JYijNp2FXXOCv6aYRc9RSfkiJS0Dg39cnnYIP
         xkDi4FXMChmZOnrV9vxiNkh4jYBFq9wIe60MVfFTmfV5/5Ts4Y8YYbH5s101bPWbnp5T
         3nn0jcSCYvOdYuUQ8urTCUnu2TvAzCwcJJX+Ctsu6/5k2KeH0CldjW1TWaEnE3l99M2c
         aJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696762218; x=1697367018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8sZ6J9Yeund4w7KUEaQOQ6dZNr2wt8UyCXQhxEHy58=;
        b=pjK3C9qL8SNQuhPdzxRG3fsLyZdbLqt7dGY3S7TA+ZQvF99yfmEh8qIyUOt+6pLzCu
         LpMHtEIfNpxW2PZLwAENMQ+qoJDvNVSYj91OCtlkthRj774Wuiia03MvyhErVyywfhd1
         dKu6+wnZqpgmrPRc8O/5//vKgWeND9kW8/RS2wEnOk4ducm8+/MY7bW+IRa/JfJwmcuz
         ivcyPcZOiSLLTu2oCnXqiXjwuJ5zmUyYbQMalCUoIHveUHyztK//lE0ji0G4JZp9VS6Q
         oHXR5k7ol/C+OZhDPcBHZkE0Q3zHqtXAPLRKH8MVZHe4LCQKIqeBbd00S9w6bmOPGEIV
         y1pQ==
X-Gm-Message-State: AOJu0YyZVcRTJbkE6YcO+9XCgC9GYGiwRShIn8LbBO0Xmfa6qpxhsJkJ
        Hf1VRk02wVt372uNqcJXUn8EAV2Hek5H+MnnjYGIugw/zVQI7A==
X-Google-Smtp-Source: AGHT+IG8yu2lCTPO1ymzl8XfTP+mOa5DCM+/klySA4I4HdBJW9oCw5MZOPBdQ7C13hk345Djn1XI9EuSo1MVwhT1WCo=
X-Received: by 2002:a17:906:73d3:b0:9b8:df8e:cbda with SMTP id
 n19-20020a17090673d300b009b8df8ecbdamr10437651ejl.59.1696762218301; Sun, 08
 Oct 2023 03:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJHH8bHBA4emP2DkDEzcXncT4K5zEN-pCS+7jjer4R1_kkCkFA@mail.gmail.com>
 <CAP8UFD0mMi2JkvqMdf2mfUw2gA0Sog42ks3umMgsG5k_+W75xg@mail.gmail.com> <CAJHH8bE4QWR1gCgH5mG8qaa5Dq19L25y3VyRxAc3+PQn93oEbA@mail.gmail.com>
In-Reply-To: <CAJHH8bE4QWR1gCgH5mG8qaa5Dq19L25y3VyRxAc3+PQn93oEbA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 8 Oct 2023 12:50:05 +0200
Message-ID: <CAP8UFD3WzgADiy07uLGpj23r3jrUnYh_Wdsc1N8ZoaAHQPDZag@mail.gmail.com>
Subject: Re: [Outreachy] Introduction and Interest in Contributing to the Git Community
To:     Isoken Ibizugbe <isokenjune@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 7, 2023 at 12:26=E2=80=AFPM Isoken Ibizugbe <isokenjune@gmail.c=
om> wrote:
>
> Good day,
> I am interested in working on this issue
> https://github.com/gitgitgadget/git/issues/1555 as a micro project. Is
> it worth doing and appropriate for a micro project?

(I have added Dscho, alias Johannes Schindelin, in Cc as he might know
more about this.)

I think it's worth doing, but I am not sure, as I think it might
generate regressions for a low number of users who might rely on
core.fileMode for some special use cases. (Not sure we would want to
support such hypothetical use cases though.)

Also it's not so simple to implement, you will have to dig a bit in
the code, and not just implement it, but likely also write tests for
it. So it's definitely significantly more complex than a simple "test
cleanup" micro-project. I might overlook things too.

But if you feel like it suits your skills well and are not afraid with
something a bit complex, I would think that you can go for it.

Best,
Christian.
