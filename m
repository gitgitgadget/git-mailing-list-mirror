Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB10AC433EF
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 18:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbiAISc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jan 2022 13:32:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58107 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbiAIScZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jan 2022 13:32:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6104917D8A1;
        Sun,  9 Jan 2022 13:32:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BOqpOLJtBBI0wzFKh+uKnhYE5fqv2nonjw8NM6
        FBsGI=; b=LfpJIUSWEOUb8JSkKWYiq7xAq3mjHgW7kzu7omCtiAK3JufgBWw/NU
        jz4tvjjjXV1ihrawGuLFWPBhYUfVt/+irRso/BR+u/wo/A5EDE1GtkKJldBIeHvs
        Hb7plsxxIYKD6YFZJEfkHiQfOnOQw9ANRCmL94ju64v3dEeeMGLsA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 599A517D8A0;
        Sun,  9 Jan 2022 13:32:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C3A8517D89F;
        Sun,  9 Jan 2022 13:32:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Issam Maghni via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Issam Maghni <issam.e.maghni@mailbox.org>
Subject: Re: [PATCH] hook: test -a|o is not POSIX
References: <pull.1172.git.git.1641528221530.gitgitgadget@gmail.com>
        <9c7aeb5b-87b2-a51e-c08d-8dfc75ecf588@gmail.com>
Date:   Sun, 09 Jan 2022 10:32:21 -0800
In-Reply-To: <9c7aeb5b-87b2-a51e-c08d-8dfc75ecf588@gmail.com> (Bagas Sanjaya's
        message of "Sun, 9 Jan 2022 15:14:11 +0700")
Message-ID: <xmqqmtk43glm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C5EA834-717A-11EC-A7C4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

>> -		if [ "$oldrev" = "$zero" -a "$denycreatebranch" = "true" ]; then
>> +		if [ "$oldrev" = "$zero" ] && [ "$denycreatebranch" = "true" ]; then
>>   			echo "*** Creating a branch is not allowed in this repository" >&2
>>   			exit 1
>>   		fi
>> base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
>
> From the patch above, the title should be "replace non-POSIX test -a & test -o with logical operator".

I think "should" is a bit too strong a word.  While yours is a bit
more explicit on _what_ the solution is, "hook: test -a|o is not
POSIX" already implies that we are fixing that non-posix-ness by
rewriting, and it is obvious (cf. Documentation/CodingGuidelines)
what the right rewrite should be.

One thing the original does a bit better tha yours is that it tell
us _where_ the problem is.  So, perhaps

    sample hook: use "test ... &&/|| test ..." instead of "test -a/-o"

But I find the original just fine.


