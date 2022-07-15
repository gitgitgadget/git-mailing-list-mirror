Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5E9C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 10:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiGOKgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 06:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGOKgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 06:36:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A7F82FA0
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 03:35:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso11192503pjc.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=NDCQwaXk30ZpkicMx6rbc9o38SLsDEGjBDI7y4l5T6I=;
        b=qfmnwFmLb6yPA35gzibvuEy9euhdq2q+pt5qVHTSYg3V3xdatc1qHGAtETF5pUyK/g
         +Tmuk+YzTQe6BbiXkRWUosteLuPZW3uOyldjrhK7LaLajZZdCzcLEJl/oG+z88+WaZK5
         +J8kKA7v1VNYXFBmig4+P56KNQcuHGsMhUSManw00badQlP/4YFRMxFoZ77hLg309aHX
         qGLjT6dE/1tTL3ScVYkcnHzjcvduQoUSCC0X1qbXvliU1fWvuBeaNBzF+aVK6rHBFMG+
         bW6eFtCwUIUzYPosrm2vFvF36cUyXYJgG0bZJneI2HbWyCCQ95f3V4LAqKNQiT5PQ+5o
         rZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=NDCQwaXk30ZpkicMx6rbc9o38SLsDEGjBDI7y4l5T6I=;
        b=jKLU3WxuLgLuGaxhynRCym3J0NGCW7IoJoWegC3fJWdvT21gPyKA2YgNa+yZOD2DhC
         qnh0YOMFyCxSU1lIjvy9oZI7F1vSdu2MY2QrXKk90F22/rpkGZ8XjZiZq8RoBtukbztg
         ejEN9oec87XT4l+f++vO+2lodvDF85oDiBPOde4ZixpSh81RMKOe+e1grQz7RexdD6OD
         wJvnBaXOzfDCqiXEhZDwITpJHsUV0ADTOOHLbIzHtqMWpLxBtcBIF7Sg6YuW93uVYGMq
         KnjgMSXOsEr+rL6IhrUNI8svBxXPmKvgagJk9xB11OGLEysAkzIehhVohusa4OiyVKkW
         BBnQ==
X-Gm-Message-State: AJIora/WLthNgyjAfp9LZkblGykGIrbW+0KOTB3J7rq/uP2+uAZY7TVI
        JKMoej2/TTwhrBQnsGoHhnRYAaMSc/AYAw==
X-Google-Smtp-Source: AGRyM1tNxF5N1wdrDyh1B2c3mEBwSnKVkbv1cESEOSKZgZk62QsuINbnJDlMQTVlOSx/FsYrocN91A==
X-Received: by 2002:a17:90b:507:b0:1ef:9344:e1b9 with SMTP id r7-20020a17090b050700b001ef9344e1b9mr21727616pjz.160.1657881358575;
        Fri, 15 Jul 2022 03:35:58 -0700 (PDT)
Received: from cosmos.melik.windwireless.net (melik.windwireless.net. [206.63.237.146])
        by smtp.gmail.com with ESMTPSA id y30-20020aa79e1e000000b00528c7f6f4dcsm3422255pfq.52.2022.07.15.03.35.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 03:35:58 -0700 (PDT)
From:   David Chmelik <dchmelik@gmail.com>
Subject: 'git clone,' build makes user non-writable files (should be option
 keep user-writable)
To:     git@vger.kernel.org
Message-ID: <822787da-bc26-0d72-a5c4-808a3d10126e@gmail.com>
Date:   Fri, 15 Jul 2022 03:35:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened?
'git clone,' built various software (with gcc, BSD & GNU make, 
autotools, cmake, etc.)

What did you expect to happen?
Option: keep cloned/built/etc. files user-writable.

What happened instead?
Needed chmod or 'sudo rm -rf.'

What's different between what you expected and what actually happened?
Option: keep cloned/built/etc. files user-writable, otherwise (has been 
said 15+ years) encourages 'sudo rm -rf.'

Anything else you want to add:
         I try/test/debug (and report bugs) many software commits but 
don't commit so need cloned/built/etc. files writable as user & even 
system-wide options: who hasn't made 'rm -rf' mistakes? (unrelated but 
someone might claim is: I don't use non-UNIX-like OS that shell alias 
'rm -rf' to confirm every file (potentially thousands) and though made 
my own alias (confirm once) it's longer, sometimes unavailable so don't 
always use (many people don't)... software should always have 
user-writable files option.)  Below indicates GNU/Linux but also have 
often used git on *BSD/Unix.  I'm not on git mailing list but you can CC 
me all replies.

[System Info]
git version:
git version 2.37.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.18.11 #1 SMP PREEMPT_DYNAMIC Wed Jul 13 00:20:29 CDT 2022 
x86_64
compiler info: gnuc: 12.1
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash

