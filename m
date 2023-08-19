Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA5C83003
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 00:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjHTALI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Aug 2023 20:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjHTAKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:47 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA464CC130
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 13:35:48 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 06EDF3EA90
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 22:35:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id B28823E98E
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 22:35:45 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W0Yl2Uek3T8t for <git@vger.kernel.org>;
        Sat, 19 Aug 2023 22:35:45 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id A643F3E88E
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 22:35:43 +0200 (CEST)
From:   Wesley Schwengle <wesleys@opperschaap.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing without a forkpoint
Date:   Sat, 19 Aug 2023 16:34:48 -0400
Message-ID: <20230819203528.562156-1-wesleys@opperschaap.net>
X-Mailer: git-send-email 2.42.0.rc2.7.gf9972720e9.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=UttIx32zK-AA:10 a=VwQbUJbxAAAA:8 a=cf1hjc53WrVvSW5ZWwwA:9
        a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of years ago I submitted d1e894c6d7 (Document `rebase.forkpoint`=
 in
rebase man page, 2021-09-16) and during that discussion there was some ta=
lk
about the behaviour of `git rebase'[1]. During that time I found that the
documentation update was suffice. I wouldn't say it kept me awake at nigh=
t but
I do think that `git rebase' with or without an upstream supplied should =
behave
the same in regards to forkpoints. This patch series addresses this behav=
iour
change. It introduces a warning so users will have to set `rebase.forkpoi=
nt' in
their configuration. In the future we can remove the warning and opt to p=
ick
`--no-fork-point' as a default value for `git rebase'.

There is one point where I'm a little confused, the `test_cmp' function i=
n the
testsuite doesn't like the output that is captured from STDERR, it seems =
that
there is a difference in regards to whitespace. My workaround is to use
`diff -wq`. I don't know if this is an accepted solution.

Another point of interest is that `git rebase' outputs `Successfully reba=
sed
and updated refs/heads/foo.' on STDERR and when everything is up to date =
it
outputs `Current branch foo is up to date.' on STDOUT. I was a little con=
fused
by this. Especially since the output on STDOUT can be compared with `test=
_cmp'.

[1] https://lore.kernel.org/git/xmqqmtocrxwq.fsf@gitster.g/


