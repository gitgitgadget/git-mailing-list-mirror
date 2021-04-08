Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA76C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0683E6115B
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhDHX4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:56:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53416 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHX4x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:56:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A505130809;
        Thu,  8 Apr 2021 19:56:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DzXsCrHLm0bq
        sLcOfzJ/jZ5Bc04=; b=DtcMzC48NSN0P9ERREDP3NrOw42qbxo3OUCxzKBjvBCv
        NROlZdDxUd544BPV4bQ0U8mX6hzJXKGEGK+BvMQlq46Jmbtu6PQ4bsVWjuuyMOf5
        rk0VYLOUkbcxCsQw5dhhx3jd6e/io5W1xvUkTNlQA++do2qvxnRsFVIRr8gM1bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QRZ/mR
        V10piwPncl60BfSpaZ65Fb0NtQjcM0HSy5xkKpTR0de28xbH15PX9qmREimVOaZK
        AccU80qaOFOG/5uwlLS4BVntwkJTbF/IVuBZ/Z2MhAyaQYzkvUdgNF/pnmfHY6Qr
        wLHguC+1AuYs+jKhTzUMdJLi5huPSEUGQ4ug0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03150130808;
        Thu,  8 Apr 2021 19:56:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 50FF2130807;
        Thu,  8 Apr 2021 19:56:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] config: Introduce GIT_CONFIG_NOGLOBAL
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
        <8735w0icb9.fsf@evledraar.gmail.com>
Date:   Thu, 08 Apr 2021 16:56:35 -0700
In-Reply-To: <8735w0icb9.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 09 Apr 2021 01:30:50 +0200")
Message-ID: <xmqqo8eopbyk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0E28DC64-98C6-11EB-9B33-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 08 2021, Patrick Steinhardt wrote:
>
>> +`GIT_CONFIG_NOGLOBAL`::
>> +	Whether to skip reading settings from the system-wide `~/.gitconfig`
>> +	and `$XDG_CONFIG_HOME/git/config` files.  This environment variable =
can
>
> Let's not call ~/.gitconfig system-wide with /etc/gitconfig being,
> saying "global" is consistent with git-config's own
> --global/--system/--local etc. Still a bit odd, but at least the same
> nomenclature.

Yeah, GLOBAL should be renamed to PER-USER everywhere.
