Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA44C433DF
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 23:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E772320674
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 23:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="GB7UTVEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGLXiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 19:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgGLXiH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 19:38:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FC3C061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 16:38:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q17so5163832pfu.8
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 16:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=VDtdv5rOqT+5AyfeqS7p0JUhT6DWd7rxIHxsfiNn2Yo=;
        b=GB7UTVEOr+iXvFg8x/3NNGReluIDwuKSUa6Hx8YHQZesskySTHKTa8t2ULub3aQCeI
         brGmzYktWfphu9hueEqVQQ/3Q6cAgGykUpHzNvje5bVAvAMfXEvK8EOKKFyb88XTOgOm
         3nYFAzfeHMoR/jcG76hNbnOkydz9Ttxlj2Ts4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=VDtdv5rOqT+5AyfeqS7p0JUhT6DWd7rxIHxsfiNn2Yo=;
        b=XunwJ4dF94o1u8JtWeFpyVzQs3jXzqkcBYyw4oyAlX78RXlRCa4AOKerSh0q/djuAN
         Lg/KBBLBRFytfGEl4iosVThGYH8aDFv0u61hkeszSZeyT7auFzYcC7/tHNQr1tvHpxqm
         we1VHfd4YfzQ8cI8ADYAZHvUOB56CC/MK5U7JIBpWZ7STVcNaqHD6pFHfrCFJ3w+qEvB
         yh6Z5W18XSUOhzESinXwVakfWHnfS044sjKPNjZxOwEZ79M2xvZtVeBWYmeC8vZtXKHR
         MG7PqYgXzTT+jdk0JzCW3N7VKkfXHRyQwDsL0d0PkjWPJ+qU/H989gVS/tw1DLgF8T9s
         IW8Q==
X-Gm-Message-State: AOAM532U67N3pFPxFvxiIm//TbD+fwNgDVHaP0aRKpvpsO2trUkutDHh
        rKwlgZaGwHOYFkXQVhAPF0jVpQ==
X-Google-Smtp-Source: ABdhPJzqoPUA7bwC85BrS4TLTHn9htz8+kYmBygKRk8DeRQ97BnKtau8RBe078lfyXMsX2R/DF6MhQ==
X-Received: by 2002:a62:8688:: with SMTP id x130mr72883611pfd.280.1594597086946;
        Sun, 12 Jul 2020 16:38:06 -0700 (PDT)
Received: from ZoomDell ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id t1sm11726092pgq.66.2020.07.12.16.38.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 16:38:06 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>,
        =?utf-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>
References: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com> <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com> <xmqqh7uhz98q.fsf@gitster.c.googlers.com> <261a01d655a0$71077210$53165630$@zoom.us> <003701d65855$c1874320$4495c960$@zoom.us>
In-Reply-To: <003701d65855$c1874320$4495c960$@zoom.us>
Subject: RE: [PATCH v13] Support auto-merge for meld to follow the vim-diff behavior
Date:   Mon, 13 Jul 2020 07:38:06 +0800
Message-ID: <002801d658a5$80a651c0$81f2f540$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGL+c9r+Sj3YnB8Xlh5VXkiFBL/EQG/MxNQAccWvdYCUW6JKAEuxOKmqWEibYA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I had rollback the changes, which is submit as [PATCH v17], it's same as =
[PATCH v14].

You can just ignore it. Thanks

https://lore.kernel.org/git/pull.781.v17.git.git.1594596738929.gitgitgadg=
et@gmail.com
https://lore.kernel.org/git/pull.781.v14.git.git.1594268906195.gitgitgadg=
et@gmail.com

Regards
Lin

