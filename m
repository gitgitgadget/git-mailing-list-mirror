Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47A6C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 17:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiG1Rop (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 13:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiG1Roo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 13:44:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F5F74CC3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 10:44:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24F05197C81;
        Thu, 28 Jul 2022 13:44:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=zunAqVFPTjiZ2gEIsyTRhr2cYOlsvLGi85LRn8SHulg=; b=yc7F
        2qWXgxJD4I1k6eRKfri5o/cRenzwnOfNoTYDqtD7si924DfHzgb3ORvGKvjq2gjA
        oqQs5wxgN6SpPswkTI9FyBaP10ks03NqEY0QVzRS6OPIbKz1rjScKQWETKxEKj46
        0pGsVy0Ln0dJmcpHcswIyAeiYm/VukxtDG5zsWo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10072197C80;
        Thu, 28 Jul 2022 13:44:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6B62A197C7E;
        Thu, 28 Jul 2022 13:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Justin Donnelly <justinrdonnelly@gmail.com>
Cc:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-prompt: show 'CONFLICT' indicator at command prompt
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>
        <xmqq35ems49j.fsf@gitster.g>
        <CAGTqyRzfeh4HLbXUCb3Zv=bWNoBmvBU5QB=N2g2d0=y+NEToag@mail.gmail.com>
Date:   Thu, 28 Jul 2022 10:44:38 -0700
Message-ID: <xmqqpmhpb08p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F44A4438-0E9C-11ED-95D0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Justin Donnelly <justinrdonnelly@gmail.com> writes:

>> It is unusual to subject our unsuspecting users to new features in a
>> way that is done by this patch.  A more usual practice, I think, is
>> to tell the users that they can set GIT_PS1_INCLUDECONFLICTSTATE to
>> "yes" if they want to opt in, and trigger the new feature only to
>> them.  Later, we may decide that the feature is useful and widely
>> apprlicable enough, at which time it may be turned on by default and
>> tell the users to set GIT_PS1_INCLUDECONFLICTSTATE to "no" if they
>> do not want to see it.  But one step at a time.
>>
>
> I see that most of the state indicators are disabled by default, so it
> makes sense to be consistent. Should I make a variable with 'yes'/'no'
> values, or set/unset? 'yes'/'no' has the benefit that if the default
> is later changed, existing setups will continue to work. Set/unset
> makes it harder to change the default later ...

As you said, "an environment variable that is set triggers the
feature" is harder to transition.  Starting from a clear Boolean is
probably easy to see what is going on, and that is why I suggested
doing that way.  

Ones that are "if set, enabled" can be corrected later when needed,
e.g. GIT_PS1_FROTZ may enable the feature FROTZ when the environment
is set, but when we introduce two or more ways to do FROTZ thing
(e.g. in addition to always do FROTZ, which may be the original
design of "an environment that is set triggers the feature", we may
add "automatically enable FROTZ only under this and that
condition"), we may say "when set to 'auto', do the auto-FROTZ, and
when set to 'yes', do FROTZ as we have always done.  When set to any
other value, warn and then do FROTZ").  But let's leave them outside
the scope of the topic.

