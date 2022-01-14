Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F4AC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 22:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiANWf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 17:35:57 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65341 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiANWf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 17:35:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A77CD16A11C;
        Fri, 14 Jan 2022 17:35:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YuGGXAfDxHU1UXrn//uqrcQcPStNbMgEoAYbz1
        s7zkY=; b=Uvtl/Bl69vluWmhp6/ZER3kiwPil0lutb2GS0b/y/zUlzFQduffU0T
        OWzbCI+30bDj8EqxgulZ+4Tqj8u9KXL5XzVRlzWzl8MO2fsG0H23hqn+shu1+tyZ
        DaqIPk/b7D+kXuSL4ZwcjZIaWi1M5A25hHHrQ2ZuouVPSLjhUtmxM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FB8B16A119;
        Fri, 14 Jan 2022 17:35:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B4AA16A115;
        Fri, 14 Jan 2022 17:35:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
        <xmqq4k7j68eg.fsf@gitster.g>
        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
        <xmqqilumayfh.fsf@gitster.g>
Date:   Fri, 14 Jan 2022 14:35:52 -0800
In-Reply-To: <xmqqilumayfh.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        14 Jan 2022 11:51:14 -0800")
Message-ID: <xmqqzgny7xo7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 556A57E6-758A-11EC-A639-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I think we had this discussion about FreeBSD before and that's why I
>> specifically dropped that option from the main makefile.  We can either
>> drop that patch, or we can set it to -std=gnu11 and tell folks setting
>> DEVELOPER to use a system released in the last five years.  I think we
>> can be a little stricter with what we require in the case of DEVELOPER
>> than we might be otherwise.
>
> But that is not being stricter, but looser, no?  I thought that the
> point of -std=gnu99 was to allow us to use C99 features while catching
> use of language features newer than that, and use of -std=gnu11 will
> defeat half the point, wouldn't it?

If FreeBSD (or any other platform) cannot do "reject features beyond
C99", I am perfectly OK to drop -std=gnu99 on such a place.

DEVELOPER=YesPlease ought to be a collection of settings that helps
the developers the most.  So on platforms that *can* do "reject
features beyond C99", I prefer to have it enabled when
DEVELOPER=YesPlease is given.

It seems that -std=gnu99 is only added conditionally even in today's
config.mak.dev, so it is fine if we dropped -std=gnu99 from there.
Which means that developers on FreeBSD cannot participate in vetting
use of features beyond C99, but there are developers on other
platforms who will, so it's not too bad, I would say.

As config.mak.dev is included after config.mak.uname, something like
this may be sufficient, perhaps?

 config.mak.dev | 5 +++++
 1 file changed, 5 insertions(+)

diff --git i/config.mak.dev w/config.mak.dev
index d4afac6b51..3deb076d5e 100644
--- i/config.mak.dev
+++ w/config.mak.dev
@@ -20,9 +20,14 @@ endif
 endif
 endif
 
+ifneq ($(uname_S),FreeBSD)
 ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang7,$(COMPILER_FEATURES))),)
 DEVELOPER_CFLAGS += -std=gnu99
 endif
+else
+# FreeBSD cannot limit to C99 because its system headers unconditionally
+# rely on C11 features.
+endif
 
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
 DEVELOPER_CFLAGS += -Wformat-security
