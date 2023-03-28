Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB8C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjC1Rhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjC1RhN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:37:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A84DBC9
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:37:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so13434512pjb.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025031;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AX5ooPVrr6vW+51MYW/NpyyxOzuVgm6RzY27CyqTYzU=;
        b=eZ0aXTRwAZaj1+Ha+4gwy6bpxEG/qrTXkEB8TQxKqZwC5zmum41LbpGVW1r5MnxzD2
         k4ML8mF9Z42+EuB6AP3IaqhyhVs48eeuTqp19BjK8jdX2kQOV72HRCjvemLQ66rvRQ3k
         U8fYcQGqo4QR8viL79pvBmphMjTGwaM8GFtYoJk7m2BPMY+JHsWxadau4tooKOMIYN5r
         K9ACD3aPiabRng6g6pysF00DGkdq45/UYW8cAzjZn9q/h52OWv2ff2eH5hjGOF81lEcB
         AMF/v+7TkJ+n/uF4amrp0Lte1jKIfwspoIbA+kMRdqpdG7rAXIWwPIzVyGqR0JTPJSyL
         +Yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025031;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AX5ooPVrr6vW+51MYW/NpyyxOzuVgm6RzY27CyqTYzU=;
        b=PYU0fcNStSgRKzo8kBvfh4bZWnKfiHnOTS1Qlfy6RfJMZue6AKvBrQyUKMu05XPJbY
         Vpx+4LHhcZMoJ1mOVQEZhctFHIa1Z7HXLHln0sZNvgCTzLXAK1dphlI1Xf3TGWgFofdo
         8p3CNhMFnbv8bSg+o3fiKbl2GJDdmvrDdc1ykmKwtES7njI0TIL7gLOdWNGSfqOTXhEU
         6ceH1zgCLs3vgQ5LusYTc99d97bTuJ0SiC2Q65fkCvC3vK5RRlxSe/l4I2IlBb4DKRJ4
         3kje025vjV19yvGKkmWVQTwWpyoa8yyrI592+36Hs/47uP3qJu33LiP1bTCD0SzVYlB4
         MBvg==
X-Gm-Message-State: AAQBX9e3UDNnrfP3vTrybr3oUoZ0viR+TmEtCZpYL7OQuHxQNB9LQScA
        vZB9ejV3UZA2vrFz5jTZax4=
X-Google-Smtp-Source: AKy350Yr7kLgiMbgKwipLTSot/iFEvTtkimmljeW87FlznW0SpsgpJMlk47EkNcc5KWTVC967ouaFg==
X-Received: by 2002:a17:902:e548:b0:1a1:241a:9bd0 with SMTP id n8-20020a170902e54800b001a1241a9bd0mr17034761plf.5.1680025031413;
        Tue, 28 Mar 2023 10:37:11 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id m16-20020a170902bb9000b0019e88d9bed3sm21355374pls.210.2023.03.28.10.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:37:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael J Gruber <git@grubix.eu>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/7] t: fix unused files, part 1
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
        <20230324205434.93754-1-rybak.a.v@gmail.com>
Date:   Tue, 28 Mar 2023 10:37:10 -0700
In-Reply-To: <20230324205434.93754-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Fri, 24 Mar 2023 21:54:27 +0100")
Message-ID: <xmqqjzz0g4l5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> I messed up when sending v2 (incorrectly used format-patch with --in-reply-to),
> and v2 didn't get any response.  So here's v3 which is just a resend of v2.

Everything in this iteration looks good to me.

Let's merge the topic down to 'next'.

Thanks for cleaning up these tests.


