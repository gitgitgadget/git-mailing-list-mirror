Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683F9C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 02:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiEXCpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 22:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiEXCpX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 22:45:23 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD13A5E5
        for <git@vger.kernel.org>; Mon, 23 May 2022 19:45:22 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id l14so15613355pjk.2
        for <git@vger.kernel.org>; Mon, 23 May 2022 19:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=SAQfnoXwlClTe3FQGgCrZtnR19SGKgEbNNzXRMJXGIc=;
        b=FZsevnRPbJLxDsH1zgEdsuQWn+Ay8Pv34mHtoEZ1FMMoJxQKwIEFoeOEAwqQzarcjS
         qDdI9YcDewxwmCqZjxLJIohyRUQED2dRTSyPPEvD8g3DOVc7bK/Xhe7Ql8hG4oY16AUa
         oNKRstO3Es85m9VcXLuVCX8hM7UxQ6gjWEqTsrqFtVfwNxkjhX8JaJyvXIdTuL9U5+mK
         F84hyyBZC7TCxzHKPZO0gD07oyYOmpFOg45PeG9mZo+YpP4FSXBbq5pbqi/kljMs7jFw
         nKwJj4kdeH3JFe3BhMUZ5l9EEChyUFR7DTeAAWqQPOoEwgheok7xLQ8YQxP12tO1kXuI
         QM6w==
X-Gm-Message-State: AOAM530rT3LM2qllk9kUfOaWWYzKaskeO7K/A0FXoRiL+lsyfOeOpoia
        lr1J4qhHiN7Xt/xHKxAdesAbIEZwqdk=
X-Google-Smtp-Source: ABdhPJyyYSc8aedO6Ujm0rQPC3BDDBvOUi98SMCK+pXwFOUkTkx+/jtzZHeQQfRzNPADnGA/AtZ92Q==
X-Received: by 2002:a17:90a:f08c:b0:1df:6f35:361d with SMTP id cn12-20020a17090af08c00b001df6f35361dmr2228164pjb.161.1653360321506;
        Mon, 23 May 2022 19:45:21 -0700 (PDT)
Received: from [192.168.1.2] ([73.67.158.18])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090aae0200b001d954837197sm411111pjq.22.2022.05.23.19.45.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 19:45:20 -0700 (PDT)
Message-ID: <b89da76a-465c-9398-bf3d-3b091d74de89@timdufala.com>
Date:   Mon, 23 May 2022 19:45:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Tim Dufala <contact@timdufala.com>
Subject: git bash completion modifies COMP_WORDBREAKS breaking other
 autocompletion
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I used bash autocompletion. So:
git <tab>

What did you expect to happen? (Expected behavior)
The bash environment variable ${COMP_WORDBREAKS} remains unmodified.

What happened instead? (Actual behavior)
COMP_WORDBREAKS is modified. Specifically, a colon is appended.

What's different between what you expected and what actually happened?
COMP_WORDBREAKS being modified.

Anything else you want to add:
This breaks auto-completion of programs that rely on completing 
arguments that
include colons. For example, autocompleting arguments like: "file://abc" 
- hitting
tab gives something like "file:file://abc". As far as I'm aware, modifying
COMP_WORDBREAKS is no longer considered good practice.

Doing some research, I see the following patch, which I'd be in favor of 
using:
https://patchwork.kernel.org/project/git/patch/20201104174716.783348-6-felipe.contreras@gmail.com/

Not sure if this will just get lost in the noise, but I figured I'd send 
this at least as a 'bump' towards this issue.

[System Info]
git version:
git version 2.36.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.13.0-41-generic #46~20.04.1-Ubuntu SMP Wed Apr 20 
13:16:21 UTC 2022 x86_64
compiler info: gnuc: 9.4
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show

