Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D28C43217
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 08:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiJTIZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 04:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJTIZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 04:25:07 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8720D7E3D
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 01:25:05 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id n63so481187vsc.8
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zlpQ+EhLADDbEGdDA++54OFwPVhwKYFZ1o+P26XgQwY=;
        b=EUZRRVEePehTf9zebJ0h0tpHT+CjylF1xSdFMgJkc3fSHm1szCjrbF2KviEd2avH/A
         iOgyNlRLnrbGvCL0jlzLmUeQnNFUwFprm/xwz6fFey+wOu43wx3sBtYwHRKglg6qXJOm
         vIC93DgknQKIR6UHIJNgqKKwXovCl24f+tAV9dBxiRDTU8Bum6gi5mlEzRu6h3W5Wz5T
         WdMBarj8aZCR2EhjFXexWD9U8BouMugSjAItHy/tLjFQP+0e11uacC9ydltyrdOGPUTe
         tUS43rF0ylPdMB9tlU1II0VFCYc4BMxLQrov1e9SGv6GnhbFFeB2yJofi6o7+Z2apzIX
         BKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zlpQ+EhLADDbEGdDA++54OFwPVhwKYFZ1o+P26XgQwY=;
        b=3l3iAnQxbhyC+DXJrpj0IiaPkCTjoHY47L3Mj7UP4DdZJr3gXqVj6iNftFbhaz9W8J
         c9oghYELoXnM69ZVODgwGPelt6YgtjzJ4f0HwIaSTK3lZwNTFLoTVr15xix4TNfz2b3Z
         1b5PDlTflWCbw3J6joACpI8GT0OZNluaTAEQlHHrHa+Pd/r3nId0vv++4WtD6xv4zGTB
         ZmYe3i0mHCX4FP4uXlpNyNLJmwNUzTI1rIV9bxWZYuFZFNmaqrbk5khjpzSD5E+blnZj
         miBj5fraEyMYU8Z+iQB2vf9e5HKcTY4YPuuhurDg6tYT1B7ni78rA9pW8AMahxs5o0Xl
         kiyw==
X-Gm-Message-State: ACrzQf005rWK5XuZAnEV0Oi+eGD1K/ZTH8cwFILoRK2NfSWRayyfyyTD
        9oV/WjGYtT0VGCkx6zMYp+oObsT14FesQnH1/0ibanEmTmk=
X-Google-Smtp-Source: AMsMyM5hT/DoGP7K+ZjRmxDS2OVv1xh0KApVYlTyzr8ZG4XfU76gQIEjLbzjfIgEY7QPjVweslQ8lbMeMBhEgdOPIfU=
X-Received: by 2002:a67:a64a:0:b0:39b:33f:954e with SMTP id
 r10-20020a67a64a000000b0039b033f954emr5389122vsh.77.1666254304534; Thu, 20
 Oct 2022 01:25:04 -0700 (PDT)
MIME-Version: 1.0
From:   Matan Wiesner <matanwis@gmail.com>
Date:   Thu, 20 Oct 2022 11:24:53 +0300
Message-ID: <CA+vqH8+zCbyF39ycKv-4=t+U2hOx7t3w5EB-+bSeyH9HdfsjMQ@mail.gmail.com>
Subject: Commit amend during a merge conflict
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi
When I use git to edit a long change of commit there are two scenarios I meet:
1. edit existing commit - in this case I do "git rebase -i", stop in
my commit, them run "git commit --amend" and them run "git rebase
--continue"
2. rebase and solve conflicts - when I rebase (for example on top of
main branch) and meet a conflict : "cannot apply commit A" I need to
solve these conflict, then run "git rebase --continue", it easy to
confuse and run "git commit --amend" and in this scenario, that leads
to commit A and the commit before A to be squashed.
My claim is, that there is no scenario that the user actually wants to
commit (and not run "rebase --continue") when there are merge
conflicts, therefore git should block this option.

As a reference to support my claim, I link 2 stack overflow threads of
users that did this mistake
https://stackoverflow.com/questions/41439424/i-amended-instead-of-resolving-conflict-in-interactive-rebase-can-i-undo
https://stackoverflow.com/questions/11116572/git-commit-during-git-rebase-what-really-happens


WDYT?
