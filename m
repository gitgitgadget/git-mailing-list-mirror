Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CFBEB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 19:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjFMTeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjFMTeO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 15:34:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CE9187
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:34:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-653436fcc1bso4941670b3a.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686684854; x=1689276854;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YUnQ9wiQqXplU29Hht2wmff7dKOqpRrfXHGjmYhYE0=;
        b=Nsma98kGCWD4GsjTMlrkEFSylpIfI9kKBNeaH+jliLoXsvU+9wk/KOzEohxlWqIs5K
         HySElQPurslRi+0bqyw6kxnD2RksxmpXY/TZ6v1G5BVT6kzXcPzrulGdcS/nHN0dXL1b
         EQTnI3HxN3QW1WmGfmynXzwUv2GmXpZzeilI9EeIY/yh6tMDA2N/KS9Fnrh74DwRxtoW
         E0mKm/BiVPRddiVni9gsUzxTNSqNq5itCRGF2qEx3dOe+KkF3vrnxA+r1HSYm4zkMYUE
         xesOMQo3hECGvOKFiRwSDqYe2OqBYUvw1BzH91qbjjpMmNkIomMxTH29PpObpjVxdrXV
         IJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684854; x=1689276854;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YUnQ9wiQqXplU29Hht2wmff7dKOqpRrfXHGjmYhYE0=;
        b=jGJLKkfpa/bPFIngNUF1V6wCBnUtONlbqtEssbwhitpdzlwmMqnkA0dNQ/UQRNDRV1
         19csXz55gNELmqlb+nhrp37a5G+oKHPf7C70T6eahWtew1FqzpeUhTg8J5wSEAJQ7j8D
         DZbCfmdZ+81A5NBeyU3xKAhKhUoQge3ZDMzUpazX9f5grziiynsagyPZzTDc7zKe6Ccw
         /bg40lJ1GZlbAvxLxXFqhpJqxSr1bH9TxatWge5XezyywA8UiNfa0EL72yC1h4/evz9Y
         fEQu4qRZuQIEGAagibo/JZNV5XAqKl17oZZGMWAWM7C73yFsIAgBWVHubWta6XgOmeGc
         0j4A==
X-Gm-Message-State: AC+VfDyhq2u8NfIovdUpBCw30mRiiv5MiWl9/5b/ShrMXPhgzPDfGmRC
        Q/9YYp8Sp7b3yr6GPIZMq1U=
X-Google-Smtp-Source: ACHHUZ6fjv53Yw3OuzM6/8Ei+rm4klZYGiFzkwnH6jrR+kcK5wUg1VHQSZowfcsRmZVh6m6rlTkghg==
X-Received: by 2002:a05:6a20:1584:b0:101:4348:3e4e with SMTP id h4-20020a056a20158400b0010143483e4emr13756040pzj.42.1686684853618;
        Tue, 13 Jun 2023 12:34:13 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id j2-20020aa79282000000b0064f2bbe2d2dsm2986788pfa.24.2023.06.13.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:34:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: tests: mark as passing with SANITIZE=leak
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Date:   Tue, 13 Jun 2023 12:34:12 -0700
In-Reply-To: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sun, 11 Jun 2023 20:29:09 +0200")
Message-ID: <xmqqv8fr40nf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> The goal in this series is to pass t3200 with SANITIZE=leak.
>
> As a result of the fixes, other tests also pass.

Thanks for working on these.  I've seen Peff's reviews and picked up
only the ones that are unambiguously good, dropping the rest that
you may want to update.  And as a consequence, 11/11 is also not
included in the set that has been queued.  Please do include that
final step when you resend updated bits that I dropped here.

Thanks.
