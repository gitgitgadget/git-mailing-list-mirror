Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB1FC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 22:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A944214AF
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 22:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xrLiThy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLMWC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:02:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60869 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMWC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 17:02:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7EC5A889C;
        Fri, 13 Dec 2019 17:02:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5IgQAv5AsTf5JB/gFm57Ihk8ARI=; b=xrLiTh
        y71avSwMeikE36ZNfMZWYCrSvPx1jfma2k+7S/wBaGY5fI8up/0Sf8rEbyUiDgdX
        jPOPlV3UnjdeL8aKUri86JLGdnVHopsx5nlRPq7eKzmgIyuigrSyzIF78EHTmMB5
        7Ps++avyllwiGOlKlmgKQgUk+5cN069Uk3K5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fZQvR9KVrZb9raC8yLvVBZuXCQ9V4Kt2
        WnHWEzGEorJ5HLnbf+UEbV11LdopTbcOryWI7LCCQm3n3cf+TRoP3QINwAgxxJRX
        b5QlocDvIrM94SxCwVGCcR34zPVB6dalLq8OzDatb01KMgACWrFs9xhz/mdXwIWY
        emtFTkufshw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF83BA889B;
        Fri, 13 Dec 2019 17:02:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E339DA8898;
        Fri, 13 Dec 2019 17:02:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] sparse-checkout: respect core.ignoreCase in cone mode
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
        <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
        <7aeb1589-cc08-654f-1bc0-d48fec1c0729@gmail.com>
        <xmqqwob0jbba.fsf@gitster-ct.c.googlers.com>
        <d1b11424-db8b-e13c-e896-923d74b3d531@gmail.com>
Date:   Fri, 13 Dec 2019 14:02:51 -0800
In-Reply-To: <d1b11424-db8b-e13c-e896-923d74b3d531@gmail.com> (Derrick
        Stolee's message of "Fri, 13 Dec 2019 14:40:58 -0500")
Message-ID: <xmqqeex7hoj8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FFD8228-1DF4-11EA-ABC6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/13/2019 2:05 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>> 
>>> If you have a plan for that branch and the merge status of those
>>> commits, then I'm happy to re-target my PR against 'next' or
>>> an equivalent branch.
>> 
>> This change does not make much sense without the cone-mode topic,
>> no?
>
> I'm saying it should go on top, as a new branch that depends on
> ds/sparse-cone. Sorry for not making that clear.

I thought that it was a *bug* that ds/sparse-cone topic does not
match the pattern case insensitively on case insensitive systems,
and from that point of view, letting the earlier part of the topic
graduate without the fix would not make sense, I thought.

Thanks.


