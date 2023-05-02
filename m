Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D16C19F20
	for <git@archiver.kernel.org>; Tue,  2 May 2023 20:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjEBUqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 16:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEBUqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 16:46:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C381734
        for <git@vger.kernel.org>; Tue,  2 May 2023 13:46:04 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3ef69281e68so19572621cf.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683060363; x=1685652363;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0+/9hdRS3tswTWx3AdMZotNPqdmX2sh2+GYVKAKPnrM=;
        b=C1WHo1YyOYSyWaGhCWZ2qqUtg/PsNsbLn1IEmzeEZSTDcHf6lDRTZUpR2kmAvgUl3n
         VYn2cGMlmJvnUiQSHLEeMeK0We1wufyQwAiTubT3XVs+iZZ3vNTFz823pVROsc54lZ9r
         mC/lCn5aVth7KDOS0a0jgn64wMRAbVikfoqmQ27ZISDWrdxbiVwB8dqJ9Zv7vrid4zss
         +Nqc2YD3QAMUowc3Hxf++7MTiAOut9PgnhPBWMMMFKl4TP3PF/k500BEchv0Rfx8DIY0
         M1/F8mvwuSa6SiyHucOghujcQp5SI2eLZ4I+SpXYR6JcGfj+/AipWAlJyCR0T6YoIGAa
         p6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683060363; x=1685652363;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+/9hdRS3tswTWx3AdMZotNPqdmX2sh2+GYVKAKPnrM=;
        b=UwQRpSd4Cr5LHDmEFsgvgv+ZieV5YwWtHEMtUCUd86P234UZU/2Nf2tCmx4RFyQUPh
         EdMOkaQjkumqMcMndglL0CHS4mGSJGE5b+7AuvXYy8M3P+Lrg7ILQEyahYPJ4+CHlrA8
         4go32mP7Ju9e8kCn0p314z5akV750zVi2SGAnnS9gxaASEOz74/nypJF8F2iU9vf0df5
         6NvTMA3WmyfDIBr8c1DAKhRUIDJTRykyVW0x+PutXC4r1jJFPQw3SdTM5wQ8+mTyx1kH
         p7ChmFpYuaEXm2LcDX7+5KYmpEpSLxGQVcg0rDkZ3Xl1d7YKSk4KeTNPdWcYXFnPrEt3
         lw5w==
X-Gm-Message-State: AC+VfDwQCbae9+M5HR1guAjcdnH+qjJmODk0xni7sBtYJefsbswMB1Kf
        G4ZSaL6tgUB4xjY+gwUMIQ90SKdCF9k=
X-Google-Smtp-Source: ACHHUZ4RzOMZGbi0CaNVZi0cZH88Qep1CoUAO5iQP2yY1B9EaWBskmTUXLPcNC1dJq5srIN5WlNaCg==
X-Received: by 2002:ac8:5e0b:0:b0:3f1:fa37:c82e with SMTP id h11-20020ac85e0b000000b003f1fa37c82emr26259489qtx.57.1683060363622;
        Tue, 02 May 2023 13:46:03 -0700 (PDT)
Received: from hurd (dsl-157-118.b2b2c.ca. [66.158.157.118])
        by smtp.gmail.com with ESMTPSA id g7-20020a05620a278700b0074deff2cb15sm9964619qkp.115.2023.05.02.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 13:46:03 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2 1/2] send-email: extract execute_cmd from recipients_cmd
References: <xmqqh6t57x0y.fsf@gitster.g>
        <20230425162631.13684-1-maxim.cournoyer@gmail.com>
        <20230425162631.13684-2-maxim.cournoyer@gmail.com>
        <CAPig+cQ+6m35cTXr20-BNyHRsQQq2nTNERCH8N9NMsUP8Ct7mA@mail.gmail.com>
        <87h6t3pyn1.fsf@gmail.com> <645158de9d0d0_1ba2d294a6@chronos.notmuch>
Date:   Tue, 02 May 2023 16:46:01 -0400
In-Reply-To: <645158de9d0d0_1ba2d294a6@chronos.notmuch> (Felipe Contreras's
        message of "Tue, 02 May 2023 12:39:26 -0600")
Message-ID: <871qjy31iu.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Maxim Cournoyer wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>=20
>> > On Tue, Apr 25, 2023 at 12:46=E2=80=AFPM Maxim Cournoyer
>> > <maxim.cournoyer@gmail.com> wrote:
>> >> diff --git a/git-send-email.perl b/git-send-email.perl
>> >> @@ -2,6 +2,7 @@
>> >>  # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
>> >>  # Copyright 2005 Ryan Anderson <ryan@michonline.com>
>> >> +# Copyright 2023 Maxim Cournoyer <maxim.cournoyer@gmail.com>
>> >
>> > Let's avoid this change, please. Many people have worked on this file
>> > over the years -- often making changes far more substantial than those
>> > made by this patch series -- who have not staked such a claim.
>>=20
>> I don't mind to drop this hunk if it's unwelcome/not current practice.
>
> In most open source projects the practice is that only the top one or two
> contributors are mentioned.

I see.  I got used adding copyright lines from contributing to GNU Guix,
which retains everyone's minimally substantial changes copyright notices
(if they wish), but that's probably not too common, given even the GNU
maintainer's manual says [0]:

   But if contributors are not all assigning their copyrights to a
   single copyright holder, it can easily happen that one file has
   several copyright holders. Each contributor of nontrivial text is a
   copyright holder.

   In that case, you should always include a copyright notice in the
   name of main copyright holder of the file. You can also include
   copyright notices for other copyright holders as well, and this is a
   good idea for those who have contributed a large amount and for those
   who specifically ask for notices in their names. (Sometimes the
   license on code that you copy in may require preserving certain
   copyright notices.) But you don=E2=80=99t have to include a notice for
   everyone who contributed to the file (which would be rather
   inconvenient).

[0]  https://www.gnu.org/prep/maintain/html_node/Copyright-Notices.html

>> it's still enough of a change to be protected by copyright though, but
>> I don't mind too much.
>
> My understanding is that your work is protected by copyright laws
> regardless of whether or not a copyright notice exists. Not that it
> would matter much in practice though, because the cases where copyright
> matters in open source projects is very fringe.

You are right; written works are automatically protected by copyright.
I think copyright ownership would matter in case the copyright holders
want to intent legal action against an entity violating the license of
the Git project (GPL v2).  Hopefully that'll never be necessary.

--=20
Thanks,
Maxim
