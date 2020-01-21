Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CAFC32771
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 00:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A2824125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 00:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1k8tc/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAUAho (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 19:37:44 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:46509 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUAhn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 19:37:43 -0500
Received: by mail-yb1-f169.google.com with SMTP id p129so576761ybc.13
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 16:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HCRuTma18AnnbRIrwL3LQB7Bc+8MKRdt+PFTDIOtoQg=;
        b=X1k8tc/Kn9zc/9DCqKS/BJrtSRfSOzs9bDul66+WV8IhuYHWZ7+ro+6Se4BOS1+ltO
         2KJMkuicZ2eevbmw1GYi/FzugV36tAljWnZa3ghGUg4LuAgnMD+pL3MQq9I4iiCWMyau
         VnLS9s1vEwkdqgLtLLhMyT1NKwT2+ceOpVSlKsfVXlaH7E9GmwDBJulsH40INB+wj4Nt
         VweiViKCuaX6ApESyV7iadCPOzZvPMKqQhM6r1lpbCcmqq4tcIvQAQpK3ki+YYVzGQ9k
         9TK6yiXegVkfIFksgt9IvomB2E105qApnShOtYH8Fqlc5Plbn6/A8vdnbpnZxbz1cJCm
         khxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HCRuTma18AnnbRIrwL3LQB7Bc+8MKRdt+PFTDIOtoQg=;
        b=s2g/W1423OxcLhssgEPoy6ONEgtNMZh4Hyb0v8lKtdspz7DsZm8iqS5FH9NaORuUXW
         o8FXG799GY7r4pw2wTS3vlCpdh5O1NWz//uqL9rsA7K6b3Eo+G7uZpPIiLhrAQBbERs7
         I1ET9DLV+IGVgl7j/r8o7iYbFP/vPduvdtULz+rv6RoxTPFt1AZTqLnm3tgGbMArwrVb
         9ggnrZCPqlu2/IPiR0uNnSGUhW0CBUuZCFFvZa6KiPjVDVBSDXZGodpvnAASsc/LNjad
         +N6ig/fF3BlLgS2VgCLf1E/U70lrhEfodeE3xmYCpYCHvU7RByhYK+uMqZklIgnedlao
         rRIQ==
X-Gm-Message-State: APjAAAXGukN4Rse9zoCAsf2aTCuNmODYy0vx6OQwLCijkw1u/69wCdYm
        32d2hBXHH+gZT7j1Heja67OImZZPR78=
X-Google-Smtp-Source: APXvYqxOi0vS7Gu+W7cyZj8ETuNU5GuaHYaIdvd5291T6eGdPpvLbpbY43/n657+DxHOFSiJC6PWtA==
X-Received: by 2002:a25:6d0a:: with SMTP id i10mr1909721ybc.118.1579567062359;
        Mon, 20 Jan 2020 16:37:42 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o126sm16181327ywb.24.2020.01.20.16.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 16:37:41 -0800 (PST)
Subject: Re: Fwd: Possible git bug in commit-graph: "invalid commit position"
To:     Gary Oberbrunner <garyo@oberbrunner.com>, git@vger.kernel.org
References: <CAFChFygiaMsUJC5Kfpnk26DLWbY0gPdNJpZ_gLMf4utZ6_oZxA@mail.gmail.com>
 <CAFChFyi5J-mb+rshtF7U2m=MtPzEPUa+V1_qbEXC=-LdQ218yA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d4313777-ce8c-0b64-997e-17cb719c9ab8@gmail.com>
Date:   Mon, 20 Jan 2020 19:37:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <CAFChFyi5J-mb+rshtF7U2m=MtPzEPUa+V1_qbEXC=-LdQ218yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/20/2020 12:32 PM, Gary Oberbrunner wrote:
> I'm running git 2.24.1 on Linux/WSL, and sometimes git fails with this error:
> ```
> % git diff --cached
> fatal: invalid commit position. commit-graph is likely corrupt
> ```
> Usually that error goes away after I do a few more git operations, but
> I haven't been able to discern a pattern yet. It's not always with
> "diff", can be any git command as far as I can tell.
> Perhaps it started after I enabled the commit-graph stuff:
> ```
> [core]
>         editor = emacsclient -c -a \"\"
>         preloadindex = true
>         fscache = true
>         autocrlf = false
>         commitGraph = true
>         writeCommitGraph = true
> ```
> In fact, when I turn off `commitGraph`, the error goes away. But as I
> say, sometimes it goes away of its own accord.

Disabling the featuere will definitely remove the error. Some commands may
also just not "visit" the corrupt commit.

> Googling turns up almost nothing on this error. I have no idea if I've
> done something wrong to corrupt the commit graph, or if it's a git
> bug. If there's anything I can do to help debug it, I'd be happy to --
> just let me know.

Please run "git commit-graph verify" to see if that catches the
corruption. If not, then the verify feature is broken.

Then, you can delete your .git/objects/info/commit-graph file
and rebuild it with "git commit-graph write". (If you have
fetch.writeCommitGraph enabled, then you may need to instead
delete the .git/objects/info/commit-graphs directory.) If that
process does not fix the problem, then there is definitely a bug
in the feature. At the moment, it may just be a flipped bit in
the file.

Thanks,
-Stolee
