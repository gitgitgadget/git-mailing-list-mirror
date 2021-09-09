Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D01AC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CA06115A
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349926AbhIIOL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343648AbhIIOLx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:11:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E5EC0C2074
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 05:16:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n27so3172445eja.5
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=j1fHnAVMMD9OcWX4uZzLuA1O9LTsbB3GIoW3TKdOB6g=;
        b=HnjY6MaZyq7G3+0Kx98pRWpU6tPIK+dwLbUGjnyBrnmg+a1DNtBBGUkXDKRYkhczhz
         k6aiDsvKxxp+aby7Fk/OaTKH4m0ois3iKKRKYqaMhYxzMqyC74GAfvKQ8InplZz5vy2G
         JSPeN5MifK3vwVItj4nDZ8oBap7Wnrl/C/+DIM7cIvMyu3bYxMF4imdcOmxdKz2dGRZX
         pYG11m6LgHPbPc3VjsvXl+kwXMutVKKNRLWfdn8i8+k4/Pm/EGx0dKWoLcLXyy1qlZyD
         SbEl/AhTAGwWaOq04sEmZnF57Ep49ChJqrt++16597IS5m87hWx8nmDSshGnA+sm6fqG
         ONYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=j1fHnAVMMD9OcWX4uZzLuA1O9LTsbB3GIoW3TKdOB6g=;
        b=oU/l4k1qGE69/UMd067VA+0gUwLnR2qOrJ4ZlsEaacScNssNetWm06K1VB1p11jGX8
         Q5zlgvQ0XacvfEJ5tAlmUsuAer3CSBL2EoWp9fpUs2TBVghVRcnoywJEy0jKa5Dz0Tzd
         VybTSRlgk8qWaTVW8IlUwbwqPOL7l9JGRPsSVCF5Iy/ZcvfiMdyFGN2TYHpn94X81zr6
         2uSUn0fDVcd0ep/L1SCp6p4WcWoQx0ZW+77wP4fzuxnWQzY0LmHTCRAUXqsWFnEB6kE3
         0ik2Zxdx1MvazPcO4fE/Z6r3AQL7Low1/7OUNrEiek2HZNMjcmBkLdmle5Cw5IaAOzbt
         y8FA==
X-Gm-Message-State: AOAM530vOlrBBdP0rwHH1HawexZijKL2x6ByUtgiOV++6YuvWFXUnd0Y
        D065WvjW2VgNfe4Zg64pyz59b0J9CGr3ZA==
X-Google-Smtp-Source: ABdhPJw9/m7H9QMA0LbYA+zzXxKYzEGCn8oEROcsYmxtUKgvtwXabUwAtmu94fTozwwSYT9NvHVA9A==
X-Received: by 2002:a17:906:680a:: with SMTP id k10mr3113925ejr.298.1631189777968;
        Thu, 09 Sep 2021 05:16:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f1sm959249edq.89.2021.09.09.05.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:16:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Subject: Re: [PATCH] test-tool run-command: remove dead "testsuite" code
Date:   Thu, 09 Sep 2021 14:05:32 +0200
References: <patch-1.1-d1e464da0a9-20210906T002938Z-avarab@gmail.com>
 <xmqqtuiw9loh.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet>
Message-ID: <877dfqdjvz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 09 2021, Johannes Schindelin wrote:

> Hi Junio,
>
> On Tue, 7 Sep 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>> > Remove the "test-tool run-command testsuite" sub-sub-command, it has
>> > not been used since 4c2c38e800f (ci: modification of main.yml to use
>> > cmake for vs-build job, 2020-06-26), see also the earlier
>> > 6081d3898fe (ci: retire the Azure Pipelines definition, 2020-04-11)
>> > for another phasing out of the command.
>>
>> I'll leave this patch hanging in the list archive until I hear from
>> somebody from Azure camp say that they do not need it anymore and
>> they do not plan to use it in the future.  Of course, if somebody
>> else from outside the Windows circle is using it or plans to use it
>> in a near future, they can raise their voice heard while we are
>> waiting for such an Ack.
>
> As I mentioned, I would love for this to stay.
>
> The reason is that there is a long-running ticket about polishing
> BusyBox-w32, polishing Git for Windows' support for BusyBox, and then
> shipping a MinGit [*1*] version _without_ Bash and _without_ Perl.
> Obviously, I would want to verify that it works as intended, and that's
> where this `testsuite` command would come in (we already bundle the test
> artifacts in our CI runs, so `test-tool.exe` would be available).
>
> Ciao,
> Dscho
>
> Footnote *1*: MinGit is a subset of Git for Windows, intended to be
> bundled by 3rd-party applications that do not require interactive Git
> usage, optimized for a small disk foot print. For more details, see
> https://github.com/git-for-windows/git/wiki/MinGit

I'm fine with it staying, I have some cooking serieses where I'll submit
some tree-wide fixes that might touch this code then (e.g. general
*_INIT pattern improvements).

I did find the "without bash and without Perl" part of your above
confusing, most of what this program does is a re-implementation of GNU
make and t/aggregate-results.sh, and indeed your be5d88e1128 (test-tool
run-command: learn to run (parts of) the testsuite, 2019-10-04) says as
much, and that makes sense for the reasons stated in your be5d88e1128.


