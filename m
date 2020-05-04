Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2795BC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0761820721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjWtNtEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgEDTte (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgEDTtd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:49:33 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94993C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:49:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so11989qts.9
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=106U0Zo/XtFKad/GAMKq4VipvqFfoV7WMAUdCgsIIG4=;
        b=tjWtNtEObbNW5kI2YSPOf6fcnliW9jlr/SxPS8GR8iqUC3gCSEdaRiax+EaeEyChap
         /ueRvhdkdbLgHkTUy1T/yC3vJ0gpW8JHpFqi6qDejwFzbiesd/SS4n5IwZw/KjyjL3hH
         vSpFM6jUo9l5UluSvUg0pikuCubBwjNICElMhHwdRBajDgyKHbkrnk1+SoFzyk/2Mp4u
         1K4EF7IGIPzZv64pPj2PqVSMbDe32bWcu8NRK8h/SZon4gZqZmK2i4rRWS0Fu0vHE6YD
         PqTHjaAV23HJbE9j0vAhguXrTLOQBST9qJfse96pSvdqtmqb5KHO0r7WWXAPIb+tPexT
         QvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=106U0Zo/XtFKad/GAMKq4VipvqFfoV7WMAUdCgsIIG4=;
        b=lW+dluarCCXueqUbZVnZ6hVcMtCmCO7orD0RyOor0tSsq7zxO3ywJKtIdGDwRG9mDH
         Gupj3XkNpHTsgDDOqNESzYEpJyhJs5v0pGpeq4fn/6FpjeRGz+5nwdc5oSjk1wSj3u8a
         GYq75KmfWQNQVol4U6mRx0TK47anARyqxmDQdDks/Vob1fUJrOciSeGSRFAM0GHIQHQW
         7Q9rLUS5ySPlZx4mJ3Ma07zY/4xcgkrtCjw2eluBq/PJBDsreVUj78++eZa7rzmp4FIX
         8eTeK5u2XtSJ9jqwW5Uc2+GkzB7jFK4beYhI5tXRcUcoFfXyR0Qu7Qz7zmpyAhKBGc6c
         DDyw==
X-Gm-Message-State: AGi0PuaTw6wKWe+b6xPuDq+FU79pX2GzBZIUNwwz79wqxAX3XBd6L1zw
        RyxS/XAJ5HVUdLoAjICc4P8=
X-Google-Smtp-Source: APiQypIYJTudI1ifMnmISZGezrVlJ1YAagU4Zlvj8/fWiarF3UrB+R5RjekqT8LrYvncrAmoBuunXg==
X-Received: by 2002:ac8:4ccc:: with SMTP id l12mr819281qtv.129.1588621772745;
        Mon, 04 May 2020 12:49:32 -0700 (PDT)
Received: from LeoBras (179-125-207-129.dynamic.desktop.com.br. [179.125.207.129])
        by smtp.gmail.com with ESMTPSA id g12sm11378474qtu.69.2020.05.04.12.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:49:32 -0700 (PDT)
Message-ID: <306703d7687377d6a74ec9f1d63331580a3c109b.camel@gmail.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
From:   Leonardo Bras <leobras.c@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?ISO-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>, git@vger.kernel.org,
        Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Date:   Mon, 04 May 2020 16:49:09 -0300
In-Reply-To: <20200501235948.GD6530@camp.crustytoothpaste.net>
References: <20200501105131.297457-1-leobras.c@gmail.com>
         <20200501125308.GE33264@Carlos-MBP>
         <xmqqees3odrb.fsf@gitster.c.googlers.com>
         <20200501222723.GF41612@syl.local>
         <20200501235948.GD6530@camp.crustytoothpaste.net>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2020-05-01 at 23:59 +0000, brian m. carlson wrote:
>   git config credential.smtp://smtp.crustytoothpaste.net.helper \
>     '!f() { echo username=my-username; echo "password=$(my-password-command)"; }; f'

I have tried doing this, with --global, and my config file changed like
this:

[credential "smtp://smtp.gmail.com"]
        helper = "!f() { echo username=mymail@gmail.com; echo
\"password=$(gpg2 -q --for-your-eyes-only --no-tty -d ~/words/imap)\";
}; f"

While sendemail has:
[sendemail]
        smtpServer = smtp.gmail.com
        smtpServerPort = 587
        smtpEncryption = tls
        smtpUser = mymail@gmail.com

Yet still,  I was asked for password:
Password for 'smtp://mymail@gmail.com@smtp.gmail.com:587': 

What have I done wrong?

Best regards,
Leonardo Bras

