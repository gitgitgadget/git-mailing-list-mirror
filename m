Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB1C388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 16:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3CA24630
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 16:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FMAIbobK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898268AbgJVQwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 12:52:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65313 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898098AbgJVQwx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 12:52:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98AFFED447;
        Thu, 22 Oct 2020 12:52:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=okyGUoF/qZGLnfU2sWGLtDrJsxE=; b=FMAIbo
        bK2Tc71vWgR8d9Uc1jySYCY6diGwO8lNAMLI5yCgLRKbSYa2WRpZLvRbP4gtssAU
        owbgWZWjUaSn1oZSz+tyEYILAAg3cMR810A8Lt5tHIJeeUOMl168pSVYSeHzR5tq
        gsE6vg0Kbh6uaBj3agayVRfxu194bZd6mW1nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p+CJ2KJNpdQiM1Tycw4LThqLNQCNUUsf
        Q5CJXcMbA9dZdmPBt3klqqQJxqp6JC/a03QFnK6q5bNhbfX3ZfzZqbJBtwEQr+rU
        /drFRia5/fupcjfzufskocJabX2xuKZUH7P8bxHQbuZ1n3yHdGQhxMCziNI7+rJP
        ObRT/v+lF1o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91E57ED445;
        Thu, 22 Oct 2020 12:52:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5FCBED444;
        Thu, 22 Oct 2020 12:52:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sangeeta <sangunb09@gmail.com>
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
        <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
        <20201021162044.GB111581@nand.local>
        <xmqqr1pr73ve.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010221047550.56@tvgsbejvaqbjf.bet>
        <cfe33eef-974d-8ff9-ebb4-d1153abd497c@gmail.com>
Date:   Thu, 22 Oct 2020 09:52:44 -0700
In-Reply-To: <cfe33eef-974d-8ff9-ebb4-d1153abd497c@gmail.com> (Phillip Wood's
        message of "Thu, 22 Oct 2020 10:46:56 +0100")
Message-ID: <xmqq7drinqxv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 025B6690-1487-11EB-A0BD-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think both bisect and rebase should be documented as running
> commands from the repository root as this is what rebase does and it
> gets around the missing directory problem.
>
> I'm not sure rebase is doing the right thing with a relative path
> though. My feeling is it would be less suprising to resolve relative 
> paths to the directory where the bisect/rebase is started and store
> the absolute path. The script may disappear while rebasing but that
> can happen now if the user points us to a script in a directory that 
> disappears while we're rebasing

If a step in the rebase sequence makes a directory disappear (or
turns a directory into a file), and the command given by -x is in
the directory (it is immaterial if it is given as relative or full
pathname from the command line), hopefully the step of the rebase
sequence that would lose the directory would error out, in order to
prevent an untracked but not ignored file from getting clobbered.

Even before speculating such an "advanced" mode of operation, do we
know that rebasing a history that makes a directory disappear and
reappear work?

For example, if there is a history like this:

    - commit #0: an empty tree
    - commit #1: adds a file D/F
    - commit #2: moves the file D/F to F (i.e. the toplevel)
    - commit #3: moves the file F to D (i.e. D becomes a file)
    - commit #4: moves the file D to E
    - commit #5: moves the file E to D/E (i.e. D becomes a directory again)

does it do what expect it to do if we replay the history c0..c5 on
top of a comit that records an empty tree if we start the rebase
in an empty directory D?

Here is what I tried in an empty directory, and the last "ls -la"
shows an empty directory, even if you try "ls -la D" from a separate
shell after everything is done, you'd see a file D/E there.  If a
platform exists that does not allow removing a directory that is the
$cwd of any process, I would not be surprised if the whole thing
failed in a mysterious (to the end user) way.

#!/bin/sh
test -d .git && exit ;# safety
rm -fr D E F
git init

git commit --allow-empty -m 'an empty tree'
git tag commit0

mkdir D && >D/F && git add D/F
git commit -m 'add a file D/F'

git mv D/F F && git commit -m 'move D/F to F'
rm -rf D

git mv F D && git commit -m 'move F to D'

git mv D E && git commit -m 'move D to E'

mkdir D && git mv E D/E && git commit -m 'move E to D/E'

git tag commit5

echo history made

git checkout --orphan rebuilt
git rm -r -f .
git commit --allow-empty -m 'another empty tree'

mkdir D
cd D

git rebase --onto HEAD commit0 commit5^0
ls -la
