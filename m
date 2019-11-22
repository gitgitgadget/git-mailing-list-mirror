Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F19C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61690204FD
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UUzW5YVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfKVGas (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:30:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55379 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfKVGas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 01:30:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BA248D820;
        Fri, 22 Nov 2019 01:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4OYiLoYscJfd
        SzjIcXetQlx74U0=; b=UUzW5YVMywppcTnFrVYP+DnUgvwxi1LhBUrG8aZ75bBh
        HbVr9H4zTjhtSa3GUUBDV1PqKLOIlrVG5yec2YX/hmjHtzq/COwt4q1mayq67Kv1
        fIcLo7DqwRq79A4LqITPTS3Zzg5Y9Kn6fsEQ2hqIdonIrfzpmirhG1cJyY15hG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JjH6Hf
        0bimAmzpxr8kh6lU5rz36UMpQw0NgydYiLAXcg//ame3IAfurBcJMg6/GviA5sWC
        TobHKixlQME3E3rYX7upf39AttCdUUmzwntlI39Bb+WMinZ9ng8BczZZ8oJiWi7O
        gnZuUkpdG7yRySRxQn7LKZ86A//rPlrqDGFaU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8373C8D81F;
        Fri, 22 Nov 2019 01:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF0538D81E;
        Fri, 22 Nov 2019 01:30:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/8] builtin/config: collect "value_regexp" data in a struct
References: <cover.1573670565.git.martin.agren@gmail.com>
        <336eaa77e4974f84ea1eef473672e1d300f3a43d.1573670565.git.martin.agren@gmail.com>
        <xmqqy2w9951v.fsf@gitster-ct.c.googlers.com>
        <CAN0heSo3E0g_ZhHb64cisZQu9hfF31sQEyyZB4X_eRyiFtv4mQ@mail.gmail.com>
Date:   Fri, 22 Nov 2019 15:30:42 +0900
In-Reply-To: <CAN0heSo3E0g_ZhHb64cisZQu9hfF31sQEyyZB4X_eRyiFtv4mQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 21 Nov 2019 20:55:53
 +0100")
Message-ID: <xmqqpnhk4e3x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9CE80C02-0CF1-11EA-909D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> > +static struct {
>> > +     enum { none, regexp } mode;
>>
>> We often use the same identifier for a struct and an instance of the
>> struct, taking advantage of the fact that they live in separate
>> namespaces, but lowercase enumerated values like 'regexp' that
>> collides with the field name (and possibly a variable name used
>> elsewhere) smells a bit too much.
>
> Ok, thanks for sanity-checking.
>
>> > +     regex_t *regexp;
>> > +     int do_not_match; /* used with `regexp` */
>> > +} cmd_line_value;

I _might_ want to take this back.  A pattern that uses the "mode" to
switch among the possibilities in a union, i.e.

	struct {
		enum {
			<something>_none,
			<something>_regexp,
			<something>_bool,
			<something>_int,
		} mode;
                union {
			<type-used-when-it-is-regexp> regexp;
			<type-used-when-it-is-bool> bool;
			<type-used-when-it-is-int> int;
		} u;
	};

may not be too bad.  So I do not strongly mind the lowercase.

But I still do mind an overly bland names for identifiers in an
enum, as enum is not quite a type on its own ('regexp' in one enum
may collide with the same identifier in another enum)..

Thanks.
