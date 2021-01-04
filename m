Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DB2C433E6
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6052255F
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbhADXrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:47:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58341 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbhADXry (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:47:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21B0C1014F1;
        Mon,  4 Jan 2021 18:47:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=7TtY4Zu6p5q6UBOsQD84qm5BP7o=; b=YlBAC/bSX4kCgUM49fom
        ZdcUYjfrhCkymjpLNwxJiOgsnrR3BZBy9lKZSW1mlmFo9yltn1anSepMioywapju
        nfBKtpiRSBbyUrRR9uFRNfWU4Q+RTF8/wDhxqqvA6bwq8ku3ayV+5fhydQZfdl3p
        bPaBMUlrp02qUngkMlOCTJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=pWIWJu/7R2FFqUmMkSx9QIvlwG/Ud6CdNh4Ltco8capgxx
        dFPtgKAm2ldmD0yRIu6LT3mb9eIZI/PWM4oDMnB6B/F5WW47YVzkfXcUhM40BCOB
        44/SZ7Uf6O1Clug0eQsWnWKgXiFAiN6ZHx4W0Gk6SsJG/eaxGk+AXjGz1QrTw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 199F51014EF;
        Mon,  4 Jan 2021 18:47:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46CC21014EE;
        Mon,  4 Jan 2021 18:47:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Nikitenko <metst13@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: git-dir requires work-tree; documentation improvements for
 working directory
References: <CA+RLzGCtp2T=8DG74geBs67X5vUvhwRP4FMZ6MJv+E+Pj=YbWw@mail.gmail.com>
        <5ff0c58422038_90dc208ea@natae.notmuch>
        <CA+RLzGArUrxC-Kbng3qGpRZUrZXKZj3zD3Hcut=XrUY-i-eYAw@mail.gmail.com>
Date:   Mon, 04 Jan 2021 15:47:06 -0800
Message-ID: <xmqqmtxo464l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28292DEA-4EE7-11EB-B710-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Nikitenko <metst13@gmail.com> writes:

> It starts to work when I remove my .cfg/config. I've no idea why it
> happens. Here is its contents:
>
> $ more .cfg/config
> [core]
> 	repositoryformatversion = 0
> 	filemode = true
> 	bare = true

As Felipe notes downthread, with "core.bare=true", the repository is
telling Git that it does not have a worktree.  The "assume that $CWD
is the top of the worktree" default would have no room to kick in.

With --worktree=<there> option or GIT_WORK_TREE environment
variable, you can tell Git to pretend that there is a worktree there
at the specified location.  Or perhaps "git -c core.bare=false", you
may be able to force the "assume that $CWD is the top of the worktree"
default to kick in.

"git help git" has this in --git-dir=<path>

    Specifying the location of the ".git" directory using this
    option (or `GIT_DIR` environment variable) turns off the
    repository discovery that tries to find a directory with
    ".git" subdirectory (which is how the repository and the
    top-level of the working tree are discovered), and tells Git
    that you are at the top level of the working tree.  If you
    are not at the top-level directory of the working tree, you
    should tell Git where the top-level of the working tree is,
    with the `--work-tree=<path>` option (or `GIT_WORK_TREE`
    environment variable)

but apparently the description forgets that there are repositories
with core.bare explicitly set to true.  There is a room for doc
improvement here.

Perhaps something like this?

 Documentation/git.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git c/Documentation/git.txt w/Documentation/git.txt
index c463b937a8..6f8225e3ef 100644
--- c/Documentation/git.txt
+++ w/Documentation/git.txt
@@ -118,12 +118,15 @@ Specifying the location of the ".git" directory using this
 option (or `GIT_DIR` environment variable) turns off the
 repository discovery that tries to find a directory with
 ".git" subdirectory (which is how the repository and the
-top-level of the working tree are discovered), and tells Git
-that you are at the top level of the working tree.  If you
-are not at the top-level directory of the working tree, you
-should tell Git where the top-level of the working tree is,
+top-level of the working tree are discovered), and if the
+repository has a working tree, i.e. `core.bare` is `false`,
+tells Git that you are at the top level of the working tree. If you
+are not at the top-level directory of the working tree, or
+if `core.bare` is set to `true` and you are trying to pretend
+there is a working tree associated with the repository, you
+can tell Git where the top-level of the working tree is,
 with the `--work-tree=<path>` option (or `GIT_WORK_TREE`
-environment variable)
+environment variable).
 +
 If you just want to run git as if it was started in `<path>` then use
 `git -C <path>`.
