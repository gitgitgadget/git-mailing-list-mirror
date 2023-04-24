Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137D3C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjDXQY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjDXQYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:24:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8414B7D9B
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:24:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b67a26069so6344258b3a.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682353463; x=1684945463;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ry43HN3xl5o7lFHHv1Bx3scGGGN0UiFR9oTKEAm1C9o=;
        b=TNV8DtG6IoVR595NKPHfdGm3nxl4CLnbuYePscDa4XKNwESUB1LLMSde2xi4Qqddo+
         DaqGpzBuF4LojmY9/JstUn3Xtwn6C9+fLh6OCHv89bjLRrhmlILyee51RKsp8fwKqFsq
         YbQCT087H87+cGQ1MS15IUjYt/8n5nKYJw6XUk6G+aMu76huTs1OiL4o/dXwL50iUnt0
         1PQEXhTrDcq+AVzxdfl9DzRi43r4/JZMOs8lV7fJ2+pYvpbUdeT0EfQHbccEpAz6K5ma
         so7F5ft7MOfpfdOE8jOtPiktx7Ny5uRk++dXdYYRYEYn3UEI1wyPr6LL/nR+g5dl8Zx9
         evKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682353463; x=1684945463;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ry43HN3xl5o7lFHHv1Bx3scGGGN0UiFR9oTKEAm1C9o=;
        b=VYYQi3SaF0BgRWNjqNO6r7ElydbO0TuFBtgoIQxM6q2wNnDRDoiFE3Gb9mQEjWoDzm
         OgGZ/wOWfMejbXqZNtFIK06o9Lsp6L7MErbZZ8pFxfkTMvLUTASIPhpOOXUACxpbwp3t
         F8KjH64oSzwa/1j5o5xtvPtHm3HIEf2xSBjl0+feq2hIDbhY96dcFbxd4bavzIcA9zMs
         U6lyelsqTQyr72EuMY6c3bTO9zDKMXi1hyJcyhsLwSs0rJcRjySnx7SXo8wJak2Sr+qR
         xGHtuyXNuesbk0FrXk+vGgbEWGzYZKprvNqgu8cHQsWyrLg7E+cLzCVtkFVXD0brgAdo
         Do/Q==
X-Gm-Message-State: AAQBX9dOjkGdgzhTCOPK0x+zBnAppgvSbduNP1HgOe1bA2mfR3S6fU0Q
        pSId+d6UvHsHjgyA89BkZj0=
X-Google-Smtp-Source: AKy350YGjsHZBzQzAr6V/Kqk/Y4lwV/OPmMc5H/U+oDsf1Dp/+7/xGBLgVOvdpSjEHEL96HRJaP61Q==
X-Received: by 2002:a05:6a00:2e0d:b0:63b:7119:64a9 with SMTP id fc13-20020a056a002e0d00b0063b711964a9mr20297357pfb.16.1682353463651;
        Mon, 24 Apr 2023 09:24:23 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id fe5-20020a056a002f0500b0062de9ef6915sm7521624pfb.216.2023.04.24.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:24:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 1/6] string-list: introduce
 `string_list_split_in_place_multi()`
References: <cover.1681428696.git.me@ttaylorr.com>
        <cover.1681845518.git.me@ttaylorr.com>
        <6658b231a906dde6acbe7ce156da693ef7dc40e6.1681845518.git.me@ttaylorr.com>
        <20230422111213.GB2969939@coredump.intra.peff.net>
        <8d228041-d473-7f3f-87d7-543b350aab0e@web.de>
        <20230423003553.GA3953216@coredump.intra.peff.net>
Date:   Mon, 24 Apr 2023 09:24:23 -0700
In-Reply-To: <20230423003553.GA3953216@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 22 Apr 2023 20:35:53 -0400")
Message-ID: <xmqqwn21fdu0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And yes, it looks like there are only 7 callers which would need a
> trivial update if we just switched to the multi-char version.
>
> That's very compelling.

Sounds good.  Thanks.
