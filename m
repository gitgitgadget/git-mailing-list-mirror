Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CDC41F859
	for <e@80x24.org>; Thu, 25 Aug 2016 21:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbcHYVaX (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 17:30:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57419 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754885AbcHYV0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 17:26:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90EFC37456;
        Thu, 25 Aug 2016 17:25:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aviWHpdEHRXxcanv3kh7Do8+ArY=; b=ooLtD5
        wrNJ77/9Eg0Hcb2QyoblVl75Z5MD3QhI5FnUFY/dkdWyLNwYM2MgifBXVOvmurdT
        Xijj7BbjHGwHO2XEcCtM09Hso6u3PjFR/8qxp8oSj+YZbzBI56x2kIOBp6+PhBxn
        PxzgsDiy+rYmv/muvFqTdLGkvpzCtCdh2RfZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uAmvY210dj5ohT0uWYnJUtI5/LGDfF6T
        TCLmplJfnk6vuoll7y+yidEmv4KkaN9AzZLvhyfjURRcSxjMHHSuI+ksIMP9WKH7
        M2MTShNFEXgnhOkEPn1kuutMaftRmtYWJJ82CaJP7mjo/hR1uZSoCJj0d+mR2LsH
        NXCclmn6Jus=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89A6B37455;
        Thu, 25 Aug 2016 17:25:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A01F37454;
        Thu, 25 Aug 2016 17:25:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Hedges Alexander <ahedges@student.ethz.ch>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: Feature Request: Branch-Aware Submodules
References: <7B5AD16B-9729-453E-839C-2A2FDB07F8E9@student.ethz.ch>
        <CAGZ79kbHfofmowHnwzFrumc1XJHE=ZMQEwNSeOSyF7YDG+aSjw@mail.gmail.com>
        <xmqqlgzklgiy.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka60e2Y87k6oKtTN9e0ZexHx2GfJ7yfhvyQon_VgbUgNA@mail.gmail.com>
Date:   Thu, 25 Aug 2016 14:25:32 -0700
In-Reply-To: <CAGZ79ka60e2Y87k6oKtTN9e0ZexHx2GfJ7yfhvyQon_VgbUgNA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 25 Aug 2016 13:55:59 -0700")
Message-ID: <xmqqd1kwlewj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75BD1514-6B0A-11E6-8954-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> So you roughly do
>>>
>>>     git checkout -b new-topic
>>>     # change the submodule to point at the latest upstream version:
>>>     git submodule update --remote <submodule-path>
>>>     git commit -a -m "update submodule"
>>>     git checkout master
>>>     git merge new-topic
>>>     # here seems to be your point of critic?
>>>     # now the submodule pointer would still point to the latest
>>> upstream version?
>>
>> Isn't <submodule-path> subject to the usual 3-way merge when the
>> last step (i.e. a merge of new-topic branch into master in the
>> superproject) is made?  If 'master' hasn't changed <submodule-path>
>> since 'new-topic' forked from it, because 'new-topic' updated the
>> commit bound at <submodule-path>, doesn't "git merge new-topic" just
>> take that change as the normal "One side updated, the other did not
>> touch; take the update" merge?
>
> Yes. I was unclear here.
> By "latest upstream version" I meant the version you pulled in in the new-topic
> branch via the "submodule update --remote" and that is preserved as is.

I do not think you were unclear at all.

What else is desired?  "git merge new-topic" leaves a result that is
not a merge of the changes made on that new-topic branch, by leaving
a stale <submodule-path> that was in 'master' as-is?

After all, the new-topic branch committed that "update submodule",
showing its desire that the latest-from-upstream commit it just
obtained must be at <submodule-path> from then on in the top-level
project.  If that change is not propagated (or at least "taken into
account") when merging it to 'master', the result is not a proper
"merge".  If new-topic didn't want the updated commit from the
submodule, it shouldn't have recorded that in its commit in the
first place.

