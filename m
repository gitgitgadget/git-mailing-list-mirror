Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624B9C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B4E610C7
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhJFTsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 15:48:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55754 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbhJFTsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 15:48:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A626015B649;
        Wed,  6 Oct 2021 15:46:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7tgxcJAy/15XLUaOP+pgVicpXRq68x5mTy+V1V
        mbWTo=; b=tdvblKvjlnsYxSNhYPAyzvVcf/gfH6d20uQkPaxpboykmTuhMPRJUG
        LBit0LBt6U4OIGs7+P59VLxSVkWlSylp0or2+bKnWQ8RP2OV2yAjupo+dEtMCutZ
        oZ+DoGnpbWDlYjruuG1q53DleY536C+mjZeteNcuPtM4K79Qduv3c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E5EB15B648;
        Wed,  6 Oct 2021 15:46:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0752715B646;
        Wed,  6 Oct 2021 15:46:14 -0400 (EDT)
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
Date:   Wed, 06 Oct 2021 12:46:12 -0700
In-Reply-To: <YV3zZFOJd6blVGXn@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 6 Oct 2021 15:05:08 -0400")
Message-ID: <xmqqv92aq6m3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 105841F4-26DE-11EC-B6F6-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> They all appear to want is as a noun. So maybe this is just
> mis-translated for Spanish. It does feel like an accident in the making,
> though.

Probably we need pgettext().

https://www.gnu.org/software/gettext/manual/html_node/Contexts.html

> I do wonder how useful it is to translate these type names in general.
> Especially as used in this series, they're really technical terms, and
> you are not going to escape the name "git commit" as a command.

I share the same feeling (I do not use translated git, either).

> Now if you introduced type_name_human(), which auto-translated and
> converted NULL to "unknown", then that would be easy to plug in
> appropriately as you audited the callers.

Yes.

>
>>  static const char *object_type_strings[] = {
>> ...
>> +	N_("commit"),	/* OBJ_COMMIT = 1 */
>> +	N_("tree"),	/* OBJ_TREE = 2 */
>> +	N_("blob"),	/* OBJ_BLOB = 3 */
>> +	N_("tag"),	/* OBJ_TAG = 4 */
>>  };
>
> This does make me feel slightly uneasy, just because so many parts of
> Git rely on these _not_ being translated. But I see in your other
> response that N_() really does nothing. So aside from possibly
> misleading readers of the code, I think this is probably OK.

Yes, this may be scary looking but the least risky part of this
patch, as N_() is no-op at runtime ;-).

