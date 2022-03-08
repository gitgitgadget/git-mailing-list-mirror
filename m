Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37239C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiCHA0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiCHA0w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:26:52 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE04CAE52
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:25:57 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E10F1110BFE;
        Mon,  7 Mar 2022 19:25:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8KsYhEB8eitBXtuIc6fSulhANgK4LNkSazJ10L
        46iRU=; b=HAgzYGDnSXGa6rnJtNCGfu4bjvDA7S9RFl/9Lz4K5Sef9GI64xNWFQ
        Mep2iJ1ZHY7IHCbOYDtXq6Vw7Y6NVQO9GXHlCEv91kkqci7ccz4PZHBJIwTfC7YO
        90XbtSQMzPdOBbkniX0RgaZveXMffE9LsiM5mbKNcVGHBNqaDXad8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D829B110BFC;
        Mon,  7 Mar 2022 19:25:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F9EA110BFB;
        Mon,  7 Mar 2022 19:25:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: tb/cruft-packs (was Re: What's cooking in git.git (Mar 2022,
 #01; Thu, 3))
References: <xmqqv8wu2vag.fsf@gitster.g>
        <0870b8f0-976a-cf2f-f34f-7e966b9c426f@github.com>
        <YiZJiPVMZwPXbfrK@google.com> <YiZMhuI/DdpvQ/ED@nand.local>
Date:   Mon, 07 Mar 2022 16:25:55 -0800
In-Reply-To: <YiZMhuI/DdpvQ/ED@nand.local> (Taylor Blau's message of "Mon, 7
        Mar 2022 13:18:46 -0500")
Message-ID: <xmqqv8wpp9ws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52295D38-9E76-11EC-A69B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Mar 07, 2022 at 10:06:00AM -0800, Jonathan Nieder wrote:
>> I'm excited about this work!  I just sent a quick review to the
>> design doc.
>
> Thanks! I haven't had a chance to look at the design doc, but let me
> respond quickly to this message:
>
>> Before merging to 'next', I'd be interested in two things:
>>
>>  1. Marking the feature as experimental so we can learn from experience.
>>     Clarifying what aspects we consider to be stable / set in stone and
>>     what are subject to modification.
>
> I'm not sure there is much practical benefit to marking this feature as
> experimental. The only new file format here is the .mtimes one, which
> should make it easy for us to modify the format in a
> backwards-compatible way.
>
> If there are other benefits you had in mind, I'm curious to hear them.
> But I think we should be fine to "lock in" the first version of the
> .mtimes format since we have an easy-ish mechanism to change it in the
> future.

Hmph, how?  For example, if it turns out that rewriting .mtimes file
for each object access turns out to be too much I/O churn and the
approach to use the mtime of the cruft pack for expiration of the
entire cruft pack (while ejecting objects that was used from the
cruft pack out of it to resurrect them from expiration schedule) is
more preferrable, how do we back out of from the "lock in" once this
series is unleashed to the workd?
