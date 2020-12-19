Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BACC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D12EE23A00
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgLSRcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 12:32:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60549 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgLSRcW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 12:32:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CE121177E4;
        Sat, 19 Dec 2020 12:31:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wiXWW5UOhOPmKl3aNFHYb3iVmHc=; b=bHsCru
        vKzxFDMeUL3Tt+Lh9TVux/3EguOzwemxBmMIVNAncFsxhSLIx0OFAFn9ZfYl2Z7R
        VZyehrC5ruSlNm4nupVjJRBqOYAAN4uC72zG9rZyIIrx2WvtFd2DDFrupIr3j0oh
        fzg7QxbtNSHXazGqYqkKsRfp+D1bliD4UdPMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mHlpUk6nudrW3KEuaJ665eI2KEMbuUm6
        QzMLR/kYGFqI+dNUMQE5cZG4lQNP7UAExOysX+QqhMK5A8HbZNMdlDLigqlSdsgF
        MuJfjuqF0T663/GHO9xyT8kbStepoqw/6Z0gUlP1RCOM3JgQtEQCwINsvIWF1mLJ
        eLTysOwzQ+k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 756531177E3;
        Sat, 19 Dec 2020 12:31:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2EA01177E2;
        Sat, 19 Dec 2020 12:31:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Ed Avis <ed.avis@qmaw.com>, git <git@vger.kernel.org>,
        "Miriam R." <mirucam@gmail.com>
Subject: Re: Feature request: 'git bisect run' option to redundantly check
 start and end commits
References: <PH0PR11MB48875130A7DF30A7394DD3619DC30@PH0PR11MB4887.namprd11.prod.outlook.com>
        <5fdccc25255b7_1273af2086c@natae.notmuch>
        <CAP8UFD1XMA7y6qXXS8h2HZXTuC8nGVkxTiMG3ZA54XJJg=gAsQ@mail.gmail.com>
        <5fdce3a04a8b6_12eac7208b@natae.notmuch>
        <CAP8UFD3AHZppV2puere=zKyRjHhywCYQcO6q4yU7jJCfF0HZJg@mail.gmail.com>
Date:   Sat, 19 Dec 2020 09:31:35 -0800
In-Reply-To: <CAP8UFD3AHZppV2puere=zKyRjHhywCYQcO6q4yU7jJCfF0HZJg@mail.gmail.com>
        (Christian Couder's message of "Sat, 19 Dec 2020 08:46:31 +0100")
Message-ID: <xmqqh7ohpurs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BB1303C-4220-11EB-8BA5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Dec 18, 2020 at 6:15 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> > There has been a lot of work over the years to port code from shell in
>> > git-bisect.sh to C in builtin/bisect--helper.c. So it would be nice,
>> > if you plan to implement this feature, if you could do it directly in
>> > builtin/bisect--helper.c.
>>
>> Yeah, I'm aware and I might be willing to do that--which probably would
>> require moving the whole of "bisect run" to C--if there was an
>> indication that such a patch would actually be merged.
>
> I think it would likely be merged, as it would just be finishing the
> porting git bisect to C saga.

I agree that the issue such a patch series would try to address
(i.e. "reimplement 'bisect run' in C") may be worth solving, and I
do not offhand see why it would become a reason of not merging.

But the "cause" is mere prerequisite to consider a particular
iteration of such a series for inclusion.  I think it is
irresponsible to say "would likely" before seeing any patch to base
our assessment on.

If the design is poorly done (e.g. it does not solve the problem it
aims to solve well, it makes it hard to explain to end users what is
going on [*1*], or makes a poor design choice and paints us in a
corner we cannot easily escape from, ...), or if the execution is
poorly done (e.g. it is unmaintainable, it breaks other things by
mistake, it makes future changes harder, ...), it would not be
possible for the project to take the series.

Until reviewers comments aimed to help by pointing out these defects
are addressed, that is.  And if the series stops getting updated to
address such defects, it may end up getting not merged at all.


[Footnote]

*1* This obviously applies only for a series that makes externally
    visible behaviour change.  "rewrite 'bisect run' in C" may not
    have end-user visible effect (and if it does, such a regression
    is a reason to say "this is not yet ready").
