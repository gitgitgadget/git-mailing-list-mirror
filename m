Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0ED20958
	for <e@80x24.org>; Mon, 20 Mar 2017 22:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbdCTWkd (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 18:40:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59920 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755078AbdCTWkc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 18:40:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 178967E7FD;
        Mon, 20 Mar 2017 18:40:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sf9++CxtjsuuTmFnIhgoHnZpSV4=; b=k/xqJS
        JDrypt6bg5WhjcPnvxALjYlZO24XsBuBMEvX5f7JyCJ9pxpsFxf6q5H4++fmQl/8
        AAIJlF5cEfGKlj5jBfdB8T6EEFhu3cm3aLVDkOrDIlPxEF7RCnk1KfmNReLHOF86
        nJV9b/BFQKh0S0FB2QeqzRqf3XJOS5b8H+HMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZAi8UQ6w1urfgbvkEMLC50mvZzcvIrEG
        ox1Z/tJ7FCh+SHl/JahEPszMoJxsasV3FYOzRal49Nr0Z7Dtq4+zu1Qf33Nt5Q2G
        B3JO1kPUxp/vfFlYcaDO5vut8wHbs7ygKxpG6VIazhAVOnDQ6WPE6sHnoywYH3KA
        Qbl7nhFiYYQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1117E7E7FC;
        Mon, 20 Mar 2017 18:40:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 736AB7E7FB;
        Mon, 20 Mar 2017 18:40:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 09/20] refs: split `ref_cache` code into separate files
References: <cover.1490026594.git.mhagger@alum.mit.edu>
        <f16c123354404088f9ffef0b0e31d4a9817cb804.1490026594.git.mhagger@alum.mit.edu>
        <20170320174937.xkozsdruyrj44qg2@sigill.intra.peff.net>
        <xmqqpohbvih5.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZL3MgVVErox-YoksZuoMY1mmV_D7Bq0d-h_mp9w6kg_A@mail.gmail.com>
Date:   Mon, 20 Mar 2017 15:40:29 -0700
In-Reply-To: <CAGZ79kZL3MgVVErox-YoksZuoMY1mmV_D7Bq0d-h_mp9w6kg_A@mail.gmail.com>
        (Stefan Beller's message of "Mon, 20 Mar 2017 13:35:20 -0700")
Message-ID: <xmqqfui7tvvm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38C52438-0DBE-11E7-BE6B-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Mar 20, 2017 at 12:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> It might have been a bit easier to review as separate steps for that
>>> reason, but I doubt it's worth going back and re-doing. I'll take your
>>> word that nothing substantive changed.
>>
>> In such a case when I do not want to "take your word", I often do
>> "blame -C" on the result, setting the bottom of the range close-by.
>> I should mostly see the ^bottom lines (or with "blame -b", lines
>> intended with blanks without any commit object name).
>
> FYI:
> I still want to revive the series that colors moved text differently.

I agree that the mode would help viewing this change with "git
show".
