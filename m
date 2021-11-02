Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845B7C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BCCC61076
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhKBOSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKBOSh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 10:18:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61854C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 07:16:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h11so35227907ljk.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=vdzJ3hNBgSjioa7E1wkFp//igq8ytVJsfw3wVqehruo=;
        b=nhM889Wrqz5iXvlmT0I+tyrpjVJ8JqUzlxiYnojaZpDO5VP+TEphjO8P3w9QZJ4F4S
         Ygoh0KnUZYTlygizZz4zbZ6xmI9D+CMjbYKFIrrdRxBbWF7zcyggD6qv3WINzVdez6Tm
         3LGv1NFzS8VwsAye/+6QBUfMYhQPMa0oJ894EcV/PBlysZ/CYrmrLo24JvC0NyA4sCd9
         FyZIFZSf7th2dRhCN9I5/wL8uAgebQ9zF9XLrTKUnnXAN/VP1YJOMdadK6f6UjyFGKLV
         Xr9i7Q9J8jqjLL/niXTzU8b4xIXbrEjeQu9y48ZIxv8wu1b9dFvXnLx+R5gpILFh7Irc
         ly1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=vdzJ3hNBgSjioa7E1wkFp//igq8ytVJsfw3wVqehruo=;
        b=ybp60LHLCjXHhbu7ez+bLPnYXdCL/yyZhij5GFpjo1zW7P+AxqwZMpEDVDZvudMbjc
         QiVjpMD4YGbrsk91EKW7IQVJ75v4cw2CdOM2sTbOzVJukBqhhEuC33YLZT6LF97NTZYR
         fPag9EV3djZPgl0RLe9hfRHLYx5KTnG7H70jPMf+ADaeobJPPPqbwg8dl/7UeViJuzEf
         Z4jhYovASUmrEI2pXRsqdvcyYUnlkxkkungXE4NYRopOpROru5hpSEFEO9UoQsv4rQ2D
         uqJ/6QTfOfMWmxxtLhlQcFR/AQxwXCP6UuKe+EeY3dt0C1qOwmDWCiJztUWbxlGZVyzC
         Gfxg==
X-Gm-Message-State: AOAM530SkdQIinvYmjU+0KjPBjPN3ylrsJhfEpsdvgP0vgXz0BdJv7cB
        qh6untQfWPLPm1ihMz8lRiJKyp7dQAylwg==
X-Google-Smtp-Source: ABdhPJyeZJ8ROFZEqyfqP4ioRZGL4pBV6UmRNeohZvZRWolYdST9PirYSJkOh+FoXTEwF81HfFzrYg==
X-Received: by 2002:a2e:b947:: with SMTP id 7mr4159889ljs.67.1635862560207;
        Tue, 02 Nov 2021 07:16:00 -0700 (PDT)
Received: from ?IPv6:2001:470:28:6ed:73ed:176:7f89:51c6? ([2001:470:28:6ed:73ed:176:7f89:51c6])
        by smtp.googlemail.com with ESMTPSA id v28sm155527lfp.121.2021.11.02.07.15.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 07:15:59 -0700 (PDT)
From:   Alexey Kuznetsov <kuznetsov.alexey@gmail.com>
To:     git@vger.kernel.org
Subject: git bisect bugs
Message-ID: <163b01f2-ddc0-c551-5462-e8f80fb7cc48@gmail.com>
Date:   Tue, 2 Nov 2021 17:15:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two 'git bisect' bugs.

1) First git-bisect asks twice for the same commit
219d54332a09e8d8741c1e1982f5eae56099de85.


axet@axet-laptop:/media/axet/1TB/local/linux$ git bisect log
git bisect start
# good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
git bisect good 219d54332a09e8d8741c1e1982f5eae56099de85
# bad: [841fca5a32cccd7d0123c0271f4350161ada5507] Linux 5.10.1
git bisect bad f12366d9f172c4fc84cd114801b87588cb663074
# good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
git bisect good 219d54332a09e8d8741c1e1982f5eae56099de85
# good: [bce159d734091fe31340976081577333f52a85e4] Merge tag
'for-5.8/drivers-2020-06-01' of git://git.kernel.dk/linux-block
<http://git.kernel.dk/linux-block>
git bisect good bce159d734091fe31340976081577333f52a85e4
# bad: [fbc1ac9d09d70859eee24131d667e01e3986e368] tools/cgroup: add
memcg_slabinfo.py tool
git bisect bad fbc1ac9d09d70859eee24131d667e01e3986e368
axet@axet-laptop:/media/axet/1TB/local/linux$


I expect git bisect did not ask twice for the same commit.

2) Second:

If you start 'git bisect' on "good refs/tags/v5.4.19" and "bad
refs/tags/v5.10.1" it will failed on second step (bad) with following:

Bisecting: a merge base must be tested

then on third step with 'git bisect good' it will result:

"was both good and bad"


I expected 'git bisect' will handle all "connection" issues between two
kernel tags, but it failed.


admin@m3n:~/local/linux$ git bisect bad refs/tags/v5.10.1
Bisecting: a merge base must be tested
[219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
admin@m3n:~/local/linux$ git bisect good
f12366d9f172c4fc84cd114801b87588cb663074 was both good and bad


bisect log:


git bisect start
# good: [d6591ea2dd1a44b1c72c5a3e3b6555d7585acdae] Linux 5.4.19
git bisect good 1670517c4dcbe1143fd86d8a9eae272d0c514415
# bad: [841fca5a32cccd7d0123c0271f4350161ada5507] Linux 5.10.1
git bisect bad f12366d9f172c4fc84cd114801b87588cb663074
# good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
git bisect good 219d54332a09e8d8741c1e1982f5eae56099de85


[System Info]
git version:
git version 2.30.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.0-9-amd64 #1 SMP Debian 5.10.70-1 (2021-09-30) x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

-- AK
