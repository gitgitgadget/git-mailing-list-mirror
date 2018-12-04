Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E945211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 09:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeLDJwR (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 04:52:17 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:42504 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeLDJwR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 04:52:17 -0500
Received: by mail-io1-f49.google.com with SMTP id x6so13055347ioa.9
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 01:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xftSrg19ZlE1GfDFiCcLHgp1UEkt52z6uHP3KyXZZ4c=;
        b=LtrmOjAg3YmHBSkjzfLlJb5XsK2Xn7LpD4R01KXhQnapdDTic3/tfsMZ1nuhJQ8T2k
         wRVEbyJvDIDgW1WdDsnX+4di7Y1a5dcB0PZhYxMh+ftR9a9+dMhk3q2Isqg1SJjFdV6E
         elSGR5+6TlEGTxpq/Q1WSKi+xeXtw4d83tLGyppNAr+Kcsfgp7mxSutprVN6+DoQyrq/
         8QDBnEl2xW74NFfvkpyQA6c9KjNpyjpgUskFwDozz1rwa76vqcgBYAC7JlKclV+HnC9m
         6EAICh2XsfYsbGSy69/k5xGiSdVqPHxmerqmmBoiJRjg9rIx/nuZBzT9kUaMSFeQkECg
         dVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xftSrg19ZlE1GfDFiCcLHgp1UEkt52z6uHP3KyXZZ4c=;
        b=Q0NEIbZDHTW4OQoLPtYEgZfcoy3tJbz6cGnXBCtWDZkLLSfZuiADYuicohHr94Ytxb
         53Mpr+ka+WPIttqeKErnyx6lZwDD8/EQzSMjq6FuquyMvJXaJt9OyQwPbwTqrh8dw0gZ
         dAEFlFiQGTmP/XP7qPfSDSZkLjkC3fZJG+YWjbTHst2QY2dtweHnQUyiU0/xlbU10JL7
         fWi6RX7b6VR6/+YBos+JOsLtHds5+SoZ7m05tU1jV+8dqZM9AQZWwxKiy/3L1iQygNul
         CCMrkEO5iqSoOurBmN7T8t8YE0L9RoOlkmK+2rmxqvBCWrNxarF2r0fOmi1ip1QjZzXe
         TsQg==
X-Gm-Message-State: AA+aEWYCqkhQN0Cl5Jyd0rvyWBURUksDqrheUY+eZQLyOGDyFDD9Wts1
        cQatr1hU8+2KvPZbTVICH0f9oa8J3HL4eN/LZXJ7hjRU
X-Google-Smtp-Source: AFSGD/UPtubR8GOJKIj9nIOuvJA/XxMoY7HhheTmrIPsLwQKQ9tygfl7zDiDOf/jR/GV2GuFIvTaadc0r1zxJelB1M4=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr16364216iom.7.1543917135540;
 Tue, 04 Dec 2018 01:52:15 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?THVrw6HFoSBLcmVqxI3DrQ==?= <lskrejci@gmail.com>
Date:   Tue, 4 Dec 2018 10:51:39 +0100
Message-ID: <CA+YJQx72dMybGWyzNMUcNcVZnpDTHoaONcC-AQdqt=C_8aEdXg@mail.gmail.com>
Subject: [BUG REPORT] Git does not correctly replay bisect log
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Executing git bisect replay reaches a different commit than
the one that is obtained by running the commands from the bisect log manually.

Distribution: Arch Linux
git: 2.19.2-1
perl: 5.28.1-1
pcre2: 10.32-1
expat: 2.2.6-1
perl-error: 0.17027-1
grep: 3.1-2
bash: 4.4.023-1

no system /etc/gitconfig is present
tried with no ~/.gitconfig

$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

$ git fsck
Checking object directories: 100% (256/256), done.
warning in tag 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c:
missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 26791a8bcf0e6d33f43aef7682bdb555236d56de:
missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 9e734775f7c22d2f89943ad6c745571f1930105f:
missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a:
missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag ebb5573ea8beaf000d4833735f3e53acb9af844c:
missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 06f6d9e2f140466eeb41e494e14167f90210f89d:
missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 701d7ecec3e0c6b4ab9bb824fd2b34be4da63b7e:
missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 733ad933f62e82ebc92fed988c7f0795e64dea62:
missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag c521cb0f10ef2bf28a18e1cc8adf378ccbbe5a19:
missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag a339981ec18d304f9efeb9ccf01b1f04302edf32:
missingTaggerEntry: invalid format - expected 'tagger' line
Checking objects: 100% (6428247/6428247), done.
Checking connectivity: 6369862, done.

$ cat /var/tmp/git-bisect.log
git bisect start
# bad: [5b394b2ddf0347bef56e50c69a58773c94343ff3] Linux 4.19-rc1
git bisect bad 5b394b2ddf0347bef56e50c69a58773c94343ff3
# good: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
git bisect good 94710cac0ef4ee177a63b5227664b38c95bbf703
# bad: [54dbe75bbf1e189982516de179147208e90b5e45] Merge tag
'drm-next-2018-08-15' of git://anongit.freedesktop.org/drm/drm
git bisect bad 54dbe75bbf1e189982516de179147208e90b5e45
# bad: [0a957467c5fd46142bc9c52758ffc552d4c5e2f7] x86: i8259: Add
missing include file
git bisect bad 0a957467c5fd46142bc9c52758ffc552d4c5e2f7
# good: [958f338e96f874a0d29442396d6adf9c1e17aa2d] Merge branch
'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 958f338e96f874a0d29442396d6adf9c1e17aa2d
# bad: [2c20443ec221dcb76484b30933593e8ecd836bbd] Merge tag
'acpi-4.19-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 2c20443ec221dcb76484b30933593e8ecd836bbd
# bad: [c2fc71c9b74c1e87336a27dba1a5edc69d2690f1] Merge tag
'mtd/for-4.19' of git://git.infradead.org/linux-mtd
git bisect bad c2fc71c9b74c1e87336a27dba1a5edc69d2690f1
# bad: [b86d865cb1cae1e61527ea0b8977078bbf694328] blkcg: Make
blkg_root_lookup() work for queues in bypass mode
git bisect bad b86d865cb1cae1e61527ea0b8977078bbf694328
# bad: [1b0d274523df5ef1caedc834da055ff721e4d4f0] nvmet: don't use uuid_le type
git bisect bad 1b0d274523df5ef1caedc834da055ff721e4d4f0

$ git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean

$ git log -1 --format=oneline
2595646791c319cadfdbf271563aac97d0843dc7 (HEAD -> master, tag:
v4.20-rc5, origin/master, origin/HEAD) Linux 4.20-rc5

$ git bisect replay /var/tmp/git-bisect.log
We are not bisecting.
Bisecting: a merge base must be tested
[d72e90f33aa4709ebecc5005562f52335e106a60] Linux 4.18-rc6

$ git log -1 --format=oneline
d72e90f33aa4709ebecc5005562f52335e106a60 (HEAD, tag: v4.18-rc6) Linux 4.18-rc6





Running the commands from the bisect log manually, however:

$ git bisect reset
Checking out files: 100% (18326/18326), done.
Previous HEAD position was d72e90f33aa4 Linux 4.18-rc6
Switched to branch 'master'
Your branch is up to date with 'origin/master'.

$ . /var/tmp/git-bisect.log
Bisecting: 6112 revisions left to test after this (roughly 13 steps)
[54dbe75bbf1e189982516de179147208e90b5e45] Merge tag
'drm-next-2018-08-15' of git://anongit.freedesktop.org/drm/drm
Bisecting: 3881 revisions left to test after this (roughly 12 steps)
[0a957467c5fd46142bc9c52758ffc552d4c5e2f7] x86: i8259: Add missing include file
Bisecting: 1595 revisions left to test after this (roughly 11 steps)
[958f338e96f874a0d29442396d6adf9c1e17aa2d] Merge branch 'l1tf-final'
of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
Bisecting: 854 revisions left to test after this (roughly 10 steps)
[2c20443ec221dcb76484b30933593e8ecd836bbd] Merge tag 'acpi-4.19-rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
Bisecting: 352 revisions left to test after this (roughly 9 steps)
[c2fc71c9b74c1e87336a27dba1a5edc69d2690f1] Merge tag 'mtd/for-4.19' of
git://git.infradead.org/linux-mtd
Bisecting: 193 revisions left to test after this (roughly 8 steps)
[b86d865cb1cae1e61527ea0b8977078bbf694328] blkcg: Make
blkg_root_lookup() work for queues in bypass mode
Bisecting: 97 revisions left to test after this (roughly 7 steps)
[1b0d274523df5ef1caedc834da055ff721e4d4f0] nvmet: don't use uuid_le type
Bisecting: 47 revisions left to test after this (roughly 6 steps)
[6dad38d38f20c0c8a84b5ae4f23c62b2c8758ec5] null_blk: move shared
definitions to header file

$ git log -1 --format=oneline
6dad38d38f20c0c8a84b5ae4f23c62b2c8758ec5 (HEAD) null_blk: move shared
definitions to header file
