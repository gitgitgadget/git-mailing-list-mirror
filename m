Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83B2C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 00:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F851207D4
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 00:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="dwsSlcMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgGBAUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgGBAUa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 20:20:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0A1C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 17:20:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w2so11747631pgg.10
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 17:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=oNnav2NjLYHNbyUnHcdxjNAExSHYyJ4cpPA0fI2juTw=;
        b=dwsSlcMyleYn3IP35pdHI7KajBKRNebRHQa+R/n1wg3OeW5wNlJQOtyCpyLcTBM38y
         7j83kwvE3D+9lzY4YJRyin/FGWbiLjJesyjaKajwviyiGVqVOFYYo+otleEQbsZFw/HE
         SPSjs9AVAcuKfRRCcKAa33vEt4zItmc9EYa8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=oNnav2NjLYHNbyUnHcdxjNAExSHYyJ4cpPA0fI2juTw=;
        b=dIJSv3DZOYQuIOFGMkxHfyVr74jaUKkSevjR+sAUPShBtOt68sy3JPYILLPwR7DgiA
         6RTf8Xyz5i23ujBS5LB51g5jDplQLqqPi/7eiSlasNJNuQeutlDsZrfAvpb2g7rH29xm
         b+eu2e4IZhjooc8BBSsL5lTBWmU1ZnAYodKsNGWoZ+ne+P/adeDlDh3l0JTw/EjChV8J
         NhSnF+l8qATIPXGwJoojm4/29uxmo4dbvd/SbeC6X/1Pgqt9QyQ1pZJYNzsZUoqPgvar
         ZcL4cYjTPx3Oe6kpGXrlGJzyuqovzujhjL9X/0Fst28qJqYTbg9ALR0UjpYE1uQ3dFeh
         vW7Q==
X-Gm-Message-State: AOAM532JqtTPeIaVHezuqP6/xHOa+25uCEVS1j8bJcrF8FNigDG3okBE
        E/r/zkcFyWMBRK62qPziA3NzUg==
X-Google-Smtp-Source: ABdhPJzl+UIyBfMTlIoczo9h/9Rk3SGydelDSy7oFf0ndosk6pFQ48wz0VfSHgyC8t8c4awqkvH3gw==
X-Received: by 2002:a63:457:: with SMTP id 84mr22529871pge.219.1593649228233;
        Wed, 01 Jul 2020 17:20:28 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id gv16sm6390894pjb.5.2020.07.01.17.20.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 17:20:27 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>
Cc:     "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com>  <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>      <20200701141755.GB1966@danh.dev> <xmqq7dvndnf0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dvndnf0.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH v5] Enable auto-merge for meld to follow the vim-diff beharior
Date:   Thu, 2 Jul 2020 08:20:22 +0800
Message-ID: <1830601d65006$957cac90$c07605b0$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHCkYwuu/FCSmveEZBDvCnrwyHmCQL1zGm+AhjQO/4Cd7/8wajetpgA
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

> While you're doing it,
> do you mind changing hasAutoMerge to useAutoMerge?
> I think that name is better :)
Okay, no problem, it will be ` useAutoMerge`.

Regards
Lin

