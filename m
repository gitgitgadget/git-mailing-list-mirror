Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7AD2036C
	for <e@80x24.org>; Thu,  5 Oct 2017 05:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdJEFRA (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 01:17:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57251 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750861AbdJEFQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 01:16:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90E10ABEBA;
        Thu,  5 Oct 2017 01:16:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zQnCmKzOn3wfM2z33bd52pBR8d0=; b=ORqpGz
        VJ58vXsEqcnM17ScgTui0LGogn06eaLS319a5foc0YVidyjyQ+PvLKt59JCsRRmK
        hGBCYJ4oXL/Me0T6hl/GSU104NxBkHH7Z57hgh6iZEUEX7MFiQ7A1mDb818voxuf
        7Pjn/iqw7wq7LNObtPUvTWMdS2V6v2Gy6cWbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MCvg14ZOJ/NUs/KH6huFjfFIx552yXhZ
        7AGkmml/mnZPjJF46dZ0r0WICpbXsvT552ewDR1jbEgjxdQvdynREX3oH7XCDJJn
        Dr14mwOPHKgrUE4aQoufL3JcY30681WWMtTEuNiTL9XRncFV6k+II9bhRSgbWeHF
        60N8SecbZbE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86263ABEB9;
        Thu,  5 Oct 2017 01:16:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB258ABEA5;
        Thu,  5 Oct 2017 01:16:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-stash" explanation of "--include-untracked" and "--all" seems ambiguous
References: <alpine.LFD.2.21.1709290650530.1446@localhost.localdomain>
        <20171001201604.GA30301@hank>
        <xmqqtvzitpjv.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.21.1710041300350.9804@localhost.localdomain>
Date:   Thu, 05 Oct 2017 14:16:54 +0900
In-Reply-To: <alpine.LFD.2.21.1710041300350.9804@localhost.localdomain>
        (Robert P. J. Day's message of "Wed, 4 Oct 2017 13:05:54 -0400 (EDT)")
Message-ID: <xmqqh8ve8989.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67A9FD04-A98C-11E7-B719-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>> If this were --include=untracked vs --include=all, then I'd say your
>> suggestion will violate the usual expectation of "on the command
>> line, last one wins", but "--include-untracked" and "--all" are
>> spelled very differently, and may not look all that related to a
>> casual reader, so the expectation for "the last one wins" might be
>> weaker than usual.
>>
>> But once we start complaining to a command line that has both,
>> saying they are mutually exclusive, people will realize that they
>> are very much closely related options, even though spelled quite
>> differently.  And at that point, they will find it very unreasonable
>> that we do not follow the usual "the last one wins" rule but error
>> out X-<.
>>
>> If I really cared deeply about these two options [*1*], I would
>> think that the ideal longer term direction would be to introduce
>> --include={untracked,all-crufts} to replace and deprecate the
>> current two options.  And then we make sure --include=* forms follow
>> the usual "last one wins" rule.
>>
>>
>> [Footnote]
>>
>> *1* I personally don't, but that does not mean I will block efforts
>>     by others who do to make this part of the system better.
>
>   since i'm the one who tripped over this pedantic nitpickery, i'm
> willing to take a shot at patching it, as long as there's consensus
> from those *way* higher up the food chain as to what that patch should
> look like.

That is rather hard to arrange.  I can give you, with some effort,
how a series of patches I may produce would look like if I were
interested in this topic.  But I cannot guarantee you that it would
become the consensus solution among other contributors on the list.

And more importantly, designing a good UI/UX (both the final user
interface, and the minimization of inconvenience to users during the
transition period) is more than 80% of the work required for a topic
like this, and by the time I outline something which may or may not
be close to a consensus solution, more than half of the effort
needed has already spent by _me_, on the topic that _I_ am not all
that interested.  That does not sound like a great economy to me.

I can still help polish a concrete proposal with the usual review on
design and implementation, of course.
