Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B957D1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 02:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfDZCkl (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 22:40:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64685 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDZCkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 22:40:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E51F11C7AA;
        Thu, 25 Apr 2019 22:40:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qnom89S4vzIuHLHU3u5Sk7fMV0I=; b=LQt0GB
        209xXCJ8YOi8a8tRcOUz6DFivT62rA1cMotkd1VsBnegwRnSadxYlYSeF0/1NnrG
        pW81/crYv/DO0jRzkPHQXx30stC2tZGmqo7cWJ/RptlmFYOH9RBCeL95EA4v6nBN
        7C1A9Pl7BRX8WZsiDMrmlCle+nbvHW3t3/dik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UfBI1FKF69vCImmnSpxYwG4mGtkmLT1p
        UGQiUfRQbrI3T+uUlRPzBYSbdsrHmQeeM4rUR+/clij2OckVZFRvBzPRpm6o/Yjk
        7RBEpKS1eDzj1/A7mN1wghZvunvmbDviBmeB4dj9TioXlMZshTf7n5EiasBJeMZV
        XNViWoVKvlA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 274EC11C7A9;
        Thu, 25 Apr 2019 22:40:39 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 947C111C7A7;
        Thu, 25 Apr 2019 22:40:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] t9350: fix encoding test to actually test reencoding
References: <20190425155118.7918-1-newren@gmail.com>
        <20190425155118.7918-2-newren@gmail.com>
        <CAPig+cR2kOmKMmSu4hP6gJp_S6t9QQCnMtKjTp6QEw+JwQxG=w@mail.gmail.com>
Date:   Fri, 26 Apr 2019 11:40:37 +0900
In-Reply-To: <CAPig+cR2kOmKMmSu4hP6gJp_S6t9QQCnMtKjTp6QEw+JwQxG=w@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 25 Apr 2019 13:52:23 -0400")
Message-ID: <xmqq7ebhwkt6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD131E98-67CC-11E9-82B1-1646B3964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Apr 25, 2019 at 11:51 AM Elijah Newren <newren@gmail.com> wrote:
>> This test used an author with non-ascii characters in the name, but
>> no special commit message.  It then grep'ed for those non-ascii
>> characters, but those are guaranteed to exist regardless of the
>> reencoding process since the reencoding only affects the commit message,
>> not the author or committer names.  As such, the test would work even if
>> the re-encoding process simply stripped the commit message entirely.
>> Modify the test to actually check that the reencoding in utf-8 worked.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
>> @@ -94,22 +94,22 @@ test_expect_success 'fast-export --show-original-ids | git fast-import' '
>> +test_expect_success 'iso-8859-7' '
>> +       test_when_finished "git config --unset i18n.commitencoding" &&
>> +       git config i18n.commitencoding iso-8859-7 &&
>
> Aren't these two lines are pretty much equivalent to this single line?
>
>     test_config i18n.commitencoding iso-8859-7 &&

Yes.
