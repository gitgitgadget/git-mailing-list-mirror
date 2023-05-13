Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A789C77B7A
	for <git@archiver.kernel.org>; Sat, 13 May 2023 17:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjEMRpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjEMRpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 13:45:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBFC184
        for <git@vger.kernel.org>; Sat, 13 May 2023 10:45:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f00d41df22so58875909e87.1
        for <git@vger.kernel.org>; Sat, 13 May 2023 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683999939; x=1686591939;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTzbX1Gik3HbbXtQlzX6YQSZMaECnDegjPRt0I3n/MA=;
        b=l1wx3WUalU6N3cOmcWPeMRXbUJK+tX7pkm3qnKkbNPahdsIYY49eb7b1HId6vL177b
         53JqWZmiCM2tPEq9jhFEMmbVWuY5x3hweYxIUoJuDWgrrIEfq4ulmuXVwfZK230l/JBA
         nANZemidKAqnJPSCkr0oVngti851qrj1Ip0Yx0WCK3veR1byntz/c8pjpf7Hk9j/NZR/
         Tc2aAc6jIr+zYT2sTRMiYKn9KmyCKYup7vvhgLp1LQUAC1Jq8gpyrnj9dd8Ojdf03ctw
         Wp0Eut8mHLTM9rDWM8jFDyRJyfLwqdYbcpZOgY6CdnertnAE2H8FZId5jSC08x0fSVZi
         HvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683999939; x=1686591939;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTzbX1Gik3HbbXtQlzX6YQSZMaECnDegjPRt0I3n/MA=;
        b=NjI0SzmsIArMKbt+/h/hjxiJQ+Xhv0Kl9nK5xsVZ+RptPkSZURpskTxAnC1CzAnUIs
         zBb29nJi/OEkAhguanjvHEp4pkbXHVpfEzOeXaykqrhIGz+QmbiOZryJHOqGrpBHnlXe
         bvnHPT3wk/s7MXoUSkcaZpuupoLMuoWu0Osx9fxd8CJMKTb8AGg2kdHs98FXYYadU5Yx
         mfPWy3G5WINgm92dSNOg5LsZMvm1BkpvQ+dS9k0jCO0b8s5f3yPoGsd8dR8x0Ob7VHK8
         lZubPMxinA4TlouO8hbCWVmXn4jmDLJvxE/7TnrX4CM5Y6+pX1S44Mng49ATvFqrnu+H
         lT3Q==
X-Gm-Message-State: AC+VfDxp6KzuFylERBVjkNdm4J3p+pd7bjUMZ9RxS8WSMcpDH/8XdRzj
        Fcj6/StQb70YKO6TpySvXIphHwv2ghM=
X-Google-Smtp-Source: ACHHUZ5bgYKV0L9Dx9bi3qPSDA9EnvdWqL98k405g/IPeX1wJ7vCU3WJfC8rQs/ZUUFy6WbaoULGyQ==
X-Received: by 2002:ac2:4d03:0:b0:4ef:ebbb:2cf5 with SMTP id r3-20020ac24d03000000b004efebbb2cf5mr5373122lfi.17.1683999938879;
        Sat, 13 May 2023 10:45:38 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y4-20020ac255a4000000b004eafabb4dc1sm1894710lfg.250.2023.05.13.10.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 10:45:38 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
        <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
        <xmqqo7mpqy6g.fsf@gitster.g> <87h6shif6q.fsf@osv.gnss.ru>
        <xmqqv8gxpd8r.fsf@gitster.g>
        <645ea15eca6fa_21989f294f5@chronos.notmuch>
        <xmqq1qjlp98j.fsf@gitster.g> <877ctdi5wp.fsf@osv.gnss.ru>
        <645ec6c64bbd7_21cbbf294bf@chronos.notmuch>
        <2ca296d5-4871-5123-3fcd-88f94e86b0b7@iee.email>
Date:   Sat, 13 May 2023 20:45:34 +0300
In-Reply-To: <2ca296d5-4871-5123-3fcd-88f94e86b0b7@iee.email> (Philip Oakley's
        message of "Sat, 13 May 2023 15:58:30 +0100")
Message-ID: <87ttwg6s75.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 13/05/2023 00:07, Felipe Contreras wrote:
>> Also agree. I've never heard the word "squelch" outside of the git context, and
>> I'm pretty sure my English vocabulary is not small. Multiple people have
>> suggested "silent" and no one has suggested "squelch" (other than Junio).
> Squelch is common in the right circles.
>
> It is the term for cutting out the static electricity based background
> audio noise from radio receivers. Back in the day, it was an adjustable
> dial, so anyone who used a radio (including ex-military and their
> family) would be familiar with the term.

Well, then we'd need to adopt something like --squelch=17, right? ;-)

>
> It's not so common nowadays because there is auto-squelch and auto
> tuning on most receivers, but it's still part of the lexicon ;-)

... and then, finally, --squelch=auto )

And then it should still switch back to full output once input signal
(size of diff?) exceeds specific margin.

Thanks,
-- Sergey Organov
