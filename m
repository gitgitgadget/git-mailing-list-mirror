Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121DBC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 21:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDAVbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 17:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAVbM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 17:31:12 -0400
X-Greylist: delayed 2446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Apr 2023 14:31:05 PDT
Received: from pulsar.hadrons.org (2.152.192.238.dyn.user.ono.com [2.152.192.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1722B0E4
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hadrons.org
        ; s=201908; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:From:Reply-To:Subject:Cc:Content-ID:Content-Description:
        In-Reply-To:References:X-Debbugs-Cc;
        bh=ETlUwqOfJtzggNF6vImy1akm49HP0OsYzo2yW5O+rOk=; b=V6gXjR/kg82CM2S3EyJctdCcvT
        btaNWgb+kLsbuODE06CAAG9kCgTZOczkWJuj4sLL/qnuP7eE+n+UmJyMmqhjMbuFIo3IRqx5mVd67
        GEUZoQyU0X+cHQWnNkGJOxfcTLyQRO448Nx/EUQCBY0BZvX+RVUgn4GIphh2T8S70+BgTE7pi6/Qu
        XVzWNoqz24oFbeexPzwwb89EqZ5MTVkpwZ3D8HqpEH/7nJwRRMvA134YsCI6rbCMj2Ea7jscGSpAi
        Os+zEZjFJF7k5yQYk0vEyIrtypyTobfmyEX/cQCglA59i7k67gQI3HidoWyg6vi7qVHp1nuJ99npV
        oGZYd53g==;
Received: from guillem by pulsar.hadrons.org with local (Exim 4.96)
        (envelope-from <guillem@hadrons.org>)
        id 1piiAz-0007u3-0W
        for git@vger.kernel.org;
        Sat, 01 Apr 2023 22:50:17 +0200
Date:   Sat, 1 Apr 2023 22:50:16 +0200
From:   Guillem Jover <guillem@hadrons.org>
To:     git@vger.kernel.org
Subject: Add a way to disable =?utf-8?Q?=C2=ABgit_c?= =?utf-8?B?bGVhbsK7?=
 per repo
Message-ID: <ZCiZCM+AAUnjp4Ml@thunder.hadrons.org>
Mail-Followup-To: Guillem Jover <guillem@hadrons.org>, git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

[ I initially filed this in the Debian bug tracking system as it
  seemed to me that filing a feature request on a mailing list had
  a great potential to get lost. But I guess I can try anyway. :) ]

For repositories that are not tracking code, say when storing your ~/
under git, or to store say collections of data files such as photos,
texts or similar, you might end up using .gitignore to unclutter
«git status». The problem is that both ignored and non-ignored
untracked files can be “precious”, as in not version-tracked by losing
them might imply data loss.

Accidentally running «git clean -xdf» or «git clean -Xdf» might be
catastrophic there. But for the ~/ case (or any such tracking in a
parent of git trees, this is even worse, as an accidental «cd» too
much while in some code repo might end up accidentally recursively
running those «git clean» on an unexpected working tree and all of
its subdirectories (except for other git working trees).

I tend to be rather careful with this, but I recently had a scare
where this happened to me, and lost a few (not essential) files before
I noticed and Ctrl-C'd git. I then set out to try to disable git clean
on these situations, but I see no way to do that as aliases do not work
with built-ins, and adding a ~/bin/git wrapper to check for this seems
extremely cumbersome.

It would thus be nice if there was an option that could be set to
completely disable «git clean» on a repo. I guess it might make sense
to disable for any untracked file, or perhaps for ignored and/or
non-ignored. So that these kind of work trees could be protected.

Thanks,
Guillem
