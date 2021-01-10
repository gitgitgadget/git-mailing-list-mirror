Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED2EC433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36ABB224D3
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 17:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbhAJRQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 12:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbhAJRQm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 12:16:42 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A935C061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 09:16:02 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m5so14025360wrx.9
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S7OdM8kILiSJ3zIvNkyfmTKd7kG2EBt+XEmpUyPIzuc=;
        b=XduRUJ0eQ9sPBT7fQ58ViptNJqb6rgxKKesT195R2W+oIXfLN93NpgAJH1Bhdg+5lW
         N+xkYRZXEY8XAS8ArfHaHAwdWoMN1K0r3HMq/kc8H309Pd8XJo/Rwzi1C10KIryvdzJ+
         JpRcL8duOuTVIB61zfYv/sTep9yjLUUW/pRFstU3CzIC0v5KaGpsBqaxoCaZNrNsMm/B
         uD2MBm21n95+cPWafRV7TD46jR4XeoE/2o+wmu8Lwll1aUDAyrujSwpUPob/AezzoTvf
         flU4BXL/XAiTlL2/9vJI/5I0Q3aX2MNGXEZ2K/Qo8nBzv79KtupTiuIcV66IKXP4W1+c
         FucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S7OdM8kILiSJ3zIvNkyfmTKd7kG2EBt+XEmpUyPIzuc=;
        b=QS9fN1WvWa5WCk8e27KDFNvMPaL1TIn9KEw3E2XVxobVmkqqRZHNBwmkdbI3qNnSG7
         s+rgveFXsq94nq5WwqtuH/zWMMsoI/y6qT1fS2+KBy2sfU9KVkcvuSJ5CqlTlojl3iai
         NXy3Drp0mt2+NGy2VMgr1tzY9MqjX5mn3HtZLfH48LzaGdAE3m+sA+lKmYWHaAn4182x
         fah7JNQZ6msXRLHjw3N2s/4Sl/de95rX/nWE/bIP4QlfUgHjyQkxR9rSDdtPfEaT+qah
         2Z6dI5kkHWx2KX0Ati1Wjx+4q1TXPEnrY8Bfie6UNZiPLsBj78RPh2QgwULXCAYkF7XE
         kqBg==
X-Gm-Message-State: AOAM5324fa0K/cwBr6BBYArht9aTotgFIS2Pp81KdktArd4LiS29T+1G
        nz+FiXeu9rNQZvJZut9+0/wy5DswkVqT0Q==
X-Google-Smtp-Source: ABdhPJx51m3bVOB1tjS6voJ9d9+jAxzM23krH8jh3FyVnANUNPPVnXJm44FbzKzX+eFjsaDyvlcXgg==
X-Received: by 2002:a5d:60cb:: with SMTP id x11mr13062088wrt.0.1610298960997;
        Sun, 10 Jan 2021 09:16:00 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-420-166.w2-6.abo.wanadoo.fr. [2.6.83.166])
        by smtp.gmail.com with ESMTPSA id y63sm19713494wmd.21.2021.01.10.09.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 09:16:00 -0800 (PST)
Subject: Re: [PATCH v6 06/13] merge-index: don't fork if the requested program
 is `git-merge-one-file'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
 <20201124115315.13311-7-alban.gruin@gmail.com>
 <44c9189d-9d2f-c437-d0d6-9529708d2c99@gmail.com>
 <411b68ad-dee5-5a19-ae94-c2b6a249161a@gmail.com>
 <xmqqv9cax1le.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <f7d7cc3b-b53d-ed48-8aa4-2b26a0ce7da3@gmail.com>
Date:   Sun, 10 Jan 2021 18:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9cax1le.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 06/01/2021 à 03:04, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> We had the same discussion with Phillip, who pointed out this previous
>> discussion about this topic:
>> https://lore.kernel.org/git/xmqqblv5kr9u.fsf@gitster-ct.c.googlers.com/
>>
>> So, it's probably OK to do that.
> 
> These days, there exists an optional installation option exists that
> won't even install built-in commands in $GIT_EXEC_PATH, which
> invalidates the assessment made in 2019 in the article you cited
> above, so the code might still be OK, but the old justification no
> longer would apply.
> 
> In any case, if two people who reviewed a patch found the same thing
> in it fishy, it is an indication that the reason why the apparently
> fishy code is OK needs to be better explained so that future readers
> of the code do not have to be puzzled about the same thing.
> 
> Thanks.
> 

Perhaps we could try to check if the provided command exists (with
locate_in_PATH()), if it does, run it through merge_one_file_spawn(),
else, use merge_one_file_func()?

Alban

