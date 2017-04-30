Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92F41FC3E
	for <e@80x24.org>; Sun, 30 Apr 2017 00:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036578AbdD3AIU (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 20:08:20 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33639 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035341AbdD3AIT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 20:08:19 -0400
Received: by mail-wr0-f179.google.com with SMTP id w50so49647241wrc.0
        for <git@vger.kernel.org>; Sat, 29 Apr 2017 17:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=52asNf7AbCQTsOxKqC2tuYh9Tg7J/uppoqSTrTRGtnc=;
        b=vPnDqHWme+7f4PpLvmS7UYjU+qa/lSJmHrsm+8rsSHmsCszjG9hNmiwbqkm8+OOHu9
         qa4V29dzym6kNcNY//BUGC4pwnrYWIoXnwQMxQ3gaEi2Ahmb2rwSHrZ1gn5IGvMDnaOe
         kZsh77KcvfQ/q5vK4D9VR0R1p2fNfemZLno1ijfWZRK5p78aVP+JI8LaUz3V+JcxfXw3
         I0SMd/8TM9NYJEgQJBMJ/uZcTPVpnOZ8oWzXwDIi18O18ILlD11h6XbDnZnTZLt1jNK7
         oY9NJfU/6jXGR2lezYUY4CyUt6CgqjEXGfmhd6j7/0kOK6AJ58Z91DUxepxe14f+Z+k8
         bEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=52asNf7AbCQTsOxKqC2tuYh9Tg7J/uppoqSTrTRGtnc=;
        b=gEJLhxCjlFNSJ1KnNk/vTABDeQTONiJxL7Xr6QPIiBDe0NjqIW4Yj9HOXCeCtR7Pnl
         UP8Bm/qzsggFEnvK1kpG+YeMwET5ySmtiRnkhgXXpSmsaMSwOIGFLixWiaDunMI4Nbzj
         fzXrD3TcUJp6zGsZPzLOazVL5BBV1+4mFoSaDBy/QEWC0+37xMiLzsL8nQkMY1ZOPZ7M
         WA2qsjfvCh4EJZcO91hpL7FTSuZg8GoS2z68f68WdqogkVJFN4bH8SrQ8NpYbiolIITP
         j8oCZHmNEIVrIQ1L5urqqQedOrDFXlTnBoA3x3VmDI1cJRS8ENM/upl4rov1PwPdq0t8
         poCA==
X-Gm-Message-State: AN3rC/5EJ/siGR8Zk8VUbeRqLz1blHncevQwbvnSLaeUvVxlfQDxtDDc
        +ZcLjUGXILD12KGZrMBQjBFd/FujDqkT
X-Received: by 10.223.165.14 with SMTP id i14mr8800212wrb.127.1493510898373;
 Sat, 29 Apr 2017 17:08:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.160.6 with HTTP; Sat, 29 Apr 2017 17:07:47 -0700 (PDT)
From:   Tomi Belan <tomi.belan@gmail.com>
Date:   Sun, 30 Apr 2017 02:07:47 +0200
Message-ID: <CACUV5oeKoVdncK3RjtusiqrACj1xLiS--z8vC+Rsvy5TF09Lsw@mail.gmail.com>
Subject: Bug: wrong documentation for git-fast-import's option command
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The man page of git-fast-import says the syntax is "'option' SP
<option> LF". But this is wrong, and commands like that will be
silently ignored.

fast-import.c only parses commands starting with "option git ", and
ignores others starting with "option ". See
https://github.com/git/git/blob/027a3b943b444a3e3a76f9a89803fc10245b858f/fast-import.c#L3487-L3490
.

The correct syntax is e.g. "option git stats" or "option git
big-file-threshold=123". The docs should say "'option' SP 'git' SP
<option> LF" or maybe even "'option' SP 'git' SP <option> ('='
<argument>)? LF" (similarly to the docs for feature), and explain this
is meant to allow other consumers of the fast import format.

Looks like this bug existed since the option command was added in
9c8398f in 2009. Am I the first one who tried to use it? ;-)

Cheers,

Tomi
