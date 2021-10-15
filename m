Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABE2C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 04:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7183F611C3
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 04:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhJOENr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 00:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhJOENq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 00:13:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7941C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 21:11:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so1599981wma.4
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 21:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=F0ZvtGTuqOnV429iAAOzg9YP2oGCi2aEMDVoPNJM8Wg=;
        b=nDlPa4kD1r/LvhatwJWlh1yLvyyDDLy33ToQ4KY8xdSFGYuLatxB/TZYRE9NVFEoQp
         LmjEdWBHzuuMTnJndnx+D/abIPalWHRUZxxTihFZ3X+1zxnIW+MYufmZtNMGdT31fgFX
         MZf1JTKUYsqpyqOE3TzhzeAqKazxbtqUf3ASoQdSqU1gqL4ZGDwUaK/eqU5uCQcyxcyc
         TEjGZf8DoAVbSuSP5Gf++W6U61OW2cJY2RV954xFhcdMOTWn0As//xOoXM+2JhdgaSQd
         U/OMXBmY0TmV0EmP2+B/+sXE9Z03XCAcRsIPouhrL+oLPnXokRNYl86Ryzf7bMB9F7LD
         m21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=F0ZvtGTuqOnV429iAAOzg9YP2oGCi2aEMDVoPNJM8Wg=;
        b=Adp9Q2Qq7d9/khNwLgF6x8C97M+bRWRsyodD9xnlAYgIenhmEoeCsauAUbL/Q23xIX
         i4xEfn2d0G4SauHUh2A1YTa7i2bZDw+wf7Xa/mNmaFKhGVf/VexwAUB33TaMSyBFkgVR
         tg2gDcxgFcK5qPlvUZmYnapX/YYKOB3M9Tr3dWrdBJaHtpGvIM1IF8SqQGJbbSoLgDxD
         gMsZ2162Aifwwzok12Tt5ZzNeF1I1RmwKQVVcsBWje/CBXplZLU8FZkQmcLmd66QpD0f
         rOMJtGcV1cRmZ9afxMNFOpolRZVclgcUBGXTkZkrEZifEDoic4K/3oGtnAXMfos+L1gT
         7SPA==
X-Gm-Message-State: AOAM531O7HJ5rvlyO2ZGjnsbTEqKJO/A/U1kll8eSsWturPf9S/uYAKf
        3tEz9QQhx9F7FZCt/1Kxn5PSCkYQE+0Jaw==
X-Google-Smtp-Source: ABdhPJyTRLBXFYXXlWh485qSAx/GBA9EeLEdIizV2tT2Dl13ojpfuKLqZLCxxcYcCAczReWP/5rnzQ==
X-Received: by 2002:a1c:3584:: with SMTP id c126mr10379520wma.0.1634271099068;
        Thu, 14 Oct 2021 21:11:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c17sm9164130wmr.15.2021.10.14.21.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 21:11:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        vagabon.xyz@gmail.com, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH RESEND] archive: rewrite description for compression
 level option
Date:   Fri, 15 Oct 2021 06:11:01 +0200
References: <20211014120233.7834-1-bagasdotme@gmail.com>
 <xmqqh7djczxr.fsf@gitster.g>
 <8e99fbef-32d0-9f19-4e57-1f28108c70cb@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <8e99fbef-32d0-9f19-4e57-1f28108c70cb@gmail.com>
Message-ID: <87lf2vylj9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 15 2021, Bagas Sanjaya wrote:

> On 14/10/21 23.51, Junio C Hamano wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>> 
>>> Currently, the description of compression level option (`-<number>` or
>>> `-#`) only specifies two level (`-0` and `-9`), giving the impression
>>> that only both levels are accepted, although other level number can be
>>> specified. Rewrite the description.
>> While I find that the updated description is more detailed [*], I am
>> not sure if the change to the heading is an improvement for readers,
>> as I do not think of a case where users would choose to use anything
>> other than to use (1) no compression level option, (2) '-0' for
>> speed, or (3) '-9' for size, and explicitly singling out `-0` and
>> `-9` like the current text does would help those who wonder what the
>> option, used in a script written by somebody else that they are
>> given to maintain, mean, better than the updated text that does not
>> even allow /-9 in their pager to look for the description, if you
>> only had `-<number>` or `-#`.
>> Also, unless we take `-47`, I do not think it is a good idea to
>> spell it as `-<number>`.  Perhaps `-<digit>` is OK, but it shares
>> exactly the same issue as `-<number>` I mentioned above.
>
> Maybe we can say `-0 ... -9` to indicate the syntax, while both the
> endpoints are common but special case.
>
> Also, we don't mention default compression level (`-6`?).

Whatever we do here maybe we'd do well to emulate what "man gzip" does,
up to and including perhaps adding the --fast and --best synonyms to
"git archive"?
