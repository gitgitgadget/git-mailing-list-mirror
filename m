Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD5DC77B61
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 16:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjDGQCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjDGQCr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 12:02:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F6F11D
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 09:02:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-62dd12c1330so187611b3a.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680883366; x=1683475366;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmYQldKLx3Wmx9rP/KGiefSkYIb+7pqNN1JJitQ8xQg=;
        b=OM6fnQ1xJkBzrJ/t6U57Wnj2AzYTWoK+fW2NFLYNe6rldIDo2biBzSjxSxRvAREthh
         CQCVr0aciqxw5WaCzxG4R19J5XhN0Z2x3rIkHq3ypZD5j1GdXtdOgMNcEmG+598exrOD
         ywj5cFlguU0UrNrnEhPNhGc/ehc5cuQ9Uwv5q10tbDgQIpOwAnnJXUG4fl1sfigCAA+R
         3y1VfKlaYYt6x3DXA1ffDYIr08e9gfEz7GJ/pK35JYASkL4uJ2E4sPvzjXDwNk6rdPWb
         5QFHjow4R33UP3e6KrLN5mar5y9uIV4/s5UKXBUOgQczEK+YNPKepAEmvtkdUWVTaYip
         WcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680883366; x=1683475366;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmYQldKLx3Wmx9rP/KGiefSkYIb+7pqNN1JJitQ8xQg=;
        b=dRK4JtnhanExVEHFbyNAC2yBkePm5Ug/QhOst7huA2Y2PYF/xphnQL+lv7YEsS+18U
         kl+apg/CrTztyodR+48kfz/a+vOgouXGzqoKRM+FmmTZiflry8LiG594RwTuSXe7cNN8
         1hGQbOUejF0Uo91hw+H9I6SOwECWQE5WLnZ6vTIdwrVueHc7kqx+HVEjE9QFi94yf7C3
         kj5W0gSYIJmw1giNPuqmwOT083qiSoChVq8SiSM8KLknZrie6IVu8h8CuDlq7jAMiwzV
         /hbJs38sYrhG2SzFwXfuRih6n30Bk9f1tYWan7i6WRkqhzUty2ihgJRD/pfy4rXlNjsb
         nfhw==
X-Gm-Message-State: AAQBX9fyY8o2ik4O1VLfC4nKu2PJv40/woNpwRPH2DHxa3OI5n9Wpyhm
        +Hi0g71iB53RWkxXZIMyE5I=
X-Google-Smtp-Source: AKy350bQuap2u06mC7/HdAqZkOpV+sQcu/yTtfUdkwM3tRFkql0dOT6lqDX/qMTE+OGWryJoWoOKkw==
X-Received: by 2002:a62:7bc6:0:b0:622:749a:b9df with SMTP id w189-20020a627bc6000000b00622749ab9dfmr2701718pfc.3.1680883366494;
        Fri, 07 Apr 2023 09:02:46 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id q23-20020a62ae17000000b005d92c9afbd4sm3260156pff.33.2023.04.07.09.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:02:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "D. Ben Knoble" <ben.knoble@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Diomidis Spinellis <dds@aueb.gr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] userdiff: support regexec(3) with multi-byte support
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
        <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr>
        <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
        <c4728fac-bea9-3794-077e-c978d99f46bf@web.de>
        <xmqq5yad7wv3.fsf@gitster.g>
        <bc6e89c9-d886-c519-85b3-fbc3f4eb5528@web.de>
        <7327ac06-d5da-ec53-543e-78e7729e78bb@web.de>
        <CALnO6CDgs+of5KCRRwpmzEoHcqZ4udbHVhNrd63q4fFh_5TwHg@mail.gmail.com>
Date:   Fri, 07 Apr 2023 09:02:44 -0700
In-Reply-To: <CALnO6CDgs+of5KCRRwpmzEoHcqZ4udbHVhNrd63q4fFh_5TwHg@mail.gmail.com>
        (D. Ben Knoble's message of "Fri, 7 Apr 2023 10:41:07 -0400")
Message-ID: <xmqqedovlly3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Thu, Apr 6, 2023 at 4:19 PM René Scharfe <l.s.r@web.de> wrote:
>>
>> Since 1819ad327b (grep: fix multibyte regex handling under macOS,
>> 2022-08-26) we use the system library for all regular expression
>> matching on macOS, not just for git grep.  It supports multi-byte
>> strings and rejects invalid multi-byte characters.
>> ...
>> Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
>> Reported-by: Eric Sunshine <sunshine@sunshineco.com>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: René Scharfe <l.s.r@web.de>
>
> I tested the patch locally on top of ae73b2c8f1 and it solved my
> problem. Seems like there's still some further discussion, though.

Thanks very much for reporting and testing.  Also, thanks all for
working on this solution.

Will queue.

