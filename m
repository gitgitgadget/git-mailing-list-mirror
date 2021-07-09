Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE85C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C414613BE
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhGIPLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 11:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhGIPLV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 11:11:21 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36341C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 08:08:37 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so9784734otl.0
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=aRT31e/ISc6+N0JcYA2/LCgu9ylSECt2pRQd2DVjS/c=;
        b=JP9GOo6ap9PW1y0+a0DF+sbvetXlQF9Me6MH5edzShTbXgHimW8s3LRYrzPtj/+m5w
         OmG1nvJ8ucLk+yNEVs0mx6XAl8H5kxFChZLSO+AmcwfVQYkee8yW6ptmLqJen3axdvku
         eZCnWKoEhIlE6sWIXjbHGKBWId8B7QVxegXbv6FBwrGpzWiqp5Ezmvrgha7XuzoAp+pg
         vZ6fk5QiV5HahJURlBsr29dMDEQV6tw76PwvtJOZz8xKxgua6xtv5j0+PY1nob0Lz2eR
         nMRO+bfz8LVHJ0GrN8hNrJvflv5jkSOJL0zxgj9JT96x47v1XtRyZls6mKbe0ZH3zFa2
         zpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=aRT31e/ISc6+N0JcYA2/LCgu9ylSECt2pRQd2DVjS/c=;
        b=UfyJaRrhfclqfTJXOZDFcQ2OSJQoLy4+ie4iBA7Nic7vm1/ITyR0IWOdlld/goyYdz
         i6zawnlycoMiZ14otiYQVcwMJsMKqRLJT5b4rVH6J7QD2//83QxtUCIyank+xy2IVUe1
         7V1+1fQilfRo9OPmrqEIVP5xaCP28nxJ3Y/kqxpujNY3R87TOZDlB72HgIKNODvu1txx
         u8Vw+NdTO57GqMClmZncO1Ao0sRrNnGIS2GxZVydVkP1Y0i+q6Q3c6fXd2VtpMv3VFgY
         N0bhRvhuJRUPnPp1fezn+kXooHmobV1Rw9B/OP68HHp1/RBT72YtMMrnv49Y5QMLcFbK
         1IbA==
X-Gm-Message-State: AOAM530AwB2RwcbX3c4SDjpQl2VwX/nEUaJhj+qTggxb6hJqE3tN60Xi
        tjVPcXfla5iuVeqosaeLmfSiB0mrElrsmg==
X-Google-Smtp-Source: ABdhPJz7vmQEBxr8JCwWN1nv/1Dlwyce8lMe+hiHphjI2q8MKYBlT2n/xQgUY6ilzWoS62UG5SaLFQ==
X-Received: by 2002:a9d:6f18:: with SMTP id n24mr1795967otq.366.1625843316237;
        Fri, 09 Jul 2021 08:08:36 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id j97sm1180391otj.80.2021.07.09.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 08:08:35 -0700 (PDT)
Date:   Fri, 09 Jul 2021 10:08:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e8666c8707f_2153208c0@natae.notmuch>
In-Reply-To: <084a355e-95cd-5c84-2fa5-a901da3e0e49@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <084a355e-95cd-5c84-2fa5-a901da3e0e49@mfriebe.de>
Subject: Re: What actually is a branch?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:

> While writing a mail on the origin topic (improve docs), I noticed that 
> the word "branch-ish" is still free.
> 
> Which would be anything that resolves to a "branch reference".
> 
> Currently this only is
> - branch name.
> - branchname@{upstream}

Actually @ and HEAD too.

I don't particularly see much value in that definition since I always
use a committish when I write a branch name, and the fact that
`git switch` expects branches is one of the things that bothers me about
it.

Either way I don't think it makes much sense to do
`git switch branchnae@{upstream}`, and even less `git switch @`.

-- 
Felipe Contreras
