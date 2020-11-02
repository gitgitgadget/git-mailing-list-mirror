Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178A5C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 16:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C916B2222B
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 16:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgPktXLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgKBQPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 11:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgKBQPb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 11:15:31 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1EDC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 08:15:31 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id v19so10689475lji.5
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 08:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Vo/hXiwi8cdlXakym/U8Qi/FcBvo9S+QTeddADv/5ic=;
        b=GgPktXLEOB4zMp1Al2csTh6nIGov7S0L3ZFfI909iCSEEv9NbR6JR+r88/DurN6Wa6
         4kTef4GEfTGQmiGxgV2DkLuvpn469tCwUqh74MvbC5dnrlhej1m6ONcnKO/aV7j0W1Dn
         UpzveERQag9t+cAC4wbDhZ7tvV0oCHnNuEn+EHKIzjKGUt2S239pDGnEmOYV2DRdPx6O
         QnMrzQbg+cBA/Qxpk/BIXAR1VjE5Arwlbrh2hpmfB7Zy3qeQZAeymTQV90ufUIuvgKhU
         gtJnTbaicQBw/AV2XFH4PCeYtUd61Vu9tT+p17QT6vQFr+Dxe6iXy9CfZuqKTFSnMsQ8
         slVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Vo/hXiwi8cdlXakym/U8Qi/FcBvo9S+QTeddADv/5ic=;
        b=i415cFv1odUcpPbW6bQYN9XR/fWEvSHt8agjUNBviKVlnQM/jzxTr7kWQAOEbC6Nz9
         e7q7aeDo4s00YlRD18W4pV7s9Exb/Ee8y7BE/zMgmiYWLHvWYbbyAbkogTLPtfPHVgtZ
         JjYWXxg6Htdp2WdAhgfTZAQSnoh6A5CbyoGjH70IfUBZ/YFW/qtzb/F0LwADVtMOl3Lz
         MdrDBVIYgoWctZ3KV3AyvE+xF9WbwhyK4dAWqPeqGSLDQOYkM+ang/9S3bfQBix/MbkB
         /Yz/ONvRH6TXB9qnoP4GweVyQ3z3A4kJlNFyuVmEcqEKaslgpIJn51J4UO92C3ZqjOkZ
         K7uQ==
X-Gm-Message-State: AOAM533yYB1yPaLiYXwhilGA253+A5kVKFMWdcTW0foqf8V/WGpRSujb
        y4TKzpDG6T+RZBO1F0MbzoHHFMsvqI0=
X-Google-Smtp-Source: ABdhPJxQ239ZinDver+aEIQzdKi8zn90HiK/LcAWYEZCSVlbggl7YnZDN3MrP9xlT1e0zSaIWx/mfA==
X-Received: by 2002:a2e:88cb:: with SMTP id a11mr7353776ljk.304.1604333728820;
        Mon, 02 Nov 2020 08:15:28 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t21sm2415721lfl.64.2020.11.02.08.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 08:15:27 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 17/26] diff-merges: split 'ignore_merges' field
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201101193330.24775-18-sorganov@gmail.com>
        <a1afac59-35c2-18cc-0d11-38d0b9479bf9@iee.email>
Date:   Mon, 02 Nov 2020 19:15:27 +0300
In-Reply-To: <a1afac59-35c2-18cc-0d11-38d0b9479bf9@iee.email> (Philip Oakley's
        message of "Mon, 2 Nov 2020 10:48:10 +0000")
Message-ID: <87o8kfohuo.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> micro-nit while browsing..
>> 'ignore_meres' was 3-way field that served two distinct purposes that
> ignore_merges (missing 'g')

Philip Oakley <philipoakley@iee.email> writes:

> micro-nit again:
>> After getting rid of 'ignore_meres' field, the diff_merges_init_revs()
> merges

Thanks, Philip! Fixed for next re-roll.

-- Sergey
