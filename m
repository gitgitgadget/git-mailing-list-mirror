Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E031C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 06:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiESG3y convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 19 May 2022 02:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiESG3w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 02:29:52 -0400
X-Greylist: delayed 380 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 May 2022 23:29:50 PDT
Received: from fred.zcu.cz (fred.zcu.cz [147.228.57.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4618511152
        for <git@vger.kernel.org>; Wed, 18 May 2022 23:29:50 -0700 (PDT)
Received: from webmail.zcu.cz (webmail.zcu.cz [147.228.57.30])
        by fred.zcu.cz (Postfix) with ESMTP id E79DC80025ED
        for <git@vger.kernel.org>; Thu, 19 May 2022 08:23:25 +0200 (CEST)
From:   "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>
To:     git@vger.kernel.org
User-Agent: SOGoMail 5.6.0
MIME-Version: 1.0
Date:   Thu, 19 May 2022 08:23:25 +0200
Subject: Bug - =?utf-8?q?remote.c=3A236=3A?==?utf-8?q?_hashmap=5Fput?= overwrote 
 entry after =?utf-8?q?hashmap=5Fget?= returned NULL
Message-ID: <24f547-6285e280-59-40303580@48243747>
X-Forward: 88.100.183.94
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: clamav-milter 0.103.5 at fred
X-Virus-Status: Clean
X-ZCU-MailScanner-ID: E79DC80025ED.AC638
X-ZCU-MailScanner-SpamCheck: not spam (whitelisted),
        SpamAssassin (not cached, score=-1.01, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, T_SCC_BODY_TEXT_LINE -0.01)
X-ZCU-MailScanner-From: perry@ntis.zcu.cz
X-ZCU-Spam-Status: No
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I try to push to remote git server, I got:

BUG: remote.c:236: hashmap_put overwrote entry after hashmap_get returned NULL

When I try push to another repository on the same server, it is working correctly. The problem is only with one repo.

Local Git version: 2.36.0.windows.1
Server Git version: 2.19.2

git fsck did not reveal any problem
Checking object directories: 100% (256/256), done.
Checking objects: 100% (23956/23956), done.
Checking connectivity: 18782, done.

git config --list --show-origin
file:C:/Program Files/Git/etc/gitconfig    diff.astextplain.textconv=astextplain
file:C:/Program Files/Git/etc/gitconfig    filter.lfs.clean=git-lfs clean -- %f
file:C:/Program Files/Git/etc/gitconfig    filter.lfs.smudge=git-lfs smudge -- %f
file:C:/Program Files/Git/etc/gitconfig    filter.lfs.process=git-lfs filter-process
file:C:/Program Files/Git/etc/gitconfig    filter.lfs.required=true
file:C:/Program Files/Git/etc/gitconfig    http.sslbackend=openssl
file:C:/Program Files/Git/etc/gitconfig    http.sslcainfo=C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
file:C:/Program Files/Git/etc/gitconfig    core.autocrlf=true
file:C:/Program Files/Git/etc/gitconfig    core.fscache=true
file:C:/Program Files/Git/etc/gitconfig    core.symlinks=false
file:C:/Program Files/Git/etc/gitconfig    core.editor="C:\\Program Files\\Notepad++\\notepad++.exe" -multiInst -notabbar -nosession -noPlugin
file:C:/Program Files/Git/etc/gitconfig    pull.rebase=false
file:C:/Program Files/Git/etc/gitconfig    credential.helper=manager-core
file:C:/Program Files/Git/etc/gitconfig    credential.https://dev.azure.com.usehttppath=true
file:C:/Program Files/Git/etc/gitconfig    init.defaultbranch=master
file:C:/Users/XXX/.gitconfig    user.name=XXX
file:C:/Users/XXX/.gitconfig    user.email=xxx
file:C:/Users/XXX/.gitconfig    credential.helper=manager-core
file:.git/config    core.bare=false
file:.git/config    core.repositoryformatversion=0
file:.git/config    core.filemode=false
file:.git/config    core.symlinks=false
file:.git/config    core.ignorecase=true
file:.git/config    core.logallrefupdates=true
file:.git/config    remote.origin.url=ssh://xxx/volume1/homes/disk_station/git/repo.git
file:.git/config    remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
file:.git/config    branch..remote=origin
file:.git/config    branch..merge=refs/heads/
file:.git/config    branch.master.remote=origin
file:.git/config    branch.master.merge=refs/heads/master

git ls-remote
BUG: remote.c:236: hashmap_put overwrote entry after hashmap_get returned NULL

