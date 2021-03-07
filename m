Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B115C433E0
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 18:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D477865172
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 18:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhCGS6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 13:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhCGS5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 13:57:38 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C77C06174A
        for <git@vger.kernel.org>; Sun,  7 Mar 2021 10:57:37 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id t9so12188126ljt.8
        for <git@vger.kernel.org>; Sun, 07 Mar 2021 10:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=+m4dlag91BRQrBC84FEVf0NJfNEzJniAQxTmtcV1Kr8=;
        b=Nlk5piCXkBJGYYBGvpM3Ldxrss1+Gf8puxug0qauoXrE0OL32eGk3ukDRERab9TIoq
         PasQtoe8WI+42agqKTq2E5e1jzHsG6KhknEfEtw06fCdp7hyIwdc+lz9SDlBm7WIxxjW
         MBfsUg68Zbs3zfz0OkyM8nvI9gbRUlG8utZ/1vtWFmLAu6WjY0YJSNrkO5UryAIVbVZY
         WYF01iFna1/1maiCl49Q4YScCSkzlFbVdIHN6pxYVtULpWKOPv5cVYBbfmIaD9k7GwSw
         fQ+4lRYvwjN8fmCtNVA1gMsl9njfsXayYzSgB7OIllHSoaxSyvRCxwSsVvVDDn8Zt1Lp
         V2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version;
        bh=+m4dlag91BRQrBC84FEVf0NJfNEzJniAQxTmtcV1Kr8=;
        b=L6hwu0O8m3aEpfFRrtJb/VOxflYnmaGwZxhdrsmGhtPj3Pp+xJbkZ5/dQieINGdciX
         Gs5M/Ci6sBskjO5Wumi0UgQiynZd4tximRsSTXAxDNSCoEqZC2atZC7h9fRu1fqjgAVC
         LU/ngWFQc66FHXmUVl03zoOwt3f1CAACkWcTLwelJhUscfsPyoY93TN9+hjDH5/t8fDz
         os864VaabBjzGZ8+hoI1YCNpN5sZPGFjxmQk+s++lVpwt4cA+BKNMBu87BKi8SgGRu9I
         DsC9zHaHVeuHe/d3TjOF3xEmZGcOZO07lXjySznfGHrklD3fqZBhzuVMtvxM3oq3QWfs
         4rVA==
X-Gm-Message-State: AOAM533wWBuCQ52AUq9mi0y+TCezTSzG47SG6zjE4FUzlJr4QrPiimVB
        C58Qy16QAJ1S2Nw2ce/LLNl5PjaNJYE=
X-Google-Smtp-Source: ABdhPJwQyS5ulasPioEz35iJjmgt1COLRf+JLtU3MIStAFooi+mIUyQA53bLlOf2clIPar/0JIlAtA==
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr11451508ljj.465.1615143455758;
        Sun, 07 Mar 2021 10:57:35 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w1sm1087765lfp.202.2021.03.07.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 10:57:34 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git pull unclear manual
References: <874khsqq0o.fsf@osv.gnss.ru>
        <xmqqv9a7emx6.fsf@gitster.c.googlers.com> <87blbzm901.fsf@osv.gnss.ru>
        <xmqqy2f2biz5.fsf@gitster.c.googlers.com>
Date:   Sun, 07 Mar 2021 21:57:33 +0300
Message-ID: <87y2eyg5b6.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Do you think the manual needs some improvement still?
>
> My reading is already tainted by using Git for a long time, so I
> won't be the best person to judge what's missing in the manual.
>
>> I mean, I'd then expect something like this as the SYNOPSIS:
>>
>> "git-pull - Fetch from and integrate with another or current repository"
>> ...
>>   git-fetch - Download objects and refs from *another repository*
>
> Just replacing "another repository" with "a repository", the latter
> of which includes the current one, would be sufficient, perhaps?

Yeah, just "a repository" is fine with me, perhaps followed by a note in
the DESCRIPTION that the current one is indeed included.

-- Sergey
