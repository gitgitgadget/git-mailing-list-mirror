Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887D4C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD65611CE
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhEMNHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 09:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhEMNG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 09:06:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D37CC061760
        for <git@vger.kernel.org>; Thu, 13 May 2021 06:05:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h7so14353392plt.1
        for <git@vger.kernel.org>; Thu, 13 May 2021 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=eUP5IMDSDG49LsfaudWbgg96hsCCAds0xSymJeiQF1s=;
        b=OThtPikSyWa3ojed6EtIg+k5YokOpmxifB3TAME2MFKMqbXGFgXhwUNrkhaTzUYB+7
         REO6SCZi3cisuh+n9tdysaXvwdBZJrdctWZR2MRUXVDywnrOu/64axplmJrzazBxLtue
         McLkz1cWIZ8XkZzYG3XgvzhYN/m3EwyebdKiv2BQ8fFGWkviqJDiUrMKP7XKzfe3j+oR
         UuYVH9g12E85HlrXytveix5kSjJlCBqlaRAu7389MWF7VZ5wlzjDND6sNSDsTJ/GGONY
         j5QiBzo6qRTDsQ9cyQOasREONdXgdGgG/Gghvcej51sb66RiV08wCmdxy4LTzZn0LhYa
         gpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=eUP5IMDSDG49LsfaudWbgg96hsCCAds0xSymJeiQF1s=;
        b=l47xXy7uqV4GR9UeM81ypbDCqieGmuAUZbdl5uoXaLeiFXPN1exs1Fgw3b2Z3LHGVP
         aLHHuhKmpIJRnt5Eicpd+YGNeQjptuTwLq9OJZRXeo76Z6Em6Ek3kd21ybZkIpnIe6Dd
         KyTk0ULJF+o/1lpB2e7pTr8VJJ7x61AvA4lFHt9gp+MDr3JV25fH375L+ivdfmm4Vo6R
         ZmfSrJwYJHnjJB9SwCXxvUJGSScVi/BbrXlPeH9qFoUFdWTRHdXtkqcHD/QfZI4D7swU
         cbwAoL7G0HJxKSLWUheymI0AoKz8tKj0qcS2Qqz186ewD1ZF5qnh8azYFcpDJBaXY0Iq
         EQkw==
X-Gm-Message-State: AOAM5321F8FLGzc54S0SRjhHjZFXlyajhRSBLjiWQ6foKbKRItWMvfze
        YY1ml5cU0w5xx4DLy9QzAj30w1+3zq8Zzg==
X-Google-Smtp-Source: ABdhPJzb9Y3LPeL24fFc5eR9sUK7nnnxOkUo2KOc4+q3kLBiedkM+1CBALSXwNW+vKXRwe2bBTjBdA==
X-Received: by 2002:a17:902:ec83:b029:ef:919c:39f5 with SMTP id x3-20020a170902ec83b02900ef919c39f5mr5669517plg.83.1620911146361;
        Thu, 13 May 2021 06:05:46 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-89.three.co.id. [180.214.233.89])
        by smtp.gmail.com with ESMTPSA id p36sm2237444pgm.74.2021.05.13.06.05.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 06:05:46 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [RFC doc] Tracking git.git
Message-ID: <4591b3bd-1f35-55cb-6eb0-be97810d6e68@gmail.com>
Date:   Thu, 13 May 2021 20:05:43 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Some people (most notably Git developers here and me) like to run Git
compiled from git.git repository, as opposed to normal users that run
either Git from distribution or compiled from official source tarball.

In git.git repo, besides master, there is also next, seen, and maint
branches. The purposes of these branches are described on
Documentation/howto/maintain-git.txt.

When we have git.git repo clone and track it, tracking master, next,
and maint are easy peasy: git pull will do the job. But tracking seen
is more like tracking linux-next. We do NOT use git pull because
often doing so will try to merge origin (upstream) with our local
version, which are divergent and most likely will end with conflict.
Instead, we do git fetch first followed by resetting to upstream by
git reset --hard origin/seen.

Should the fact above be documented? And on what file the fact should
be placed? In INSTALL?

-- 
An old man doll... just what I always wanted! - Clara
