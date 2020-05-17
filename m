Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8147C433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F43D206F4
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cjn411B4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEQPNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 11:13:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59805 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgEQPNC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 11:13:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2979456FD0;
        Sun, 17 May 2020 11:13:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tGSTL1swbjh8
        bJE3OGAJpeTdyps=; b=cjn411B40gTx9Ww8F5PVrEnMZvjoyqPSgGJT4gaGt3Ju
        2rbH/G0T8G3sDwZWmSX+xtWqt296iiSnViZ2zDhhi76zmjcqVfMWxbjDxAqXAdIQ
        reXLh4nOuMKYkqyjgX3KxgYjLbnDHFjFuwkx7F8g+9Vhqy0l3cJfF8YSP9vQY5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=i0+kc1
        jaRKGRb/7JyIwmqwrvuMyjtcQl/1x/NJVmLx/MC3OxTYaDnacNRm8GyVqkuxFwI9
        roxufLMK5FrhyzBYqIGviSweVwDngCMgG9tLFJXTFa4pxelF51oa5lsFUU3PFWzF
        kah/hAwH5qqosbv7GQSNdS27skJaDkmOOcwr8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CF1856FCF;
        Sun, 17 May 2020 11:13:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9331E56FCD;
        Sun, 17 May 2020 11:12:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Laurent Arnoud <laurent@spkdev.net>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v4] diff: add config option relative
References: <20200515155706.GA1165062@spk-laptop>
        <20200515233130.GC6362@camp.crustytoothpaste.net>
        <xmqq1rnk923o.fsf@gitster.c.googlers.com>
        <20200516173828.GB34961@spk-laptop>
        <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
        <20200516194033.GA2252@spk-laptop> <20200517021452.GA2114@danh.dev>
Date:   Sun, 17 May 2020 08:12:58 -0700
In-Reply-To: <20200517021452.GA2114@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Sun, 17 May 2020 09:14:52 +0700")
Message-ID: <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E512D152-9850-11EA-A135-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>>  Documentation/config/diff.txt   |  4 ++
>>  Documentation/diff-options.txt  |  3 ++
>>  diff.c                          | 16 ++++--
>>  t/t9904-diff-relative-config.sh | 93 ++++++++++++++++++++++++++++++++=
+
>
> I think t99?? is used for miscellaneous tests.
>
> To me, diff-relative things should be tested in t4045-diff-relative.sh

Right.  Thanks for carefully checking what we already have.

>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-optio=
ns.txt
>> index bb31f0c42b..1b279904eb 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -651,6 +651,9 @@ ifndef::git-format-patch[]
>>  	not in a subdirectory (e.g. in a bare repository), you
>>  	can name which subdirectory to make the output relative
>>  	to by giving a <path> as an argument.
>> +--no-relative::
>
> Please merge this option with `--relative[=3D<path>]` above.
> And says something likes:
>
> 	`--no-relative` can be used to countermand
> 	both `diff.relative` and previous `--relative`

This, and all the rest of comments are quite good.  Thanks for helping.
