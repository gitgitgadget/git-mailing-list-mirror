Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297A8C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiGUTwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGUTwO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:52:14 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3622183F
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:52:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id l3so2149591qkl.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9jXG4G1U+bFNw5GkmqlbhfVVthQIQviNGBm4AOHRHg=;
        b=HSeVPHRLlpY80AZug6dOGGwugk31XCa2g9BoyqeuxPbXtra4n3sGPRZkKSTjsuUMmY
         Y6BKKPohvY4HdgtPsqvNTbs9kyC7D+vNxPaDY3c53nAz+nVJXBIRtqBESNCBVCCo939L
         WrVXSKcypgUxVG9VaADc0zGTIpPk8nDi6IxlQ3jkl+GOKS4tHbSvG0YKU05/LjqOAPo+
         TSLZQ8NPunMQi3UNDu7kptUmSKtn/2FDLo53nJzeKIdh4ZxAKFA+QipjRZmLWBoHIWp7
         i6p7UzIKNl5TbkPM+0r157225+ErT65zYtG0UJ0MtwdW1xKCIjIwQcTPszi0QXzdZ5cZ
         qvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9jXG4G1U+bFNw5GkmqlbhfVVthQIQviNGBm4AOHRHg=;
        b=o0ix4A7TfYmYf9OuSDPkyW2368dJoMFWIowWUszJjTKVk6o9erqXjDj41ZiEwyzM7l
         lYTKzLwYHNc3RA5CZvDrJFYaG8H5tKG8jjusq2XsoKLbYwjU9k4J2sKc3d/8Yh4ry6A1
         /cZR0cvX1FBL8r6vm3cdMRH9eX+LY4ePxQz+hy+ByyfjfEexbHtKB/RsiiXxexsiJ8IZ
         71DyYoCKKOQipNkbI/6bNo+6bqNXIQ36m/lTT/wwDR0HQjRtcRShzG7AJd173j5phftP
         Af6SHJeHA1qrin4/ut5Dqg8hldHktElq1WfEKepEx5Bq2NLe4uRI5aOZwK8FPhjWKslk
         k/9A==
X-Gm-Message-State: AJIora+B60x0xPlyDPg5ED2Vqx14IWpm8foL+hSVqgVi7FFR7ryBoSL2
        1zGsdUOoyThlq1A5SZimZ55KkeJ3xNL33+8o4V8=
X-Google-Smtp-Source: AGRyM1uthXMoInRjxLnsD8qqdhR+FEfaSBLCZYqHt1YYlJhykGJb4Q0PGFPnke1x0V96KV8Zvii0b/fauLI3zIiu1pg=
X-Received: by 2002:a05:620a:4551:b0:6b6:1d51:99a0 with SMTP id
 u17-20020a05620a455100b006b61d5199a0mr53092qkp.187.1658433132567; Thu, 21 Jul
 2022 12:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
 <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com> <91c495c770e3f7f91ae655a503bdd1cd99935e40.1658391391.git.gitgitgadget@gmail.com>
 <xmqq8roml9h6.fsf@gitster.g>
In-Reply-To: <xmqq8roml9h6.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jul 2022 12:52:01 -0700
Message-ID: <CABPp-BG5Dvoft_RhSz5PicGJyL3-j2PDqoxF4+cfH3k3NhVz4g@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] merge: make restore_state() restore staged state too
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 9:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >    * stash the changes, in order to clean up after the strategies
> >    * try all the merge strategies in turn, each of which report they
> >      cannot function due to the index not matching HEAD
> >    * restore the changes via "git stash apply"
>
> A tangent that does not make much difference in the end, but I am
> finding these lines curious and somewhat annoying.  Why do we have
> &nbsp; sandwitching the plain whitespace only on lines that begin
> with an asterisk?

Eek!  That's nasty.  I was switching back and forth between responding
to emails and coding up fixes, and copy-pasted part of my email into
the commit message.  So, apparently gmail hates me, and I just didn't
notice.

I'll clean these up; I'm rerolling for the "error()" cleanup you
mentioned anyway.
