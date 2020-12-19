Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CF4C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 16:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA5123A79
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 16:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgLSQYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 11:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgLSQYS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 11:24:18 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC92DC0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 08:23:37 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s26so13378836lfc.8
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 08:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nR10U+IKKc4RX2OuX4Nnmz/JlIv69/FprrMANolvbj0=;
        b=cGRhDO9aVTvMPBkmQpewUcrobAkUp1b62lzavEDK01Fax5M2gseKU8bd2gIXQgDFE+
         PKZmSkomnkEigzLhGzpKfNAb9E3beqpBIGPxmQUPm0wXGkzIUZLVMFEE4uLkSUBXuTKB
         2P1KH4eLnY8CQQ/AD1E6uZlveDDGCljJ+hGzuZVIP/kxtLEh9ejw2Lsx+DqWy8m/Ve/o
         MHZwNWviF123Ul285vgWkO2i0PrQ1IPZkm41vapxPGLu8cvQV90ffSUjyrjtScKVcku9
         fpjNBCsJ8WwLuwsHQgj3dnUhHoBWF8mmSbRPfeWFjYI9uWkuVZtoD2lVzkfof8kG8Rjm
         qjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=nR10U+IKKc4RX2OuX4Nnmz/JlIv69/FprrMANolvbj0=;
        b=n/8cgpTVagQIY4636X/d6l6zrDMSGD9PXww0j9RqobNya6ZAnzSUv0DY17gYR5bu+C
         py8c3WTBuQMQk2AUKDYuzUfGYQsGtAMdlqjJlf22OIUqHYbblafZunPJAsDxfQ/y8tMD
         Sc8LAuByDFUQHENWB1fJA0qYd32COlqmE/1icE03toDi+3yH+Z29WSXRFX1gRWqZOU+p
         IbTqxSI9l9tKF37ikDc2sffdlcBo/jqrWSGi/3hvzxggAeHYSRwm0mb3+nnX42tQae5z
         yz0hW8BPZRanLcZE48X1+roIiI8Vo29kShrIqXFqbh7H7WkwGPbgmokKUhRTv86kXvx7
         yPbQ==
X-Gm-Message-State: AOAM531QYmnBq1JNV6P+1RPiltj3dFOyv0Dy3iUObJzlQsnB9xnViviV
        jfENvUNlnSBfiqqe5A9UQqXM5e7+qnw=
X-Google-Smtp-Source: ABdhPJyk5tnU79arpkR0dib1M5T2o+bif24RynB96xzAain00C9///c3kSPDXQuPoThQmxJksdCzDg==
X-Received: by 2002:a19:40d7:: with SMTP id n206mr3453946lfa.27.1608395016230;
        Sat, 19 Dec 2020 08:23:36 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o6sm1459301ljc.124.2020.12.19.08.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 08:23:35 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 26/33] diff-merges: let new options enable diff
 without -p
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-27-sorganov@gmail.com>
        <CABPp-BHu2xLZLfwBg+hzNEKQ0K=EyT1HLqJO9=pNzBFf4MqR=A@mail.gmail.com>
        <87wnxfb2gt.fsf@osv.gnss.ru>
        <CABPp-BG4GEmv20YK39M51nzTYVZtcLgD-UbmQLfgynjUhBKx9w@mail.gmail.com>
        <87o8iqm1wq.fsf@osv.gnss.ru> <5fde01924f744_1de0de208ea@natae.notmuch>
Date:   Sat, 19 Dec 2020 19:23:34 +0300
In-Reply-To: <5fde01924f744_1de0de208ea@natae.notmuch> (Felipe Contreras's
        message of "Sat, 19 Dec 2020 07:35:14 -0600")
Message-ID: <87im8xlq7t.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> The problem is that original name I've used lies to the reader, or, more
>> precisely, tells half-truth. True meaning of the variable is "do run
>> diff for any commit, no matter if it's merge or not". So "need_diff" is
>> already better than "regulars_need_diff".
>> 
>> Maybe "diff_all_commits" will do?
>
> all_need_diff

Fine with me.

Thanks,
-- Sergey
