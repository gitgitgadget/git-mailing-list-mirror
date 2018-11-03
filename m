Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9F81F453
	for <e@80x24.org>; Sat,  3 Nov 2018 00:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeKCJ7R (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 05:59:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33429 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeKCJ7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 05:59:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id u1-v6so3649720wrn.0
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5Rep5gu+PiWo+atmvx5t8nWa7GBTTYeQpeT5Q2vZAo8=;
        b=ftx0u7hzK5uDrPbS29izWZKNJaFjRC7ForZ+v6tDNep94TSXZYM45eFHCm/7I9VSzh
         Z8ueY0g/tocu80/gFjoHNufXzhZfZV5ZtT/ycsTRflzU39ZCWxYRE0ML7rSILg4To5Cj
         Turp8DUu7tHAAjjvU3JViNy7X0TT+pnrLpuq8hLXWoan7OBp9cbl0d23F75bSLXzYgQl
         wZW+vd0GRdgbt5wzabZeDqKDmn/FJVAyyyg2MGGTTAna16p+dOoUlWDRDMTI5fCqzOoJ
         KIcNN+U/8M5HeO5VFqH6RUfyEP5K8GuemmI/nLlyEgcUzUdQalgJEekXgp4YcWLU7Nac
         Qr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5Rep5gu+PiWo+atmvx5t8nWa7GBTTYeQpeT5Q2vZAo8=;
        b=RoEiHDvpKgt+qSJ+bzvcKbcURHMlUsz4whZkD5FdNbjocKTOyATQiGjiXPBJInJW0y
         vE7cFkjOjligHMl0eW0ZIBJrjrPowsP9j9JzribT9yep2TKioZ0YBgP3kS+J70CQYq4x
         00x8tw/5198f41em/fWuZGqVH9+m+GJsYKEHS69LD/ECjVUMYpgbXxB6Kp0/Q8ABOIKx
         mAHIhuSK9TUovj7BMHfzaMSzIXA2DxJbJejlPOtg/OJb3zHLaE+BauFUqp8yFHeQE2M1
         BCNt7G2gVl8JohtnLNmVgL8gh5z8IGzkVImuI2r7djlz77gE/dAfDAe6AwjSG3j9y4e0
         GwAA==
X-Gm-Message-State: AGRZ1gIv8k7GdH7O4VOMaXGwGH218OK4XAJfvkI+G9chEOtdWVo3txjv
        1f+9u1yfPNTCcxBkjWx1EeY=
X-Google-Smtp-Source: AJdET5cTDLblIwRFwQAe7achMAuOABpRPChOsdEpRmrpu0mI8aUoXDQ/2hdI8Qr6wyiGRhAbRs0ZPA==
X-Received: by 2002:a05:6000:1091:: with SMTP id y17mr11687417wrw.226.1541206190251;
        Fri, 02 Nov 2018 17:49:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w11-v6sm7333587wrr.96.2018.11.02.17.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 17:49:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Steve Hoelzer <shoelzer@gmail.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around issues
References: <pull.64.git.gitgitgadget@gmail.com>
        <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
        <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org>
        <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
        <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>
        <xmqqin1fngdx.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 03 Nov 2018 09:49:48 +0900
In-Reply-To: <xmqqin1fngdx.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 03 Nov 2018 09:39:38 +0900")
Message-ID: <xmqqefc3nfwz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>>> Yep, correct on all counts. I'm in favor of changing the commit message to
>>> only say that this patch removes Warning C28159.
>>
>> How about this fixup instead?
>
> Isn't that already in 'next'?  I didn't check, though.

Well, it turnsout that I already prepared one but not pushed it out
yet.  I'll eject this topic and rebuild the integration branches,
and wait until Dscho says something, to avoid having to redo the
integration cycle again.

Thanks.
