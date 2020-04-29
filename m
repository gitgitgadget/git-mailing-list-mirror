Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608EC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50DE20787
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JjtyZKdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgD2RTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:19:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55314 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgD2RTL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 13:19:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CFAAC8907;
        Wed, 29 Apr 2020 13:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CX/YodFqrkKL+XdKHN4F1jgpQ88=; b=JjtyZK
        dmlIDVNRCjyC+aJAs/zGc5T8LysG7NO/TRxMykzzgMmXM/y8XQppkq6e2V8XBlxP
        zkNlt4DzqsAkkTLXiCKiupjSzUK7aID5N7BCKNjOiPqcg5R4+TxKR+/JCHEhJzUR
        j91dO5nP83slEJyAjKr9DfsY32zbZywQXDbOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OoBhS3poN6dEn7T+fVcQvSut7HPbKMB2
        g0mqIlPQ+AzMuAgOIGJeiPFa8CVHJL5rilBDILeJBtkEGQCKun63PWUP7Msw3zrF
        KTOF9fDhVE+utYMVcVc5b9pv+3xhBWpKKGnlIq5F1lWhknvdXA3R2rXn6MPU9K4F
        Q/R+CytEWpo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 74E8CC8906;
        Wed, 29 Apr 2020 13:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B805CC8902;
        Wed, 29 Apr 2020 13:19:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 4/4] gitfaq: fetching and pulling a repository
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
        <20200429093811.8475-4-shouryashukla.oo@gmail.com>
        <CABPp-BFt_5-OyOw9YbYJhhu1P4CJLOi65wdyRckOY5_acRejGg@mail.gmail.com>
Date:   Wed, 29 Apr 2020 10:19:06 -0700
In-Reply-To: <CABPp-BFt_5-OyOw9YbYJhhu1P4CJLOi65wdyRckOY5_acRejGg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 29 Apr 2020 08:56:49 -0700")
Message-ID: <xmqq368mxl9x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 889A782E-8A3D-11EA-9763-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> +       go smoothly or have merge conflicts depending on the case. A pull
>> +       does not allow you to review any changes made upstream but rather
>> +       merge those changes on their own.
>
> I don't understand this last sentence.  You can definitely review
> changes made upstream after a pull; e.g. git log @{u}@{1}..@{u}
>
>> ++
>> +This is the reason why it is sometimes advised to fetch the changes
>> +first and then merge them accordingly because not every change might
>> +be of utility to the user.
>
> I don't understand the purpose of this paragraph.

Readers who need to resort to a FAQ will be at loss when told "it is
sometimes advised to...", as they do not know enough to judge if the
advice applies to their situation themselves.

Don't we have a workflow document?  Not the one that documents the
workflow I use to maintain this project, but outlines various ways
different projects work, describing centralized, triangular, merging
and rebasing, etc.?  I do not think this single entry belongs to a
FAQ list that gives simple answers to common questions without
people having to think.  Similar to the "merge or rebase?" question
(not part of this series), it belongs to "workflow guide", "concepts
manual", and "tutorial" kind of document, I would think.


