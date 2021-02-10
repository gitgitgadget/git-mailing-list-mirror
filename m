Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA43C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 07:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D43264E42
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 07:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhBJH06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 02:26:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57298 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhBJHZi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 02:25:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3B92110625;
        Wed, 10 Feb 2021 02:24:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QVlgZz7OkcWctUFcfogjWUy2DtE=; b=gQe3p/
        vb9u6r6ia0V36hbCAgNXfMhtQ7KXv40c3AgDvCn3jdLHXOgmyKO/HiJf7cTO3o1l
        6/IlRTJoTaQWjbTLv/v7Z+wjOdVE6ZNiFp5gtsxfeayXim64jMJf1Rs3WkDT0ouQ
        q4CyfpxH7xLmKaJGzgcIbnnH6ICMdaf2JsuVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sYQfI/TvMIFizjlE4Ni3MJEnqwTqDONB
        BgGkFd2IZPR5EQPDPF5VLgw7XSArhNmmBL/GU/uLetUEg7X1Gj3A26b8ZWyByxLb
        zyLBogqKzjdIi62HLiiaa/0J61tvdVVBvYX6pomT7MStVlPYYEOP+yVGqT+k0s8o
        Ki7sY2MJIhw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0EF9110623;
        Wed, 10 Feb 2021 02:24:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2B214110622;
        Wed, 10 Feb 2021 02:24:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/9] t3905: remove nested git in command substitution
References: <cover.1612258145.git.liu.denton@gmail.com>
        <cover.1612855690.git.liu.denton@gmail.com>
        <57c21e2461eea8a37456d211f38fb668278cb2ed.1612855690.git.liu.denton@gmail.com>
Date:   Tue, 09 Feb 2021 23:24:53 -0800
In-Reply-To: <57c21e2461eea8a37456d211f38fb668278cb2ed.1612855690.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 8 Feb 2021 23:28:50 -0800")
Message-ID: <xmqqk0rg4c6y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1290FDF4-6B71-11EB-8F5A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> If a git command in a nested command substitution fails, it will be
> silently ignored since only the return code of the outer command
> substitutions is reported. Factor out nested command substitutions so
> that the error codes of those commands are reported.

Locally this makes sense.  We may want to clean it up further by
using existing blob objects, instead of using hash-objects, but that
is for some other day.
