Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2982C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 16:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjBBQRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBBQRL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 11:17:11 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465AB72B5
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 08:17:11 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id be8so2316483plb.7
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLQCjMCvqepcGbee9bp5cL1DbKLkL6d5DroKZLGNwpw=;
        b=R9/0mA/iae6hmR8rs0Qt8UamHyLVcZgd2iCVyI/vaObXUgYCQ/pgI9IwSRvtFawKXz
         jnQ0ievQVSvFXzAk8TUhL2DJ4Qy+myezpEJk0Fje0Jqi3imzavGlemNfEErl60qi2hmS
         RhBezIttujpbTdVg0Kpvmbgm09nU+2I6BLBQGneBjSpdT/nChWnl1A1AJAtyIvce9Qij
         AVcGFyh9X9HmRd4pAv7Co9QGhftRu6wMWnJ45cMrwePOf91MiY5IEQNjVW0a6pDGhGvL
         WAVa+HktnT8DSq1LuiHl3rPXLQ1oeLedkFaPhPCXF4CZ06vqVzUgRvAKWHTvT1W24iZx
         it6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RLQCjMCvqepcGbee9bp5cL1DbKLkL6d5DroKZLGNwpw=;
        b=Ocdj/oMVbLWUpL5De2XyqW3i6AKJi3wPSQtJHtIK/JmDKoNoAsTh7EbL2e26g/y0uk
         1aClgLXp/dM4Eo/Ls1DCfX4aTvfhIsvD+g5VGaKUM0iZp6qjn7fCS65erPG9sukRF28i
         DJYWXvJ0w/LsaaEgmWvqP7OhIia1dLcEPNSdwZPXDac8DZDJx7eaeSNMmRj61QlmQ57b
         hcGs7HAMwXO18wyhOowx2UBU0/wXrXmS9/JILxxMLrO0mRtBpTmPqiU2lU3+TA6zwtlH
         8uNUTO79m/R12kD/oxdMPckehxT2fN/AGfgLY4rCZtXNcJ+H9T1U+NxtvqzlC0n8dzMi
         MMGA==
X-Gm-Message-State: AO0yUKW6bxGsMlnlmU51ZynuTwJgI/L0oaa5SR3JkgcJKzcKepHpv2Y3
        1GGkK9se0z2lAFocTfyNbuhhXcCGDUg=
X-Google-Smtp-Source: AK7set/uKoJ/0iGhqlCIlKjjmFvu4JKuylqhtlEpJfcyuYnmnaXN+2H5Wowx2o2sqLG2JkVov9o2HQ==
X-Received: by 2002:a17:90b:1e02:b0:22c:65e:6dcc with SMTP id pg2-20020a17090b1e0200b0022c065e6dccmr7087286pjb.36.1675354630671;
        Thu, 02 Feb 2023 08:17:10 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id bt17-20020a17090af01100b002192db1f8e8sm64392pjb.23.2023.02.02.08.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:17:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Dulfer <rafael@dulfer.be>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Rafael Dulfer <rafael.dulfer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] rev-list: clarify git-log default date format
References: <20230201155712.86577-1-rafael@dulfer.be>
        <xmqq5ycl1c6h.fsf@gitster.g>
        <230201.864js5q9sv.gmgdl@evledraar.gmail.com>
        <xmqqy1phxabi.fsf@gitster.g>
        <d9fc8688-bbf1-96c2-07bf-a12fe38625a9@dulfer.be>
Date:   Thu, 02 Feb 2023 08:17:09 -0800
In-Reply-To: <d9fc8688-bbf1-96c2-07bf-a12fe38625a9@dulfer.be> (Rafael Dulfer's
        message of "Thu, 2 Feb 2023 12:37:37 +0100")
Message-ID: <xmqqfsbovy7u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Dulfer <rafael@dulfer.be> writes:

> like. "`--date=default` is the default format. It is a custom format
> based on rfc2822".

But the thing is it is *not* custom based on rfc2822.  The default
format came first, 2822 much later.  If I have to guess (and I
shouldn't because I was around back when we invented that format,
but I am lazy and my recollecion hazy), it came straight from the
result of ctime() but with timezone info appended at the end.

