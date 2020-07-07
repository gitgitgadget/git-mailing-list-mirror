Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D288C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7AB20773
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bca1wi9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGGNLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGNLV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 09:11:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A755C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 06:11:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i3so31603467qtq.13
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EYymAiig/rDP51GcX0TKWmi0tlJZ7daRm6vBsf8TawY=;
        b=bca1wi9HZalB9Q8IhfDXHEIL/ztC0MppdOzzAOqRTh+6IE/K6mSAVN/cYj2ErS5Zc6
         /7E+T2f2BMw527gaom0UoudOza6zPSCljPvB6pAxkaQZ8SvFqv6hKnLCBoYrkvwhtF1f
         +xoaqDDOB1tXmgrf+DZIti0WPbCUpwET96lXNX82wGk4ox68AueLEYQFB/qrsWky7JFx
         BI4zgzeG52Z2w7KHQXPwAcNA+gYc7d0k6uBqZ8uwdCX4vklnmvfNcUI9UjV3lwGc/ZTV
         nm/9Rj6r3NL/ANW4mzVq2ltiJMRUCIDokOpTS98bDjBizW1Gu5oAZv9MusK98vOWaBJN
         e2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EYymAiig/rDP51GcX0TKWmi0tlJZ7daRm6vBsf8TawY=;
        b=Oao2JMyht3dcn88CdzGRShKaTbzO6Q5HgWt47r+M+tqoFTp4sBsUUSWV5vyBqLuJHy
         wD602KygZsGUGMl3JQ+HOu2nZIFtkXwYnfg/94VZ6CKSw53+26QXLFsra+QJOHqAgVsp
         zue3FXemaQ5+O6iLi3OEor2EiOLy7FTalTPi+nCaZ9NKrQvBW6yBWb/xbdhl7OSAjlkL
         zSkXgVg4Nq8YvMo2vhY9qhJBUY0oyQ1iH9n+TgBUc2cJbLn0nFTiMvubwc7IGs4vRfMp
         MEGCube+E2Oe77bB7u9D2BZXZW6BBufrnyaWNcSvn0Kme1Pt5H739nyCEUzYTPIsGxPl
         OAXw==
X-Gm-Message-State: AOAM531MU5oVJVudu7+iQtkGQjuqQVPTVT5GTW2swr+UK//MlZiKpLIy
        p9KXBLH+nLF2lAPJq6vbwmQ=
X-Google-Smtp-Source: ABdhPJz2XRhYGEUwAOKr1XbyruVgZ7eMhpmZJyzJ5wFhEvHA0Gtl4qQe22t/kzvLJSlQO1Cnk9BNBg==
X-Received: by 2002:ac8:409d:: with SMTP id p29mr54719765qtl.369.1594127480881;
        Tue, 07 Jul 2020 06:11:20 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id a25sm26633748qtk.40.2020.07.07.06.11.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2020 06:11:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 1/4] git-log.txt: add links to 'rev-list' and 'diff' docs
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqimf087pq.fsf@gitster.c.googlers.com>
Date:   Tue, 7 Jul 2020 09:11:18 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CF9816CD-35BC-44D8-990C-019D8C1F4405@gmail.com>
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com> <pull.590.v2.git.1593747509.gitgitgadget@gmail.com> <59c48282a094e90b7f4635c4cbcc04b1914b4c0e.1593747509.git.gitgitgadget@gmail.com> <xmqqimf087pq.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 6 juil. 2020 =C3=A0 20:55, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
---8<---
>>=20
>> -The command takes options applicable to the `git rev-list`
>> +The command takes options applicable to the linkgit:git-rev-list[1]
>> command to control what is shown and how, and options applicable to
>> -the `git diff-*` commands to control how the changes
>> +the linkgit:git-diff[1] family of commands to control how the =
changes
>> each commit introduces are shown.
>=20
> The original did mean "git diff-*" family of plumbing commands, but
> I think it makes more sense these days to just refer to "git diff"
> Porcelain, which is the single entry point everybody uses.  So you
> would probably want to further replace "family of commands" with
> just "command" in the text.
>=20

Right. I'll change that.

> Other than that, I think making these into links is a good idea.

Thanks,
Philippe.

P.S. sorry for the resend, I forgot to convert the message to plain text =
the first time...=
