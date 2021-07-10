Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C96C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 10:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6522613D0
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 10:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhGJKkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 06:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhGJKkO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 06:40:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1031FC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 03:37:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y4so10134470pgl.10
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 03:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1jicSBHmX2VZKrZ3KUtO4xgFVs+sKCAnwlW5knsDq+c=;
        b=dTWGFiXHbm06FlyNkgiWTkWx1UpZZmRsG3KIk9hMbjxupSJaXsOVQeTroUJg96Zb4I
         5ax/ihQtv3ONzU1ae7KVCYKxaD7vizVeoxSYfNSmeIfbn1pFS+U6nBRFyumgNFTo6o9j
         AVyCLsPz1BqbFlogdafogkmbm81IuiCkJXHgqtJbBbEQvYViQSgFyQM6k3gdXe1NQaKb
         LmTcgmw6dQJlXQlXesnebCtPy9+c0jFLW/k8u5rWJWTGwTE3CgAtGEnsuRXiA4LxRdEt
         uOPjE8enPDZ/ot+HgfaFXhV75erbewrRJceI/h0eidhrpxaHszyVSmM7jBb7jnOQJttP
         /vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1jicSBHmX2VZKrZ3KUtO4xgFVs+sKCAnwlW5knsDq+c=;
        b=SMSya4eCte7Akcfzg+18lDVVpplTOkuceVEWGnhtgXD7eQP8WI+P+YU+zHB1ODtklG
         aP+NdkZr3zEKsqXlQeVOxKXzr5dZAFsIcNexupN9YrYskTRuenVElz2qXPfwS7yoFI+E
         CvVRDxmlcmk172LsoZjLfubBIOAMB2E6V/jNnTMhQGNpcI900N6imm2hSBpeKx+xSXgp
         RczgUNanDSANtQhcsHBCMeKtrxDeXPhOWmPcIe7JpmUUVfz2kHxJGRAiB30a927tgBlW
         FlCJS0HZmjNcp0G2y+dqGspekrJYB/9oZ6TnVF9Rp9FwbMkpQOZfOVaA2U/GV4bka4tf
         uZLw==
X-Gm-Message-State: AOAM533nzXi+IBlbkPzmzhstE1gfIlDuaTJ0zMt8uWkrJknObiWzp4gd
        Vt8dwLaR6bdFSPeBBZ3t7a9yXIMpdOI=
X-Google-Smtp-Source: ABdhPJwHyHN3i5dqxpklljo5ykW0UJyKXNkiyCYEfbUoZL/2RTxF57P1L8GJf2ROQ9l/6F78hH1tpg==
X-Received: by 2002:aa7:8b4c:0:b029:314:5619:d317 with SMTP id i12-20020aa78b4c0000b02903145619d317mr42523866pfd.60.1625913448227;
        Sat, 10 Jul 2021 03:37:28 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id u7sm10921294pgl.30.2021.07.10.03.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 03:37:27 -0700 (PDT)
Subject: Re: PATCH: improve git switch documentation
To:     Sergey Organov <sorganov@gmail.com>, Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <87im1ieaba.fsf@osv.gnss.ru>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3dbe1f6f-1e9d-3bcc-a7b1-4d9cde56bcde@gmail.com>
Date:   Sat, 10 Jul 2021 17:37:24 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87im1ieaba.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07/21 17.24, Sergey Organov wrote:
> I believe that's because "git switch" tries to do too much. "git switch"
> should rather switch between existing branches, and do nothing else. As
> I said once in this discussion already: trouble writing good
> documentation is often indication of some flaws in the design.
> 
> Creating (a branch) is fundamentally different operation than switching
> to (a branch), and that's why the former doesn't fit into "git switch".
> 

So I prefer your suggestion. Also make `git switch` also switches tags 
or random commits (like `git checkout <tag>` and `git checkout <commit>`).

-- 
An old man doll... just what I always wanted! - Clara
