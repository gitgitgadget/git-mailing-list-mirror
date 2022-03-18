Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C570AC433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 16:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiCRQCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiCRQCd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 12:02:33 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E319ABC6
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 09:01:14 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id r2so9750098iod.9
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 09:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNxlQ4m2lEsNe8lHOBfilzNA4CnVsHbSn8/rzbSHi4Y=;
        b=osoO5qUR0gGN1gKXpiqwXfdDXrlhbA3zoRqX0mmcBlv+GPbLU+CUEF+mFjljRczR8y
         V3IJJsTNPlQN0fwjiUKYzVND636L6WM9D7y2WySNQjExn94P3HNmc2z9/2RKhrif62fW
         YmL5LxPvlBiYUlhK8Cb+qDWBZxwZ9/Y5mdue0HpRUV9keBeBtrFkty1yCfn3+kOQxPoV
         Pt3oFbqp7nO0RIc0ezw3dpcL7qibYmjwPokkmk7uFVH7c8ww3lDADN8ta40r6UXQNQ3b
         ilCuCjFofA4LbQ25gbYgS/FDN6C52wJuGsKvyiMGUPPEAyelYEV1cYwaJEtnU8uIPGZW
         Nezw==
X-Gm-Message-State: AOAM533+SMbQEhGpYITJwbOkzB6xvLGzci0hGakaWQPIhRswQyPdkb1J
        efzqLYX+znf9Hbw95czKlzZmleuoZp10/OL/Kux0YX131rI=
X-Google-Smtp-Source: ABdhPJwqLQN04BJmFx4k77jiS0WaVKrgL4DY/Dx/q2TjaGMh5QJl7kaKWtVm9cMMWHRpRYmEBUWQQfDcuRmegw+t3SA=
X-Received: by 2002:a05:6638:1655:b0:319:a174:6ba0 with SMTP id
 a21-20020a056638165500b00319a1746ba0mr5073920jat.195.1647619272230; Fri, 18
 Mar 2022 09:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <bc7b04de-17be-df86-1c93-792903eeec9b@mails.ucas.ac.cn>
In-Reply-To: <bc7b04de-17be-df86-1c93-792903eeec9b@mails.ucas.ac.cn>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 18 Mar 2022 17:00:37 +0100
Message-ID: <CA+JQ7M8_QiidajaWJpz3gFeUXiLMLiDA38W1mnWyxnMLJN3fpQ@mail.gmail.com>
Subject: Re: how to automatically open conflicted files when "git rebase"
 encounter conflict
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 18, 2022 at 8:02 AM wuzhouhui <wuzhouhui14@mails.ucas.ac.cn> wrote:
>
> Hi
>
> When "git rebase" stopped due to conflict, I have to manually open
> conflicted
> file one by one and resolve conflict, and the typing file path is too
> boring.
> So, how to automatically open (e.g. use Vim) conflicted files?
>

Hi!

I rebase quite a lot and my strategy is as follows
  git diff
allows me to quickly overview the conflicted files and conflicts.
Usually, I want to either take all *ours* (the stuff I've rebased
onto) or *theirs* (the incoming rebased commit).

To do this quickly I've developed a script (basically glue-code of git => sed)
https://github.com/CervEdin/gut/blob/main/git-resolve.sh
which can be invoked
  git resolve -o/t/b (--ours/theirs/both) 'pathspec'
More information on the underlying implementation can be found in this
stackoverflow answer
https://stackoverflow.com/a/68498101/
The script is something I've developed for my own use and very much
not bug free.
Nevertheless, I personally find it efficiently covers the case of
basic conflicts I encounter.

In the situations of more complicated conflicts (as well as the
functionality you request) can be invoked using
  git mergetool
  git mergetool -- 'pathspec'
  git mergetool --tool=vimdiff -- 'pathspec'
That is unless you want to solely use vim without vimdiff.
The main downside is that invoking mergetool is a bit slow :/
