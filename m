Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054A4C5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 06:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E54022245
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 06:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="axqVkjcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgKNGNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 01:13:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63713 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgKNGNn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 01:13:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29E06A3DD3;
        Sat, 14 Nov 2020 01:13:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1tHfHwUvBYJDuKu3FXktCiRboIU=; b=axqVkj
        cTBnBpOMaMiTlyI0FgjiwLe2w+G13XvM50JQbVr+y1orDdsVzFkQ8PNa5o6AAU56
        2Or0As1uNtLJEwpk6sqpxvAzdqEDrXhMKtQM4Vv95ns+GP+h95hGhgYmwgjMet9S
        wiYgyjX7D94fukb2kgeFsjXU6ehy+mR5uUPg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UZOERZFIA8+MOu1R47V0q0+MJej1We2M
        rXIAzwP0n0fFZe6atcEkoo9cs4CRfPFo/ODCXKjBtrA0lFfIyefWOImJsoQPTX6n
        A151jp8lY2368CP/jD5d7wawTONJZ0beJC/PlInMJdTb1GmlbOA4DlA5G+C4XhSe
        P0hS+Hl8Ln0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11DE0A3DD2;
        Sat, 14 Nov 2020 01:13:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80CC4A3DD1;
        Sat, 14 Nov 2020 01:13:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
Date:   Fri, 13 Nov 2020 22:13:38 -0800
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 12 Nov 2020 22:43:30
        +0000")
Message-ID: <xmqq361ccvot.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89BB56E8-2640-11EB-AA4B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This is the big one. This changes the default of init.defaultBranch to main,
> reflecting what many open source projects already did (which was followed by
> GitHub, Azure Repos and others).

I'll keep this brief as I'm still offline/vacation til next week.

As other people already said, I'd prefer to see

 - all tests updated to work, without losing any coverage,
   regardless of the default for the init.defaultbranch is.  

   Some test scripts may require setting init.defaultBranch='master'
   at the top in the 'setup' part (I've shown how in my response to
   t4013 patchset) if the body of the test relies too heavily on the
   primary branch to be 'master'.  On the other hand, some test
   scripts may require setting init.defaultBranch='main' at the top,
   if they have been converted to work _only_ with 'main'.

   Both of these are unfortunate, but it is much better than losing
   test coverage during the test update effort.

   Some test scripts may not need any "this test would only work
   with 'master|main', so we are forcing".  After your test update
   series so far, hopefully many may already be ready to be force to
   'main' even when the Git binary may still use 'master' as the
   fallback default for init.defaultBranch.

 - a well thought-out transition plan (including user education and
   publicity), with the final "flip of the fallback default".

and I'd strongly prefer that these two to be done separately.  Since
we cannot anticipate how long the latter would take with unknown
amount of distraction, I'd prefer 100% of our tests keep working
while the fallback default for init.defaultBranch is 'master', and
they still work on the flag day when the default is changed to 'main'
(or 'primary' for that matter---after all, tests that care too deeply
what the primary branch name is, and have been updated to eradicate
'master' from them, would be forcing 'main', so the hardcoded
fallback default in our binary should not matter).

Thanks.
