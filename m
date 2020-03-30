Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E233C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FFB2073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DkA2M72e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgC3Qzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:55:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61648 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgC3Qzw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 12:55:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B7EFAB7CB;
        Mon, 30 Mar 2020 12:55:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lYG/xdPoxTkE0glgTLNrL9mc+E0=; b=DkA2M7
        2eW6lAI8NoqfWRFC/xMMG7C8nX8rheefPsRpp+z177ONfHG+OXnsIw/jUyLMSY3z
        +WOMuy4lvb3pqdDwt3LgRQXzeKTt1Zg9QHsJszmaQzWRidHNfrYzUTF7ZY0whyo9
        onihzT7RbTu6CwFZYnftHZP7ZpF91mMSF+A1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QPNKB7mmmyEvIhui10AIY/k4JL1WSbvQ
        yz063KONvPVIwAPc8YH59ThVmQjXhVPi2Ia6gwL6+wHBFLqR1HP6wy82UTVC2W0Z
        XZvstE9SClgkeVIV8DQ5pge64YYW9aLP1f8v8N5/e4BW/mOxxsH6Ds4eK8PvVdF4
        Avxn92jfuqk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02CB8AB7CA;
        Mon, 30 Mar 2020 12:55:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D217EAB7C7;
        Mon, 30 Mar 2020 12:55:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 4/9] update-ref: organize commands in an array
References: <cover.1585129842.git.ps@pks.im>
        <50ffc263293571f8af71fd1d253ac238c6909229.1585129842.git.ps@pks.im>
        <xmqqh7y9fq29.fsf@gitster.c.googlers.com>
        <20200330080551.GA186019@ncase.pks.im>
Date:   Mon, 30 Mar 2020 09:55:44 -0700
In-Reply-To: <20200330080551.GA186019@ncase.pks.im> (Patrick Steinhardt's
        message of "Mon, 30 Mar 2020 10:05:51 +0200")
Message-ID: <xmqqwo7193zj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C9E5FBE-72A7-11EA-AA6E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> 	for (i = 0; i < ARRAY_SIZE(command); i++) {
>> 		const char *eoc;
>> 		if (!skip_prefix(next, commands[i].prefix, &eoc) ||
>> 		    *eoc != ' ')
>> 			continue;
>> 		cmd = &command[i];
>>                 next = eoc;
>> 		break;
>> 	}
>
> The reason why I moved those `skip_prefix` calls into each of the
> respective commands is that this patch series introduces calls that do
> not accept a trailing space at all. Thus we cannot handle the space
> generically here, as that would was soon as we introduce the set of new
> commands.

That's not a good excuse, though, is it?  The command[] structure
can say "this takes parameters" or even "this takes N parameters",
and the field being zero (i.e. "does not take parameters" or "takes
zero parameters") would mean you do not want a trailing SP, no?

I also suspect that the "extra lines" thing we'd see in a later step
is correlated with this, but we'll see.

Thanks.
