Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237B1C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 09:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97FD20726
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 09:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhV/ow/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfLJJqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:46:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40384 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJJqU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 04:46:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so19222277wrn.7
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 01:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kax0FPWZ6qiSuCN/aSGqFhly0V7zzi0Nw/7S2y41c4Q=;
        b=BhV/ow/eUuWW4vHixyJeo/vpEObBQwupSQjFykCRUFFCknBz9TZR7wRKHhS0n7D/pN
         SPRMfxh+/GxjGX80Pz36BBGzWDacDZDYxFo7BWKfS0/aoIHLlUGUibWpHOEyltHOtdFk
         2TLDfQl/gg6WPPPLI5KbW3XZ34DDr3ErquqcVDdymsBCwsBzEHQ9r8bW4nYGKdQwXbxh
         RYe/t6KHCG5ppaGMnPo/OOCrUeWNIx+FkWmS3cayIjKPg4U+83JMFoXWYqltkhbLyRUd
         RboDI+VIwOL98nIw2J6gwLITRLG/VjWoVwCy5FAcompHCBysN0V+D4gbtSKXlP67RidL
         qJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kax0FPWZ6qiSuCN/aSGqFhly0V7zzi0Nw/7S2y41c4Q=;
        b=mXl0vybjpYkT2+K0onbgwewddOi5X1HchtXMouL4E+lVZPuIux3R65bPwXMW8fnmVa
         N2fQrlrrwegCWhJZjLolRfazVy0UOMEeGKi/7YfMGc9UwqWaCbHq/03NrrEA4ML3KTUV
         uqjr5QAaJEwsyhtk9pzjjvqiKWaonO9aqjgWeBtk830wuEd9e9/6kZD+77s/rzZnhRwS
         6znl+c5qK0rQtkI3I9nQ7bBP/Qbn3rd80cD894IJm4QF4pXiYDcptPov01m6cFGlZyIS
         QydprYY2svc/PsBwHR5OD+q9HpK7V8Gzax1r8U3d5lvEWLR6Qs1G/3OzOu1waNrHKJTQ
         O71Q==
X-Gm-Message-State: APjAAAUph1X75xVuD5CnDKOs3/Tq1SVDz67pXbn4Fo4GMZRe33Zc1iMM
        9ZAZVEmSorZByDb8nznComU=
X-Google-Smtp-Source: APXvYqznF4CFCa2rWoXnMi/xY1oLOMv3D9MeE7DHTk0kQYEXUIAomm6fEIgOy8BFsRLpGr5kzjcP/Q==
X-Received: by 2002:adf:93c5:: with SMTP id 63mr2148700wrp.236.1575971178963;
        Tue, 10 Dec 2019 01:46:18 -0800 (PST)
Received: from szeder.dev (x4db55d5d.dyn.telefonica.de. [77.181.93.93])
        by smtp.gmail.com with ESMTPSA id d16sm2815264wrg.27.2019.12.10.01.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:46:18 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:46:16 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] fsmonitor: disable in a bare repo
Message-ID: <20191210094616.GC6527@szeder.dev>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
 <79bb4c8e7d74c9c85cd6e6616811fc9a2e7c0afa.1575907804.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79bb4c8e7d74c9c85cd6e6616811fc9a2e7c0afa.1575907804.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 09, 2019 at 04:09:57PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The fsmonitor feature allows an external tool such as watchman to
> monitor the working directory. The direct test
> t7619-status-fsmonitor.sh provides some coverage, but it would be

s/t7619/t7519/

This typo is present in all but one other commit messages.

