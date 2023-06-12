Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AA1C7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 21:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjFLVVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbjFLVUh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 17:20:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000ED2718
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:14:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b3a9e5bf6aso15810255ad.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686604482; x=1689196482;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72xHJg7LGVnhEZwb6cidrbsGrKtAQEivwpJA4VC99jg=;
        b=N0fYCwaL2L5IA7LVFQZUQr/3my1JSJ44ssjy0BGgXSGRHWiWK+jjv9p8WLjOl3y2k4
         f8Ta0intlbPBw3u90cZYGnuJhz8SFjfldhp+FLWBwx2R4Ih9rwZYIZ8gGnBehYeVl92K
         QTagKArPxNo4BeV1gUcuiKy/aUuSjEU4G9EHvSsPDyxNlRuTAF78SaED9QOv5kTjsbQW
         2II/CvNVENiiUbgNsFDgPDVTXAoRpzE6wP+WoCL4P3VHeIACyOJc2d7FDZGhwVUaDnmp
         XJdNqr3TqiSzYvV54UmyjNVyx+anM8+lSuQ19IyOL/sQC0dh4N4gvj+W5bybOR4Q31kV
         l04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686604482; x=1689196482;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=72xHJg7LGVnhEZwb6cidrbsGrKtAQEivwpJA4VC99jg=;
        b=FmOvl9Kgok/LI+HRDVO3RRn6guzZe9zzFP+g/jaNW87TNDPP78Uah01/ia5aEy5dGi
         K2YaAJNdIAjgzudH2ECsRcHAMF9K2VS49+QXZZ6W2AiP64Gh6FVTyld+IRDk9247Mtbg
         QVwiHBnMCZ+Zf6SAdxYrrfjh5GbR4herAiWyE3mGOXdCdMfL4PpbMQX/c9N1LujtjQEu
         Zi/NAzAQ4KyaY0j1xf3fIHWba0jCSvasiTsRdl/MUwoi+9bPos70LK3hlDahrruMre8O
         t0q1m5cZHUs9gb3flhMtAVDvlbILpaPsFbiV+yi5WJ0JjChodX6bahGb1lkyCRZd/yYx
         be0g==
X-Gm-Message-State: AC+VfDzWcxvsBJFNLkUanqYLZGHkhyiO2z2y9In98wFfF2Yi9tF9tfcd
        lB7lxCj3RLXmg08iWRP5AOk=
X-Google-Smtp-Source: ACHHUZ50j2t8SdF2uMcaTOiA+F3Ph7bvwJypDfIggOhdpPl09BT4J0Wx4G8PYQshd10bNMro/nhSxQ==
X-Received: by 2002:a17:902:850a:b0:1b0:378e:279f with SMTP id bj10-20020a170902850a00b001b0378e279fmr7302699plb.19.1686604481910;
        Mon, 12 Jun 2023 14:14:41 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id mu13-20020a17090b388d00b0024e1172c1d3sm7880059pjb.32.2023.06.12.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:14:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5 2/2] gc: introduce `gc.recentObjectsHook`
References: <cover.1683847221.git.me@ttaylorr.com>
        <cover.1686178684.git.me@ttaylorr.com>
        <f661b54941a12c9bd8e226aebb4f0d53c10479c8.1686178684.git.me@ttaylorr.com>
        <kl6lwn0cfbyh.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 12 Jun 2023 14:14:41 -0700
In-Reply-To: <kl6lwn0cfbyh.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 09 Jun 2023 16:33:10 -0700")
Message-ID: <xmqqv8fs8jsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> When performing a garbage collection operation on a repository with
>> unreachable objects, Git makes its decision on what to do with those
>> object(s) bed on how recent the objects are or not. Generally speaking,
>
> s/bed/based/ ?

Indeed.  Also "or not" sounds a bit extraneous.

>> +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
>> +			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
>
> To be consistent with the other error message, perhaps s/extra cruft
> tip/additional recent object/?

Sharp eyes.

> Aside from those trivial points, everything looks good.

Thanks for reviewing (and writing).
