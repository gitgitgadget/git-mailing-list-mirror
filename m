Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF38C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A8461039
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbhJGSI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:08:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58230 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhJGSI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 14:08:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB492E60F5;
        Thu,  7 Oct 2021 14:07:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GPkmJ+9DsKQjZgDH3F8K6eJFWCRHAKqieMBnbU
        rH4sU=; b=Bb3ptmDmi6jUNuGZ1/srNcPn0jKkREENp2lqQrO6iP5jRcwchSbYFw
        iZLx2QTXZItuq4JvH0rghxXIKYUQnoKCtL5bVYPqgmAA5Yv24kECE59Wv1ssVJ0U
        OujuaUVd+rLlbVlBw9m9qYz4dPZN8ji+iXfehOWfoh/stxbwCKR6E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3CC6E60F4;
        Thu,  7 Oct 2021 14:07:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A1FAE60EF;
        Thu,  7 Oct 2021 14:07:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] object.[ch]: mark object type names for translation
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
        <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
        <patch-v2-1.2-55bde16aa23-20211004T142523Z-avarab@gmail.com>
        <YV3zZFOJd6blVGXn@coredump.intra.peff.net>
        <xmqqv92aq6m3.fsf@gitster.g>
        <YV4JQytrc9UTa22o@coredump.intra.peff.net>
Date:   Thu, 07 Oct 2021 11:06:59 -0700
In-Reply-To: <YV4JQytrc9UTa22o@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 6 Oct 2021 16:38:27 -0400")
Message-ID: <xmqq35pcr9oc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E95E7CA-2799-11EC-9922-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 06, 2021 at 12:46:12PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > They all appear to want is as a noun. So maybe this is just
>> > mis-translated for Spanish. It does feel like an accident in the making,
>> > though.
>> 
>> Probably we need pgettext().
>> 
>> https://www.gnu.org/software/gettext/manual/html_node/Contexts.html
>
> Yeah, that make sense. I'm not sure how it interacts with N_(), though.
> I.e., I'd expect the "context" to ride along with the original string,
> but I guess it is really in the caller who's translating it. So the real
> spot becomes:
>
>   printf(_("my type is %s"), pgettext("object-type", type_name(type)));
>
> It's a little unfortunate that every caller has to do it rather than
> putting it near the source string. But I guess a type_name_human() would
> solve that, too. ;)

Yes, I agree the need for pgettext() is annoying but I do not see an
easy alternative.  Introducing a wrapper like type_name_human() to
limit the damage sounds like the best we could do.

Thanks.
