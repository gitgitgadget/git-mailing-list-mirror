Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D22C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 01:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245275AbiBPBH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:07:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbiBPBHx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:53 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93D9C7916
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 17:07:36 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42E87129920;
        Tue, 15 Feb 2022 20:07:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PmTfDNDVtYQmX6kwu7a7CQVCJ5vk3bfowfADYz
        zjcL8=; b=k/QkNjyyTjFiaL2Z60qURqYdrT6B3BHGHG6wFZtYmT9injKJGMoTdC
        aCn2JtIpH7ubxds6YXAWnmBLfXtHyZO5yy4OtFi2MoHasj4r/Spd+OveqCKU04VC
        4fjEY7zeC2krl+9dtAuayFSQ/wIBfRv1+qdiyiJLandrc5qJFN6/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 386C012991F;
        Tue, 15 Feb 2022 20:07:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 845C612991E;
        Tue, 15 Feb 2022 20:07:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH 5/7] sparse-checkout: reject non-cone-mode patterns
 starting with a '#'
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
        <265cbe36b2df5a9a076877fe3ddc3880a64a9217.1644712798.git.gitgitgadget@gmail.com>
        <xmqqsfsl2utb.fsf@gitster.g>
        <CABPp-BEhsp4=dzCkSpyu4Bd7Q=hP1Ec6W09-zX2+N+5_-ytk8A@mail.gmail.com>
Date:   Tue, 15 Feb 2022 17:07:34 -0800
In-Reply-To: <CABPp-BEhsp4=dzCkSpyu4Bd7Q=hP1Ec6W09-zX2+N+5_-ytk8A@mail.gmail.com>
        (Elijah Newren's message of "Mon, 14 Feb 2022 20:31:00 -0800")
Message-ID: <xmqqr183y5yh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D38CF874-8EC4-11EC-BD2B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> If this were the only special character case, I'd totally agree, but I
> do worry a bit that escaping this particular case might lead users to
> expect us to escape and fix other special characters from '*?[]!\'.

Sorry, but I do not quite get why it is a problem.  I understand
that the idea behind this "rejection" is that "#" is special only
when it appears in files (as comment introducer) and must be
prefixed with "\", right?

Do any of the wildcard characters mean different things depending on
where they appear?  Isn't '*' a wildcard to match 0-or-more-bytes
whether it appears in files or on the command line, and need to
prefixed with "\" to make it non-special regardless of where it is
found?

> If users have files with those characters and specify an argument with
> one of those, are we to automatically escape them as well?  If we
> don't escape the other characters but do escape '#', aren't we being
> inconsistent?

I do not quite get where you are seeing an inconsistency.  Do you
mean that it is inconsistent that "# comment" is only allowed in
files but not on the command line?  If so, a way to make it
consistent may be to allow "# comment" even from the command line
;-)
