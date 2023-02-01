Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755DDC636D4
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 18:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBAS4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 13:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBAS4r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 13:56:47 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F099B7CCB5
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 10:56:44 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 311IuRTs006244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 13:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675277792; bh=CmRccYcJvTlxXx6mqChaeg0P0EXRTp0wfH86+4WSYbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HmPaZ4ULREE0VuJxGZIgwzh2+iuTv62NLsQAlialyMuchHkbHSviAadSUJ8h70KQf
         +AOXb9yKPXF7uVIOyBM5Fk4nxwcUcwPVOQZ0JQArSebS73fHlIPIt337MGhaR8YySe
         m/Zzky75ODJD4vj56Jox+z6lbVMBSz5GF9HJUsgRh4UNxI1Ea0eBNwewdiQsUOR4IV
         U40a3m4nqedFduPaTPzjTwKVAJHFJ1+p9c6jQuQ5jQYUa5s42jYs65/4rx/DjlwvG3
         a7AzW5RU0OW7wdVhlizDXUT9rXLtqnfM02AuZRxu8HofHlqueed4YEnlhcmE3SWmLA
         EOedJvoBqAiCA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CD8A715C359D; Wed,  1 Feb 2023 13:56:27 -0500 (EST)
Date:   Wed, 1 Feb 2023 13:56:27 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     demerphq <demerphq@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <Y9q129WbseimgeBS@mit.edu>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
 <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
 <CANgJU+V0QRFwmTh8ZzY=28kmbUw=DvSLE24LioOXp6_ozq+RdA@mail.gmail.com>
 <20230201122152.GJ19419@kitsune.suse.cz>
 <CANgJU+VLseURimM++38WA81uFPbnoHiToOt4F4UFL9yVbQpBEw@mail.gmail.com>
 <230201.86cz6tqyvy.gmgdl@evledraar.gmail.com>
 <CANgJU+VNY-VziRijSwyb1WF9s31hKroK+2VJ0qEGiYweiA59Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgJU+VNY-VziRijSwyb1WF9s31hKroK+2VJ0qEGiYweiA59Ug@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the goal is stable tar.gz files, Debian has a very nice soution
called pristine-tar[1].  This you to store a tar.gz image which in a
very efficient way, by leveraging the objects in the git repository.

[1] https://manpages.debian.org/unstable/pristine-tar/pristine-tar.1.en.html

The data is stored on the pristine-tar branch, and is quite efficient:

% git show --stat pristine-tar
commit 56dded989c9e0c852b8af9ae72ffe94270bfd34a (origin/pristine-tar, github/pristine-tar, pristine-tar)
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Dec 30 01:06:13 2021 -0500

    pristine-tar data for e2fsprogs_1.46.5.orig.tar.gz

 e2fsprogs_1.46.5.orig.tar.gz.asc   |  11 +++++++++++
 e2fsprogs_1.46.5.orig.tar.gz.delta | Bin 0 -> 59034 bytes
 e2fsprogs_1.46.5.orig.tar.gz.id    |   1 +
 3 files changed, 12 insertions(+)

And this allows me to reproduce the original tar.gz file, along with a
GPG signature file, which is about 9 megabytes.  The *.id file
contains the git commit from which the tar file was generated, and
this is what allows the *.delta file to be as small as it is.

% pristine-tar checkout e2fsprogs_1.46.5.orig.tar.gz -s e2fsprogs_1.46.5.orig.tar.gz.asc
pristine-tar: successfully generated e2fsprogs_1.46.5.orig.tar.gz
pristine-tar: successfully generated e2fsprogs_1.46.5.orig.tar.gz.asc

% ls -sh e2fsprogs_1.46.5.orig.tar.gz*
9.1M e2fsprogs_1.46.5.orig.tar.gz  4.0K e2fsprogs_1.46.5.orig.tar.gz.asc

% gpg e2fsprogs_1.46.5.orig.tar.gz.asc
gpg: WARNING: no command supplied.  Trying to guess what you mean ...
gpg: assuming signed data in 'e2fsprogs_1.46.5.orig.tar.gz'
gpg: Signature made Thu 30 Dec 2021 01:02:52 AM EST
gpg:                using RSA key 2B69B954DBFE0879288137C9F2F95956950D81A3
gpg: Good signature from "Theodore Ts'o <tytso@mit.edu>" [ultimate]
gpg:                 aka "Theodore Ts'o <tytso@debian.org>" [ultimate]
gpg:                 aka "Theodore Ts'o <tytso@google.com>" [ultimate]
Primary key fingerprint: 3AB0 57B7 E78D 945C 8C55  91FB D36F 769B C118 04F0
     Subkey fingerprint: 2B69 B954 DBFE 0879 2881  37C9 F2F9 5956 950D 81A3

This is currently a Debian special, and while its functionality was
designed to work well with Debian packaging workflows, but it's a
general tool that could be used in multiple contexts, not just for
Debian packaging.

If I recall correctly, pristine-tar is currently in maintenance mode,
and I suspect if someone was interested in investing time into making
pristine-tar more portable to other OS's, including MacOS and Windows,
and maybe potentially even integrating into git directly, the current
maintainer of pristine-tar might be quite happy to let other people
give the code more TLC.

						- Ted
