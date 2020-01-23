Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4A0C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 16:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0381E24125
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 16:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpCV/QnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAWQc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:32:26 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:34514 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgAWQc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 11:32:26 -0500
Received: by mail-wm1-f47.google.com with SMTP id s144so2237009wme.1
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 08:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HUIvNafLn3tyUOozTjsPQ76gX7iIq3+PzrxnG8qhF2g=;
        b=CpCV/QnHvocuxocJd5jicLhw0G177luke9legSs8/wl6nUVzT/wlDGdRqSUWw061Aa
         nXVuZIllQQV0pXz0V20P+3aKJrMHCLzKM9Ui/kj91VCnkUlpuJjgB0UuPt3Jk203Bhn6
         rBZ77y5SPHDm4vwft0uWRPGvgR90lQBrWHkSwfmSOK/gSLHEo7hDtYRTqA2c1kvQSL7L
         8ZOGUpOL46WXJPN49N5Ewdhm0MQof69/vhkSNxHPlnTXObraeFk0FT8HgacNUOLbt6oV
         WzKhh+eFx+BVtmYQ7qaxlSqPQWQ5UBDxlir+rn64LqGq9Vhb+S4a6QdKd6+zDPimUJCS
         Gvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HUIvNafLn3tyUOozTjsPQ76gX7iIq3+PzrxnG8qhF2g=;
        b=PxlJVsVweQLxQRfl5JtpvDNbF4PWjzuNf0y0G5BLkiwYwzDRVYFXti3D6rwBCTCLqF
         65UMNTONhnI8k/KmfM5wFbQ3hDqMv0zgx/ha1oHFEspcL2p1TESeXQ0R4KQiNNdf9itJ
         Rp7dddudp1qOXLK1dbg3iFBWyNwy7PdLzHBlYI/e7QaaJW3ynCazQieeBdikOgGidnNF
         DNtf1U6HCLK1xurn+CuhlLymMmLSlvjiTXdnvvkCWw8nkiVm/Ro6JGV4wQNmzsHXiQ+D
         JDIX9V43b9/1UauA4DCyFsj5/8v1Yji5gcTVCnzxCr2alF58Db1y/ic6leaTIudjQZ+U
         MFzA==
X-Gm-Message-State: APjAAAUHY5ToODF5k48tM5e5FOEeJKqa/O2H7mDvjeE85ZqW57Nj5KFY
        XVIsszKoziEz2x+OcFWoKDs=
X-Google-Smtp-Source: APXvYqzbhvWyOrIZKlIgKUna/ndVoHvPPpj5OSkeirOAlLiT3cE2Q2EY8gGJwRKkuS2/LTftoE61IQ==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr4869523wmj.41.1579797114609;
        Thu, 23 Jan 2020 08:31:54 -0800 (PST)
Received: from szeder.dev (x4db607d2.dyn.telefonica.de. [77.182.7.210])
        by smtp.gmail.com with ESMTPSA id i11sm3765451wrs.10.2020.01.23.08.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 08:31:53 -0800 (PST)
Date:   Thu, 23 Jan 2020 17:31:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     ch <cr@onlinehome.de>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
Subject: Re: [REGRESSION] gitk can't be run from non-worktree folders
Message-ID: <20200123163151.GC6837@szeder.dev>
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 05:04:09PM +0100, ch wrote:
> I recently updated my Git installation from 2.24.1.windows.2 to
> 2.25.0.windows.1 and from the looks of it the included version of gitk does not
> support being run from non-worktree folders of a repository anymore (like the
> .git folder for example).
> 
> Here's a small reproduction recipe:
> 
>   $ git init repro
>   $ cd repro
>   $ git commit -m test --allow-empty
>   $ cd .git
>   $ gitk --all &
> 
> gitk terminates with the message:
> 
>   fatal: this operation must be run in a work tree
>       while executing
>   "exec git rev-parse --show-toplevel"
>       invoked from within
>   "set worktree [exec git rev-parse --show-toplevel]"
>       (file "C:/Program Files/Git/mingw64/bin/gitk" line 12634)

I've stumbled upon the same issue when I tried to run 'gitk' in a bare
repository a while ago, but it refused to run with the same error
message.

Are you sure it's a recent regression?  I have no experience with
'gitk' in Git for Windows, but on Linux this has been broken for quite
some time, namely since 784b7e2f25 (gitk: Fix "External diff" with
separate work tree, 2011-04-04) in the v1.7 era.  FWIW, reverting that
commit on top of v2.25.0 makes 'gitk' work again in bare repositories.

