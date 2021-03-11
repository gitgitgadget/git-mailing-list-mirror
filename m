Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A842C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FFD64FA9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhCKOJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 09:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhCKOJS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 09:09:18 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCF5C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 06:09:18 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:39248)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1lKM04-0002mo-3s
        for git@vger.kernel.org; Thu, 11 Mar 2021 09:09:16 -0500
Received: from auth1-smtp.messagingengine.com ([66.111.4.227]:54525)
        by fencepost.gnu.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <tsdh@gnu.org>)
        id 1lKM02-0004DM-R5
        for git@vger.kernel.org; Thu, 11 Mar 2021 09:09:14 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 622A827C0054
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:09:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Mar 2021 09:09:14 -0500
X-ME-Sender: <xms:iiRKYKEPqQClM-2uMZBx38_kxjL_NesxXoZFnSY8f7IJebBDskDNsQ>
    <xme:iiRKYLTO55rRSoOTBvMtObJfBiLTBsEwvW3eLklILxynAHLzASPz2UZxlMGph6-6X
    E5YVhLD_1jyJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvtddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegfhffvufffkfggtgesthdtredttd
    ertdenucfhrhhomhepvfgrshhsihhlohcujfhorhhnuceothhsughhsehgnhhurdhorhhg
    qeenucggtffrrghtthgvrhhnpeeltefgteeklefgtdevleekgedugefgheefkefgveefud
    euudeitdfhtdduieehieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeeg
    iedrkedtrdejhedrvdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehthhhorhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithih
    qdekieejfeekjeekgedqieefhedvleekqdhtshguhheppehgnhhurdhorhhgsehfrghsth
    hmrghilhdrfhhm
X-ME-Proxy: <xmx:iiRKYBCwfX9Tprbe4EXOIU7Ec7C9bhsus1sE7gk6UVcjaQBuzwUS_Q>
    <xmx:iiRKYL1DHSVhsBETVMuvNfPjRJolJ8XH6lJbIWuARXM8YmIRYHwK8Q>
    <xmx:iiRKYPWujH8YWH0ZmJwDTWwu2Zt-WCAY-fZ-IrNIklT4dknZVSD36g>
    <xmx:iiRKYML5pqcNtb0zyd2E0KyYw2D_Ueuv7vT1W_xClxKoNgqdmJGSH23hjwo>
Received: from thinkpad-t440p (p2e504be7.dip0.t-ipconnect.de [46.80.75.231])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E9231080068
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:09:13 -0500 (EST)
User-agent: mu4e 1.5.9; emacs 28.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     git@vger.kernel.org
Subject: [Bug] Stashing during merge loses MERGING state
Date:   Thu, 11 Mar 2021 15:00:58 +0100
Message-ID: <875z1xwznd.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I did a large merge, resolved the conflicts but still had compile
errors.  In order to check how stuff has worked before the merge, I
stashed all changes, and eventually popped the stash.  Then the MERGING
state was gone and committing created a single-parent commit rather than
a merge commit with two parents.  I was lucky to see that before
pushing, so all is good.

Here is a simple recipe with a publicly available repo:

```sh
git clone https://github.com/magit/magit.git
# Current master is 4735b9254105eb7dd538f979d8b4c6ab96b827b9
cd magit
git merge origin/km/reshelve-rewrite # currently 0073bff21c826a57a4b48076074bdbba092d4b67
# Conflict in magit-extras.el
git add lisp/magit-extras.el
git stash
# The MERGING state is gone
git stash pop
# And it won't come back, so when I commit now, my "merge" has just
# one parent.
```

What did you expect to happen? (Expected behavior)

I expected that stashing during a merge will keep the MERGING state.
Or that popping the stash again would also restore the MERGING state.

What happened instead? (Actual behavior)

The MERGING state is lost.

What's different between what you expected and what actually happened?

I've lost the MERGING state, thus committing results in a one-parent
commit rather than a 2-parent merge commit.

Anything else you want to add:

In my original situation, I've copied the working tree to /tmp, resetted
to origin/master, re-initiated the merge, copied the modified files from
the /tmp backup, staged the changes, committed, and pushed.

I wonder if there would have been a better approach to come from the
"accidentally having a single-parent commit containing all merged and
resolution changes" state to a proper merge commit state.  In the end,
the tree was correct, just the second parent to the commit on the merged
branch was missing.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.11.4-arch1-1 #1 SMP PREEMPT Sun, 07 Mar 2021 18:00:49 +0000 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /usr/bin/fish


[Enabled Hooks]
