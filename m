Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D3C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 09:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB0F22265
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 09:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3c3Qgym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKMJm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 04:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKMJmz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 04:42:55 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353DBC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 01:42:54 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id za3so12423025ejb.5
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 01:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DIokvNiABp4xNuD2YkdXKG4z7kU5HsESjVOnA0PXACU=;
        b=Y3c3QgymGnLx5sFRM85vT6yswy6c25+ud0GIbNi0xJP0M2/V3K0tXpEvlb0AGz8AJz
         Q9F7QvhR9PNlwFOpB2DPHVZtRqjqt0EkkfnPMQfiGKoUTNNNPNwCpdYgextV2B7nf2OV
         skKFhUb2HEvVYrqy5h3oeQPRSp5OIy3hV4vkYp26qF6Q5WclTNS+TNSfz2R0uM4wYvVB
         TAGj3GgtxOm6Nx0yWYFS0TVseJ4Xs1z8rGeSpsSbOPlvG7VAjpB//rQ3qdZF8vSTa0uM
         8Pme5GHDCCTHMq11GREyDpWf8Qx3TOZ0DRB6kIivfCFvLbKd580JykeROLo6TC+XkE5L
         bd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=DIokvNiABp4xNuD2YkdXKG4z7kU5HsESjVOnA0PXACU=;
        b=dz6eE+9XC5/j44RCvCY67XVKBO57U4xBB2EGMTdShi/qSrAfj0w5VP+Zjxzyd+p5Xl
         8tJTz2+FBKbxXQAVw85RGvA1umOVdwWcXOapMh2dYdOnLReWuJtR4xH/+svt6ogy4ufr
         0kfEMLwSIv/3OFUeDDR2HlccKuWPTW3iae+dlWouG82D5nQrb4lPWq6nvYTvCV+vyEJH
         peyqEvXT3ydTg88wfa30ndCVgbH2Oa/oHAhKBeHhgGVCR/JwjoHBxRcY2OTICHQ1w7CG
         YkQVXYfGIFre6Ny57hB3utVM46gSk3XrYnkIie+OC749dzNIaUJzHKxniCvP0/n/aNL6
         nVWQ==
X-Gm-Message-State: AOAM532eke+Ko6KYeF2Fa2wf6Yr5IU+DfiCN0+KeN418oXljVvKIenxT
        NIwcDPOGm4+kOBBGq4Fjg+iIHCXzfNs=
X-Google-Smtp-Source: ABdhPJyr0jzEivukRXDozqm7AO+aImj56143NMW+j0a2nlY7OkelMyXLg/xmMzMkzMn78GqYIQcGZw==
X-Received: by 2002:a17:906:7a11:: with SMTP id d17mr1066910ejo.153.1605260572897;
        Fri, 13 Nov 2020 01:42:52 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id w15sm3445482edx.37.2020.11.13.01.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 01:42:52 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Retire git-parse-remote
References: <xmqqwnyr4zv8.fsf@gitster.c.googlers.com> <20201112203155.3342586-1-gitster@pobox.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201112203155.3342586-1-gitster@pobox.com>
Date:   Fri, 13 Nov 2020 10:42:51 +0100
Message-ID: <87y2j5fv8k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 12 2020, Junio C Hamano wrote:

> This is based on =C3=86var's 5-patch series, which removed unused bits
> from git-parse-remote one by one, before finally moving the remnant
> to the only user to remove the file.

I was planning to re-roll this myself today, but I see you beat me to
it. This version looks good to me.

