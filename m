Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBBBC19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 16:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiHBQQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiHBQPr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 12:15:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5188558E2
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 09:13:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FE60142B5B;
        Tue,  2 Aug 2022 12:12:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6ydJAsZ/6WQQGFtFuVrhX1tOrGez+u25bDIr2v
        IcwWI=; b=R+oMfu9LVTmy1PS2d3UJCbcAq/2IAdiTU5N6Dkam+Gt0UzQ7zr+2C8
        uTWTB18b2z1JklQTnS/UVQN7Kl5MZpOZjhT/zwUp9bUF1+HFTTHQUpyW8hYmY9Ka
        2XCSf2tvkIRVfh2/o6wsYgKSbGPUE1gVYRHoHOFSQ4ViHRX2HfBhQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37D5D142B5A;
        Tue,  2 Aug 2022 12:12:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 835A0142B59;
        Tue,  2 Aug 2022 12:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas MAFFRE <nicolas.maffre.external@airbus.com>
Cc:     git@vger.kernel.org
Subject: Re: Git v2.20.1 EOS date
References: <CAHWqpUPVAvw5bsvS1DgAQDwxhzYmh6_V=r+TfPxekdy-oMZWmg@mail.gmail.com>
Date:   Tue, 02 Aug 2022 09:12:56 -0700
In-Reply-To: <CAHWqpUPVAvw5bsvS1DgAQDwxhzYmh6_V=r+TfPxekdy-oMZWmg@mail.gmail.com>
        (Nicolas MAFFRE's message of "Tue, 2 Aug 2022 10:34:13 +0200")
Message-ID: <xmqqa68mhbef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8F7994C-127D-11ED-A595-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas MAFFRE <nicolas.maffre.external@airbus.com> writes:

> I'm working on a project that uses Git v2.20.1 and I need to know
> if there is an "End of support" date for this version of the software Git ?

As we clearly describe in our COPYING document, there is no warranty
as far as the project is concerned, so "End of support" is a foreign
concent on this list.

When a bug is found, we try to fix it in a way that can be merged to
the oldest released version with the bug, but we do not usually do
the backporting ourselves all the way down to an ancient version.

 * For a normal bug that does not require an embargoed security fix,
   we apply a fix to the tip of the tree that is preparing for the
   next feature release, and we often apply the same fix to the
   maintenance track for the most recent feature release (as of
   today, the 'master' branch is working towards 2.38, and the most
   recent maintenance track is 2.37.x) ourselves and cut a
   maintenance release (the last one was 2.37.1 so a follow-up
   maintenance release might be 2.37.2).  But the maintenance track
   older by two generations or more are usually untouched.

 * For a security sensitive bug, members of a separate security
   mailing list works behind closed doors to assess the issue to
   decide which maintenance tracks should receive a fix, prepare the
   fixes for them and propagate up to the tip of the tree.  The cut
   off point depends on the severity of the bug, but typically the
   shelf life of a Git release is less than roughly 3 years since
   the first feature release of the track.  E.g. Git 2.30.0 was
   released on 2020-12-27, and the maintenance track 2.30.x did get
   the most recent security update, but the maintenance track 2.29.x
   (2.29.0 was on 2020-10-19) and older did not.

A bugfix patch (e.g. the changes found by "git log v2.36.0..v2.36.2"
are the fixes we made after we started working toward 2.37 or later
and applied to 2.36.x maintenance track) can often be cherry-picked
to older maintenance tracks [*], because the fixes are often
designed that way, but as explained above, we usually do not do the
cherry-picking ourselves.  You'd just need to do that work or pay
somebody else to do that for you, if you are not "following along"
with the most recent releases.

But the distributor of your operating system may offer extended
support.  I do not recall 2.20 being of any significance, so I do
not see why any distributor find a particular interest in giving it
a long term support, as opposed to picking say 2.19 or 2.23, though.


[Footnote]

 * Sometimes a fix to an issue that originates in ancient version
   may only be applicable to reasonably new versions, as the code
   evolves and we may do things in morally-equivalent-but-different
   ways.  I as the maintainer try to rein our developers in before
   they make changes that are not necessary "while at it" to
   minimize such code drift, but I am not always successful.
