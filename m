Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40F7C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 22:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjBNWeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBNWeD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 17:34:03 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B979EEA
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:34:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso2551819pju.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vD6YYovXhpE6MmFihiBuNUZJ0O/DIct1oEBfNNq/BfE=;
        b=QFgtQ3BQP/bZG1VQQC/LjWfDS3CROGlhf4gR0bTLQtxKNUuHEEdIZniQDMiAOB3WUv
         cOBM+EHfA9JcRmFHJr0Jv/C4XTl1u+vAcuzXluK2MsDgvrpqrsdpW3WvSEqCdTaI9h7a
         avX2QgoM57G90LOYNn3Hb3irH8AZEDBFdm0wPtMVrvN883qLT2JvydxSkWWafaahq6QU
         CSfgWWOVqeH6CQ65FVYPo7VyWrX58JOvxADkMXHrv05nVdgTGkx0dlLHyf4n3U9J3n9c
         0JgE+b9L7CbjxcjZvBrinYorn92EPouLQdYa67WCawCyV+ZeaRweV6QxmFwEuNARUocE
         bCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vD6YYovXhpE6MmFihiBuNUZJ0O/DIct1oEBfNNq/BfE=;
        b=VsnY2/On1LbynPgOux+gaYEq2n5UNNLRGz1IhDbgQVCH9IaW+FK3tZDW2TqL5NzDFM
         yhCqilNBc/zIWNMwmMI0/s1pFy6xnZUbaD7wGv9xSxOGU5kPT+J6dqzno+gaYwFhA6Va
         2leNia44iu8SJgMT0HgCg02SnVUHn8DsJi0ZJHl8X0Ru8aI29OxODlySsYtn5NT+iVDi
         tcNiRfXnZsHfLSlpG9/4KfixDNyzdnH0ZLKlur0C+mZAhB+6xF6oNgnfqUvyyqlHabEm
         tPIXP19GfpTprxe77U+Su5PeOexk9zIvhtP/bAVOKqgKS2sjYDwhiXc0088FmHq9EG0o
         DU9A==
X-Gm-Message-State: AO0yUKXo+NDCMUvjsL9H1dpmxSfRUbX4jExUroHDyC1JCHGKp+tery13
        MDAJyqVNm2bO1kRCNjrcotpCqcnYc3g=
X-Google-Smtp-Source: AK7set/pBlv3WtmnUNLBNVLrZTLNgAlFYrmc2OJkUVdR2N1agKKb55rW2mpTa3LDkGpr/6sjk0632w==
X-Received: by 2002:a17:902:db03:b0:19a:9266:2ea5 with SMTP id m3-20020a170902db0300b0019a92662ea5mr306053plx.43.1676414042370;
        Tue, 14 Feb 2023 14:34:02 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902768400b00194c1281ca9sm10721119pll.166.2023.02.14.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:34:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): avoid sscanf()
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
        <Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net>
        <xmqqmt5f535i.fsf@gitster.g>
        <Y+wLoFKXhlugxrh1@coredump.intra.peff.net>
Date:   Tue, 14 Feb 2023 14:34:01 -0800
In-Reply-To: <Y+wLoFKXhlugxrh1@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Feb 2023 17:30:56 -0500")
Message-ID: <xmqqwn4j3mhy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> but I have a feeling that it gets more readable if we flip the break
> conditional and the loop condition.

Yeah, the somewhoat unusual loop structure was what motivated me to
look at its corner case.  Flipping the logic around may make it more
straight forward.
