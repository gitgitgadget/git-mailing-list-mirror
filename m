Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027C9CCA483
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 13:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiGWNQ3 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 23 Jul 2022 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiGWNQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 09:16:28 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0162C1EECB
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 06:16:26 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 26NDGPfX053784
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jul 2022 09:16:25 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Yuri Kanivetsky'" <yuri.kanivetsky@gmail.com>,
        <git@vger.kernel.org>
References: <CAMhVC3acU06uBDAjd5LEiCvuf8=XW_1RYVVt7CdKr-JqB7cRFA@mail.gmail.com>
In-Reply-To: <CAMhVC3acU06uBDAjd5LEiCvuf8=XW_1RYVVt7CdKr-JqB7cRFA@mail.gmail.com>
Subject: RE: Dropbox and "Your local changes to the following files would be overwritten by merge"
Date:   Sat, 23 Jul 2022 09:16:20 -0400
Organization: Nexbridge Inc.
Message-ID: <01bf01d89e96$699539e0$3cbfada0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJBnQvVZYZSdwSZWejgPNLI5Xdcuay58bPg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 23, 2022 8:40 AM, Yuri Kanivetsky wrote:
>I've started to run into issues with git relatively recently. Let's take the issue I'm
>experiencing at the moment. I'm trying to rewrite a history (git rebase -i some-
>hash, move 4 commits up, rename the last 2 of them), and it fails to apply the next
>commit on the todo list after these 4 (I've redacted the message):
>
>[detached HEAD 1888888] name-3
> Date: Mon May 9 22:41:03 2022 +0300
> 1 file changed, 1 insertion(+)
>[detached HEAD 00b5555] name-4
> Date: Sat Jul 23 13:19:42 2022 +0300
> 1 file changed, 1 insertion(+)
>error: Your local changes to the following files would be overwritten by merge:
>        some paths
>Please commit your changes or stash them before you merge.
>Aborting
>hint: Could not execute the todo command
>hint:
>hint:     pick 8222222222222222222222222222222222222222 name-5
>hint:
>hint: It has been rescheduled; To edit the command before continuing, please
>hint: edit the todo list first:
>hint:
>hint:     git rebase --edit-todo
>hint:     git rebase --continue
>Could not apply 8222222... name-5
>
>The files it complains about, they're versioned, and they're not changed when it
>stops. If I copy the repository (cp -r), and repeat the steps, it sometimes succeeds,
>sometimes not. If I were to split it into smaller steps I believe it would succeed. In
>other words I got this message occasionally for no apparent reason. Usually it
>succeeds if I simply repeat the steps. Sometimes I need to do it in smaller steps.
>
>First I thought it's an issue with vim-fugitive, but I can reproduce it with git alone.
>The other culprits I can think of are magit (I believe I used it with this repository),
>vim, and now that I think about it... Dropbox? The repository is in a dropbox
>directory. I understand that this is uncommon, but a couple of my repositories are
>in a dropbox directory and I'd like to put the reasons aside. Can you suggest what I
>can do to find the reason it fails? Do you know what exactly triggers this message
>(the content changed, modification time, ctime)?
>
>I'm running Alpine Linux and git-2.36.1.

Is DropBox 100% up to date when the operation is run? It uses timestamps to determine whether files changed. Git uses SHA1. So, they each have a different perspective on what is changed. A git status before the operation would tell you what is modified prior to the merge, which could be something DropBox is updating or is pending an update. You could try to do a git stash push prior to the merge and then a git stash pop to isolate whatever DropBox is doing at the time.
--Randall

