Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18537C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJUFTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJUFTj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:19:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440051F2E0
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:19:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id l22so2653897edj.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ymkatz.net; s=g;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GQcV9M/TvJg/DVxaYB0GtGr0AR5Ka6QtwZE2NfsL6/s=;
        b=cAVmHIcmEQanskBePPylzq3AfonAEdknhw0HTOB76x8ZGW8ThgEGx3A1gx794yHDcF
         uuRNXe5aQTSz98msfEWG44GwzQQGymBT9SS+oe8lcskHHy74teUaZIlPVU7TkSbbNSrd
         2aEjF/Mo8dun9jt2RjEXwp6QfLoyEz8dn9E+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQcV9M/TvJg/DVxaYB0GtGr0AR5Ka6QtwZE2NfsL6/s=;
        b=SoVwsOnQoG0tRw/NjfalPmqaHxwoypk+O8xhIdJ+3K9viAz/x6TXNnE4oWcw0QdJ1K
         rMqAPmei301XQF7Pr9jUGmbzTN8ktSJw3o2itAQ8hxPf/5UlxxNC3Ux8+OjjpF6tJAYp
         Mca/9d7FX4p7y4YejwSv4y8tvye6+A4+nDVC0Rr3jOa4CT6aRZPmx7UoimvJcfDdCrW9
         /uMdRSnZECwtmaJ0+VfHuVPpPjPqQcPRY1eHPoqOU2q1RNeWeGw6BSQHv4pouY0APZRk
         AuPCW7DVwZGpObHxa14CyLwYylK+O/DYCx6qC7r72FOttii1lQpcoLK6zypooiId9kLO
         FGZQ==
X-Gm-Message-State: ACrzQf0LpbN2GkvHz+SbKTUx3B4jTC2+LJAoel3N3RxJ3mrfnPx0KzYU
        mlbnYyOQNvROnJtUYGsjweA/VfRq9ZA04CXW
X-Google-Smtp-Source: AMsMyM65XC1wISv6yzWPoTw7RBO3Xj9ocHu/mLFQLrrwcd1b3/wKqW1R3na10Q8Z1DtONrPMIoCfpQ==
X-Received: by 2002:a05:6402:2712:b0:45d:de37:f828 with SMTP id y18-20020a056402271200b0045dde37f828mr14837554edd.317.1666329571583;
        Thu, 20 Oct 2022 22:19:31 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id br16-20020a170906d15000b00772061034dbsm11088813ejb.182.2022.10.20.22.19.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 22:19:30 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id k2so4531594ejr.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:19:30 -0700 (PDT)
X-Received: by 2002:a17:907:743:b0:740:ef93:2ffc with SMTP id
 xc3-20020a170907074300b00740ef932ffcmr14284561ejb.514.1666329570027; Thu, 20
 Oct 2022 22:19:30 -0700 (PDT)
MIME-Version: 1.0
From:   Yehuda Katz <yehuda@ymkatz.net>
Date:   Fri, 21 Oct 2022 01:19:12 -0400
X-Gmail-Original-Message-ID: <CAGBAQ45f6D=XsyiOmumpAnE+OxQpuZXhMsVegrHKsxaN5mc3eQ@mail.gmail.com>
Message-ID: <CAGBAQ45f6D=XsyiOmumpAnE+OxQpuZXhMsVegrHKsxaN5mc3eQ@mail.gmail.com>
Subject: Change in behavior of included safe.directory in system config
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There seems to be some change in behavior, either to included files or
to safe.directory between Git 2.36.0 and 2.38.0. I don't see any
explanation in the release notes.
I push out a system configuration with a configuration management tool
which is why it is in a separate file.
If I put the safe.directory configuration in the main system config,
it works. I don't understand why this is because the value is still
shown when running a config list.

Basic config:
[root@myhost myproject]# pwd
/opt/myproject
[root@myhost myproject]# cat /etc/gitconfig
[include]
        path = /etc/gitconfig.d/myproject
[root@myhost myproject]# cat /etc/gitconfig.d/myproject
[safe]
        directory = /opt/myproject

With the old version:
[root@myhost myproject]# git --version
git version 2.36.0
[root@myhost myproject]# git config --list --show-scope
system  include.path=/etc/gitconfig.d/myproject
system  safe.directory=/opt/myproject
local   core.repositoryformatversion=0
local   core.filemode=true
local   core.bare=false
local   core.logallrefupdates=true
local   remote.origin.url=git@gitlab.example.com:me/myproject.git
local   remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
local   branch.master.remote=origin
local   branch.master.merge=refs/heads/master
[root@myhost myproject]# git pull
Already up to date.
[root@myhost myproject]#

After the upgrade:
[root@myhost myproject]# git --version
git version 2.38.0
[root@myhost myproject]# git config --list --show-scope
system  include.path=/etc/gitconfig.d/puppet
system  safe.directory=/opt/myproject
[root@myhost myproject]# git pull
fatal: detected dubious ownership in repository at '/opt/myproject'
To add an exception for this directory, call:

        git config --global --add safe.directory /opt/myproject
[root@myhost myproject]#
