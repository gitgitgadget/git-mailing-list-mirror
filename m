Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75929C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 06:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E00222C2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 06:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CO8mt9dE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfLSGZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:25:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54430 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLSGZG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 01:25:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5229692043;
        Thu, 19 Dec 2019 01:25:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zqJfHcVl7d/aWO/0u5HzO5PU6ts=; b=CO8mt9
        dE1OLdw8onOmMYiXGmO1XjnmHdrIfSn7EWheTADInw8ior4nH9R46Vl1vd3vw2VI
        o9rcwVuFQkRQoOZLqqkxTaJmBfoP7suoC5HA7NclduHa8h7w9kFxqUWyG+h+wU9b
        +6XFbOjAhfQaSTnn1Q2g854VniX6zTnoRPwlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EOlwAB40evfp5hYPXzENu7VZdKZDEewQ
        +PL3//1/sGhmNfCHFTvRomKWGNZmWXWcS8H3kL01OpI+sDyaEDVliyz5+JwrcMks
        mOeJuKIDnmPzoyXPeQ1ER7PYUFRyPP6Isc9WhHS4tsMV9EIDRrHOhsFB9pk8swye
        u7owxgblCbE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 496E892042;
        Thu, 19 Dec 2019 01:25:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7AF7D9203D;
        Thu, 19 Dec 2019 01:25:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 01/18] t7107, t7526: directly test parse_pathspec_file()
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <8d5fb9f40b8fc766ef022f910529e6308d9c2d80.1576511287.git.gitgitgadget@gmail.com>
        <xmqqwoatcn5u.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 18 Dec 2019 22:25:00 -0800
In-Reply-To: <xmqqwoatcn5u.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 18 Dec 2019 13:57:17 -0800")
Message-ID: <xmqq5zicde83.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A159C96-2228-11EA-B5EB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> ...
>> 3) Tests are indirect
>
> That cuts both ways.  For a developer who is too narrowly focused
> (because s/he spent enough time staring at the code), testing the
> underlying machinery in a more direct way does feel attractive, but
> at the same time, what matters to the end users is how well the
> feature, when integrated into the commands they use (not the test
> scaffolding like the "test-parse-pathspec-file" command), works.
>
> So "indirect" is not necessarily a bad thing.

Just to avoid misunderstanding, I am not opposed to adding tests and
test helpers that allows direct access to the guts of the machinery
to check the behaviour of the lower level codepath.  I am merely
saying that such tests would not make it unnecessary to have
end-to-end tests that validates end-user visible effects.

Thanks.
