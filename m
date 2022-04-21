Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD532C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344270AbiDUTZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiDUTZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:25:34 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE554D602
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:22:33 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id r8so2786252vkq.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEeU8WYudyQTn7TDJyY9uVG+M6xI88FxuxvuCsi6qHM=;
        b=NnN9I1QszBC6wTKez84JrtU4ohDw4xZzPYEznCtfvb5Rk1CNnc4qeVDGd3h/DzExML
         GkeCyM1G5CnwoCvr6HuT6MTnNWxSXOqSxUYIaf0K3+v2bIXbQX/4fLVpX1dVk2tvkEVO
         4A0uOTzHGxYALhg358ALAgTGP6ECzGJFMaRj1dpv0wRV+qBedA4dekCZutFS8Uc6Jtai
         guP95J2k10lPWr1ck5NXjQETh61RBooyCXcSmfPu00z9rsYd9nnZfcpTmEvud4F5kkJj
         07Hd2q+YsyV/8DlAYh4D0gxT3nx+L51C9ao4WtM7THyulPoV0HqBC+SZ624NhP+1+pa1
         xSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEeU8WYudyQTn7TDJyY9uVG+M6xI88FxuxvuCsi6qHM=;
        b=nQpkrm0xWlfMxnShV4AwtLsUNFPppLr7pFZj9OnTj6Z9Dhkb4wBkLVJ9o1Vgf2IMAJ
         asAXiI4e6YEsSEwtwngz9W5A1MwgIIc6q0HRTpKNlwz0RPOcAqn/H/v3Q6PLNuOg3p55
         EhFdBQaF1hn0jZWxZgZqK6ft4VGiYNmVUkRkslt96W8ZK8Cj9Om/VRNxi5cyUVbOGoTv
         TTmKqdFYZSUEC68Di1bHT+s3olbFsckZ+VBX4R0RfsJ9I+XnhYd+H/HsJyLjUhYFyqxT
         HB+RtauafMU2lSAGH1N2HW2x1nVs1tz6p6+DKdWtCXtVUi7q5Kb5UboMPvqsvM2KKRSn
         c5vQ==
X-Gm-Message-State: AOAM530KjK/ocXYBvMtLVePHcvIp+maeGDm0gbBicAsbvnfBIXNH2JRB
        eeK0mHbmLrvd+l4yyc+XG9D/yeAibBXapgNncyE=
X-Google-Smtp-Source: ABdhPJzwQvN4ZnyoDXgn0mqXN2lKvQO8w9mx/PG5kl4jJ26b6XKZ2zHxAZYa0gM6eWRXdcZobX74WhQAHJv4RsMULoY=
X-Received: by 2002:a1f:38c2:0:b0:349:9667:9232 with SMTP id
 f185-20020a1f38c2000000b0034996679232mr447002vka.16.1650568952156; Thu, 21
 Apr 2022 12:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
 <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
 <CAPUEspggNfra_C8PBcVqjZrxxnswg27WFLg2kT6JOCMB8f0FGg@mail.gmail.com> <xmqqv8v2gsjl.fsf@gitster.g>
In-Reply-To: <xmqqv8v2gsjl.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 21 Apr 2022 12:22:21 -0700
Message-ID: <CAPUEspgrk3+FAo9Y6VWcYddh0o4xCkqmQ=GLap1XomcMmnFCuA@mail.gmail.com>
Subject: Re: [PATCH v2] CI: select CC based on CC_PACKAGE (again)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 12:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> >> -       CC="${CC:-gcc}"
> >> +       CC="${CC_PACKAGE:-${CC:-gcc}}"
> >
> > minor nitpick, but most likely still relevant considering your other
> > "bashism" fixes.
> > the POSIX syntax doesn't use ":" (documented in CodingGuidelines)
>
> You are reading the guideline wrong, I am afraid.

Indeed; and I realized it as I was trying to answer my own question
about the compounded replacement being supported.

Wondering if something more explicit might be easier to understand anyway like :

  if test -n "$CC_PACKAGE"
  then
     CC="$CC_PACKAGE"
  fi

Carlo
