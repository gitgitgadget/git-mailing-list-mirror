Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE84C433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 15:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08738610CD
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 15:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhDRPPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 11:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhDRPPb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 11:15:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593BC06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 08:15:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z13so35033577lfd.9
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=z59Wdcf6FULCrzSE5Aja+9qnh4OOGUb+u+XM1ie6a/A=;
        b=Ov+pOHJ5Zk5BLnCW04GDWYGKjDz1KF9Mx0A4A6jRT1q6v81mr5xq2ili6F8es+hwBB
         FLtC91mC8Th7PfiVEvj3PZfSmlRMnrn8ES4tPCcDkTQtPbhdrA57e4aJWvOfpck5nty/
         v+LdsbNaOcGpUWyvsHaanq0s9PicPvhCs2mFPa/dkRqZ3yljH4cvT44y2PXNx+rjU5Vk
         25crptZOcC8TrjwsgjJuEUb0Ajxt1I1GUAvfvIwSLdLYIUqwf82TF0TsyVZam6y5Jv8v
         fml70KSLMG2o5GUA5Nk0GCQKrUX5MOuVUCVK18+eDQ2TcPHA1I102vCjoN3Eo5j9SHuN
         cN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=z59Wdcf6FULCrzSE5Aja+9qnh4OOGUb+u+XM1ie6a/A=;
        b=RoRJGKpakSLkhBCKXQBXKV+O1CIiTzQM0gURjl/wa0jxnht5cJcCSkZrudNcqNZlYM
         Zg62XI21m9Z9pIKxV7+P6RKCEEN+nkudyhO7iqOIysWtfffjVa7OqbMu0MKRD66JAHnK
         lJfS3mQ9dVUuvuQKLUd6sZguo9U9Lv21T5IamPLHFSUv61gajRmSOesHf3p1TrEQTxF5
         aZhCRJ6AfVYyCJO+w/+vi7EZJSyad6BSDpQxZz2yb+K4ep1XFd1/qNGVUE8A1iEcH/sE
         j0WSTetdK9uHv5XXEocxSzdUD1nk7GmP3q5gwmpZEjT/J6MjKGoS1VFhuXy487shQ/le
         bSlg==
X-Gm-Message-State: AOAM530WUxV5hgqxED5mi+Ra3MV3GvFFqxBpStX1rjjQsOq25/lKSNOf
        MpIHWshvOvGHtoG/F5+D9FiO24UCn9U=
X-Google-Smtp-Source: ABdhPJw02gkuc//SsvEARf+REYrck/z4EpqVQGBa67MB+tH9ZZ5Abe12/NfNrEZ0I3TPPePXtW4VUg==
X-Received: by 2002:a19:98b:: with SMTP id 133mr9436608lfj.587.1618758901363;
        Sun, 18 Apr 2021 08:15:01 -0700 (PDT)
Received: from aaberge.net (kramer.samfundet.no. [2001:67c:29f4::72])
        by smtp.gmail.com with ESMTPSA id y2sm1575591lfj.161.2021.04.18.08.15.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 08:15:00 -0700 (PDT)
Date:   Sun, 18 Apr 2021 17:14:59 +0200
From:   Trygve Aaberge <trygveaa@gmail.com>
To:     git@vger.kernel.org
Subject: Using --term-* with bisect breaks skip
Message-ID: <20210418151459.GC10839@aaberge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
1. git bisect start --term-new=fixed --term-old=unfixed master HEAD~10
2. git bisect skip

What did you expect to happen? (Expected behavior)
Git should mark the commit as skipped and change HEAD to a different commit.

What happened instead? (Actual behavior)
The commit was marked as skipped, but HEAD was not changed.

What's different between what you expected and what actually happened?
After running bisect skip, HEAD was still at the same commit as before,
instead of having changed to a new that I can test. The usual output about
steps left to test and the new commit was also missing, skip did not output
anything.

Anything else you want to add:
- If I don't provide any --term-* options, skip works as expected.
- The revisions provided in the reproduction steps doesn't matter, they're
  just an example.
- I tried running from the next branch, and it happened there too.

[System Info]
git version:
git version 2.31.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.29-1-lts #1 SMP Sat, 10 Apr 2021 14:40:41 +0000 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]


-- 
Trygve Aaberge
