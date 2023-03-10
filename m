Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DF0C61DA4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 00:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCJA6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 19:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCJA6v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 19:58:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441EA103BE7
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 16:58:46 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id i10so3938398plr.9
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 16:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678409925;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2dXBTQckQFRna/whl8pTvPOT7Xt6FltxtDa6e4H039w=;
        b=P6OSn3rp2+xZJui+H4HvE0C4LMHFvluUU5etFtI+USvS0LwNIW5wbbn2iLQVyLFsuT
         1kCHjUkTebHUDUg/uHwClC5VnZKZQmIvW9dFqRuPILdEdB6qALnQ3I4fkfMc4aM8Zn4Y
         r1PU31aW5I0dQwjAJBOUkJV4HNP+LkkFJwzMfxQ23lBTITOHedN9H2EB8vXAyOtYZSWR
         vD0DLc7fVyCQyEYYIwgX9H+/J8YYBixJvFpGFxj8/c0aQYlrkbqhcAka80/r5Augf8FO
         PibpSAonFg/IXjU9CuNh9YmzmO0sUcLnCsuaLAjyezinNPZbOAmGpWPEGw91NYkPcLW1
         THlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678409925;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dXBTQckQFRna/whl8pTvPOT7Xt6FltxtDa6e4H039w=;
        b=yZWjp/vTRGTvjS+USqa87p43tOJ84/o3+C7aURlf/duakcGj2/aTVo/cHPiEqYG6WD
         xYpmeXGc23fWs00apyB6QstiTFzXEoVA4zSsMV6wNOjBcpeYe9rBRKUODV70KS0y2yq/
         +1AMM9bn9Vb1VVttD7bxLRfWbzTA0s5aYwRf45/cWQ1Vbc685RL8SNj9aDUxOO+XknUH
         iiCNS/5Tw826teG3+cPV38OsEm0bDPAFGRNPE+X6++Xz5R/2jEcp6Mg2Y7OJihJeomFD
         yhldEFdckD0N+ZNFNW8SIw49kQ/l3fZnotjqxgR2RA3dSXdaOgKKpu+nJm7amerzsnXR
         4FWA==
X-Gm-Message-State: AO0yUKUncqe0SvtdwN6VasbYRQsgFXPm6DN5pKLxjTRU/DlW3VPTV+D1
        61C9Xf8zauZRvV9Zq07983s=
X-Google-Smtp-Source: AK7set86OsuwFBQlJhLXCHcp44nXB5BovacNy9wjcMaJonALDqpyS8hpWm68yX0ZQgpVkI+WkmCiPg==
X-Received: by 2002:a17:90b:3812:b0:23a:4875:6e1a with SMTP id mq18-20020a17090b381200b0023a48756e1amr25361151pjb.25.1678409925497;
        Thu, 09 Mar 2023 16:58:45 -0800 (PST)
Received: from [127.0.0.1] ([49.204.129.143])
        by smtp.gmail.com with ESMTPSA id np1-20020a17090b4c4100b00233864f21a7sm467328pjb.51.2023.03.09.16.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 16:58:45 -0800 (PST)
Date:   Fri, 10 Mar 2023 06:26:40 +0530
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Hariom verma <hariom18599@gmail.com>,
        Victoria Dye <vdye@github.com>
CC:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: GSoC 2023
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+CkUQ-T73NqPjzRT3t7X0PgoszHwVVWwPOnhxwFL7TcVhT_3g@mail.gmail.com>
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com> <CAP8UFD20=SScM3XA4mjiNs=rHJY3i_9MOcL8uxsFT-mn1-JH1A@mail.gmail.com> <07423D73-8CD9-498B-89E7-7241AC6490D3@gmail.com> <CA+CkUQ-T73NqPjzRT3t7X0PgoszHwVVWwPOnhxwFL7TcVhT_3g@mail.gmail.com>
Message-ID: <BC0F01D5-595C-4A99-B046-A1E950726C8C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hariom and Victoria,


On 10 March 2023 12:15:32 am IST, Hariom verma <hariom18599@gmail=2Ecom> w=
rote:
>Hi,
>
>On Thu, Mar 9, 2023 at 10:49=E2=80=AFPM Kaartic Sivaraam
><kaartic=2Esivaraam@gmail=2Ecom> wrote:
>>
>> Victoria and Hariom,
>>
>> Do kindly log into the portal and complete the process and let us know=
=2E
>> Once that's done, we'll add you as mentors to the 2023 GSoC program=2E
>>
>
>I have accepted the agreements=2E Let me know if anything else needs to b=
e done=2E
>

Thanks for the quick action, both! I've added you as mentors to the progra=
m=2E You should've received a mail regarding it=2E Let me know if you haven=
't=2E

For now, that's all that you had to do=2E Our next action at GSoC portal i=
s likely needed only after the application period starts (March 20)=2E So, =
there's still time for that=2E

Here's a link to the timeline for reference:

https://developers=2Egoogle=2Ecom/open-source/gsoc/timeline


--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
