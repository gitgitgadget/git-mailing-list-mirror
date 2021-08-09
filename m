Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C5C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F31B60F56
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhHIRRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 13:17:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60595 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhHIRRt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 13:17:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87F79144D42;
        Mon,  9 Aug 2021 13:17:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2vdwh1L73CmS
        hvRVpXh3IUMB/tBAeIS6CHbsgszdWjM=; b=r8yExGhJH6/75dneVbK7E7VYEQnf
        WkPbtip8wUhPS2sKWGAuFcvnHq8t+72fTCsyHD2BTeLcHnAyJ8zbtM8UQo0dw3GO
        1ms+q0a21zYfyyPgnF6S3OIGLyOyuvzWItktC57zH6bY3b9m7/Xlm0y8aWwODubU
        RoMoLuvz2aNoz+I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 795F6144D41;
        Mon,  9 Aug 2021 13:17:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C0C9E144D40;
        Mon,  9 Aug 2021 13:17:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #03; Fri, 6)
References: <xmqqzgtuf6r0.fsf@gitster.g>
        <CABPp-BFOusrK6E6n91XSXcKP8kin-8RX8L_HXdKRjS790HkwHQ@mail.gmail.com>
Date:   Mon, 09 Aug 2021 10:17:23 -0700
In-Reply-To: <CABPp-BFOusrK6E6n91XSXcKP8kin-8RX8L_HXdKRjS790HkwHQ@mail.gmail.com>
        (Elijah Newren's message of "Sat, 7 Aug 2021 10:29:11 -0600")
Message-ID: <xmqqlf5afsgs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AABD8BD6-F935-11EB-9800-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Aug 6, 2021 at 6:26 PM Junio C Hamano <gitster@pobox.com> wrote=
:
>
>> * jt/push-negotiation-fixes (2021-07-15) 3 commits
>>  - fetch: die on invalid --negotiation-tip hash
>>  - send-pack: fix push nego. when remote has refs
>>  - send-pack: fix push.negotiate with remote helper
>>
>>  Bugfix for common ancestor negotiation recently introduced in "git
>>  push" codepath.
>>
>>  Needs review.
>
> I decided to take a look.  It appears both Emily and =C3=86var have
> reviewed previously.  =C3=86var brought up some comments on v2 of patch=
 2,
> but Jonathan responded to them all (and Peff chimed in as well), and
> there has been no further response from =C3=86var leaving the impressio=
n to
> me that Jonathan has replied to all feedback.
>
> I'm not at all familiar with the protocol areas of the code, but I
> tried to read over the patches too.  I think it'd have been a bit
> easier to understand for someone unfamiliar with this area if there
> were separate patches that introduced test_expect_failure showing the
> particular failures being fixed, followed by fixes in subsequent
> patches.  I also noticed a stray newline removal in patch 2.  Those
> are pretty minor issues, though, and I didn't spot anything
> substantial.

I am mostly worried about the lack of response to comments on [2/3],
especially to Peff's "Wouldn't this also be a problem for
multi-round fetch?".

Thanks.
