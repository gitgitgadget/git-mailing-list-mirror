Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3718AC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 20:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCIU30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 15:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCIU3T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 15:29:19 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326FA28218
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 12:29:13 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id y10so3481030qtj.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 12:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elijahlynn.net; s=google; t=1678393752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOCZxN4+YWWjRibHqPX1QNhLQxmz1vuJkvdh0guoW9M=;
        b=OoATUArI1W7vEvJxC8wuyIxLuZGyhKcW1WIutG/dLxgNN28Gdr7zbh446kAud28aOh
         FFvK4beCkTEY0mAVZgrurXsyx45KHp+sYAwLAIoca3o7E8X45O41Hz7BffTrw0hI8XuI
         C/QnNyivbzOE+H9csmz8UbYsYtg/u/SicnOao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678393752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOCZxN4+YWWjRibHqPX1QNhLQxmz1vuJkvdh0guoW9M=;
        b=PKRoc0CbUbKToSVZ6WM8rHNehmcHM2KyJMAnXGZGjWEfU7Cr49bf91uGf6JojCSBRB
         xbiS3wKSI8HVJaCW2NkYjTadaz6eiflO1tOskqFvonLWUlKzpWJru6RnIegJARaZssL9
         8nj3khlTAWpoyF1IZLiiHFLvi3rJdGKLIvCWWfevDzBAiuwFISaqm0vXV9M3BMNSp/R9
         yTSkdl6db2JKIWAXF9ZZtraXh+qCdfvdNZnemKIQNMWL2+s2XSLtbH+B+pEqlv+ktCWB
         pd1qgK4CfY47HJuPHvc2hyJd8o9iYUKCkWPFndQiNTbwRN4J2j+Ez1BdsWEqueMB2Cgz
         Xvjw==
X-Gm-Message-State: AO0yUKXmvzl3qcttLu71cBvsNeXDpo4j0yAouHg792SAJsESP1vcSQSg
        EVpICQlPpdMUlQihU5SXGOGXSXEUtgyfKCG6i6M=
X-Google-Smtp-Source: AK7set8XkyH5NQwr/PpHgUiIR073K2qEV438GOtVUwFUej86kvXMXsZMF5bO7hdM82yAUnwckgo/iQ==
X-Received: by 2002:ac8:5a4b:0:b0:3bf:d00a:2eae with SMTP id o11-20020ac85a4b000000b003bfd00a2eaemr39445228qta.47.1678393751975;
        Thu, 09 Mar 2023 12:29:11 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id d25-20020ac84e39000000b003995f6513b9sm14027860qtw.95.2023.03.09.12.29.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 12:29:11 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id t39so3275524ybi.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 12:29:11 -0800 (PST)
X-Received: by 2002:a5b:1cb:0:b0:a6b:bc64:a0af with SMTP id
 f11-20020a5b01cb000000b00a6bbc64a0afmr14168197ybp.4.1678393750966; Thu, 09
 Mar 2023 12:29:10 -0800 (PST)
MIME-Version: 1.0
References: <SY6P282MB3782FD975E6F39951C5A43DA92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
 <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
From:   Elijah Lynn <elijah@elijahlynn.net>
Date:   Thu, 9 Mar 2023 12:28:55 -0800
X-Gmail-Original-Message-ID: <CAJ9KuXxDfK5rOitVaXQbV2ZDZR8U8Xc2HNCbSGP8DUgN+5waUg@mail.gmail.com>
Message-ID: <CAJ9KuXxDfK5rOitVaXQbV2ZDZR8U8Xc2HNCbSGP8DUgN+5waUg@mail.gmail.com>
Subject: Re: Let us not call it git blame
To:     Dinesh Dharmawardena <dinesh_dh@outlook.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've thought about this a bit too. And I like the command `git tell`.

Elijah Lynn
www.elijahlynn.net

On Thu, Mar 2, 2023 at 2:02=E2=80=AFPM Dinesh Dharmawardena
<dinesh_dh@outlook.com> wrote:
>
> Hi
>
> I am writing to you to request that the term blame in git blame be replac=
ed with something that does not sound so blameful. I=E2=80=99m an SRE and w=
e actively try promote a blameless culture as such industry tooling should =
also follow suit imo. Progressively phasing this term out with a better ali=
as would be great.
>
> Cheers
> Dinesh
>
> Sent from my iPhone
