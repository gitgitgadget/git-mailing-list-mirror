Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80243C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 09:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbjAIJUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 04:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbjAIJT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 04:19:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B153ADD2
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 01:16:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q64so8094316pjq.4
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 01:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRWq6rmA+IKG7pen/CGs+GRMjTfHF3nZrgvwU13vGbw=;
        b=H7aEcU4p/Ttded9ATYIViXlo/8xNw8VCGAVIAgVF7paFS1HW1fVuZ3dSq/c2TLxbRU
         bIsUM2qAKKLWOEah/VkRAyVU3O5Vh/rsi24MCupCg/lDZMSDzDnOxZiBSkgRNut/gLqM
         C9djVBXENgBcTDp2200imup9TOQdkSbxP8u8i8OC2jsVj5msCVDqxHLH3EriHZgfxp5x
         u5HHxVLg+SAHQ153Sc7LU7nh4QE2ZdM+jZUkrtNUpx8ej/UAPBPLnyd8MdI1INVn1RBt
         7TwrzoBfxl2zhAhg1aRozjqmhKdS2EfxIZxaRL51L18//N5QQuPx11FhYTQ3F5rNXqNB
         cXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VRWq6rmA+IKG7pen/CGs+GRMjTfHF3nZrgvwU13vGbw=;
        b=Aux4vRdflMl4cvIAoica2iIC7rfDpSUFI5wUQ9Tr3zwacmtm7tXVMHqhms48+PXd7T
         lpk02WCUyFWS/XccJNTOX0pfsxogUEexnRjhk1NGixfNtxy1TUCFGaKiwKZRqbfE9EHG
         IzamLBcB8xfJqkZgyadf5FdatXdDYjB57o6N4kflSUPs5RWKb37n8ZgvyhWftSX9zT2/
         5/Wh1May80zDxNrZensxuyVKWXMUDPFof+gQT8K9aFWP/Io2GB9YwRRvVqHP3w5h3Cpx
         vvO5p2jGhScshdN0lAReGia9dcY1KAkr7+6pw0WasOJ09lv9F/PaH77TpugsrLtAx/Sf
         nJdA==
X-Gm-Message-State: AFqh2kobyQKe3aSHBSQMK2hip0jnxU/IdTQBYQ6g3XHWOPA29rggCQze
        cpi2n5IFG5sgnS7gJWINouU=
X-Google-Smtp-Source: AMrXdXtc0Kie6saTbU3f7wN5MRGPrUicPBHz+8SWJNQd14nfUtxhFkNwmmAshNqNE+OWTMk8p0rAIQ==
X-Received: by 2002:a17:902:ec01:b0:192:89f2:e07b with SMTP id l1-20020a170902ec0100b0019289f2e07bmr49430122pld.57.1673255776147;
        Mon, 09 Jan 2023 01:16:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902ca0d00b0016d773aae60sm5674179pld.19.2023.01.09.01.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:16:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com, plavarre@purestorage.com
Subject: Re: [PATCH] date.c: allow ISO 8601 reduced precision times
References: <20221216033638.2582956-1-phil.hord@gmail.com>
        <xmqq359gnfhe.fsf@gitster.g>
        <CABURp0pWwfWO3msZ4U=_i3zkEDOq6+CUVT9Tb7KCjeBRK34Miw@mail.gmail.com>
        <CABURp0pqQFiM4+L0sRADTt-jmAsHcMMWLR6xa4NbqrziZjmdOQ@mail.gmail.com>
        <xmqqbkn8um9q.fsf@gitster.g>
Date:   Mon, 09 Jan 2023 18:16:15 +0900
In-Reply-To: <xmqqbkn8um9q.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        09 Jan 2023 17:48:01 +0900")
Message-ID: <xmqqy1qct6e8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Phil Hord <phil.hord@gmail.com> writes:
>
>> Do you have any suggestions about how I can better alleviate your
>> concerns?  I don't think there are real regressions here and I tried
>> to explain why.
>
> Other than "including it in a released version and waiting for
> people to scream", I do not think there is.  The "next" branch was
> meant to be a test ground for these new features by letting
> volunteer users to use it in their everyday development, and the
> hope was that we can catch regressions by cooking risky topics
> longer than usual in there, but we haven't been very successful, I
> have to say.
>
> Thanks.  Let's queue it and see what happens.

Actually, let's not queue it as-is, because it seems to break many
tests for me.  I won't have time to take further look myself before
later in the week when I come back online again, though.

Test Summary Report
-------------------
t4255-am-submodule.sh                            (Wstat: 256 (exited 1) Tests: 33 Failed: 22)
  Failed tests:  1-6, 11-13, 15-20, 25-27, 30-33
  Non-zero exit status: 1
t4150-am.sh                                      (Wstat: 256 (exited 1) Tests: 87 Failed: 62)
  Failed tests:  3, 5-7, 11-13, 15-16, 18-22, 24-25, 27-32
                34-36, 38-46, 48, 50-52, 54, 57-61, 63-65
                67-77, 82-85
  Non-zero exit status: 1
t4014-format-patch.sh                            (Wstat: 256 (exited 1) Tests: 193 Failed: 20)
  Failed tests:  6-7, 10, 141-157
  Non-zero exit status: 1
t7512-status-help.sh                             (Wstat: 256 (exited 1) Tests: 44 Failed: 1)
  Failed test:  26
  Non-zero exit status: 1
t3901-i18n-patch.sh                              (Wstat: 256 (exited 1) Tests: 20 Failed: 5)
  Failed tests:  16-20
  Non-zero exit status: 1
t4151-am-abort.sh                                (Wstat: 256 (exited 1) Tests: 20 Failed: 7)
  Failed tests:  2-3, 5-6, 15, 19-20
  Non-zero exit status: 1
t4153-am-resume-override-opts.sh                 (Wstat: 256 (exited 1) Tests: 5 Failed: 2)
  Failed tests:  3-4
  Non-zero exit status: 1
t5607-clone-bundle.sh                            (Wstat: 256 (exited 1) Tests: 14 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t4152-am-subjects.sh                             (Wstat: 256 (exited 1) Tests: 13 Failed: 9)
  Failed tests:  5-13
  Non-zero exit status: 1
t4253-am-keep-cr-dos.sh                          (Wstat: 256 (exited 1) Tests: 7 Failed: 4)
  Failed tests:  3-4, 6-7
  Non-zero exit status: 1
t4257-am-interactive.sh                          (Wstat: 256 (exited 1) Tests: 4 Failed: 3)
  Failed tests:  2-4
  Non-zero exit status: 1
t4258-am-quoted-cr.sh                            (Wstat: 256 (exited 1) Tests: 4 Failed: 2)
  Failed tests:  3-4
  Non-zero exit status: 1
t4254-am-corrupt.sh                              (Wstat: 256 (exited 1) Tests: 4 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t0023-crlf-am.sh                                 (Wstat: 256 (exited 1) Tests: 2 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
t4256-am-format-flowed.sh                        (Wstat: 256 (exited 1) Tests: 2 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
Files=987, Tests=28346, 137 wallclock secs (12.84 usr  4.19 sys + 799.53 cusr 1017.07 csys = 1833.63 CPU)
Result: FAIL
gmake[1]: *** [Makefile:62: prove] Error 1
gmake[1]: Leaving directory '/home/gitster/w/buildfarm/seen/t'
gmake: *** [Makefile:3196: test] Error 2
rmdir: failed to remove '/dev/shm/testpen.2086794': Directory not empty
