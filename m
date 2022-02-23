Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79683C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 19:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244475AbiBWTkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 14:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbiBWTkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 14:40:12 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91D848E6A
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 11:39:44 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C494102357;
        Wed, 23 Feb 2022 14:39:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mnsCv7nIaSCMDD4/wcGrlqLbUgBJgIkJg43qp4
        URRaU=; b=BOgFW5F6SAE7PqNw7U1v1iD81PUIYiBFwHmhs2TOvAoqj+ivpxx6vY
        Lo9EqpjGm7IrW24RhkmfmbAK0Lq+Kz92PhYWSZzBGP9vIftZJM0lrh/wpfe8kHXX
        UgmFR7pIqzqKUG59mgJGh4rTnC3E+91pKSG/VQgKa9IT6h64LsTvE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60F73102356;
        Wed, 23 Feb 2022 14:39:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4C7C102355;
        Wed, 23 Feb 2022 14:39:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: en/present-despite-skipped (Re: What's cooking in git.git (Feb
 2022, #05; Thu, 17))
References: <xmqqley93rkw.fsf@gitster.g> <YhBNgUFnujFGVcRo@google.com>
        <YhV3KruSTFYEDBAO@google.com>
Date:   Wed, 23 Feb 2022 11:39:40 -0800
In-Reply-To: <YhV3KruSTFYEDBAO@google.com> (Jonathan Nieder's message of "Tue,
        22 Feb 2022 15:52:10 -0800")
Message-ID: <xmqqo82xv0cj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5864B9D0-94E0-11EC-92E9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>>  Will merge to 'master'.
>>>  cf. <20220204081336.3194538-1-newren@gmail.com>
>>>  source: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
>>
>> I'd recommend holding off on merging to 'master' for now, until we
>> figure out what to do about
>> https://lore.kernel.org/git/YhBCsg2DCEd9FXjE@google.com/. Hopefully that
>> won't take long.
>
> Since as discussed there this isn't a regression for existing users of
> git 'master', I see no reason to hold off on merging to 'master'.

I think I've read on what people said on this topic for the past few
days while I was away.

I do not quite follow the above, though.

Does the logic go like this?

 - Earlier you worried that VFS for Git and similar that have been
   working happily with vanilla Git would break with this series;

 - It turns out that VFS for Git comes with its own version of Git
   that does not have this series;

 - Hence we can do whatever we like to vanilla Git, and it won't
   immediately hurt.

The config knob to tell the sparse logic that it is OK if lstat()
tells us that there appears files that ought to be missing from the
filesystem due to sparse settings would be needed and that is why
you sent an updated proposal patch in separate thread, right?

Shouldn't we iron out the details of that knob and release the topic
with that knob at the same time?  If Microsoft folks already have an
existing knob to tweak the behaviour of sparse checkout to work better
in vfs environment where lstat() lies, and if the necessary adjustment
is wider than just the issue the sparse.expectFilesOutsideOfPatterns
solves, I wonder if we should take the approach to align with their
forked version of Git by matching the name and the behaviour of the
knob somehow.

Thanks.

