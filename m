Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5232AC4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 01:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiKWBTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 20:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiKWBTN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 20:19:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E1DDC0
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 17:17:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so504376pjj.4
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrLiaL8lkwbqudTbY5BblVu/TC+oVZH0OTiwzvu3Qrk=;
        b=pA7hP7005ZGqTY7S3Obnl768t8TUFJNQCb9dhoNsKuKRA684cMMOZLYX+K2wdpJGTh
         iUYRk5GR4ubp4kVq4Na7BUZWg/GMmcKUbx5vVmEmxoWwEEd7XQBef0Pka7TZOI4pDSYF
         hhcATUXwiDvlOqANuPIWDinoVK8dl0/5oGHZAV42q5s06kPfIRoTYNfGyYEeubRktzeH
         36DFwD8DHzVDjr6uTdnoJILacBO8c2zCV1Gt9JJiN4kXhB8xfqrVIIQciETfJDo+gMoV
         aERALgbpYkL3VqhDRT2f3Pj4ojnBo/+Tq7u9cQMk+m82Ha6+9ttJj/w58tKiSwgo4syv
         rYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QrLiaL8lkwbqudTbY5BblVu/TC+oVZH0OTiwzvu3Qrk=;
        b=EAGYuloBZm0ElHaFz+Dk0jb2OA0MYgORa4YKrsCF7G4xPfktR+S4aISjOvYG5QR+5P
         WEwsarFrNs2knw1cDd8Q7HHyyuxWecJxl8GZ/Wi6HjEJ7tJDpqy1pAuSWKuEuY9ARWQj
         RyLeqr3KJNuv+8q05ki31HcvJxbb7ThAru7aNM3afFdmwB2WX93RQW4wqR2ofVKAC5Pm
         tFJXm+1eaNudEs6x1RLXy8dbONWlRvQJNR4bCSO/xha3debip6aUHznz2+5FpRioe4vJ
         h3IYKuhOcQ7WqVHAlve0djEt6tGMUXj4ch07uAJIAes5j5uy5SpSRopNR2CXlMwPX9DN
         3o0A==
X-Gm-Message-State: ANoB5plplUYDHagd55f+iA4oAtY88Y0BwE6ap2XzMGQJ9pKvaFRYrDUo
        8cBuP3w785cDuUbpfiKB2c8=
X-Google-Smtp-Source: AA0mqf7cEFdVCHyvey0qCjndQxVaesdzSownyHlXn21Y83Z95qeURUeW0gRJX9ksX0l0/yM20o/8ew==
X-Received: by 2002:a17:902:b78b:b0:186:e2c3:91c6 with SMTP id e11-20020a170902b78b00b00186e2c391c6mr6689776pls.27.1669166250085;
        Tue, 22 Nov 2022 17:17:30 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id lt11-20020a17090b354b00b0020ad86f4c54sm191107pjb.16.2022.11.22.17.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:17:29 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Kyle Zhao <kylezhao@tencent.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] t5516: fail to run in verbose mode
References: <20221121134040.12260-1-worldhello.net@gmail.com>
        <xmqqo7szsjs4.fsf@gitster.g>
        <Y30eK/mNYeLNtOi2@coredump.intra.peff.net>
Date:   Wed, 23 Nov 2022 10:17:29 +0900
In-Reply-To: <Y30eK/mNYeLNtOi2@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 22 Nov 2022 14:08:27 -0500")
Message-ID: <xmqqwn7mo4eu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree this is a good fix for now, but I wonder philosophically what it
> means. That is, I could see two arguments:
>
>   1. Our tests sometimes run with stderr connected to a tty and
>      sometimes not. This means the test environment isn't consistent,
>      and perhaps we should be piping all "-v" tests through "cat" or
>      something so that the environment is stable.

Yes, this is tempting (and I almost brought it up in my response),
and a pipe to "|cat" may be hopefully closer than tester's tty to
the redirection to "/dev/null".  I didn't know how much closer,
though, and the differences may still matter (we could teach "git
grep" or "git diff --exit-code" to notice that the output is sent to
/dev/null and stop at the first hit, for example), but still "|cat"
is closer than ">/dev/tty".

> None of which needs to hold up this patch, but I wonder if we'd want to
> pursue the larger fix in (1).

Yeah, I agree.

Thanks.
