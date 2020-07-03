Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43E1C433DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D8A208DB
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="F3CX1pcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgGCDxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCDxw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 23:53:52 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3CFC08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 20:53:51 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id p7so13732899qvl.4
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 20:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=/OmJhKALP3HS1eQMLFY8RJsuKMfMZx4np1phigPTJKk=;
        b=F3CX1pcCJEQP0PrsY5xDpwrW+5ZRhBhTu7w57WnKH/fwCLZGEnaoTxSQ94sMnScYms
         ozRHjcw14wcG+kPMsPQ/HJ7Y03sLSSnyzs61ejSaeFfpG2FbdfA4PNq+yxeWDa+b8T8/
         o9CezHL+W0GL//GQbg0RS82nnWEcxOpw6CujE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=/OmJhKALP3HS1eQMLFY8RJsuKMfMZx4np1phigPTJKk=;
        b=rs8BPIHKr8EA6M55iWLXF5gi+EOFnrHBAGElY/8P4eQF0jfBcM7f+7F4IlFhvRNOxh
         AfOP/A36Qq6IqBMSsFrIf1dr67uQo8pBzTGESysbzIVUjPUEMtHzV32pOVfbhw5Obp5p
         sWhYElIfGwnD9fsYyCQLTdqNIoyxMf6tsKhNVLqSP7Vdhr1rDXhs1UGG+Hv8sJRainjQ
         cFDKLwhj9RPgzxxTbGPxlkRVGED5cAQ1CNfl9cKLocTWQ/fnot/rDLxitXdzRUuldLqA
         EW6CQND3kEZnZOAiL2owAas1q4NTuiO9lwZ7ZXiHxZZK31Mdu6PwWrQQEQIx1yP5Se8h
         U+iA==
X-Gm-Message-State: AOAM533DOevrm98aZZNbpStua0Yi0C0TLA/qJK3BgYuR3vTKMyFBbONz
        H4bFfDAe8QZ490cqrW149MBIEutYqwQq0Fh8oZ6BR0Ahycil7cskjshp9O3twQaFvEFmnm1ublJ
        I75j7x/Aj6ilerxQ/OjQdQYWELs8yVI6z6YBKXHom6lwoflg1gv4KqBAFIg==
X-Google-Smtp-Source: ABdhPJzIsuotDQ2v9bnSzst+QT0saMXVw3FahoLK9vMcrNMDPYtu5tIAU8CVeN/V4RaZCC9o2MQ4XQ==
X-Received: by 2002:a05:6214:10e1:: with SMTP id q1mr31679458qvt.78.1593748430717;
        Thu, 02 Jul 2020 20:53:50 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id j52sm11039373qtc.49.2020.07.02.20.53.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 20:53:50 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>  <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com> <xmqqv9j5bc4o.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9j5bc4o.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH v6] Support auto-merge for meld to follow the vim-diff behavior
Date:   Fri, 3 Jul 2020 11:53:45 +0800
Message-ID: <1f33d01d650ed$8f6069e0$ae213da0$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL1zGm+763T+IyJ8eZ0BxMuyQEl5gHMDywQAa4znDymmm69gA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thank you for your comments, and the changes are made to follow your =
suggestion.=20
In the [PATCH v7], the ":+set" is removed, and the "${var,,*}" is used =
to convert=20
configuration to lower-case, it won't call git config twice for getting =
`useAutoMerge`.

Please review again, thank you.
https://lore.kernel.org/git/pull.781.v7.git.git.1593746805771.gitgitgadge=
t@gmail.com

Regards
Lin


