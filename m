Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D3C46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 22:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjASWBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 17:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjASWAx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 17:00:53 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65859C13E7
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 13:39:25 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id g31-20020a63111f000000b004bbc748ca63so1595155pgl.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 13:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsTW53HGbDwJ/XctrN/5sFzCW8qFig9j6qrUhLlG3rg=;
        b=PmP4bp9mzv7zTzZAJ/aRwyZ4WUOxzHmOttwFTL9fsK6sWRiDiyVF1YIdYuKhUNm7ho
         ZMlr3ek8mMV0xc2qK7A1Gg+P4mI/6/FTzTEGEdXelZfjYKDFhDKnaJB6wRggSnbWT21z
         Yzzm6dy/gfP8lRpd/a6B0W1MoXo93P9UViTMsCRygXCNP40XzoyX1oyCHtz+udsjWtEv
         /jikwLGGJKI6LtxAyft56MStBW4uTHaI9sgh05gN7dp4sxI0713GPU2xbk9SIrUsTM5/
         iouKRPXD2XHPvPHlq0VMMM1yNVYQc8R8m4sFg7MoftAVu33FUG52p7F3tiMKy5R5PUkY
         NNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TsTW53HGbDwJ/XctrN/5sFzCW8qFig9j6qrUhLlG3rg=;
        b=NLcsAPMF85CFeopAb2EechMgyy+CzDNd5Tmizns9oafY+rEkEsPunEdOqANn4NHGD+
         zw2C5rVd8bQuSSAg3clY/0XGdPcNcdi5bFixIoSUCmPOcuUflEC7TiUH/eepACTgbaKm
         7DgMgRTiJNbJhuykUD23a+Qz/6tUMIjkzSIs7i/BmA8R/8A9m0eoB2hvLkga/iOT8hQN
         ymBF9gSC06YMLYeciNXGM0Xs5knF8NNt3hRSNfc9KiXrSS6D3+DNOk25xttMg3Z+71zF
         1ThEpZ0vebjynRFEd2vZBoaQh/hYcUWxI4w8AJeD/hpWDoOdjIzOVJ4wMzxZOQkb0/zW
         gYMg==
X-Gm-Message-State: AFqh2koxvQOTg3lx7Ydxjz19bg7iNEPq+KcARDxKjumwqwal1w+Bt8Mg
        LjFTXVRna+rHvYSk5/GQGUX7rOTkQxTXzhA=
X-Google-Smtp-Source: AMrXdXvrOBtUC/exBwshtd31jAMQ0Q9eCZd7Us0McYocb+wShFtrdYd6O7t5DQudsAUdhxuCb0LDrNwey99kWgk=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:1302:b0:589:bd89:3651 with SMTP
 id j2-20020a056a00130200b00589bd893651mr1300199pfu.28.1674164360898; Thu, 19
 Jan 2023 13:39:20 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:39:11 +0000
In-Reply-To: <DB5PR02MB100691E6422F5E94228F0E0EC8AF79@DB5PR02MB10069.eurprd02.prod.outlook.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230119213911.1515188-1-calvinwan@google.com>
Subject: Re: Parallelism for submodule update
From:   Calvin Wan <calvinwan@google.com>
To:     Christian.Zitzmann@vitesco.com
Cc:     Calvin Wan <calvinwan@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

I investigated this as well about 2 months ago and am happy to share my
findings with you :)

> When updating the submodules, only the fetching part is done in parallel =
(with config submodule.fetchjobs or --jobs) but the checkout is done sequen=
tially

Correct.

> What I=E2=80=99ve recognized when cloning with
> - scalar clone --full-clone --recurse-submodules <URL>
> or
> - git clone --filter=3Dblob:none --also-filter-submodules --recurse-submo=
dules <URL>
>=20
> We loose performance, as the fetch of the blobs is done in the sequential=
 checkout part, instead of in the parallel part.
>=20
> Furthermore, the utilization - without partial clone - of network and har=
ddisk is not always good, as first the network is utilized (fetch) and then=
 the harddisk (checkout)

Also an astute observation that separating out the parallelization of
fetch and checkout doesn't allow us to fully use our resources.

> As the checkout part is local to the submodule (no shared resources to bl=
ock), it would be great if we could move the checkout into the parallelized=
 part.
> E.g. by doing fetch and checkout (with blob fetching) in one step with e.=
g. run_processes_parallel_tr2
>=20
> I expect that this significantly improves the performance, especially whe=
n using partial clones.
>=20
> Do you think this is possible? Do I miss anything in my thoughts?

Sort of. The issue with run_processes_parallel_tr2 is that it creates a
subprocess with a git command. There is no git command that we can call
that lets us do both the correct fetch and checkout command, so first
you would have to create a new option/command for that (and what happens
if we want to add to that parallelization in the future? Create another
option/command?). I think we can do better than that!

`git submodule update`, when called from clone, essentially does 4
things to the submodule: init, clone, checkout, and recursively calls
itself for child submodules. One idea I had was to separate out the
individual tasks that `git submodule update` does and create a new
submodule--helper command (eg. git submodule--helper update-helper) that
calls those individual tasks. Then, clone would directly call
run_processes_parallel_tr2 with the new submodule--helper command and
each process separated by submodule.

This is what I imagine the general idea of what
`git clone --recurse-submodules` would look like:
superproject cloning
run_processes_parallel_tr2(git submodule--helper update-helper)
        Init
        Clone
        Checkout
        Recursive git submdodule update-helper

I'll discuss what I think are the benefits of this approach:
- The entirety of submodule update would be parallelized so network and
  hard disk resources can be used together
- There only needs to be one config option that controls how many
  parallel processes to spawn
- Any new features to submodule update are automatically parallelized

The drawback is that any new feature that would cause a race condition
if run in parallel would have to have additional locking code written
for it since separating it out would be difficult. In this case, only
adding lines to .gitmodules in init is at risk of a race condition, but
fortunately that can be handled first in series before running
everything else in parallel.

I haven't started implementing this and am not planning to fix this in
the near future. This is because we are planning a more long-term
solution (2y+) to solve problems like this (notice how much simpler it
would've been to add parallelization if we didn't have to create
subprocesses for every separate git command and instead could call from
a variety of library functions). So if you need the parallelizations
sooner or want to scratch your itch, you're more than welcome to
implement it. Happy to bounce ideas off of and review any patches for
this!

Thanks,
Calvin
