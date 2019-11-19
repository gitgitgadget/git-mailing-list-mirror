Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE33C432C0
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D7C222B6
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcVD+/7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKSXqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:46:07 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:37856 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfKSXqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:46:07 -0500
Received: by mail-pf1-f172.google.com with SMTP id p24so13230864pfn.4
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wNO0CH9mVJLOOpgGm6W9axaJGfaVA4lfynSUBAG/DoQ=;
        b=JcVD+/7TmuCFiuy0P4IvOaHOvTcL3Hm8qMq6WwgGA3/Gn62Av6k8RGzd2Cl/yjvynt
         AE/gFGLyWsleWm42xXQ5AiVoheMVlh11WkX47E2EIwhTrrkuP7O8Zo9W7g2AY32lcEAZ
         PJFo7JU2yDQgBFXXBsO/6a5z0GfNTWNAT58/LwqO4ePLm09trzbJSY4ddNXyTaAp7FMp
         9kyh7bSEK502nso6oPo/5urOrxNVHPOzWR7W7qIyL6naD4z4gEmQK7c3U3qUt7FUJP6J
         AyUWNVsOjkFh40r+EJID1wpdO3asN97lXAssnPUrfkfDQqAMxYGHYX5Z+R+a+FYYBAj8
         AFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wNO0CH9mVJLOOpgGm6W9axaJGfaVA4lfynSUBAG/DoQ=;
        b=EmEmqErVjy+zL4EgylYFhWx5P0HeZkbk+s5GgBzhLJQPYZtSrJhLMIXI5+U/y3qgNB
         woz2z3F1tjcoAD37+otJuJPJNiAWiynsdyYKhFGtEdPdrlOxkCiHqDbCK06n9pIeJJ8+
         oYZOhzMp0rV0naZ33+HZ1hGH9gRtpZfPmrxMO+cKx1mQPaOSsVvdyXJxZ/XMcJnUn7TE
         tXDPbfN8UAyG2Ss187zlEcblBdimbviWTgW8TPcalofm4kMX8nsjl0OSPILH/UNQjyop
         9PTlFkOgUPtC6xNZrtPXorBIktQjg993A1rWc63moQjj1WfvE70FzdHjdTThsKRBn9nC
         SRkg==
X-Gm-Message-State: APjAAAWgWpyzgBjPosRY8ENpbonq74luyhcRr0riDhe8dzH2TxKJjfoJ
        PkXdbxnkbtDbNyHg/cPowUignRZy
X-Google-Smtp-Source: APXvYqxPqsRezQYZk1dvbgYxS8bF1W4cj6SpKGLhGDAnlnku7nuBUF6AT0n22ZHxuZYr6iVGL0KzSg==
X-Received: by 2002:aa7:9ab0:: with SMTP id x16mr296807pfi.139.1574207166417;
        Tue, 19 Nov 2019 15:46:06 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id k17sm22027833pgb.64.2019.11.19.15.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 15:46:05 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:46:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     "Force.Charlie" <force@forcemz.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: Protocol v2: The wrong --shallow-since time format causes git to
 wait indefinitely
Message-ID: <20191119234603.GA50851@generichostname>
References: <tencent_AB1A7466D1F2EF9A84B437705F06A7652709@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_AB1A7466D1F2EF9A84B437705F06A7652709@qq.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 13, 2019 at 09:00:52AM +0800, Force.Charlie wrote:
> Recently, when I tested my Git Over HTTP server, I found a bug in Git. When we used git -c protocol.version=2 clone --shallow-since , if the time format is wrong, it will cause git to wait indefinitely.
> 
> Github supports Wire Protocol to reproduce, Gitlab does not support it and does not reproduce it.
> 
> The commands that can be retried are as follows:
> 
> ```shell
> # time format wrong
> git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=20151012
> # trace
> GIT_TRACE=1 GIT_CURL_VERBOSE=1 GIT_TRACE_PACKET=2 git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=20151012
> ```
> We can see that the server closes the HTTP connection after sending the `shallow-info\n` message, and git-remote-http(s) is still waiting.
> 
> ```
> $ git --version --build-options
> git version 2.24.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> 
> ```
> 
> When the time format is correct, the clone is successful, so this is followed by the shallow-list：
> 
> ```shell
> GIT_TRACE=1 GIT_CURL_VERBOSE=1 GIT_TRACE_PACKET=2 git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=2015-10-12
> ```
> 
> Github Issues: https://github.com/gitgitgadget/git/issues/457

FWIW, I can reproduce this issue as well. From what I can tell (without
actually looking at any code), it seems like when an invalid
`--shallow-since` is given to the server, it'll hang up on the client.

With protocol v1, the client quits as expected:

	$ git -c protocol.version=1 clone https://github.com/git/git.git --shallow-since=20151012
	Cloning into 'git'...
	fatal: the remote end hung up unexpectedly

However, with v2, I believe that the client doesn't detect the hang up
and just waits forever.

Unfortunately, I don't know the networking code at all and I don't have
time to actually dig into the code. Hopefully this helps a little bit,
though.

Thanks,

Denton
