Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E7BC4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 09:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D362084E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 09:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIK3Esv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBZJKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:10:10 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:32782 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgBZJKK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 04:10:10 -0500
Received: by mail-lf1-f43.google.com with SMTP id n25so1411804lfl.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 01:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=gw0DZe/y+ebjhPSWahEfyx8+75/atvS8LOD4cCmrnL4=;
        b=GIK3Esv0D64/kyKtPvL8SRcyAQMLdasZAK5sM9F/TnVjwUfRwh33KWDBhaOtOpY27V
         tts42VgYPJoiAPSMh0FKtHv8oadEyKD5MH69exDJ6lKSjgYpxRnxNrPTZDTpLjPikPki
         qcPTte35P94bzt7cnZ1DPRJ8jsR4Nyqqn8iK52NzrM5DazPicCMlXAhIFhG/8A7dYUBP
         sDWClGFSvb0yW0kYkchdUbCOtz2+23dToR8I0BuvqCxgZOAk4LgGeA+0qLXRC0u0tb0A
         FlB1zcFPXPbMzOJM0pVahcXD1JiwoYGIjEcF6ORy7g+6ZHyqZqs45LeX4W8Xt6gZIkro
         qRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gw0DZe/y+ebjhPSWahEfyx8+75/atvS8LOD4cCmrnL4=;
        b=FL9nsnqrsiZGQxPXcQZaywkpoqzc38V1Q1xk0NJ7B98avee5OOo+E8wQEcOWYx3WD7
         f4OID7IVN/S97eEENGbId5yY9R3Lseoc5x/sXvuhrsDilbHCn4/3+IkhxFVGZAeriNYC
         Quh77FTtQBeudu3vikywNBPhCc+MAZCiwSyrEQJyiZk9Mqo/rQXB6056wt312a7tJz/h
         OWjB9cyC3MVIeJV/pVYyIDiTwMiIgIpbwpIIpL8P9xMcIVzai5733Ps6ezMXr8+C4cQk
         QWrZHe2T+QjT/C8oQWPbqIKWIiqJRTNdYeQg/9xF8wHju8jxC8VWgMDKWkCOUR6Eo9nS
         CLGw==
X-Gm-Message-State: APjAAAWGMjkds3dDBLeqam5sSIaIfCROgdVmvGml3lXOQBzcwqq2Uca3
        /HJi8neZBXcnIGqVET0rcDsxMrg2
X-Google-Smtp-Source: APXvYqyes117MlZHgLIlF14Yy9H9UHnOLRZ97Duv93v/fiVXa5WNU24MaFfOTTg/S1+6A02+6kZXDg==
X-Received: by 2002:a19:48cf:: with SMTP id v198mr1893322lfa.68.1582708207942;
        Wed, 26 Feb 2020 01:10:07 -0800 (PST)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id w9sm772542ljh.106.2020.02.26.01.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 01:10:07 -0800 (PST)
Subject: Re: git-shell default working directory
To:     Greg Anders <greg@gpanders.com>, git@vger.kernel.org
References: <20200226004830.oxd5562v7qqspnkk@Kepler>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <241ea912-44b2-96fa-6f9a-3f04d5386b05@gmail.com>
Date:   Wed, 26 Feb 2020 10:10:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226004830.oxd5562v7qqspnkk@Kepler>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-02-26 01:48, Greg Anders wrote:
> Hello,

Hi Greg,

> I'm working on standing up a self-hosted git server. I'd like to keep my
> repositories under a dedicated directory, i.e. /srv/git, but I'd also
> like to be able to clone a repository using a simple syntax:
>
> git clone git@myserver:repo.git
>
> as opposed to
>
> git clone git@myserver:/srv/git/repo.git
>
> I've not yet found a way to get this to work without keeping the
> repositories in the git user's home folder.

Disclaimer: I'm not at all familiar with git server setup. Would it make sense
to change git user home directory to be the required dedicated directory?

> I've tried using a ~/.ssh/rc
> file to chdir into /srv/git and I've tried using the `command=`
> parameter in the authorized_keys file; however, both of these fail
> because `cd` is not recognized as a valid command by git-shell.
>
> I suppose I could create symlinks from the repositories in /srv/git into
> /home/git, but I'm wondering if there's a cleaner way to do this?
>
> Thanks,
>
> Greg 

