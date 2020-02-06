Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30024C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 21:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA19521775
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 21:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JZvCJTft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgBFVLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 16:11:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53239 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgBFVLY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 16:11:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5F9A44713;
        Thu,  6 Feb 2020 16:11:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hv39PaurBqep
        hzoxlKhMx1Oars8=; b=JZvCJTftlth3dkMHQHi0we56/Cee/9U/g1xY05sqzJO8
        EwSFY3B3k3aSgbB17qLI7bk8M8jExVStz7ekyHXQ694fk5/YvO9IZN1sMGguUhwL
        ntLmRmI1sZhRBmjW+0G7+npM8o8BsuV9cDO7ozeQcS45h6PWwdNao9U1JmcCwvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aoL2NA
        TtrkvC7wCNTHq0xYbk9TEYf5TC1AXNk0qA8HJiUtChThkOW8SM2DAqCHZmhXcN1F
        u57pgsX4xAEYcIZrIOfFgczk7NlNf1bHDRe/HXAqiHbhGf+lQZoa+Bb17ytWdKWp
        zoe3i5fR9v9Rq4twbAvL3cic/Y/7ivmwR/7OA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C25044712;
        Thu,  6 Feb 2020 16:11:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F09B344711;
        Thu,  6 Feb 2020 16:11:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>
Subject: Re: Printing a uint64_t portably in Git?
References: <CAFQ2z_Pac6yb9Vi782VMtPkssNmdc08WntS7xRt8KCFfM6KVsw@mail.gmail.com>
        <CAN0heSqoU1NxOtwaE_ZBBzghLXAeC4CxVh1x8R-efOVtbHdA5g@mail.gmail.com>
Date:   Thu, 06 Feb 2020 13:11:21 -0800
In-Reply-To: <CAN0heSqoU1NxOtwaE_ZBBzghLXAeC4CxVh1x8R-efOVtbHdA5g@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 6 Feb 2020 19:00:02
 +0100")
Message-ID: <xmqqk14ze806.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3A5D2C1E-4925-11EA-91E9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Thu, 6 Feb 2020 at 18:54, Han-Wen Nienhuys <hanwen@google.com> wrote=
:
>> What is the right incantation to do printf of a uint64_t on OSX ?
>>
>> Apparently PRIuMAX is to be used for "uintmax_t", and not for "long
>> long unsigned int".
>
> You could cast it? Grepping around, that seems to be how PRIuMAX is
> used:
>
>   printf("%"PRIuMAX"\n", (uintmax_t)var);

Yup, that is used already in existing code in our codebase, so it is
just as portable as the rest of Git is ;-)

Thanks.
