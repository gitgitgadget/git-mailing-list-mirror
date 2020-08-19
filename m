Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EFBC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065062078D
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tJlqmeTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHSQBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:01:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57238 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgHSQBU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 12:01:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9797DF3241;
        Wed, 19 Aug 2020 12:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NTv2hF0eY5UBJlgGsB4nlToeJrg=; b=tJlqme
        TPX/01RD2EWjBDDVWeNIb4HPrBKCkazcGS4rje0gTlIYjrttIKvucdxnvdbAkvXZ
        6JzHfQPWTR8CSNxaPM8aNBYRCydhD1+UtOKrWqOFHi1Mnh0tfYvviS/zCyysnwXM
        MrSbeR9CmjIbK+l9lXeFSZk4UBbehBnuQLG9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C91dUj0QU/lCMpO+QOtGPIrl+D32hcUT
        y/ZLGBOFIJvgRuYFjSHPRJfSXW6tt/mDZuTg7bTwGWGXqe/jecjNjDxQSUjE3FJj
        Va7UPkAdVVrLIcL7wNxu9gbAMoLnbO6mQR6FyhG0nmug+NWfgwCPbsy4zMs8gaCu
        wRgBjbqwyjo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 908B0F323F;
        Wed, 19 Aug 2020 12:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD907F323D;
        Wed, 19 Aug 2020 12:01:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v3 7/9] pretty: refactor `format_sanitized_subject()`
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
        <0ad22c7cdd3c692aa5b46444e64a3b76f1e87b4c.1597687822.git.gitgitgadget@gmail.com>
        <xmqqpn7p1373.fsf@gitster.c.googlers.com>
        <CA+CkUQ9tkwXmrHq_ZV+RCgwoFHZ0M4dEhBkjUd97Xi+3shB-WQ@mail.gmail.com>
Date:   Wed, 19 Aug 2020 09:01:14 -0700
In-Reply-To: <CA+CkUQ9tkwXmrHq_ZV+RCgwoFHZ0M4dEhBkjUd97Xi+3shB-WQ@mail.gmail.com>
        (Hariom verma's message of "Wed, 19 Aug 2020 19:06:59 +0530")
Message-ID: <xmqqimdevd4l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 363156F2-E235-11EA-93BC-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> writes:

>> Also, because neither LF or SP is a titlechar(), wouldn't the "if
>> r[i] is LF, replace it with SP" a no-op wrt what will be in sb at
>> the end?
>
> Maybe its better to directly replace LF with hyphen? [Instead of first
> replacing LF with SP and then replacing SP with '-'.]

Why do you think LF is so special?

Everything other than titlechar() including HT, '#', '*', SP is
treated in the same way as the body of that loop.  It does not
directly contribute to the final contents of sb, but just leaves
the marker in the variable "space" the fact that when adding the
next titlechar() to the resulting sb, we need a SP to wordbreak.

LF now happens to be in the set due to the way you extended the
function (it wasn't fed to this function by its sole caller), but
other than that, it is no more special than HT, SP or '*'.  And they
are not replaced with SP or replaced with '-'.

So it would be the most sensible to just drop 'if LF, replace it
with SP before doing anything else' you added.  The existing 'if
titlechar, add it to sb but if we saw non-title, add a SP before
doing so to wordbreak, and if not titlechar, just remember the fact
that we saw one' should work fine as-is without special casing LF at
all.

Or am I missing something subtle?
