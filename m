Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07D5C433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6390C221FE
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jUJl4R1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgJHRXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:23:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58207 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732027AbgJHRXq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 13:23:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A041880D5;
        Thu,  8 Oct 2020 13:23:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RF9gir///21L3hM1B7SDTuajehY=; b=jUJl4R
        1TxMMg8A53tznVjJT3ma+1k4VE9/RhdVOIGeqJlwY4djHc0cXZIdM/164onNS8sy
        KBo8mMHFZAvpFmrx34LWviQPbFiwcHQzLEPotrKxJ1ng7+XgSlPehiIYx552yGeR
        fQDB83uhC33n6RajCY7zj+CseCri5GVOccGqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NDqoK46KiFUW3EWwb6fjDcN9rOGAF0Ja
        83K4mhtrkRllF6X7ghRgCAGwhC1LvCkJIc2wSOvyN0zdUeMU4rHqrv7j1+GUOqJd
        CT/agZmawPDOJVsVFtxvex8A1eSVeBS9KWfxJam/wUTfQgZbMwEVSDkUux4kNqkh
        SRY9Td5tCew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91E7C880D4;
        Thu,  8 Oct 2020 13:23:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21B51880D3;
        Thu,  8 Oct 2020 13:23:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Sohom Datta <sohom.datta@learner.manipal.edu>
Subject: Re: [PATCH v2] userdiff: expand detected chunk headers for css
References: <pull.866.git.git.1602062726316.gitgitgadget@gmail.com>
        <pull.866.v2.git.git.1602146164799.gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 10:23:42 -0700
In-Reply-To: <pull.866.v2.git.git.1602146164799.gitgitgadget@gmail.com> (Sohom
        Datta via GitGitGadget's message of "Thu, 08 Oct 2020 08:36:04 +0000")
Message-ID: <xmqqeem8y6ld.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03AA7C18-098B-11EB-BCE7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sohom <sohom.datta@learner.manipal.edu>

I'd call this line *1* for later reference...

> The regex used for the CSS builtin diff driver in git is only
> able to show chunk headers for lines that start with a number,
> a letter or an underscore.
>
> However, the regex fails to detect classes (starts with a .), ids
> (starts with a #), :root and attribute-value based selectors (for
> example [class*="col-"]), as well as @based block-level statements
> like @page,@keyframes and @media since all of them, start with a
> special character.
>
> Allow the selectors and block level statements to begin with these
> special characters.
>
> Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
> ---

Looking good.

The "Name <email>" on line *1* must match that on the last
"signed-off-by" line, so I'll locally tweak the authorship information
before applying the patch.

Thanks.

