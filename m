Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A945C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 23:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiLPX2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 18:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPX2H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 18:28:07 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D81A1EC4F
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:28:07 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fy4so3952077pjb.0
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3bXUuDNvN2VZROVG3UHNQPRRv2vxn4yw4TT/6rqG9Q=;
        b=ja4b7AqVyeO4xe6XENcBsNNGyE0aZpWtWgRgzioMzbGR3VopTIKrzHsdnaIi3T0vyH
         JDs3bjlVHI2mN2SkNzviCY+PJljresCMci0Abuj9wn6kvONEuwjG6pIc3+xsCyi6Iia+
         uwIXyP5wsg1ePQ5GtFuplna3SWnY/2ZNj2yTcR7eOw2VmB1c/bLMZj3mLhXZkvw7s8VS
         HzsKUONFqcbHT+JvRqChAiEbAHTZ4wKjavCE9iksH0gfMLnjxMVo/OZGArlagoOT5fBX
         ieopYGtnzD/lO+DAf8afq8vqTtouw329XZU/yCsGKz4HPTo7vDe4TBYJ+1AKamB3Cd2X
         xlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3bXUuDNvN2VZROVG3UHNQPRRv2vxn4yw4TT/6rqG9Q=;
        b=lSQ9FKacwWPVvCtgK4slOFIQ+FvYW7StmAFvlMxHib6GArlswjUiKx/hHnPA/XC/uX
         4aN3I6mBhXRNyK1w9G5B+VJoZrOGbFUiCazwzm4JPtzAwT4CasG4d2D+Mynb3LC4Cg4v
         ZGf/TI519Nb5AUSsrBK4U3hLTdKb+04Q9PdFJR4HbcUwm9V3TK6qUvi0dMefcr9KjL4a
         k2Wm+KeiDwSI6VRROkQi+Lnl+v7fhCGfpv2Dr3SNXWl4WbfdnMrzMCnvnTL7GPAv4dCY
         11JfzJM4lUkPvkRLvG/kxBqQiUgUmGS8DwaSgyc3CIUbg66NodHSaZlSnKMF/v8cDl/i
         nJfA==
X-Gm-Message-State: ANoB5pl/rCDLtMRLaZMQU4ZZqZedCYx41eG/m0/bxjPHYV4TV0r/2N+O
        UynNH2B4cgEhP31cEa1bbT0=
X-Google-Smtp-Source: AA0mqf6QAe0w858yjKVIw7ZH+aBBeYf2mARuOwvsRLnnO35ohz5EWE5OeJTsf6Vz4Rm671X9BmutOA==
X-Received: by 2002:a05:6a20:7d86:b0:a7:9f6:b7e8 with SMTP id v6-20020a056a207d8600b000a709f6b7e8mr55178982pzj.46.1671233286468;
        Fri, 16 Dec 2022 15:28:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k186-20020a6324c3000000b00478a3079b7esm1972688pgk.19.2022.12.16.15.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:28:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
        toon@iotcl.com
Subject: Re: [PATCH v3 0/2] check-attr: add support to work with revisions
References: <20221216093552.3171319-1-karthik.188@gmail.com>
        <221216.86k02r1fcl.gmgdl@evledraar.gmail.com>
Date:   Sat, 17 Dec 2022 08:28:05 +0900
In-Reply-To: <221216.86k02r1fcl.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 16 Dec 2022 17:17:48 +0100")
Message-ID: <xmqq4jtvkjy2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> This series aims to add a new flag `-r|--revisions` to git-check-attr(1) which
>> allows us to read gitattributes from the specified revision.
>
> I didn't look at the v2, but expected at least the short form to be gone
> here re
> https://lore.kernel.org/git/CAOLa=ZTSzUh2Ma_EMHHWcDunGyKMaUW9BaG=QdegtMqLd+69Wg@mail.gmail.com/;

It was unexpected to me, too.  Thanks for pointing it out.
