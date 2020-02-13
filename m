Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE77C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 04:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B376E206ED
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 04:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0wiv1Zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgBMEag (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:30:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40828 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgBMEag (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 23:30:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id c23so3225296lfi.7
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 20:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=osb4h8lY2DQqJl1E+xoxTUEVjOsbd8e70aM5+QMvS3c=;
        b=g0wiv1ZxMNEK+IHmyb7xCmyWYzU7/9xwq+/przRHTyF0XNxpFGQt7ET1mXN/cxS4JV
         SIPEXROSv7I2JnZq76UpFtG1yQRC/n/1ADc2QN00Gwq1Q/PJORPdekh2oirCJFzW/AjN
         4GZRkx0Uhqf7tpAlKnanO0UdlJpjc5wZFBbtOvXuMmDktYa+kU+nqMX65q1uNWhHSifD
         ezvzCEEFc0oBxZdHpvP0GAtzYF5rHDBaPFoaQp4H8OwcNAQNjM9Khwj6Oxp7yHllfBXM
         QwwkVDlhQXfNWXiPkxpGNUgH3/Tieg3dkAEQdHXckzfOUbLEqIIxxQIqR7/3RfilOOPQ
         RVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=osb4h8lY2DQqJl1E+xoxTUEVjOsbd8e70aM5+QMvS3c=;
        b=FLXR8iz+pEf3tNcoZdixf+cfR1SkAn01A237xommD+r41ws8aCxtvq8N6/Gw/o1cbz
         R5ikHNJlbV+5mAnQcYks8HKYxWJQ1qrOU7V4UfTP290V1zajt58OrKE2zNGzgfrIAwaL
         ev39oJrEwkd7WcVnQsr5oAA10ysvwKweo7LaBgrQpgDWVpQP5F1ogyhZ3EaMI/xw7QtI
         LV2XFKFUZDDcWe4d1WEAVl26V6BPjGfUnvgVAQ7e5FBl7veXXhX/qGEP5Os/tCr9chE9
         zrp0xqBqaBi55SLnb3hNavB+dVRCcKDZ8KONWmBnMrIoLg/QR4dfCDeuAk0ww8AyOQ7/
         JJTQ==
X-Gm-Message-State: APjAAAUKfYYctcduK/EKRIB+xSbvoIp4CQHOYkO49yxRAFerBwMERHS/
        93Eemxn+RH6tfh2kVA401nS+TE4B
X-Google-Smtp-Source: APXvYqz1+5ZZLNUQI/GbK3740BcYQlNa2HZaYRoPaStdrE0PlxOmQqewppn3mYUgXi6Eq2Jdxz/oOg==
X-Received: by 2002:ac2:5a48:: with SMTP id r8mr8501096lfn.179.1581568233913;
        Wed, 12 Feb 2020 20:30:33 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x18sm467998lfe.37.2020.02.12.20.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 20:30:32 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Aleksey Midenkov <midenok@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git tedious verbosity
References: <CAHk66ftUsKU2+Uhy-a7V5QcRdO7ShcYUk28qz7WAm28wGFmPOg@mail.gmail.com>
        <CAF8BazCpFyr_tpayWVtbk7V2LAtXaVmEKTCRQbgLYg4AvmvLvQ@mail.gmail.com>
        <20200211195549.GE2127797@coredump.intra.peff.net>
        <20200211195627.GF2127797@coredump.intra.peff.net>
        <87k14se849.fsf@osv.gnss.ru>
        <xmqq7e0rvhau.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Feb 2020 07:30:32 +0300
In-Reply-To: <xmqq7e0rvhau.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 12 Feb 2020 09:36:41 -0800")
Message-ID: <8736bf3y8n.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> It says:
>>
>>    All advice.* variables default to true, and you can tell Git that you
>>    do not need help by setting these to false:
>>
>> If there were an option to set that default to 'false' (advice.default
>> maybe?), it'd have answered the demands of the experts, I think.
>
> Well, just like newbies won't stay to be newbies forever (and that
> is why you can disable advice.frotz once you learned about frotz),
> what you call "experts" won't stay to be experts, either.  A new and
> backward incompatible way to work may be introduced and a new advice
> message to guide _everybody_ (including those who thought they were
> already experts) may have to be introduced, and turning off all
> advice.* variables, even the ones that you haven't seen, would hurt
> them.

By "experts" here, in the context of particular discussion, I meant
Linux/UNIX experts who are used to tools being silent, unless verbosity
is explicitly requested (typical --verbose,-v), or at least having a
simple way to make them silent (typical --quiet,-q).

>> So...

So in fact this has little to do with git proficiency.

-- Sergey
