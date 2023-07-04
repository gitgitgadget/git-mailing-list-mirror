Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45E0EB64D9
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 21:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGDVoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 17:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGDVoR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 17:44:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B66BE54
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 14:44:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF5EC2AED7;
        Tue,  4 Jul 2023 17:44:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iC7hy7x0+qXz2G6xdwyz8hR402owLZaLhapxWX
        8xdvc=; b=mDtnWDbgObSq9EZte40bv/HcjVZEX0xGdeR2OEJ/sz0zk+XzEUxznC
        kgmAAjx95SPrLAkSTNANp4bkGXI8HQVxJDVr+CHvKkUpKUdcATO7Y+TVE2Opo/I9
        Sx9vQ8SwjKTGubT/TOhj4LXKFftLIORYcui3uE329hvKxWIOT9+Sk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E76FC2AED6;
        Tue,  4 Jul 2023 17:44:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4BBD02AED5;
        Tue,  4 Jul 2023 17:44:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        git@matthieu-moy.fr, christiwald@gmail.com, john@keeping.me.uk,
        philipoakley@iee.email
Subject: Re: [PATCH 0/2] advise about force-pushing as an alternative to
 reconciliation
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
        <c3c36f93-3fc5-7f7d-1c24-e6925729cc96@gmail.com>
Date:   Tue, 04 Jul 2023 14:44:08 -0700
In-Reply-To: <c3c36f93-3fc5-7f7d-1c24-e6925729cc96@gmail.com> (Phillip Wood's
        message of "Mon, 3 Jul 2023 16:33:02 +0100")
Message-ID: <xmqqv8ez4ajb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8439BCA-1AB3-11EE-A15D-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Alex
>
> On 02/07/2023 21:08, Alex Henrie wrote:
>> Many times now, I have seen novices do the following:
>> 1. Start work on their own personal topic branch
>> 2. Push the branch to origin

And did this succeed, or did this fail?  I'd assume that it failed,
because othrewise you would not be rebasing your work done in #1 on
top of what the central repository has.  Also ...

>> 3. Rebase the branch onto origin/master

... the user's better have done "git fetch" to update origin/master
before this step.  And that means this can just be done with "git
pull --rebase" (or you may already have configured pull to do so).

In any case, assuming that this was indeed the intention of the
user, i.e. the user never wanted to discard the changes made in the
central repository (presumably by others)...

>> 4. Try to push again, but Git says they need to pull

... if this happened, it is because somebody else pushed in the
meantime, right?  Then ...

>> 5. Pull and make a mess trying to reconcile the older topic branch with
>>     the rebased topic branch

... this means that somebody else's work was something that
overlapped with what you did in #1, and then you do want to clean up
the mess carefully, so that you do not lose the work by that
somebody else.  So ...

>> Help avoid this mistake by giving advice that mentions
>> force-pushing,

... why would it possibly be a good idea to suggest force pushing,
which discards other's work?  I do not quite understand.

> I don't think we want to be advising users to force push. For the case
> you mention above I think it would be much safer to advise them to use
>
> 	git push --force-if-includes
>
> In the absence of background fetches even
>
> 	git push --force-with-lease
>
> is still safer than
>
> 	git push --force

Absolutely.  git push --force-with-lease=$(git merge-base HEAD origin/master)
or something, perhaps, would be even better.

Thanks.
