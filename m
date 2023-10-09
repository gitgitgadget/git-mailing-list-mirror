Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD9AE95A95
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 13:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377350AbjJINiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 09:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377333AbjJINiq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 09:38:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D9812D
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 06:38:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso817166566b.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696858718; x=1697463518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3quW/p8YEGcN1i7w0+Z1d6Yryrphnjdlqr7/6tdRiDA=;
        b=D4HPPhMqLIA+nk/d/P8TWS0lr2cbUQi6ysoy2cV6aSzlcioydm1ZZMm6IOVaBwtE8A
         I7bzohj6a6C2USG5BoqxFG3vg70Ojaqv9COWgHlBmq9/t7i5tb3mTR09qA/gtKYEr59H
         YnBc56X6Zzt40Cczi3IbcsIZVXSR+eUbxG/iROmKpr1Wf6J3cQhOYCimmxhtdoENnO/e
         q8boyxdnNSsZf54QuDUCcPWq3aS3vYwnG8GapC8LwZXKGXBukPyZgp1w08F6AzCQrMPD
         1loNTf74G3QYUUEwugk2Z70h4ugWxqQwFfA5Ylqcjlsd48fS7bQEafa2T9QcFDZPIhXN
         7rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696858718; x=1697463518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3quW/p8YEGcN1i7w0+Z1d6Yryrphnjdlqr7/6tdRiDA=;
        b=QAPiXTk8Utd2jt64fPhOi5u3KHWc6MBkLT4DpNfrw7cz2udl/aiXyuwZLQ+kei/RY1
         YUW5zmpxXLdqhGRauMopyhSYbwYkiqUJA+xa9lP5b+Xz2oOPGrJze3ROVJDdJbf42JDT
         oBjGh+BqHBpfOsMKNdH9FztiWK//BAjWhFWtzdh0mCbe5e/cN5O4jVdY+6oty5gu7dO3
         yYVA6/s9BIDdHlAQKbZX+PE8QlzsUoQAIBoeagCJEmKQV7xPx7qKoZ1Wgc+tMTJ+m4/B
         RiYpO4nIThz26KlGfGXCsLMhOkqlLohSRiJZCK27cxNDXnp10dr9MN4tow+kxsBr71Ht
         aenw==
X-Gm-Message-State: AOJu0YwOUONwJIZ6n+086W2YQBoSUfPHesaJkX7Xb9nIocyUMqkq71XR
        xGS1fb0y296LZe2zeMU05Ocw3GjIkWAZOW+pmp4=
X-Google-Smtp-Source: AGHT+IFw/oyyFUb9gKM366Hw21NGWlbUeyXYX26ERYkhSvvtBr3m71E2PBBV38p6XAQzErtkPdggiqc5Wzp5JqVD9KQ=
X-Received: by 2002:a17:906:8b:b0:9b2:b149:b81a with SMTP id
 11-20020a170906008b00b009b2b149b81amr15679099ejc.64.1696858717970; Mon, 09
 Oct 2023 06:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJHH8bHBA4emP2DkDEzcXncT4K5zEN-pCS+7jjer4R1_kkCkFA@mail.gmail.com>
 <CAP8UFD0mMi2JkvqMdf2mfUw2gA0Sog42ks3umMgsG5k_+W75xg@mail.gmail.com>
 <CAJHH8bE4QWR1gCgH5mG8qaa5Dq19L25y3VyRxAc3+PQn93oEbA@mail.gmail.com>
 <CAP8UFD3WzgADiy07uLGpj23r3jrUnYh_Wdsc1N8ZoaAHQPDZag@mail.gmail.com> <CAJHH8bEa=xE_xNdbW4rDJQQ9dacAuFQseajdtBmGnZ1bDxZsxQ@mail.gmail.com>
In-Reply-To: <CAJHH8bEa=xE_xNdbW4rDJQQ9dacAuFQseajdtBmGnZ1bDxZsxQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 Oct 2023 15:38:26 +0200
Message-ID: <CAP8UFD3RV-70RG6H86+7E-ZKrqhfgFRfRQdMc6DLGMXPAEf31Q@mail.gmail.com>
Subject: Re: [Outreachy] Introduction and Interest in Contributing to the Git Community
To:     Isoken Ibizugbe <isokenjune@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 9, 2023 at 3:33=E2=80=AFPM Isoken Ibizugbe <isokenjune@gmail.co=
m> wrote:
>
> Thank you Christian for the help, I have another idea for a micro
> project "modernizing a test script". I have found test scripts that
> needs modernizing , which is to rename the setup test 'prepare
> reference tree' to 'setup'. Is it appropriate for a micro project and
> should I go ahead with it.

I am not sure these kinds of renames are worth doing, but if you find
some clear doc or Junio saying that setup tests should be named
"setup", then that might be worth a try.
