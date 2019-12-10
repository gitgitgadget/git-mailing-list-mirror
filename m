Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BADFC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 14:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E612207FF
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 14:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aynkgATt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfLJO5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:57:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37896 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJO5t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 09:57:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so3523112wmi.3
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 06:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MeHpIBvTgxLOcxEwTns+FfjUSgjdHLH4vDK9C93di18=;
        b=aynkgATtf6Hs9t3Vn83h3UiUv/MbPBX+yQC7Q4kSEnomlZ7u2kyaAxrvDNW6yiX9r1
         wzUcuMG+eQ2Dn2m/c8CZ8I/Esb/vO8rDBo+/RFYbecCemiVCaW6ovZxQbutXLe25wU7G
         BAY6YWtjSXubOVvLMvqa5gRu+9TxDGk+KWlePI5MS96ZaB79bjp3eX8pxE3/2rVj+2y4
         DRJLYyIYJdRWa28GKWXkgmAAfdpJOz+5vpLogv22eOM3OiTwzf8Ssq8nokZtKLSoOewr
         wJ5FXFITv5TXdZXacZqdGAsQh4lffV5aqUW4RXICrTJbcW7tRd4iwcXOp8qPK9+3LY9J
         KM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MeHpIBvTgxLOcxEwTns+FfjUSgjdHLH4vDK9C93di18=;
        b=KO2Xt9pNpG7A3Yq0pVRSsBI6bXkNfftAYQr7V7LXelYXSmeiNQ1LjSMxW+fmlwvEps
         AOD7qZZva7Z5TGUr0Qf7D+pcbnEXRvQVxSWiUpnXl0FgZSaij52FaZ9J+62/tlzN9T0w
         AIybfNqZ0xsjVEEEiNuMuhtGONijXEb0DgOukrxu7iZ7BePunXJfUsUVGBvYSnssjDQj
         Cikz1U4srkllXSRmENq2wi4+bV49Ml3Nndpw8O0UFZ2bXYv5TwByo9woi1v5/xHlNnQr
         OUDPA4w3nJvSM2Tl9s13uvNWvxfcHZzojevkUuHztUgjvkYltVgFIY/Zi03VffO2E3Km
         WFAw==
X-Gm-Message-State: APjAAAVq2Q2enNBok/lzUsqF/7X9mviGp3n7k0VY9pdUXKLlvKtvL2dQ
        f77GhaKS6N9FBVOAKLjb1gc=
X-Google-Smtp-Source: APXvYqxxQSS71DBwUTP3P9CVC1mieHiLcKFgUQ/77yx7EF/ibUi7TgiFVao0y+INZZ0Y6RUbnGlKKQ==
X-Received: by 2002:a1c:3d07:: with SMTP id k7mr5281258wma.88.1575989867132;
        Tue, 10 Dec 2019 06:57:47 -0800 (PST)
Received: from szeder.dev (x4db55d5d.dyn.telefonica.de. [77.181.93.93])
        by smtp.gmail.com with ESMTPSA id w17sm3478569wrt.89.2019.12.10.06.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 06:57:46 -0800 (PST)
Date:   Tue, 10 Dec 2019 15:57:43 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] t3030-merge-recursive.sh: disable fsmonitor when
 tweaking GIT_WORK_TREE
Message-ID: <20191210145743.GG6527@szeder.dev>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
 <efc16962ee2595db50bf051fc84632b8c70036b3.1575907804.git.gitgitgadget@gmail.com>
 <20191210100732.GD6527@szeder.dev>
 <b3e8ad07-b2cb-e024-405e-27d9f065f5fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3e8ad07-b2cb-e024-405e-27d9f065f5fc@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 08:45:27AM -0500, Derrick Stolee wrote:
> On 12/10/2019 5:07 AM, SZEDER Gábor wrote:
> > On Mon, Dec 09, 2019 at 04:10:00PM +0000, Derrick Stolee via GitGitGadget wrote:
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> The fsmonitor feature allows an external tool such as watchman to
> >> monitor the working directory. The direct test
> >> t7619-status-fsmonitor.sh provides some coverage, but it would be
> >> better to run the entire test suite with watchman enabled. This
> >> would provide more confidence that the feature is working as
> >> intended.
> >>
> >> Worktrees use a ".git" _file_ instead of a folder to point to
> >> the base repo's .git directory and the proper worktree HEAD. The
> >> fsmonitor hook tries to create a JSON file inside the ".git" folder
> >> which violates the expectation here.
> > 
> > Yeah, there are a couple hardcoded paths in there, e.g.:
> > 
> >   open ($fh, ">", ".git/watchman-response.json");
> > 
> > and, worse, not only in the test helper hook in
> > 't/t7519/fsmonitor-watchman' but in the sample hook template
> > 'templates/hooks--fsmonitor-watchman.sample' as well.
> > 
> >> It would be better to properly
> >> find a safe folder for storing this JSON file.
> > 
> >   git rev-parse --git-path ''
> > 
> > gives us the right directory prefix to use and we could then append
> > the various filenames that must be accessed in there.
> 
> Adding another git process inside the hook is hopefully not
> the only way to achieve something like this. The performance
> hit (mostly on Windows) would be a non-starter for me. (Yes,
> the process creation to watchman is already a cost here, but
> let's not make it worse.)

Hrm, _when_ is the 'fsmonitor-watchman' hook invoked?!  Every time a
git process tries to figure out what files have changed since e.g. the
index was written?  For running an fsmonitor/watchman-enabled CI build
it might be an acceptable compromise until we come up with something
more clever.  'man githooks' is not clear on this at all, it only says
that "This hook is invoked when the configuration option
core.fsmonitor is set to .git/hooks/fsmonitor-watchman".

> Perhaps a better strategy would be to do something in-memory
> instead of writing to a file. Not sure how much of that can
> be done in the script.
> 
> -Stolee
