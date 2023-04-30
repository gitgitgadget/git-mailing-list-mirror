Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B320C77B60
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 01:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjD3BKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Apr 2023 21:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjD3BKB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2023 21:10:01 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE4F10DB
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 18:10:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-51f3289d306so801525a12.3
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 18:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682816999; x=1685408999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEF/TVaqo6lnjSkr2aNLO64cvR4KaUzCnkCM/YGRtlk=;
        b=iToIE25dR80YXcvBuKP7nfiBF6j+KmYIJw4Bn2VghC8jMmJybQR36yOa2j3Y2YbuLv
         9ts0ZVjzCHfnk3jtv3VJwFm5lEh+DJs29Nnyb+B3myaFmLdbbFQZihd7TwtiElelcP4x
         BfsHji8fJUssjJluCvVqzBRO2Hf7nWy778T9n7i0QnDyTuFWrB6nkbY9/fVuAjnMtk0N
         VraAuJvwbc5yxC1LPbBkG5VYePzUq4gfgd1ww0ikz9qQivAU/oXRFnq60RGi7vp+tcwZ
         AqSSfKAgvWQsx4vrs+9Ke4nrcSOCgIx1tdVdMcqvCDSp62UCcZJrHemDpdkHfM7Qh2ZG
         6ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682816999; x=1685408999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEF/TVaqo6lnjSkr2aNLO64cvR4KaUzCnkCM/YGRtlk=;
        b=aJy4L/gTOc1/JMaAkMabj/Q8KWQw0SYXOq1+NYL2nnRM5MwBqq1K+nxAuZGjlf1L43
         S59fisNC7aRhm/EHlKDG38wX1oS7Cf/NiG+kL/HQocMe52+KDZAmerl/rFVrbsAcAXkR
         1o2R3Fq03GKkzjJImXtZ7Yi7AoDQO4azzA507nyxlxs/dGkMMyOOU4GzkS8DWWnhab/4
         tp5pMwka5Zhc2cQM7QVbfeXE9zrTT+jlkJAfAFNWE6wWYvWBHBuPvGleTKm7UeBZsN+y
         fqTUTZzMBFjSv2tlcqlVVwY1AZgpsu8X7yxm6refBQA7rGHv5tgONUhFZxy7T0CgMSzd
         j7Lw==
X-Gm-Message-State: AC+VfDyL+hc1cWhM1l/puFa01s09wn/h/rDvdQ3gMEcmDRRfaavEX4eK
        /d6clhPydKQG7m6XLVvGruE=
X-Google-Smtp-Source: ACHHUZ5lsPmdRRXlEd3xdsHTEdiRgCzTCUq/mqLgvmC9R+WIsoy8XkIN57JLYkVVJBL2B42do09FYA==
X-Received: by 2002:a17:902:d482:b0:19f:8ad5:4331 with SMTP id c2-20020a170902d48200b0019f8ad54331mr12048439plg.38.1682816999623;
        Sat, 29 Apr 2023 18:09:59 -0700 (PDT)
Received: from localhost.localdomain ([39.144.154.116])
        by smtp.gmail.com with ESMTPSA id 9-20020a170902c14900b001a9a36c5216sm6483701plj.80.2023.04.29.18.09.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Apr 2023 18:09:59 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     --cc=avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        felipe.contreras@gmail.com
Subject: Re: [RFC PATCH 0/1] push: introduce '--heads' option
Date:   Sun, 30 Apr 2023 09:09:48 +0800
Message-ID: <20230430010948.4396-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.445.gf85cd430.dirty
In-Reply-To: <xmqq7ctvetbo.fsf@gitster.g>
References: <xmqq7ctvetbo.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>Teng Long <dyroneteng@gmail.com> writes:
>
>> ZheNing Hu mentioned me that could use "OPT_ALIAS" instead, it seems
>> like could be better than OPT_BIT in this scenario. If so, are problems
>> that may arise from interactions shielded? If not, I'm willing to add
>> extra test about it (some relevant advice if possible).
>
>The intent of ALIAS is to just add an extra option visible at the UI
>level that behaves exactly the same as the other one at the code
>level, so the codepath that is prepared to deal with one can handle
>the other one without any extra effort.  In fact, after the option
>parsing is finished, the rest of the code should not even be able to
>tell which one, the original or the alias, was used on the command
>line.
>
>And in this case, you'd want a new "push all branches" option that
>behaves exactly like existing "--all", and possibly you may over
>time want to deprecate the latter.  All the code to ensure how
>"--all" should interact with other options should be working fine
>(or if there is a bug, that needs to be corrected whether we would
>add this alias or not).

Make sense.

Thanks.
