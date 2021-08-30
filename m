Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F65C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4885A60ED6
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhH3Uqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhH3Uqs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:46:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235D7C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:45:54 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y6so28142362lje.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jl1C4LdYvOTwkaQA6CV0CzZkPia2fqTeE44NBmiHLw4=;
        b=ibwh3WgH45BbVeJlqWQuRRLT8v4Q3iGw4Ob9yvIC3O1+czo+etoJdBwNd08g8VKbDr
         yu5Sfml8j1kml+mE8sKsOWqAstb+Aobv54FdjbNvFolO2HHssv8Mf+y+9u49bD31Zf/Q
         SEmbxT6mOGwh0cH2ogzAV8VmQnhOnBCnjkSLSILRRYbtcXIPVPpfljy68rHbXGOVoFz3
         G1aYtAxkBI9fcZk1XnuI/sfh/bS0eHQeSZHZrdB1jhObtTEQ6sY6SclLepf18HK0clYu
         vr7BDh0KHTpctxWedPafaRHYO4nLGcnuVrfy5QQv7dbvSxbqqaOXVaThrmpmLuB1zibx
         5BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=jl1C4LdYvOTwkaQA6CV0CzZkPia2fqTeE44NBmiHLw4=;
        b=r5/MpR8uE8cacVF6WRmubZ424vqZaWRiAXnAiojOTs1r6DoRmOB53tE0MZJTRVF44J
         AADJvnDkCisepEBFDDaYAQEi1U++LysvjWr93DdrH6jKKEqWVu4vSEs+mill97y7SWNi
         CPMXS9p5OJ9hVzif9BMI7kOhcqRFlpjBA+22UAqwtiu0pKtVVW1W6BsHeNFCY/MIenJ1
         OcnQ2Kjb40fh7d1Q/bGZt2CcSG59mIno5snk28+eVE8gtTDdOY3T/DrPb+En9jgQ2/JH
         16SJBatZWejiNiEXTm4kGBwM4+k5ihZPVkIkV6CJw3TMDfEZE9KM/lExHTUXW+wR2W9J
         wiLw==
X-Gm-Message-State: AOAM530BUzHQ+tHyBdgvZmPO93L744jKUN4aRRedSP3MLIDNM38+7tz3
        WdlwarnCkFCGa+DzIKgpPLM=
X-Google-Smtp-Source: ABdhPJx4bU+Ms4kO4ip6kF2hWczPbDbLgrvThi9wKh0lqh+N8+guORgLtkCzc7Zihneph+Tuekd98g==
X-Received: by 2002:a2e:9455:: with SMTP id o21mr22234048ljh.103.1630356352550;
        Mon, 30 Aug 2021 13:45:52 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a13sm1504240lfu.13.2021.08.30.13.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:45:52 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <875yvn9j69.fsf@osv.gnss.ru>
        <3ce08986-a402-0b07-de87-2d0f01aef7dc@kdbg.org>
Date:   Mon, 30 Aug 2021 23:45:51 +0300
In-Reply-To: <3ce08986-a402-0b07-de87-2d0f01aef7dc@kdbg.org> (Johannes Sixt's
        message of "Mon, 30 Aug 2021 22:26:32 +0200")
Message-ID: <87h7f6zmo0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 30.08.21 um 15:05 schrieb Sergey Organov:
>> As far as I can tell, --cc had no effect on diff-index, it was just
>> silently consumed. If I'm right, this line in gitk never needed --cc.
>> Then either gitk is to be fixed, or we can "fix" diff-index to silently
>> consume --cc/-c again, for backward compatibility.
>
> That latter would be much preferable. Gitk uses the combination -p --cc
> for *all* diff commands when it requests patch output regardless of the
> number of parents. It would be tedious to special-case diff-index to not
> pass --cc.

It's already noticed by Jeff that --cc was not in fact a no-op, so
diff-index is to be fixed. Sorry for the breakage.

Thanks,
-- Sergey Organov
