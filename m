Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E7C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 03:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EFC23110
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 03:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbhATDm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 22:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729314AbhATDlC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 22:41:02 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B6C061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 19:40:21 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id d85so31401qkg.5
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 19:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7Gm+oyAWbLY83TATAKsJcumrV9/AyMWW3CBXWUdrjyw=;
        b=Ws3DXUCTe1qsFtUGTVQXmfJMObcVDQjgNlbQiH1JODJz5bLb/GkjU4Wa3yKl9wzl3c
         v2ytZMPYBc8T1ZK7jPi8vWYtjjj+HDeB1YiYF7tIc2xxOEdfAb1oSP/HOruk3lMWAK85
         WVNHgcQw/DMptLbxmXSeLlW3UGpzzTcjvBKBaGWhCZ8eMX7k/rjs+RUe3bXxff3VhcJW
         Kfkgw+Aol1wBsvTZXMC540dmgOluJbZ5skQtWM8tBDEJ7/QzT3uEZJBZ2X0DBROq+hU4
         R6Ei3xEvU1ohKQPIKw4tQ5/53zrrIQXv+0CkaCCaTwacyxDgTvyaOtrwuX2/pAZeFekK
         zb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7Gm+oyAWbLY83TATAKsJcumrV9/AyMWW3CBXWUdrjyw=;
        b=g49haB4x+1ElqNFy0N4X50kitpyi4pMEYT7nhNH2eiiA/5d/r+TnZ8T36jbzeczMbC
         dzS9N4zPtdXIwCo8Hn5+XcBnrHV6RITjKehtle56/0LfXazlotF7yWdNPpvlMQvgm28D
         OrbEWGvC8GYVARaCLm9TpS5sR3Vb4TzlIbvoeEqLpktRERPAtlsiFdmHDTlI/cECxVQi
         bRmeGWvqT0SftyJEEDL3T9JMPmWEOWR8HP2C0emTe3BMC8T6ymebY86xVik94la0ouos
         UEXaDcIMdiOh+Qnj602SyezXO4vDYs51L6It7r9C/jV+tUjax/k1n9sDCz4ZXzJ297Ks
         FkEg==
X-Gm-Message-State: AOAM532W2ggq/2nhYHNUYW+GQtjNkqMmoqgiKDskKU1pvHwOdMt0cmw9
        TwT0fCLUM9rzE0P94M2Nq4FNvUuk0XA=
X-Google-Smtp-Source: ABdhPJzY9XTdGubRGGics2mllNw9b8FG3idKoFSwaIaTOUqmY4DLc+EhOX8zTu5X0xeiVXKs3hg0sQ==
X-Received: by 2002:a37:809:: with SMTP id 9mr7615471qki.156.1611114019798;
        Tue, 19 Jan 2021 19:40:19 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id e38sm441243qtb.30.2021.01.19.19.40.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 19:40:19 -0800 (PST)
To:     Git mailing list <git@vger.kernel.org>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Question about 'git log', custom formats, and '--left-right' and
 friends
Message-ID: <24504597-7c14-70aa-393b-2e18df2a51bb@gmail.com>
Date:   Tue, 19 Jan 2021 22:40:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I think I've come across a limitation of using custom pretty formats
along with the '--left-right', '--boundary', '--cherry-mark'
options to 'git log'.

I'm trying to replicate the behaviour of the 'oneline' pretty format when it
is used with or without the options above and a symmetric difference. When not
using any of the options above, no mark is added before the commit hash in
non-graph mode, and a '*' is added in graph-mode. When using the options above,
the corresponding marks are used: '>', '<', for left/right, '-' for boundary ('o'
in graph mode), '+' and '=' for cherry-mark, etc.

I'd like to get this behaviour with a custom pretty format (I use it to add some
more informations to what '--oneline' shows), but it seems it is not possible. And
the '%m' placeholder does not help a lot, as it's 'always on'. The script below demonstrates
what I'm talking about:

~~~
#!/bin/sh

run () {
echo
echo "RUNNING: $@"
"$@"
}

rm -rf test
mkdir test
cd test

git init -b master remote
echo data>remote/file && git -C remote add file && git -C remote commit -m root
git clone remote clone
echo dato>remote/file && git -C remote add file && git -C remote commit -m L
echo date>clone/file  && git -C clone  add file && git -C clone  commit -m R
git -C clone fetch
git -C clone config pretty.ol     '%h %s'
git -C clone config pretty.ol2 '%m %h %s'

run git -C clone log --oneline --no-decorate --left-right @{u}...
run git -C clone log --format=ol  --left-right @{u}...
run git -C clone log --format=ol2 --left-right @{u}...

run git -C clone log --graph --oneline --no-decorate --left-right @{u}...
run git -C clone log --graph --format=ol  --left-right @{u}...
run git -C clone log --graph --format=ol2 --left-right @{u}...

run git -C clone log --oneline --no-decorate @{u}...
run git -C clone log --format=ol  @{u}...
run git -C clone log --format=ol2 @{u}...

run git -C clone log --graph --oneline --no-decorate @{u}...
run git -C clone log --graph --format=ol  @{u}...
run git -C clone log --graph --format=ol2 @{u}...
~~~

the (commented) output looks like:
---
RUNNING: git -C clone log --oneline --no-decorate --left-right @{u}...
< 10f70d1 L
> 31e5b8e R

RUNNING: git -C clone log --format=ol --left-right @{u}...
10f70d1 L
31e5b8e R

-> NOT OK: no marks shown

RUNNING: git -C clone log --format=ol2 --left-right @{u}...
< 10f70d1 L
> 31e5b8e R

-> OK: marks shown

RUNNING: git -C clone log --graph --oneline --no-decorate --left-right @{u}...
< 10f70d1 L
> 31e5b8e R

RUNNING: git -C clone log --graph --format=ol --left-right @{u}...
< 10f70d1 L
> 31e5b8e R

-> OK: marks shown

RUNNING: git -C clone log --graph --format=ol2 --left-right @{u}...
< < 10f70d1 L
> > 31e5b8e R

-> NOT OK: marks shown twice

RUNNING: git -C clone log --oneline --no-decorate @{u}...
10f70d1 L
31e5b8e R

RUNNING: git -C clone log --format=ol @{u}...
10f70d1 L
31e5b8e R

-> OK: no marks shown

RUNNING: git -C clone log --format=ol2 @{u}...
< 10f70d1 L
> 31e5b8e R

-> NOT OK: marks shown

RUNNING: git -C clone log --graph --oneline --no-decorate @{u}...
* 10f70d1 L
* 31e5b8e R

RUNNING: git -C clone log --graph --format=ol @{u}...
* 10f70d1 L
* 31e5b8e R

-> OK: no marks shown

RUNNING: git -C clone log --graph --format=ol2 @{u}...
* < 10f70d1 L
* > 31e5b8e R

-> NOT OK: different marks shown twice
---


Am I missing something here ? Is this a known limitation ?


Thanks and cheers,

Philippe.
