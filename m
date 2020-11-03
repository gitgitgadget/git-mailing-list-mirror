Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65DDC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 22:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F99722404
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 22:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JNhak1oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgKCWan (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 17:30:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54653 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgKCWan (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 17:30:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39AA17D20F;
        Tue,  3 Nov 2020 17:30:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lNYq9HpJnHpDmfDHmWgGIkUvtmk=; b=JNhak1
        oiuD5ih+rokUjFpVwu0fBYR26dqQRv2xWjfvDyQBvVoHa9A0tO0zRT/B2iNLH7VG
        AtJ7Z4ZygWyIMRmbwieDZedzSgQP68wYpf48A7PXT6/30DTOAtELI+C/M4AFZVEE
        +m/PRm4HtuPuNEqhGNgKgSxAM62UJJgc5rX0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A6ZzVr1i+sX67HAh7OPmz3lJvXNPfv0d
        kM5uo53vbasXuRRFjiMFIUk2dGdVinVN4py9j2By6tftsVT6Vkh4rPbsYidVe/QX
        Dq8gYHEZ1sGiXOeNntIbNK+EpFoR+NM26KWLVZuVwxfiuZOQYu0j/7Y00upY5avq
        f3yMmlT8C20=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30CA77D20C;
        Tue,  3 Nov 2020 17:30:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 998197D20B;
        Tue,  3 Nov 2020 17:30:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Maintenance IV: Platform-specific background
 maintenance
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
        <xmqqmtzyqjil.fsf@gitster.c.googlers.com>
        <022c5792-e66c-71d8-fbf4-ead9231030ad@gmail.com>
Date:   Tue, 03 Nov 2020 14:30:39 -0800
In-Reply-To: <022c5792-e66c-71d8-fbf4-ead9231030ad@gmail.com> (Derrick
        Stolee's message of "Tue, 3 Nov 2020 16:09:46 -0500")
Message-ID: <xmqqo8keoyy8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34172D4E-1E24-11EB-86BC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/3/2020 3:21 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> This is based on ds/maintenance-part-3.
>> 
>> Ah, I forgot to ask those on CC list how carefully they read the
>> part 3 of the series, as it's been left on 'seen' for some time, and
>> I do not know if it is ready to start cooking in 'next'.
>
> It has been a while since anyone has commented, and I've been
> running the patches locally for quite a while. I'd be very
> happy to see them cook in next. I wasn't quite to the place
> to be pushy about it.
>
> I'm hoping that parts 3 and 4 can make it in time for 2.30,
> so the feature is universally available for all platforms.
> I realize that's not entirely up to just me.

After writing this entry in the What's cooking report:

    * ds/maintenance-part-4 (2020-11-03) 3 commits
     - maintenance: use Windows scheduled tasks
     - maintenance: use launchctl on macOS
     - maintenance: extract platform-specific scheduling
     (this branch uses ds/maintenance-part-3.)

     Follow-up on the "maintenance part-3" which introduced scheduled
     maintenance tasks to support platforms whose native scheduling
     methods are not 'cron'.

I was wondering if I should propose making these two parts into one,
so we may be pretty much on the same page.

