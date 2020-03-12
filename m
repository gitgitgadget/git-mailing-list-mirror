Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAA3C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 12:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49CF206FA
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 12:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdtQR03B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgCLMXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:23:50 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]:45829 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgCLMXu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 08:23:50 -0400
Received: by mail-qv1-f42.google.com with SMTP id du17so2450668qvb.12
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ESD9Zwemc5U0BM5fTVCJYXd4qoK/+7ACqfK61nFYDeI=;
        b=IdtQR03BReBxY7jrgKDZpjmYoS0dRCgel/5Z9DbkbceYAc10ZCYeRUbeyN81rfGPNg
         dZfl7lwHzmAR6QdAU/iCPZOJDEsgPx3s47W/xNyp6GG0iN+YcD3QCegWjGwIJgbvHuto
         r+VSTN/ZtKQ8N6NIp1iEEseCUJz2B7JWBfr1++OKA3r26W2ZZP09OMdy1nY0Gj92rBcK
         GdLsh8oJMiPCzJrycInuZjycDa7T9tIWJ3R+QFGz7rHtGg6voldQl2M/uKpxGCCvmYOO
         9E0uYb5FDVK0hOw7EXoznFy+HSN3DuKhh6L+9aKdUbZjv7XrVW0ePYvZfMf0Ue8Y8k3B
         jBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ESD9Zwemc5U0BM5fTVCJYXd4qoK/+7ACqfK61nFYDeI=;
        b=FVuU4Gx7PzWvUzBVgi9lK2BtPzEDWqWpSvoPbhXLvAwAgJj3nwkSMNiTs/usfhJjsG
         wQPk6EzAXsrg1ZBi2YqPnjS4pmkU4uVnFiIlX6hX4D9UmTsflrOQ58rjn0Lp9ntJBlBG
         +k5dpUELIGgMt1tpnes2x4SLj/s7HkMMXhrIYJqHshlOYFTOyVqYzAHDG3gd/kscySMh
         FulPr/cyZ87aks5FbXFugX9Yk4oabQvK5oAPncOniKPfkqQPB/zxXClPKx3A7FZtrO0d
         QV2Etjt0BFgfQEoNBwC1g778DDTA4qiCstlxmY4V2/u7V5ve6SY1Q8N5UGyCc4/e7VQa
         yZhA==
X-Gm-Message-State: ANhLgQ04QQ2zTzD/z0XgBRvnnQVhtR8xlYOz1SofIKipuN7Gi4gFRzCT
        mXxTcqVXi8ewZV2x77ISCvI=
X-Google-Smtp-Source: ADFU+vt/zQWaQYYpESlcZtqQ2IoBtrQph8YwyEXoPntLW2a8jZgQa5EXii5kdGoF8DTmJo+HSEWW3w==
X-Received: by 2002:a0c:f601:: with SMTP id r1mr6989542qvm.91.1584015829026;
        Thu, 12 Mar 2020 05:23:49 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k66sm14547780qke.10.2020.03.12.05.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 05:23:48 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Subject: [Question] Is extensions.partialClone defunct?
Message-ID: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
Date:   Thu, 12 Mar 2020 08:23:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was looking into an issue around partial clone in v2.26.0-rc1, but found several references in the code and documentation to "extensions.partialClone".

Here is the blurb from Documentation/technical/repository-version.txt:

  ==== `partialclone`

  When the config key `extensions.partialclone` is set, it indicates
  that the repo was created with a partial clone (or later performed
  a partial fetch) and that the remote may have omitted sending
  certain unwanted objects.  Such a remote is called a "promisor remote"
  and it promises that all such omitted objects can be fetched from it
  in the future.

  The value of this key is the name of the promisor remote.

and this error message in builtin/fetch.c:

	if (filter_options.choice && !has_promisor_remote())
		die("--filter can only be used when extensions.partialClone is set");

but it appears that we rely on the "remote.<name>.promisor = true" setting instead of this extension.

Indeed, if we run `git clone --filter=blob:none <url>" the resulting .git/config file is as follows:

[core]
        repositoryformatversion = 1
        filemode = false
        bare = false
        logallrefupdates = true
        symlinks = false
        ignorecase = true
[remote "origin"]
        url = <url>
        fetch = +refs/heads/*:refs/remotes/origin/*
        promisor = true
        partialclonefilter = blob:none
[branch "master"]
        remote = origin
        merge = refs/heads/master

So, I thought I would put this up on the list to point out the inconsistency, in case someone with more context has thoughts on the correct way forward here.

Thanks,
-Stolee
