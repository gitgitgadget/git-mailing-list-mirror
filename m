Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3351A1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 16:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436710AbfHIQ6Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 12:58:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56155 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407439AbfHIQ6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 12:58:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6B031739E1;
        Fri,  9 Aug 2019 12:58:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yILmXOSHIvEJLXZrGbpqNHA3+wI=; b=XIdfSL
        iY8j88Uzwx87IisE0WGxD1b0R7rQeCvumHYApJTsmKd+9jtbz0hEBYyXhjGRXLo4
        kkik5cj2L/RD05Zso3X1hEibYGRFsL8TQPhGet+/xVXWd7EL+VNcat1c8hvhIWHB
        yQwJ09ylOxzhUDIxAcfE24f8TvYXa7fevvztg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wJbCwdRO6fuTeaQuGAaeW0y6PUtNMKtg
        zZEk4R/fDOykDNshNucxsOLuAjjQlohhyNEUMfOzikMN1gdKkQJfV6Xlrjd1sXtQ
        aAGOGIuJyGNOaPs+YHe+tGhJ2sPzeOWLjnErEW3gQSmMKCRXK63Re1jBl2w4yj94
        Py4wUDDhvBU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF5551739E0;
        Fri,  9 Aug 2019 12:58:21 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 422D51739DF;
        Fri,  9 Aug 2019 12:58:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Koning <dk@danielkoning.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] blame: document actual range specifier behavior
References: <m2ftmcijgk.fsf@danielkoning.com>
        <xmqqsgqbfucj.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 09 Aug 2019 09:58:20 -0700
In-Reply-To: <xmqqsgqbfucj.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 08 Aug 2019 10:19:24 -0700")
Message-ID: <xmqqblwye0nn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E496716A-BAC6-11E9-8E55-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  If anything,
> perhaps such a description should go to "git help revisions", as it
> is not just "blame" but "log". "The dots notation is not about
> date-based cutoff, unlike the --since/--until options" is shared by
> all history traversal tools.

By this, I do not necessarily mean "hence such a piece of info
should not be added to the documentation of blame".  Rather, an
explanation like "'^A' limits an operation to commits that are
topologically newer than A, while '--since=A' limits to commits that
are chronologically newer than A" is shared among "log", "blame" and
friends, and would be better to be clarified in documentation for
all of them.  Especially ...

>> +  git blame v2.6.18.. -- foo
>> +
>> +... If changes from branch `fix` were merged in after
>> +v2.6.18, the commits on `fix` which introduced those changes will appear
>> +in the output of 'git blame', even if those commits took place at an
>> +earlier time than v2.6.18.

... is a brilliant way to illustrate how "A.., i.e. topologically
newer than A" is different from "--since=A, i.e. chronologically
newer than A", whose understanding would help readers to understand
not just "blame" but "log".

Thanks.

