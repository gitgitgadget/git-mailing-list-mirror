Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4A4C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 05:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8B2611F0
	for <git@archiver.kernel.org>; Thu, 13 May 2021 05:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhEMFDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 01:03:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58595 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhEMFDG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 01:03:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B5C3147313;
        Thu, 13 May 2021 01:01:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OSXcccfej4W05xh+gFpiZ/H5qcEwqQAHfVEi6/
        LLpmA=; b=LYjJq3G1q0jsEzZgblPA+Bh9wWODvgCv89xud2rh2qxzjJZVJMTUlH
        Rp1+ma3j+EXrcj/PueTEuP6EuQ0wEvSRjHWBsUKoNm7ABKAWt/uF9CzJRQhocW+C
        yERHmPM535z+s78LLNgmn1P8QUtgYyQtQfYZFmEaiRyRjfMgrjAbg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 651BD147311;
        Thu, 13 May 2021 01:01:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9FB0D1472E4;
        Thu, 13 May 2021 01:01:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christoph Anton Mitterer <calestyo@scientia.net>
Subject: Re: git-sh-prompt: bash: GIT_PS1_COMPRESSSPARSESTATE: unbound variable
References: <f1fc174b10ca5bc8b54ede513bc79e3864d8e014.camel@scientia.net>
        <xmqq4kf7cmaj.fsf@gitster.g> <xmqqzgwzb7ad.fsf@gitster.g>
        <CABPp-BGERNLKbLA_r7i7+r+v7YK6xT00_5n9ebESb2SzLhC0Cg@mail.gmail.com>
Date:   Thu, 13 May 2021 14:01:52 +0900
In-Reply-To: <CABPp-BGERNLKbLA_r7i7+r+v7YK6xT00_5n9ebESb2SzLhC0Cg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 12 May 2021 21:53:20 -0700")
Message-ID: <xmqqv97nb51b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 562E5258-B3A8-11EB-95BA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Yeah, I accidentally was relying on undefined-translates-to-empty,
> which breaks under set -u.  I can duplicate the precise error, and
> your fix below is exactly how I fixed it too, before seeing you posted
> the same fix.
>
> I'll post a patch with you as author...and some questions on what to
> do with the rest of the commit message and attribution tags.

Nah, please take full credit for it.  It is more work to test the
result of the change than just running a grep and coming up with "I
wonder if this would work...".

Thanks for a sanity check.

>
>> Thanks.
>>
>>  contrib/completion/git-prompt.sh | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git i/contrib/completion/git-prompt.sh w/contrib/completion/git-prompt.sh
>> index 4640a1535d..b9485f4016 100644
>> --- i/contrib/completion/git-prompt.sh
>> +++ w/contrib/completion/git-prompt.sh
>> @@ -139,7 +139,7 @@ __git_ps1_show_upstream ()
>>
>>         # parse configuration values
>>         local option
>> -       for option in ${GIT_PS1_SHOWUPSTREAM}; do
>> +       for option in ${GIT_PS1_SHOWUPSTREAM-}; do
>>                 case "$option" in
>>                 git|svn) upstream="$option" ;;
>>                 verbose) verbose=1 ;;
>> @@ -433,8 +433,8 @@ __git_ps1 ()
>>         fi
>>
>>         local sparse=""
>> -       if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
>> -          [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&
>> +       if [ -z "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
>> +          [ -z "${GIT_PS1_OMITSPARSESTATE-}" ] &&
>>            [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
>>                 sparse="|SPARSE"
>>         fi
>> @@ -543,7 +543,7 @@ __git_ps1 ()
>>                         u="%${ZSH_VERSION+%}"
>>                 fi
>>
>> -               if [ -n "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
>> +               if [ -n "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
>>                    [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
>>                         h="?"
>>                 fi
