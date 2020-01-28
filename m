Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99592C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 19:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B4F2467E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 19:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I655Qh2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgA1T2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:28:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53375 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgA1T2n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 14:28:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CFAC43A93;
        Tue, 28 Jan 2020 14:28:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B6UX/5NikKRzWG8wY0iqeotWdJs=; b=I655Qh
        2j6QvKREvDEsvzDuIInCKTZHMikXUJrYhHb4gpU0JH4mvpRf5d2LomCpZS5fJnN9
        fiBy/+LrJsvlKpvtBXmU7RK49TB+soTX/If4OnvVo9txUpH2yfp3MdiQ+urCXWP2
        JbfoqF9BX3NnCJCRFg395QkpbN7gK9b/J/USc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IVnweK7KhbNVfK7OWXXk0N6P3u0hQAHa
        kve2ISg+Vo/rSLoxOfDVy2GT8+d9UWMqpx1tLBGqvsa4tD67eSFtkL023oNwZSKY
        eU67RPcLICSgYzXHjBZiqtRc4LZTDqOkiD7CLKBT6eXQVwsoEsn2u3KapNrStuGb
        OXvYs7MSdHQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 026D843A92;
        Tue, 28 Jan 2020 14:28:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6102543A91;
        Tue, 28 Jan 2020 14:28:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Zeger-Jan van de Weg <git@zjvandeweg.nl>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] config: learn the --stdin option for instructions
References: <20200127100933.10765-1-git@zjvandeweg.nl>
        <20200127100933.10765-2-git@zjvandeweg.nl>
        <CAPig+cS03oS9PhN_cusjpzoCzwNmgc5rXiVAmG3ceUCFw71PVg@mail.gmail.com>
        <20200128092414.GB574544@coredump.intra.peff.net>
Date:   Tue, 28 Jan 2020 11:28:36 -0800
In-Reply-To: <20200128092414.GB574544@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Jan 2020 04:24:14 -0500")
Message-ID: <xmqq36bz8job.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61AB9CEC-4204-11EA-BF4D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jan 27, 2020 at 11:59:03AM -0500, Eric Sunshine wrote:
>
>> Second, this doesn't give any indication about how the lines should be
>> terminated. It should instead be written as:
>> 
>>     set SP <key> NUL <value> NUL
>>     unset SP <key> NUL
>> 
>> Third, importantly, unlike git-update-ref from which this DSL takes
>> inspiration and in which "refs" might have oddball names for which
>> NUL-termination makes sense, it's hard to imagine a case in which a
>> configuration key would be so strange as to warrant NUL-termination.
>> This observation suggests a simpler DSL in which only <value> is
>> NUL-terminated:
>> 
>>     set SP <key> SP <value> NUL
>>     unset SP <key> LF
>> 
>> (The proposed code changes in config.c would need adjustment, as well,
>> to implement this revised DSL.)
>
> The section and key parts of a config key are pretty restricted, but the
> subsection portion can contain anything except newline and NUL. So in
> particular, it would be valid to have a space, which would make the
> input ambiguous.
>
> I agree it would probably be rare, but isn't the whole point of "-z" to
> be able to represent anything without worrying about quoting?

Yup.  I was tempted to say, in addition to "without worrying about
quoting", "without worrying about the syntax".

But unfortunately that would not work.  If we were to add a new
"frotz" subcommand in a future version of Git that takes N args,

	frotz SP <arg1> NUL <arg2> NUL ... <argN> NUL

may how you'd express it, and it would be wonderful if the current
version of Git that does not know "frotz" subcommand can at least
parse and ignore it.  That cannot however be done, though, because
there is no syntactic difference between the argument terminator
(after each arg) and subcommand terminator (after each subcommand).
