Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105B11FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 21:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdALVMu (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 16:12:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59105 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750782AbdALVMu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 16:12:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E6145D82F;
        Thu, 12 Jan 2017 16:12:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tq6MRHSRsl6kcKqfdbpV5EWbh8U=; b=PpvrpU
        jU+4a40FQC81DswF9FUecb7u0BEb+ucflnpDecqtKHwOkYNaly9z7CGr+PUJdw1a
        zjDVxopvhV5XUegZdDGUAxKsPl9K/IEEu72vHJMk3NQriCrQP13qNtv03qAdYAFt
        55FcaVFu9x5CwdTmjZ5lGeIfoiN7w48jiOHVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MwKI8UF9Q0YUk4B/RiD3XSusbpZ/A3ja
        OhJ4zzU2Ei54LHM+hWqM51Cp+wHsk1e1Wj+KvPvB2oZZp2UlxTNWrrwDMOc5q6YW
        3M8DbL+Fup0k5a2rjriNDcEpNPyGKqQG6tgdeczfg6qrULUlZ3E8/z9yahffqO3a
        C+oiSgR7Rj8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1637B5D82D;
        Thu, 12 Jan 2017 16:12:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A1AB5D82C;
        Thu, 12 Jan 2017 16:12:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kai Zhang <kai@netskope.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: Git pull hang occasionally
References: <9B7DCFB3-73A4-40DE-8FC6-867C5016EF95@netskope.com>
        <xmqq8tr9huc0.fsf@gitster.mtv.corp.google.com>
        <xmqqshphge7o.fsf@gitster.mtv.corp.google.com>
        <E9196161-995C-4575-9560-D7E7B9A6B43D@netskope.com>
Date:   Thu, 12 Jan 2017 13:12:47 -0800
In-Reply-To: <E9196161-995C-4575-9560-D7E7B9A6B43D@netskope.com> (Kai Zhang's
        message of "Thu, 12 Jan 2017 10:24:03 -0800")
Message-ID: <xmqqy3yghtio.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE993512-D90B-11E6-80EB-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kai Zhang <kai@netskope.com> writes:

>> On Dec 21, 2016, at 1:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>  ...
>> 
>> I wonder if the latter is solved by recent patch 296b847c0d
>> ("remote-curl: don't hang when a server dies before any output",
>> 2016-11-18) on the client side.
>> ...

> After apply this patch, hanging did not happen again. 

Thanks for confirming.

> Would this patch go to release in near future?

I see 296b847c0d in the message you are responding to (by the way,
do not top-post to this list).  

Let's check it together.

	$ git log master..296b847c0d
	$ git merge-base master 296b847c0d
        296b847c0d6de63353e236cfbf94163d24155529

Yup, it already is in master.  

Using a third-party script "when-merged" [*1*], we can easily find
that it was merged a few days ago to 'master', after cooking in
'next' for a handful of weeks:

	$ git when-merged 296b847c0d next
	refs/heads/next 3ea70d01afc6305b88d33b8585f1fc41c486a182
	$ git when-merged 296b847c0d master
	refs/heads/master d984592043aec3c9f5b1955560a133896ca115b5
	$ git show -s --format='%cI' 3ea70d01af d984592043 
        2016-12-05T11:38:03-08:00
        2017-01-10T15:24:25-08:00

Unless people find regressions caused by this change (in which case
we may have to revert it), this will be included in the release at
the end of this cycle.  http://tinyurl.com/gitCal tells us that the
current cycle is expected to complete early February.


[Footnote]

*1* git://github.com/mhagger/git-when-merged
