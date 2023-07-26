Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB42DC0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 17:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjGZR3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjGZR3O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 13:29:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3B31BC1
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 10:29:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D1FA192680;
        Wed, 26 Jul 2023 13:29:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vecDv1V82uBGegcyuXVuvgcHIgtzJZvVStveEj
        YKgbQ=; b=LsDo4kOOYvy+jEHrA3ovm9pyUo2q5c7Eof1j8IDzjBNDmC0Tl3kwtP
        30zMgJCRbNd3SaR+U8WIvvc5eD1UsYeAxCeX5dIzz1XyEwxqvgckdFjcCTvhXZNR
        R+Y8C49oI1O9vcYpACEP0e6PMyuX1RYjQyyHuWfJlca6LZpOiGavs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3640819267F;
        Wed, 26 Jul 2023 13:29:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCD1419267E;
        Wed, 26 Jul 2023 13:29:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri <yuri@tsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push -- {dir}' puts files in stash that are outside
 of {dir}
References: <5fce9c4f-0ea7-9393-4a30-ddd66946661d@tsoft.com>
Date:   Wed, 26 Jul 2023 10:29:09 -0700
In-Reply-To: <5fce9c4f-0ea7-9393-4a30-ddd66946661d@tsoft.com>
        (yuri@tsoft.com's message of "Wed, 26 Jul 2023 10:05:04 -0700")
Message-ID: <xmqqsf9ad1ju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEC00952-2BD9-11EE-9DE9-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri <yuri@tsoft.com> writes:

> I am in the FreeBSD ports repository.
>
> I run this command:
>
> $ git stash push -m "gh-print-tuple" -- Mk
>
> But then 'git show' shows that the top stash entry also has other files:
>
> $ git stash show -p stash@{0} | grep diff

Not offering a solution, as a quick test or two in my environment do
not reproduce this problem [*].  But instead of the above command,
which will show matches on any line that has "diff" in the "-p"
output, perhaps

    $ git stash show --stat

is easier to see?

Are there configuration variables set to affect the behaviour of the
"git stash" command in your environment that I do not have (I have
nothing in "git config -l | grep stash" output), which may be
affecting why it does not reproduce for me?

> Why do files that are not under Mk get into stash?


[Footnote]

* Admittedly I didn't recall we had pathspec support to "git stash
  push" so consider me no longer an expert in this area ;-).
