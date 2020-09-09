Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAA7C10DAA
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 18:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85912206E6
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 18:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QYRKBIqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIIS1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:27:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55290 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIIS1t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 14:27:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 346516BC5C;
        Wed,  9 Sep 2020 14:27:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3IqxRgddh705Ir4MvjtCgQku++s=; b=QYRKBI
        qH0saC0bBttUQihdEGoCXyBSDq/mSn6Gj8wp0i2ep2B942/AD6WWPxfc1sc4Ln6O
        jhqx/QjJzu5Wnx7U0Oo6UhDXW/YbjpaRsubcBKYZ6EEa9C14/884PBmvxu3oJntX
        zMc0GqGbMYoRZvz4bI2Zb2rJCbvPy3L5Ok8l8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UZcXJxxlk5u22UYild1YiRCQyG/h0pnB
        Q6Ui0WAXgUkb4YhsDsrZSrkIOqWAHPMJLPzkps0ut06fNb+zApX6lRDGmjTKsSOP
        XZWPWEFmXpzP6M20OiWzy2hGSxt/k3LFbG8YAiLz0z9zdNObjYqN6Bkqmmp1hkT2
        AWIHwxGz4zg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A4C16BC5B;
        Wed,  9 Sep 2020 14:27:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AAE9A6BC5A;
        Wed,  9 Sep 2020 14:27:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Beat Bolli <dev+git@drbeat.li>, Denton Liu <liu.denton@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] pretty: allow to override the built-in formats
References: <20200905192406.74411-1-dev+git@drbeat.li>
        <20200905195218.GA892287@generichostname>
        <xmqqeene36t7.fsf@gitster.c.googlers.com>
        <8bb68268-8e4c-749e-b2e0-21b38b70c8bf@drbeat.li>
        <xmqqtuwa13gt.fsf@gitster.c.googlers.com>
        <20200908135303.GA2448968@coredump.intra.peff.net>
        <xmqqzh60xhms.fsf@gitster.c.googlers.com>
        <20200909090842.GA2496536@coredump.intra.peff.net>
Date:   Wed, 09 Sep 2020 11:27:43 -0700
In-Reply-To: <20200909090842.GA2496536@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 9 Sep 2020 05:08:42 -0400")
Message-ID: <xmqqtuw6vm8w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26D757D8-F2CA-11EA-97DB-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 08, 2020 at 11:12:11AM -0700, Junio C Hamano wrote:
>
>> > Here's a slightly different proposal. I'm not sure if I like it or not,
>> > but just thinking out loud for a moment. The issue is that we're worried
>> > the consumer of the output may be surprised by a user-configured pretty
>> > format. Can we give them a way to say "I don't care about the exact
>> > output; pick what the user configured for this name, or some sane
>> > default". I.e., something like:
>> >
>> >   git log --format=loose:reference
>> 
>> Yeah, that, or with s/loose/user/ or something.
>
> Heh, I actually called it "user:" initially but wasn't sure if that was
> sufficiently descriptive, so I groped around for another word. But if
> both of us thought of "user", maybe it's better.
>
> At any rate, this was mostly just thinking out loud, and isn't something
> I'm planning to follow up on with a patch. But maybe it inspires
> somebody to run with it.

Of course, we could go the other way and follow the same approach as
the "--literal-pathspecs" feature (and what bash does with the alias
and uses "command" keyword to work around the confusion it causes).

IOW, we could force those scripts that want to be strict to pay the
price and be explicit (e.g. "--format=builtin:<name>") and allow
others that want to be affected by end user customization can keep
saying "--format=<name>".  It unfortunately breaks our long standing
stance against backward compatibility breaking changes, so I would
say it is not likely to happen.  "--format=loose:reference" does not
share the problem, and it is much safer.

In any case, I do not think "pretty.override<word>" configuration
variable, which warns with the 'override' and makes those who tweak
builtin format think twice, is a good idea.  Those who add the
custom configuration are not in the position to decide if a
particular use of --format=<word> in a script (like gitk[*1*]) should
or should not be affected by customization.  It is up to the script
writers [*2*].


[Footnote]

*1* We've been using gitk as an example but it is not the best one,
    since it was made crystal clear that gitk will not be accepting a
    single liner patch that uses --pretty=reference anyway, it is a
    moot point.

    cf. https://lore.kernel.org/git/20191211215826.GA31614@blackberry/

*2* In general, a script wants strict/builtin output if it captures
    and parses, and customizable output if it just lets the git
    command it calls directly talk to the end user.
