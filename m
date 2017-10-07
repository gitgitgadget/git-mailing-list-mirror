Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69A4720372
	for <e@80x24.org>; Sat,  7 Oct 2017 01:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbdJGBS7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 21:18:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56713 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751485AbdJGBS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 21:18:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5646493D5D;
        Fri,  6 Oct 2017 21:18:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LgfD+R3f08EDqwlmkqbr1s+zD48=; b=aJUVPw
        A54unIzoXSobuTmSwPF5R/ynmghx10aPDfWGgbwuJ2CtlfdF1k4LhFYTWGuYXmCx
        KWkJQ4+ZIlARx9ep+eenTWKuTg45p09zYPas8SfCbHOd7/Q3FeN/Ib7Iy2wLq+eq
        GrJ4N7qwfrJVAXu1WE5GHxXcLLzV/1uL59LKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DWjMPyRmqlY2Yun5SEkGcpOThmiFm6NE
        rGG6/RoWa7SHXYkwNWQlZlyq6SEOl+AQwQvIf+GEc0s70z+b1IExLfwLJRmzCoHz
        0K1XV5UWnBwCkFoQXl2cKvwBZjCNeXyEkTJhUG817XjPneQJuaIVYJwKUgs98oo5
        8Yk6uGelJqg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BBE393D5B;
        Fri,  6 Oct 2017 21:18:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6F6693D5A;
        Fri,  6 Oct 2017 21:18:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] tests: fix diff order arguments in test_cmp
References: <20171006190006.19623-1-sbeller@google.com>
        <20171006190006.19623-2-sbeller@google.com>
        <20171006220101.GZ19555@aiede.mtv.corp.google.com>
        <CAGZ79kZhF=-baqPPqTCsbdyybOTV+SdvTqYiRbvsvB1epqpkZQ@mail.gmail.com>
Date:   Sat, 07 Oct 2017 10:18:56 +0900
In-Reply-To: <CAGZ79kZhF=-baqPPqTCsbdyybOTV+SdvTqYiRbvsvB1epqpkZQ@mail.gmail.com>
        (Stefan Beller's message of "Fri, 6 Oct 2017 15:10:27 -0700")
Message-ID: <xmqqefqfvjpb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EB9B0F8-AAFD-11E7-A71D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> How did you find these?  E.g. is there a grep pattern that reviewers
>> can use to repeat your results?
>
> The grunge work was done via scrolling through
>
> git -C t grep test_cmp
>
> However it occurred to me that checking for the completeness could be done
> via
>
>   git -C t grep test_cmp | \
>     awk '{$1=""; print }  | \ # remove file name from output
>     sort | uniq

Just like grep's GNUism, you can use -h to lose awk, i.e.

	git grep -h -e test_cmp t/ | sort -u

