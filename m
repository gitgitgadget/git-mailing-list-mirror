Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652BFC2B9F7
	for <git@archiver.kernel.org>; Tue, 25 May 2021 02:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F7461404
	for <git@archiver.kernel.org>; Tue, 25 May 2021 02:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhEYC4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 22:56:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50187 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhEYC4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 22:56:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30AE512897D;
        Mon, 24 May 2021 22:55:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GdXAUW2g6jn6
        GAPHMhe97Zwy4okY+A7U3SJLYXfjwLE=; b=UDHtpqaE+dqGlyScuiWkY12dxxmD
        kPya4LZ8s4jpjS9DhvE+KqJp9H9ommr4z7zP7dJikV50GMKeMUJNIn7MklM2oyM7
        hR8sBgDNw8gRjWXoOj8E0Io6ewck2KpXKVoaB+6VM2ak4gxY5FTS/Lgj6qSGtlMN
        I5K7BID48nc3E3A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 283F112897C;
        Mon, 24 May 2021 22:55:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7251B12897A;
        Mon, 24 May 2021 22:54:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
        <YKwMU13DOtTIgaeP@google.com>
        <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
        <YKwd2e5VxVmU6zqj@nand.local> <87fsybohy5.fsf@evledraar.gmail.com>
        <YKxBIP4lkoPeCYvb@nand.local>
Date:   Tue, 25 May 2021 11:54:56 +0900
In-Reply-To: <YKxBIP4lkoPeCYvb@nand.local> (Taylor Blau's message of "Mon, 24
        May 2021 20:13:20 -0400")
Message-ID: <xmqq1r9viku7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9789F1D4-BD04-11EB-8630-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, May 25, 2021 at 12:57:52AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> On Mon, May 24 2021, Taylor Blau wrote:
>>
>> > But I don't think this isolated instance should push in the directio=
n of
>> > adding support for either of the above, regardless of how easy it mi=
ght
>> > be.
>>
>> I don't see why we wouldn't just tweak GIT_PROGRESS_DELAY to support -=
1
>> or something for "inf".
>
> Ironically, I think that this already works, since we parse the value o=
f
> GIT_PROGRESS_DELAY as unsigned, and don't bother checking for if the
> input is negative (since we eventually call git_parse_unsigned(), which
> doesn't have any extra checks other than for overflow).
>
> So we silently convert -1 to 2^64-1, and call it a day.

Stepping back a bit, this is an unattended test---why do we even see
progress meters?  Are we forcing the output to tty somehow in our
tests, or do some codepaths forget to ask isatty() when the command
line does not say --progress or --no-progress?

