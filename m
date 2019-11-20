Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2EFC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 22:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605AE206D7
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 22:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgw+SpG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfKTWys (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 17:54:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34642 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKTWys (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 17:54:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so6241191wmk.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 14:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zMm+1PqhuISUDkURa+G5exhDcne6VKULQStD+Y82Ee0=;
        b=tgw+SpG0tdsXZuswAExc2u1bQ/L/O+XWh1paYOSyrYZzMOl9lZoUBKjozo5wlEp3vO
         NZRA6dXhi6JlL1DMwy3DeOLMIaH/3GHeerZ0mfgcICuplqNF7LnEaeZ7dVJJbBjLC4ZQ
         dS7kpQpMJ6FitZ1igXo5gY/qXfMyN1UV0WWeWs0JHz4r1FXD2vfNY6HPk73P02d/WAzm
         kqfMO3edEImeJvNZFaRQ/6ye8zatClWLrwsoaKQDwYUjuaI5JKBzpttwxNWq5hDdJduQ
         FJwvWI3zd490MuDShRmnYfDDvp6w8ajQfmWzamrhsL4PoXYWWkZ3JAOI32jKfYDDr1MQ
         YYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zMm+1PqhuISUDkURa+G5exhDcne6VKULQStD+Y82Ee0=;
        b=jzMnEuzf4akpaMJDsVFvCy235/8bfF/fNE7NpJmkgMm/91LYzCCXhzldSjPh32ZPC2
         T+DaAb7+EBQ3Pc7xBUxQlj1bxeJeC6jT+0zwOU7/jXGZVIPO0UF0ylrOqZqkGfA+IgoM
         X5bjbQY6OrSo4nzWUBdai+GPdGHdTyJv4Mzb1DFKA+wNC7DgyWdHtTh+IsaVxfQB5uuA
         DCJDmo95WQuTKPtchL5LqQ7nGv9FMXeKHki8xrPqCkyACmNcXkMsJXrZXJSnrvE4kV0i
         tlRgAnBgwdA76m45fkUKKigW2cmvnJaCShr1pHLApxp6dzThFkLu698igVD9JPu4KiCP
         vV6A==
X-Gm-Message-State: APjAAAXHHdhaOnuRmLNPHLczPAPbYj7aM2t85xIt8RTShbMkEhYmS0/C
        7K1oTnAC/vZCUExhtOs6ZhdjOVqH
X-Google-Smtp-Source: APXvYqyn3p40LuUR1w66JexmskXjN/E3Xq+x0BEmTGOVFEgt+TicBT1513UrzTuR27/ATmkJBPMKYA==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr6642565wme.76.1574290485771;
        Wed, 20 Nov 2019 14:54:45 -0800 (PST)
Received: from szeder.dev (x4d0c5363.dyn.telefonica.de. [77.12.83.99])
        by smtp.gmail.com with ESMTPSA id x10sm893641wrv.60.2019.11.20.14.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 14:54:44 -0800 (PST)
Date:   Wed, 20 Nov 2019 23:54:39 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/1] ci(osx): use new location of the `perforce` cask
Message-ID: <20191120225439.GA18277@szeder.dev>
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
 <pull.400.v3.git.1571789978.gitgitgadget@gmail.com>
 <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com>
 <20191118221804.GA23183@szeder.dev>
 <nycvar.QRO.7.76.6.1911192155140.15956@tvgsbejvaqbjf.bet>
 <xmqqk17ve45s.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk17ve45s.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 10:18:39AM +0900, Junio C Hamano wrote:
> Subject: ci(osx): update homebrew-cask repository with less noise
> 
> The OSX CI build procedure updates the homebrew-cask repository
> before attempting to install perforce again, after seeing an
> installation failure.  This involves a "git pull" that by default
> computes and outputs diffstat, which would only grow as the time
> goes by and the repository cast in stone in the CI build image
> becomes more and more stale relative to the upstream repository in
> the outside world.

Minor clarification: I, too, thought that the CI build images are cast
in stone, but the Travis CI build images are definitely not (don't
know about Azure Pipelines), but receive smaller updates from time to
time, including updates to their Homebrew database.  Such a recent
update necessitated commit 7d4733c501 (ci: fix GCC install in the
Travis CI GCC OSX job, 2019-10-24).  I contacted Travis CI support
about it, and they confirmed.

> Suppress the diffstat to both save cycles to generate it, and strain
> on the eyeballs to skip it.
> 
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  ci/install-dependencies.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 4e64a19112..b6b4f4707f 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -42,7 +42,8 @@ osx-clang|osx-gcc)
>  	brew link --force gettext
>  	brew cask install perforce || {
>  		# Update the definitions and try again
> -		git -C "$(brew --repository)"/Library/Taps/homebrew/homebrew-cask pull &&
> +		cask_repo="$(brew --repository)"/Library/Taps/homebrew/homebrew-cask &&
> +		git -C "$cask_repo" pull --no-stat &&

Oh, a '--no-stat' option; I looked at the man page, but stopped
scrolling after finding '--quiet'...

The patch looks obviously good, thanks.

>  		brew cask install perforce
>  	} ||
>  	brew install caskroom/cask/perforce
