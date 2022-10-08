Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688E2C433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 07:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiJHHX4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 8 Oct 2022 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJHHXx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 03:23:53 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013DE72844
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 00:23:50 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id u2so3521401ilv.6
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 00:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEoDr80Bmy4gHliAPfpzorrau5boWRmgQ0Fp0iDubgo=;
        b=0jWR9DmCgZ7PrH60cUKfunYgmJvvuXUGTtQzgVQUBjzgnVH8d3C3NZHzEiud+ZDdTI
         D/XhaoZyZ1wMDU0AavJyObCRkCI/m/aItTPFmzGWgYjTaQB2b2DOHM7VDPo3OhRdImyj
         uF3LoJLVDi9MUlR5q7CblipVSw8kJa7yhzsey7r+DVq/YxsrpXN5n5WWHu5c9FmIQF4V
         cM3l98Wnb2xCqmm66Lq/CQdBw+qaC4XrrG9p+C32yDvgWJUVGlx9ePqZmutKVpy3NzqW
         g3sEkaZ165eScQTKlCslVp4sT21CncQihx8OQMI/71C1MmlQy6TuJXhVn/ZNbJv9PCpK
         Jkcg==
X-Gm-Message-State: ACrzQf2AyVTmvIsZrNlyPQw5pao3N5SVXDKZ6XVS87BacdI15KuMiKav
        gX8Gyz33kWLDs5699vzUaJQFG6+Lc7eWFgzc1J/ZN1SLB/U=
X-Google-Smtp-Source: AMsMyM4T3O0QIeBnyx6j3kAdkFrNTe2aWbBAynWw1Tx2zvqDKt8n43OD3Pk4A2sC0USV7TbEXgof0VYj6kI82eFvjXE=
X-Received: by 2002:a05:6e02:b2f:b0:2fa:1c95:5c98 with SMTP id
 e15-20020a056e020b2f00b002fa1c955c98mr4309228ilu.249.1665213830245; Sat, 08
 Oct 2022 00:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com> <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com> <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
 <f24837e9-7873-c34c-bd78-8ae3be0fc97a@gmail.com>
In-Reply-To: <f24837e9-7873-c34c-bd78-8ae3be0fc97a@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 8 Oct 2022 03:23:39 -0400
Message-ID: <CAPig+cSn29Fq4ywC9zXoJYRVG8KUEhHuDdwEUSioFMUVs+S-ow@mail.gmail.com>
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
To:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 8, 2022 at 3:07 AM Rubén Justo <rjusto@gmail.com> wrote:
> On 8/10/22 5:17, Eric Sunshine wrote:
> > On Fri, Oct 7, 2022 at 9:36 PM Rubén Justo <rjusto@gmail.com> wrote:
> >> +       echo "Branch description\n" >expect &&
> >
> > Is the intention here with the embedded "\n" that `echo` should emit
> > two newlines? If so, interpreting "\n" specially is not POSIX behavior
> > for `echo`, thus we probably don't want to rely upon it.
>
> Oops. Thank you! I'll reroll back to using "git stripspace".

`git stripspace` is perhaps unnecessarily heavyweight. Lightweight
alternatives would include:

    printf "Branch description\n\n" >expect &&

    test_write_lines "Branch description" "" >expect &&

    { echo "Branch description" && echo; } >expect &&

    cat >expect <<-\EOF &&
    Branch description

    EOF
