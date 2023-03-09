Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E405C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 21:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCIVcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjCIVcm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 16:32:42 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE20102855
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 13:32:26 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 132so1898891pgh.13
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 13:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678397545;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivLAuhgKt26yKa2dpdtJc+N1RaPiJ61yfKxWbGyszBM=;
        b=epRfp0CiD0e+TGpZlsS9Qlcv+UFp7gpcrWt2UmKyOOzRJ5j0Ijv4cTynXb7lyaUoCz
         DXIvpBQCpJjQRaI3qBaaMLxgNyd9QupU3Ln3vXfGUTYH9bkv66G9ZBtcbbXPF+W+m51v
         1R1eABCUsclncZkdM7zB37miUIHJPlsqHZHnMfLof4ayzpaF37KzSOqKxau/zcSEBb3a
         szF/h/8rzJv8DldoPKQGZ615rBVblmwb7dXzX9DumtL+75rzvY2Gan8VZrDkZozFyrl+
         xXcoJR92V1Y6ISS11xELvclxwLTdV4Ks3EjYhXpWxMymrBcb7f8a6theLKTyEoayIFj1
         bCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678397545;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ivLAuhgKt26yKa2dpdtJc+N1RaPiJ61yfKxWbGyszBM=;
        b=rjR4yyDYnEbDwq6rIZVXxTxWGswyiJkJ7rtpfzZ+zuSY2cTRIamgTIdKzhKmIxDwKg
         ksxRxI9nlQ+tZ0GNIfdsteG4YvFPiD6XlLgR7s8YDHwtJQFC1gFpqDpFrPuVbzGVvowF
         Ju32/flnvlHXO0Jy0izayUfX2XpUar/dO0jjVfQrSAS9IfU20cQbFqynS6VGEQdskQMP
         AeEPaRaNtkHrpDG4OhRmDEjuZRWW1/2PuK76cSpKEPLUNwMMvhms8uNVOHnZ4p2rqhOh
         L9sX7ANlnT0J/uSniIPF32bYSd2LHsQVqPkGN3UkJZpbPWWuE8fWZOGE0ihLtWfC1Auy
         Ve7Q==
X-Gm-Message-State: AO0yUKXSQD1dxZRIR5fIZFYFmOSZX2tj8Rq1yylafJSwaxkNgnrdost2
        yChFGEqHDadMwJec+o7H0qlGdskr1Do=
X-Google-Smtp-Source: AK7set8dn7K9yU+qCCbykIqvagf1pdBe8HfsolJvC0AhfZk82cpHRwnG/da/gJLHaP69J7RqDeKRjg==
X-Received: by 2002:aa7:96d8:0:b0:5ef:b4e1:db0e with SMTP id h24-20020aa796d8000000b005efb4e1db0emr19674663pfq.16.1678397545506;
        Thu, 09 Mar 2023 13:32:25 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id y10-20020a63fa0a000000b00502f4c62fd3sm64015pgh.33.2023.03.09.13.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:32:24 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch: pass --no-write-fetch-head to subprocesses
References: <20230308100438.908471-1-e@80x24.org> <xmqqwn3rta2c.fsf@gitster.g>
        <20230308222205.M679514@dcvr> <xmqqttyurg4w.fsf@gitster.g>
        <xmqqjzzqrevv.fsf@gitster.g> <20230308234857.M503278@dcvr>
Date:   Thu, 09 Mar 2023 13:32:24 -0800
In-Reply-To: <20230308234857.M503278@dcvr> (Eric Wong's message of "Wed, 8 Mar
        2023 23:48:57 +0000")
Message-ID: <xmqqzg8l8vbr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > I think we should instead enumerate submodule repositories, instead
>> > of enumerating existing .git/FETCH_HEAD files.
>> 
>> Perhaps something along this line?
>
> Sure, can you squash it into mine?  Thanks.

Heh, I left it at "something along this line" because I didn't want
to debug it myself, or think about the longer-term ramifications
when the tests before this part eventually change in the future.

I've squashed it in and merged the result to 'next', together with a
few other topics.

Thanks.
