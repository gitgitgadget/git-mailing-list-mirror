Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC84EE95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 13:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377137AbjJINd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 09:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377136AbjJINdY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 09:33:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7116B91
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 06:33:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5855333fbadso2711669a12.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696858403; x=1697463203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2+9pJUEUYI0JBBqv9G6pO+pi7vGWVjYtxdT013xi+Q=;
        b=TqmS9Co8zexdNDB2Qsq9RjWz7qF/9ksGCth6zm49Z/AjhIQXH1vrC9z57XZLacu0bd
         7UqPGadwieSCa7B6BvVgDSQgDGLGwv97wnIPAxYp15LvPe+9YDOaUd67DWtuRYFYj4wX
         TzMYOnOVuMNRUjJcpRndLvAUtBKbg29me2+AsEOpqV29O8KTlHKRYU8+qeFqCynjuK0i
         3kD+vZtzI4X75aeB0LvUxwQKGYZXzwlNdhpXRYqIIOA+vsFmelQpb2AnLuULZzNyByED
         ZGHv9Ie9udJiJWtt2u4geMvdsqeN74i0pB9QP9ge7hq7FcKe7y1LfdPIO8tk9MXhpZeP
         /diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696858403; x=1697463203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2+9pJUEUYI0JBBqv9G6pO+pi7vGWVjYtxdT013xi+Q=;
        b=mIA66B/4/ar8l40PbbVXBJ29h7+qfXltRqMSG3aLktx3Z/t+4G1SmvkmPGaHGCWFYY
         FIB5z/0y+STlkZ5vjmxWB5zAUD/tdfJdlwI68xGxYvfB5vtApz0xmCaSngp4fmkC+Xlc
         mS0gCGhNR3Hx94GLPqgHCOwiRNBXHCC5enIz7DKS7TDeWjapf2XlD6ttSNmG+tZ9aHpp
         +JJSXQErLXw00XhbBeOEVjXy8ierVQfGZmXzSqFGbvON+PE1hdFpU2gZjBuF+7GOwUCd
         CbuA9bz5VHJsyGbinVJr4BGpt0eP1n5c79xE5DcdEceaCN4lAX9NiizYM3BBnp3S4LHP
         wdew==
X-Gm-Message-State: AOJu0YwfxwvxTNfVLmckUt0m/AoV2sfrF4L4u5I51b2OVp+f0TjT0ib0
        TxlngmybwYCQ1qHowwO4u72wFu/BCRpnzyz13FQ=
X-Google-Smtp-Source: AGHT+IFUxKVQREuwb6iA3YQblQ84TU8w3pm4aoB9/ilM43JbexA8CjHIoXQDRsszePm7E4nDoUVR0UhshUC2wTWPVuY=
X-Received: by 2002:a17:90b:4c92:b0:268:93d:b936 with SMTP id
 my18-20020a17090b4c9200b00268093db936mr11552385pjb.18.1696858402707; Mon, 09
 Oct 2023 06:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAJHH8bHBA4emP2DkDEzcXncT4K5zEN-pCS+7jjer4R1_kkCkFA@mail.gmail.com>
 <CAP8UFD0mMi2JkvqMdf2mfUw2gA0Sog42ks3umMgsG5k_+W75xg@mail.gmail.com>
 <CAJHH8bE4QWR1gCgH5mG8qaa5Dq19L25y3VyRxAc3+PQn93oEbA@mail.gmail.com> <CAP8UFD3WzgADiy07uLGpj23r3jrUnYh_Wdsc1N8ZoaAHQPDZag@mail.gmail.com>
In-Reply-To: <CAP8UFD3WzgADiy07uLGpj23r3jrUnYh_Wdsc1N8ZoaAHQPDZag@mail.gmail.com>
From:   Isoken Ibizugbe <isokenjune@gmail.com>
Date:   Mon, 9 Oct 2023 14:31:55 +0100
Message-ID: <CAJHH8bEa=xE_xNdbW4rDJQQ9dacAuFQseajdtBmGnZ1bDxZsxQ@mail.gmail.com>
Subject: Re: [Outreachy] Introduction and Interest in Contributing to the Git Community
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Christian for the help, I have another idea for a micro
project "modernizing a test script". I have found test scripts that
needs modernizing , which is to rename the setup test 'prepare
reference tree' to 'setup'. Is it appropriate for a micro project and
should I go ahead with it.


On Sun, Oct 8, 2023 at 11:50=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Oct 7, 2023 at 12:26=E2=80=AFPM Isoken Ibizugbe <isokenjune@gmail=
.com> wrote:
> >
> > Good day,
> > I am interested in working on this issue
> > https://github.com/gitgitgadget/git/issues/1555 as a micro project. Is
> > it worth doing and appropriate for a micro project?
>
> (I have added Dscho, alias Johannes Schindelin, in Cc as he might know
> more about this.)
>
> I think it's worth doing, but I am not sure, as I think it might
> generate regressions for a low number of users who might rely on
> core.fileMode for some special use cases. (Not sure we would want to
> support such hypothetical use cases though.)
>
> Also it's not so simple to implement, you will have to dig a bit in
> the code, and not just implement it, but likely also write tests for
> it. So it's definitely significantly more complex than a simple "test
> cleanup" micro-project. I might overlook things too.
>
> But if you feel like it suits your skills well and are not afraid with
> something a bit complex, I would think that you can go for it.
>
> Best,
> Christian.
