Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D88C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57C46112F
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhD0HYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 03:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbhD0HYR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 03:24:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9934DC06138A
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 00:23:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n21so11900276eji.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=CxVnL1B9K0Vmi3Yom3MdwDalig23PAndVOWRroThMeA=;
        b=Cc9/40Ady/zfMvSuZGTxlFxvbvdA1Jn+/a94aSbOth8agECu+fZ4pH3d6SAcGPmQoT
         q1fMhmqPUBkyxLXQtp8m4C82gMTCuVgsACmwYPqTPpMSUnZYDwafnZqfYWbYVd9quU//
         ORKZTEvAGf2p9SLfmF13BMdsgw4w5grx0h4ClyVNnWeSah2dAxFsp9GB7ytApfCtLinh
         WwlCbKB0JXWOt5u0efZjByxYVvMEE7P87mgy34MqCefblXgVc1G68oxTD4kDKgZbGSrU
         xc8e5UQMo/kt8L7+E4rPns2reMhXAc9yAK5Q5M0iUL/vnd8OlYJzCekwk4YxhFxiBDI5
         ZsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=CxVnL1B9K0Vmi3Yom3MdwDalig23PAndVOWRroThMeA=;
        b=syF6bUovX3mw+/SE2azbv+t6HqXTs/5eKLxkgSduA5QNz6NcBMY95AmRJpvXMxdPaK
         Cq1EWVC9YK4tLKcbDZW6nNymJnSuXVJHTYac149Zxd12Wa+VtvNk5FIB8dkcrEm51zZM
         Zfwy1wkpt4J/ZkwfnvEVMIdnnPNu8hm70tt2kzFBd6FHDqTbNrjpxLdQhTNTd+H05SAu
         7ATRC1RdEqziQqRGTeM3LRPsdn1iufnE3MbjhBgIuEf47FuEndzvA6iH5+yrbaWjOSbY
         XySQaYW5dEJoKUC8JsrfAJkSGgHJM/lVQJssv0mNPLknuSKtYW1hOKIslGzOAh105LSi
         OrTg==
X-Gm-Message-State: AOAM531qncdt6CIBz1YCgaF1tLrlsgR6Vd90QR/AEERawR7U+7xHKP3E
        Ma3nGOXyuPE0XSye9nQc2xGMf+H8H/SgYE8=
X-Google-Smtp-Source: ABdhPJwSwpd7A44dECCeM7d26MogPZCD29qiyDXKh5vsmtBEWU17NEgD7mUwDls3wHBI06eVyC0aGg==
X-Received: by 2002:a17:906:8a59:: with SMTP id gx25mr11688408ejc.63.1619508212404;
        Tue, 27 Apr 2021 00:23:32 -0700 (PDT)
Received: from [192.168.73.193] ([212.55.198.55])
        by smtp.gmail.com with ESMTPSA id z17sm4310549eju.65.2021.04.27.00.23.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 00:23:32 -0700 (PDT)
Subject: Bug: Git invokes hooks from wrong directory.
References: <03b67357-4d9a-ea66-ad72-f01bb25aa54c@gmail.com>
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Gabriel_N=c3=bctzi?= <gnuetzi@gmail.com>
X-Forwarded-Message-Id: <03b67357-4d9a-ea66-ad72-f01bb25aa54c@gmail.com>
Message-ID: <e173a3c0-5ca9-4c0e-9a1b-ef5f6aa72340@gmail.com>
Date:   Tue, 27 Apr 2021 09:23:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <03b67357-4d9a-ea66-ad72-f01bb25aa54c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Community

The following MWE in
https://stackoverflow.com/questions/67273420/why-does-git-execute-hooks-from-an-other-repository/67276138#67276138

shows a bug that Git executes the hooks in `/tmp/A` instead of 
`/tmp/Githooks`.

# ----------
|# Make simple repo git init "/tmp/A" && cd "/tmp/A" || exit 1
|
|
|
|# Make hook to demonstrate the problem
   mkdir -p ".git/hooks" &&
|
|echo "echo 'EXECUTED!!!'" >.git/hooks/reference-transaction &&
|
|  chmod +x ".git/hooks/reference-transaction" &&
|
|  git clone -c core.hooksPath=".git/hooks" --template= 
"https://github.com/gabyx/Githooks.git" /tmp/Githooks|
# ----------

Would be nice to know, if this is indeed a bug and should be fixed?

If somebody points me to the corresponding source code, I could dive in.
Thanks a lot.

BR Gabriel Nützi


