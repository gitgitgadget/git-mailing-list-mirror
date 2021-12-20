Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5921C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 20:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhLTUCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:02:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50807 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbhLTUCn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 15:02:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D857717A0DA;
        Mon, 20 Dec 2021 15:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SUOrLrzBzT4aAQu2s5P7u9Hz8GiDxnHNznHiip
        pku4k=; b=Fc8vmftAxU3ytGmP7aZwXUSirRkmKvxBFSRxTZwsgVViKcQfEJcykp
        Eq7RcrOAswDVO/BDXuSer1GUnfkHDYJfNUNYVt+GpRaphNTNjHZ5hEUNpN+FIKFQ
        eOEXVwXWBPMADW2OOfXYRWJGGe7z/Pu4zcmfNoPLpqVcmESexFURU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFDFA17A0D9;
        Mon, 20 Dec 2021 15:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A113017A0D6;
        Mon, 20 Dec 2021 15:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>,
        Git Users <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v2 2/2] git-p4: show progress as an integer
References: <20211217203856.2339161-1-jholdsworth@nvidia.com>
        <20211217203856.2339161-3-jholdsworth@nvidia.com>
        <CAE5ih7_uq2xos46tH_dR+gietA_5bhr3JzYNJOLmrjhuijy1Ng@mail.gmail.com>
Date:   Mon, 20 Dec 2021 12:02:37 -0800
In-Reply-To: <CAE5ih7_uq2xos46tH_dR+gietA_5bhr3JzYNJOLmrjhuijy1Ng@mail.gmail.com>
        (Luke Diamand's message of "Sat, 18 Dec 2021 10:12:11 +0000")
Message-ID: <xmqqzgovujs2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8360FA0-61CF-11EC-9541-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

>> diff --git a/git-p4.py b/git-p4.py
>> index 4d8a249b85..3c621a6efd 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -3635,7 +3635,8 @@ def importChanges(self, changes, origin_revision=0):
>>              self.updateOptionDict(description)
>>
>>              if not self.silent:
>> -                sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt * 100 / len(changes)))
>> +                sys.stdout.write("\rImporting revision %s (%d%%)" % (
>> +                    change, (cnt * 100) // len(changes)))
>>                  sys.stdout.flush()
>>              cnt = cnt + 1
>
> Thanks for fixing this - this is one of those small python2->python3
> bugs that's still left over.
>
> Looks good to me, ack.

Thanks.  I'll wait for an updated [1/2] but this is an independently
good change that does not depend on it, so I'll take [2/2] alone for
now.
