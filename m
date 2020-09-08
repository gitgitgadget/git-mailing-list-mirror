Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1DEC43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A677021919
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UTTLSS7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbgIHTb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:31:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62488 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbgIHTbv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:31:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C439E5FAF;
        Tue,  8 Sep 2020 15:31:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TLjnAYnnd9xO
        y3b4Y+tCzkrM774=; b=UTTLSS7ztQVpuFUIHNgNPECNnxiCfQHOUrbXqmkRCuOW
        nE58rrq6mpgJKql79DOJ9L9ujgvNV7xZiIYX1r/DDBRIlfx1PNChix2zEI/esf/2
        sQ/05XG44Poup5May89AVI84CHAOQdmJT4cYGxbEaztH4oPWAcNQZlg75GUuMK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S1IL1R
        qxXxz9qBwxTvv9G9lLbPlD4Mn6Gkj2Og6YYgbcz13JcKoSY9RpdY61Pcy4rv14Qh
        wIsv+izdcDIRouCgGxwkM29KFdBeUMlL7ForgZHiLELo2UKtD1HlJJPZ+qbovFpn
        3HYkdTpNmT2MdLfxlI3Rw9kYLI7o7zmjEXeB4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 223BEE5FAE;
        Tue,  8 Sep 2020 15:31:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 46F2BE5FAB;
        Tue,  8 Sep 2020 15:31:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH 5/7] maintenance: add start/stop subcommands
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
        <e02641881d998d1e6a31e941b61eb6f89d0519f7.1599234127.git.gitgitgadget@gmail.com>
        <20200908062914.GC6209@szeder.dev>
Date:   Tue, 08 Sep 2020 12:31:39 -0700
In-Reply-To: <20200908062914.GC6209@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Tue, 8 Sep 2020 08:29:14 +0200")
Message-ID: <xmqqv9goxdyc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC680130-F209-11EA-B369-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +int cmd__crontab(int argc, const char **argv)
>> +{
>> +	char a;
>
> So 'a' is a char...
>
>> +	FILE *from, *to;
>> +
>> +	if (argc =3D=3D 3 && !strcmp(argv[2], "-l")) {
>> +		from =3D fopen(argv[1], "r");
>> +		if (!from)
>> +			return 0;
>> +		to =3D stdout;
>> +	} else if (argc =3D=3D 2) {
>> +		from =3D stdin;
>> +		to =3D fopen(argv[1], "w");
>> +	} else
>> +		return error("unknown arguments");
>> +
>> +	while ((a =3D fgetc(from)) !=3D EOF)
>
> fgetc() returns an int, which is assigned to a char, which is then
> compared to whatever EOF might be on the platform.  Apparently this
> casting and comparison doesn't work as expected on s390x (I haven't
> even tried to think it through...), and instead of detecting EOF and
> exiting we end up in an endless loop writing 0xff bytes to 'cron.txt',
> while 'git maintenance start' in vain waits for 'test-crontab' to
> exit.

Ah, is this fun with unsigned char never comparing equal to -1?
