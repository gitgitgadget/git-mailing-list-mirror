Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB27BC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 14:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjANOyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 09:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjANOyu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 09:54:50 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5EE5274
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 06:54:48 -0800 (PST)
Received: from 88-110-98-79.dynamic.dsl.as9105.com ([88.110.98.79] helo=[192.168.1.23])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pGhvi-0001EB-CW;
        Sat, 14 Jan 2023 14:54:47 +0000
Message-ID: <bce6ac3a-17a6-beed-43ef-5a1e0dd92a5d@iee.email>
Date:   Sat, 14 Jan 2023 14:54:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Git List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Subject: test_pause giving '__git_ps1: not found' warning
Cc:     Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was trying to refine a test_expect_failure test [1] and tried 
inserting a `test_pause &&` test line [2].

I then found, when it paused, I was repeatedly given the warning line
     /bin/sh: 1: __git_ps1: not found
in the terminal until I expected the test shell.

my PS1 is working normally in the terminal, but not here.  Is this 
expected, or do I need to set up anything else?

Normally I'm on Git for Windows, but this was on my old laptop (Acer 
7741 i5 4GB ram..) converted to Ubuntu 20.04, which I use when away.

The basic sequence was

~$ cd repos/git
~/repos/git (doctrunc *)$ cd t
~/repos/git/t (doctrunc *)$ ./t4205-log-pretty-formats.sh  -i -x -v
Initialized empty Git repository in /home/philip/repos/git/t/trash 
directory.t4205-log-pretty-formats/.git/

[... ...]

+ git log --format=%<(5,mtrunc)%s -4
+ test_pause
+ PAUSE_TERM=dumb
+ PAUSE_SHELL=/bin/sh
+ PAUSE_HOME=/home/philip/repos/git/t/trash 
directory.t4205-log-pretty-formats
+ test 0 != 0
+ TERM=dumb HOME=/home/philip/repos/git/t/trash 
directory.t4205-log-pretty-formats /bin/sh
/bin/sh: 1: __git_ps1: not found
\w$ git status
On branch source-b
[...]
nothing added to commit but untracked files present (use "git add" to track)
/bin/sh: 1: __git_ps1: not found

I added the gits status to see when/where the warning was emitted.

[1] 
https://github.com/PhilipOakley/git/blob/doctrunc/t/t4205-log-pretty-formats.sh#L1021-L1046
[2] https://github.com/git/git/blob/master/t/test-lib-functions.sh#L137-L188


Any suggestions as to how to set this up correctly to avoid the warning?
--
Philip
