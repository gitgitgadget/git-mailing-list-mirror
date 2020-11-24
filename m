Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8B8C6379D
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4778206C0
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QNedpZwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKXTno (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:43:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64103 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgKXTnn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 14:43:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 25D8AF9CCF;
        Tue, 24 Nov 2020 14:43:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zbsHxBBRSIVLExJJyCfRWM4D9sk=; b=QNedpZ
        wjoYYhnd1Upb5P5VmgBDByIX6TDbEyZlBvoSCWYYMJb46y3ZCvOV5l7br07tRaZk
        HgL2Yr9LWEWllWVrV86XuV4wJ2DzHOz+46W3utSk+cTDy7JweNCU2Kwwu/iGM1sE
        z545G3beklcjfclzxZXrzeYhUngEOVt/B5jcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VPAoe89rrzX4+Yb6bGyd9k77skSltEKf
        UGgRk+5s7pgNkP8brb62QVagxpuV052vKCBlrlxjN3i+JvL5Ve1uM+BTNPyfpQPM
        U+OUd1mySrax0fVs6czraHwPDI5H8uJepdXOPpZ6b0LTPvf8Zkq16UDqZz4J5KzK
        7oQy0lTLvjU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CDC3F9CCE;
        Tue, 24 Nov 2020 14:43:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 60637F9CCD;
        Tue, 24 Nov 2020 14:43:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/7] t1300: test "set all" mode with value_regex
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <2da2131114eb47e70ccaf8fb9c51bf7fb5b173b0.1605801143.git.gitgitgadget@gmail.com>
        <xmqqo8jtvvby.fsf@gitster.c.googlers.com>
        <20201120183903.GA320614@coredump.intra.peff.net>
        <20201121222734.GG389879@camp.crustytoothpaste.net>
        <xmqqlfeuqd8d.fsf@gitster.c.googlers.com>
        <X7xyHyFMU2E8cBCE@coredump.intra.peff.net>
Date:   Tue, 24 Nov 2020 11:43:37 -0800
In-Reply-To: <X7xyHyFMU2E8cBCE@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 23 Nov 2020 21:38:23 -0500")
Message-ID: <xmqqtutek0ba.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59A39C86-2E8D-11EB-BF37-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I am reasonably happy with the "let's keep the vanilla untouched one
>> in .git/config-initial, refrain from using [core] and other sections
>> that MUST be in the initial configuration for testing, and use a
>> wrapper that reads expected addition to the initial one from the
>> standard input for validation" approach I came up with, but I am not
>> happy with the name 'compare_expect'; 'validate_config_result' might
>> be a better name.
>
> IMHO this is worse than just using "config --file" in most of the tests.
> It's more steps to remember to deal with. And most tests do not care at
> all what the source file is.

"Most tests do not care" only indicates the lack of test coverage.

Knowing the implementation, it probably is OK to assume that things
would work fine as long as "--file <file>" works correctly, though
;-) 

Not having to keep the minimum parts of the real configuration file,
and being able to use a throw-away file for each test, certainly
makes things cleaner.

> That said, most of the effort is in the tedium of switching each
> individual test. I am happy for whoever volunteers to do that work to
> have the final say in the approach.

Yup.
