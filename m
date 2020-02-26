Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DD5C4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3513F24653
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bHaTZlji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgBZUFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:05:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52300 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgBZUFA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:05:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21CBCB8E1F;
        Wed, 26 Feb 2020 15:04:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9d964kcj31MeDZm0LMgfTwlnn0w=; b=bHaTZl
        jiH9dhP5DVUWd1ETEGMrj6u4tpw3yvSob7pzWUibY1hhGOgF7NQ27LZbw6r25f4K
        xuVAc9pNzjcEAzpBqJ9gqz/C3w8syIN+qCnfYXj0DaqNKO+n31y3VI7t/Kh92P1h
        BWx4bTTweYoyhudyKUFtQxA6VtNOsu5apLUx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Btp7NBB+8OX7aALjxlUJPT/KIKmugL/T
        MOAtLyb3TwfVMeukqndWBQQq03zZmQHiN/hnUv/gYFH0lJKLMr95eH+E7A2ZMOiE
        u+NsQBAoFbCREPJCOHoHBIYk/8w9HiJ7D2qdiKrHOGD2zBk25Q2jJzzxItp+y+IX
        se7MM8qB9NA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 18C20B8E1E;
        Wed, 26 Feb 2020 15:04:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B12CB8E1D;
        Wed, 26 Feb 2020 15:04:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v6 0/5] Reftable support git-core
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
        <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <20200221064026.GA11129@google.com>
        <CAFQ2z_P8Ph_f0CbYHYZm0XVyk+ax+Dv_-FrSSyLBkB-xn-uupA@mail.gmail.com>
Date:   Wed, 26 Feb 2020 12:04:53 -0800
In-Reply-To: <CAFQ2z_P8Ph_f0CbYHYZm0XVyk+ax+Dv_-FrSSyLBkB-xn-uupA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 26 Feb 2020 18:16:01 +0100")
Message-ID: <xmqqr1yhi07u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41BE4AF2-58D3-11EA-A818-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Fri, Feb 21, 2020 at 7:40 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>> > This adds the reftable library, and hooks it up as a ref backend.
>>
>> As promised, here's a patch to include the reftable spec in git.git.
>> Please include this in the next iteration of this patch series (or if
>> you prefer for it to land separately, that's also fine with me).
>
> I did.

Ahh, I didn't see that original request to make it part of the
series.  Let me drop the standalone patch and revert it out of
'next', so that we can polish it as a part of this topic, which
makes a lot more sense.

Thanks.
