Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA041F731
	for <e@80x24.org>; Tue,  6 Aug 2019 03:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfHFDxH (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 23:53:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52115 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfHFDxH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 23:53:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE1198F5C2;
        Mon,  5 Aug 2019 23:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AliTlr8lHKQZP2Nv8Sf3usOZnrc=; b=NPZuig
        B18PYfhm7WswYjeljoc22DNyVh8/vbwoM0sOuaOywzo6T/VQlXsSX9m08U53YEsq
        ByDV0jGmFrSnPYNNVVF1SW8T4bq+pcXqL7zm/4+qZgd2yv4/yGiwWhQ8DLZ5nRqe
        HQolBRyKOaKyqZQcEpViEKE04N9Yjnr9Un4wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IzL8cjh1fRezsgOHvnIqu4a73twatje6
        azN2B5AOI40OXDP0b9Q0tqC4akK2npQlKs1gMTNbSRdwEhv+5YVX4eQufLOTB3j8
        0vuV79cYm/ZcEe0TnYPNg7mjuEB2e2Bejk5is3UrK0UHwTqBFQr5gxv3MmzPALlq
        NL4l4X50sm8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B70DC8F5C1;
        Mon,  5 Aug 2019 23:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C33998F5C0;
        Mon,  5 Aug 2019 23:53:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lukas Gross <lukasgross@u.northwestern.edu>, git@vger.kernel.org
Subject: Re: amend warnings with no changes staged
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
        <20190806013030.GA61803@google.com>
        <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
        <20190806021618.GC61803@google.com>
        <xmqqtvavko1h.fsf@gitster-ct.c.googlers.com>
        <20190806030026.GA8864@google.com>
        <xmqqpnljkm3d.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 05 Aug 2019 20:53:00 -0700
In-Reply-To: <xmqqpnljkm3d.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 05 Aug 2019 20:29:42 -0700")
Message-ID: <xmqqh86vkl0j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B08D0E0E-B7FD-11E9-ABE2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>>> Some non-judgemental descriptive output like
>>>>
>>>> 	$ git commit --amend --no-edit
>>>> 	No changes.
>>>> 	$
>>>>
>>>> would address this case, without bothering people who are doing it
>>>> intentionally.  So I think there's room for a simple improvement here.
>>>
>>> I do that to refresh the committer timestamp.
>>
>> I do, too.  The proposal is, paraphrasing,
>>
>> 	$ git commit --amend --no-edit
>> 	Ah, I see that you want me to refresh the committer timestamp.
>> 	Done, as requested.
>> 	$
>
> Ah, OK then.  I somehow misread "No changes." as an error message.

Well, on second thought, I think "fatal: no changes" that exits with
non-zero, with "--force" as an escape hatch for those who want to
refresh the committer timestamp, would probably be more in line with
the expectation Lukas had when this thread was started, and I further
suspect that it might be a bit more end-user friendly.

It is a backward incompatible behaviour, but I suspect that if I
were inventing "commit --amend" today, unlike 8588452c ("git-commit
--amend: allow empty commit.", 2006-03-04), I probably would design
it that way.  After all, failing and stopping is always a safer
option than going ahead with or without a report.

I am not sure which one between "go ahead anyway but report" and
"fail by default but allow forcing" I would prefer more.  At least
not yet.  But I won't rule the latter out at this point.

Thanks.
