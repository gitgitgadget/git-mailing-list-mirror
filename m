Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE19C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 18:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiJFSpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 14:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiJFSpn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 14:45:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC8C5123
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 11:45:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bh13so2624385pgb.4
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x75EZro/3wLZFEnj04KkdP+wrJozJzBocvm1mgiaOj4=;
        b=n1iMyHghCWgMdGhlMhuvyeN2D/AM0zTQ/WOvJFzKk9iQS5IaYGYGtOs7xE1EtHY+UT
         eaO2YSXb15Zcs5Js3X0KEPDQeNjHp5FSi/9dRWffxM/N5eH+ouj/exRAbC2HdNxxqVNQ
         CFWnQkZ9uqaJH0IiHrsV5pxNb44nIXdAv+Mim362NOhqa/iGVwH+GzZye104ej7TBSj8
         cDch2+9169RDPnKgPXmYFvf2KjswRo3hHDYyUXtIRd68JIXGq5sXxg4QHBACwtRvvHPx
         irwhBgGT/F/tc4Mqm4x5bnZCHjC+vMXPIM/SeK2TFbF0+EdiieJPxhCVpuFpOoWwFpca
         Jklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x75EZro/3wLZFEnj04KkdP+wrJozJzBocvm1mgiaOj4=;
        b=i3yP5kQfddJkpuXzGISs5oNRR23eEoOTjPMeRQCn5L3/RgpN1FhY7M7FkY8IJi1/pJ
         x+mb2krrKK167rIrs6fRL3KEghFFrQLva9Us1ULY8DguTgv/o2SzzLL5Fa42HqDW0p+F
         sNPa/slUSPYee0vqFRtFvL+pYyHit7y5ka4r56WO04EKXypCu4PvyzLeHrvSZz6bm2d+
         aTzwa8Nnvl9KELBeBEJFpebD1v2diPgfhkLLbOBZBDIqWtTdvGET1F1kDXmK+Ul7V0BO
         dU11vBbGYKs/Nuio1ajuh0jD0q9KHXLlfh6Bqj/mZBx4OoWObJFwfgDgPbZjXKdTWqzI
         MaHw==
X-Gm-Message-State: ACrzQf2A6nJ2TrdbuesXZdREcjHmnQyAOso/SPAg3sBi3BpSCMCHUQ0I
        Nnakh1XHZl5jXD3F0Pxp4bY16vLztag=
X-Google-Smtp-Source: AMsMyM75+IIuzeNhFH5xtNQq14npEmQIbUVD0Gle+J9Jn3DkdDS2aNLYR0F129JBD8G6MPj2qVtE3A==
X-Received: by 2002:a63:7e4d:0:b0:43c:8ce9:2a9f with SMTP id o13-20020a637e4d000000b0043c8ce92a9fmr1042329pgn.528.1665081939089;
        Thu, 06 Oct 2022 11:45:39 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b0017c3776634dsm12563631ple.32.2022.10.06.11.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 11:45:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andreas Krey <a.krey@gmx.de>
Subject: Re: Idea: Git Bundle V3 capability @HEAD=ref/heads/<name>
References: <8d88ba68-4585-634b-1fe0-61c3465fa682@iee.email>
        <037901f1-1649-1485-a853-9783b9d43b31@iee.email>
Date:   Thu, 06 Oct 2022 11:45:38 -0700
In-Reply-To: <037901f1-1649-1485-a853-9783b9d43b31@iee.email> (Philip Oakley's
        message of "Thu, 6 Oct 2022 16:55:49 +0100")
Message-ID: <xmqq7d1clrjh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> In brian's recent work on V3 bundles [1, et al] I spotted a potential
> idea for resolving the long standing problem that the bundle code may
> need to guess at which ref HEAD was pointed [2, et al] at when there
> were two branches that pointed at the same HEAD oid.
>
> The basic idea is to utilise the new 'capabilities' field to pass the
> particular ref that is HEAD using a 'HEAD' capability
> i.e. sending the capability    @HEAD=ref/heads/<name>

Whatever you do, I think it should model what the protocol between
"git fetch" and "git upload-pack" use to convey where the symbolic
refs point at.
