Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1BDF20951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdCQRRo (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:17:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55056 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751057AbdCQRRn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:17:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A41478CFC;
        Fri, 17 Mar 2017 13:17:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eIsFyOs5D9Rz3W8BHD+4x2r0+Pw=; b=QG9g97
        sEP8nGBUPEKxm2Av36VjF+LPaF5gRz/oxxRgMhaiSTTzYu+ltOX3enXuhxTex+aK
        DbHsl9sgP4g5rmR0JokCCNhj4Yi/vI37Ukf33o1wjv2bBmhmsVBY0s3UcFSDASfW
        gmV6AaMYwDBgK6Gya9XFLYZWRLAHh39YRlY6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OanH6iDCStaWUUQBxLghru8yavYYuZpa
        K0XVomWl71yZHnG0iu2VbYz+QOmMg7w2uD4xxcR0MlFRwArKsSI4XqwVPudNks9b
        Xib6bIoIGaNVxF6qgFxlH0EdkJfQ7M0Cdbnck4Kb4gAWXia8Yh5eIJMmKF0MB6xl
        nMS+94ZkAoI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1206578CFB;
        Fri, 17 Mar 2017 13:17:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FE6078CFA;
        Fri, 17 Mar 2017 13:17:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 2/2] name-rev: favor describing with tags and use committer date to tiebreak
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com>
        <20170315225045.15788-1-gitster@pobox.com>
        <20170315225045.15788-3-gitster@pobox.com>
        <9AE7ADCA-97F9-4857-AC55-76C4BD822C25@gmail.com>
        <xmqqy3w48nif.fsf@gitster.mtv.corp.google.com>
        <xmqqshmc8n09.fsf@gitster.mtv.corp.google.com>
        <015A7026-960F-450C-9276-AAC3A0B11207@gmail.com>
Date:   Fri, 17 Mar 2017 10:17:35 -0700
In-Reply-To: <015A7026-960F-450C-9276-AAC3A0B11207@gmail.com> (Lars
        Schneider's message of "Sat, 18 Mar 2017 01:09:50 +0800")
Message-ID: <xmqqd1df961c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DB8452C-0B35-11E7-9E59-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> git-p4.py | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/git-p4.py b/git-p4.py
>> index eab319d76e..351d1ab58e 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -582,7 +582,7 @@ def currentGitBranch():
>>         # on a detached head
>>         return None
>>     else:
>> -        return read_pipe(["git", "name-rev", "HEAD"]).split(" ")[1].strip()
>> +        return read_pipe(["git", "symbolic-ref", "HEAD"]).strip()[11:]
>> 
>> def isValidGitDir(path):
>>     return git_dir(path) != None
>
> Following your explanation this patch looks good to me and this fixes the
> test failure. TBH I never thought about the difference of these commands
> before. "rev" and "ref" sound so similar although they denote completely 
> different things.

Thanks for testing.

The above was done merely to point out the problematic place and a
possible solution.  As I am not familiar with the code in git-p4.py,
I didn't even try to check if the code already has a helper function
that strips "refs/heads/" from the beginning of the string (iow, I
am not happy with the [11:]).  I didn't and don't like the fact that
this function now runs "symbolic-ref HEAD" twice but I didn't try to
see if there are more suitable and idiomatic ways to do this with a
single invocation.

Hence, I would really prefer not to commit mine myself.  I'd rather
see somebody from git-p4 circle to come up with a version that is
more in line with the way things are done in the existing code and
send a tested version for me to apply.

Thanks.


