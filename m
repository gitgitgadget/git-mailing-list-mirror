Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05C4C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842416135F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhHXSre (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 14:47:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50852 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhHXSrd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 14:47:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E5DD1143785;
        Tue, 24 Aug 2021 14:46:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ST0cRmISEosqOgspN3X8gEQZtY7SjH9O5En8UL
        5bF/4=; b=h87rO5xdUgO0ziIvF11/ea+fUVeaYosny0EDmfIVy5EgplRoh+7AP/
        eF2G8zSdWUqyHKEbLmXWByTZxYUO0RNr/OlgcS2VqnSC2WUae5CME750BBzZcWVp
        /h3CWXkFVfOjE6YTSSeNYlY7lq20ytt3jvQJnJFzuGASLg2+i8zpg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF26C143784;
        Tue, 24 Aug 2021 14:46:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 28BB8143783;
        Tue, 24 Aug 2021 14:46:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Tal Kelrich via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Tal Kelrich <hasturkun@gmail.com>
Subject: Re: [PATCH] gitk: new option to hide prefetch refs
References: <pull.1023.git.1629807526939.gitgitgadget@gmail.com>
        <0004f758-759b-f523-fa3d-dd7759d6eec7@gmail.com>
Date:   Tue, 24 Aug 2021 11:46:44 -0700
In-Reply-To: <0004f758-759b-f523-fa3d-dd7759d6eec7@gmail.com> (Derrick
        Stolee's message of "Tue, 24 Aug 2021 09:49:23 -0400")
Message-ID: <xmqq4kbeptnv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1F80CA6-050B-11EC-8FDC-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 8/24/2021 8:18 AM, Tal Kelrich via GitGitGadget wrote:
>> From: Tal Kelrich <hasturkun@gmail.com>
>> 
>> The maintenance 'prefetch' task creates refs that mirror remote refs,
>> and in repositories with many branches this can clutter the commit list.
>> 
>> Add a new option to ignore any prefetch refs, enabled by default.
>
> This seems like a sensible feature to add. Thank you for contributing!
>  
>>     It might have been better to allow gitk to read log.excludeDecoration
>>     (or a gitk specific configured pattern) and use that to ignore refs, but
>>     this was simpler for me to implement without knowing Tcl.
>
> I agree, but I also don't know Tcl so can't comment to how hard that
> might be. I'm not sure how gitk operates and why it does not automatically
> benefit from log.excludeDecoration. Is it computing its own decoration? Is
> it using a different Git command that isn't integrated with
> log.excludeDecoration, but should be?
>
> I also cannot review that this patch works as advertised. I just wanted to
> chime in with support for the idea.

I would usually say that defaulting this to 'on' would be a biased
choice [*1*], but in this case I tend to think it is a good idea to
hide these by default, as 'prefetch' came way after people started
using Git, and users did not ask for 'prefetch' refs.  The prefetching
may help users but the refs used to anchor the prefetched objects are
implementation detail that the users would rather not to see.

I wonder if we should also hide refs/stash for the same reason, but
that is outside the scope of this change.

In any case, please make it a patch relative to Paul's tree and send
it in his direction.

Thanks.


[Footnote]

*1* Whenever the inventor of a feature says "I expect users would
want this!", it needs to be taken with a moderate amount of salt, as
the inventor is self selected specimen who wanted it (after all, the
feature motivated the inventor enough to write the patch).
