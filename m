Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7E61FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 18:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758584AbcLASvF (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 13:51:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51246 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754217AbcLASvD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 13:51:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4560153068;
        Thu,  1 Dec 2016 13:51:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/5q2OusMThhL1x6YIjGyUBaC9Gk=; b=emujOX
        veU/DznPH0upDOkCvR1sX5PmDdJpiOmAlcf+pel2dOHlTTb8wgUvEXGx3vHCdnGW
        ISB/HgI0C+PLgQ1hyZvESRCUH4VIwce62oJI1pW/c4HxX5FEHtDqFz1z/hDCisiO
        Mzs/1ztUi2UhhSWUbHqeDJGAyhR/+pVoKUnEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OoYJn+RxeQTUPrmhYgfGaPkcBDpPDR3T
        8N55pcG99cosb5lPZSuU2hoHCiPKvv3VSty+UUHXq30hgZ/Z78jB4/usDYXYV9uJ
        TGaYoOplAGEwxIFFjYESC4hmfG2Npn1fm5DROWvrEjU/9D4zvSW+8jAdpF4hLqLe
        CwbwI7S/Ra4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B91D53066;
        Thu,  1 Dec 2016 13:51:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9BBC53065;
        Thu,  1 Dec 2016 13:51:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>, neuling@dakosy.de
Subject: Re: Re* git pull --rebase should use fast forward merge if possible
References: <OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de>
        <xmqqd1n0552i.fsf@gitster.mtv.corp.google.com>
        <xmqqtwgb52py.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYS=XWBpEBJsj95FV+j+HLxg=5xqwD73618t7ERYrKUfA@mail.gmail.com>
        <CAPc5daURyXO6-yaOWPhvvdS8Dr5psEEc8MVP4wQJ_AuxyZraRg@mail.gmail.com>
        <xmqqa8cfbkeq.fsf_-_@gitster.mtv.corp.google.com>
        <CAGZ79kZSEan5uXCUn4iVCWEc9zohMSr+UDyHDyQUHz84H=tR8w@mail.gmail.com>
Date:   Thu, 01 Dec 2016 10:50:59 -0800
In-Reply-To: <CAGZ79kZSEan5uXCUn4iVCWEc9zohMSr+UDyHDyQUHz84H=tR8w@mail.gmail.com>
        (Stefan Beller's message of "Thu, 1 Dec 2016 10:24:49 -0800")
Message-ID: <xmqqoa0va3fw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AE104D6-B7F7-11E6-853E-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Dec 1, 2016 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> +test_expect_success '--rebase fast forward' '
>> +       git reset --hard before-rebase &&
>> +       git checkout -b ff &&
>> +       echo another modification >file &&
>> +       git commit -m third file &&
>> +
>> +       git checkout to-rebase &&
>> +       git pull --rebase . ff &&
>> +       test "$(git rev-parse HEAD)" = "$(git rev-parse ff)" &&
>> +
>> +       # The above only validates the result.  Did we actually bypass rebase?
>
> Good catch for the test, but I think we can make the sed regexp simpler, as we
> can leave out the second "[0-9a-f]"? (git reflog |sed
> "s/^[0-9a-f]*/OBJID/" works here)

This mimics the existing tests around there for consistency.
Simplifying or cleaning of this test script as a whole is outside
the scope.
