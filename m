Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35515C61DA4
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 00:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBGANg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 19:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGANf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 19:13:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16DB28D29
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 16:13:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so16865706pjd.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 16:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3z8yOsHr6aRVx/QIcVFicAiQ6xEL7yFlcZuTSCtMsDU=;
        b=oTHIJFhPEJHLf2kmHixD1ZoQU/whwuqcI7HNksznulByD4c6s0DbNGlbTHTHURN103
         Wa+jlrXh72K+CDX9I6vLZPKRv9QtBAw4yTcs7LOu+4S0Slsrj5jh1mA50aeU2G6ubv4h
         opgi81560Ka4jFwA1Ar9Azsf+g0IlUvFGuJpzLGSQGvoJingREGDjsMbhBz2ZhJjD721
         LDP1mrBoCN4GYiQt8Frvw9PMZFTJpAR1aOP9ip5bMQ94e0BdVvADmXZeQfIirMGBnHcs
         rEBY+crPB68FAz8f/ir1fuEHjzNcUubAk48lztYeqRltElkRl8a9as2HZXjPoByZodPB
         oQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3z8yOsHr6aRVx/QIcVFicAiQ6xEL7yFlcZuTSCtMsDU=;
        b=DW5dV9pY9U4V1ECYy/ybVXY1cdE+8yF9uhqBSRzIhyer1u849+EP5fr2L6nbh0lY5t
         sN8XSROmjIGAzq4eHxXuTEm2EFkxsTNOP+CyYhsNeyJ6+donUAcvK3fRkb7k7vyOpE2b
         Yq/TJ0DOvEpOCc4HPRt98tfNHgjVNzTgHxdFRMQhMDsuK+cr6psYoYcYjlgQyRAeIi2c
         nXlCVcZmfSC6Zrr4H/wIEE8eM1d0SVPAzWOmGxUpuoo5+gmvE1TNCXiG6GvFGbwpmiiY
         +1k3P9cSeseMZj3lcz9fIzoGKn2wU/i2KMrQleE1BPbQywmZkAw2r/tCb69rmYF4NrwL
         IY9A==
X-Gm-Message-State: AO0yUKWp57ZPdaM5HdJTeXn7w4WkxFlPW9eaqxt6mqKBFdSXEVx+rE0n
        wr5FMAOFkBxaeb+kXXIhrVE=
X-Google-Smtp-Source: AK7set+kUOolV8c7Ems+oeoifxpUH3xRvrtGhvvvGkCb0jxK9Up3wX6UFltkXxa4F0plN/4iW7jBqQ==
X-Received: by 2002:a05:6a20:8b1a:b0:bc:5f20:1409 with SMTP id l26-20020a056a208b1a00b000bc5f201409mr950282pzh.17.1675728814376;
        Mon, 06 Feb 2023 16:13:34 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001948af092d0sm7500743plx.152.2023.02.06.16.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 16:13:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v7 00/19] leak fixes: various simple leak fixes
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
        <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
Date:   Mon, 06 Feb 2023 16:13:33 -0800
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 7 Feb
 2023 00:07:35
        +0100")
Message-ID: <xmqqttzy1geq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> See
> https://lore.kernel.org/git/cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com/#t
> for the v6. Changes since then:
>
> * Corrected the 17/19 commit message to note that it free()'s an
>   entire allocated struct, not just its "flex" member.

Yup.  There isn't much point in saying that the struct gained a
flex-array member during the course of its life.  The fact that we
forgot to free the struct but now we do is what matters.

> * Per my replies on 18/19 and 19/19 in v6 I think those commit
>   messages are correct as-is, so sending this in in case Junio's OK
>   with picking up this version.

These looked OK to me.

Thanks.
