Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2F3C1F461
	for <e@80x24.org>; Mon, 13 May 2019 07:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfEMHsR (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 03:48:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56987 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfEMHsR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 03:48:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DFDC156F98;
        Mon, 13 May 2019 03:48:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PioQTmUj6Qg+
        11UpKJezb0Er0fk=; b=VlfE4peSFwRas+jONSR9mVOxV/zKud2FvmffYRhq2Q0/
        kt1uMsUb/QEXcyTPUg3Kxm2Uktj15GMtfcIWoKM7HthaVOmTrkD+5kchT8/y49c9
        0GsBq2iVwjG1xN+SECVQAnA0g9wpPiAU6UwIfzv9NQ+3fCeq1kKwXRNd3n2Qh5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AqBK7z
        AhLb5GAUEDfDbhpC7h+AtiOc6CehqjBcHda61pvkma0hhbR2qoMzkg4EUh5Bq6y+
        NJReOpysP3BzkOkpupV59unDq42tZno6o3KqiwBsrj1HEv3M4ZV8oBosWzvXfF0y
        ghQRG+RLRdi1R0QzG6lrx4SBBbqzGRmhC2Nr0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34A45156F97;
        Mon, 13 May 2019 03:48:15 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91406156F96;
        Mon, 13 May 2019 03:48:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 5/5] fast-export: do automatic reencoding of commit messages only if requested
References: <20190430182523.3339-1-newren@gmail.com>
        <20190510205335.19968-1-newren@gmail.com>
        <20190510205335.19968-6-newren@gmail.com>
        <20190511210704.w2mxw3jv2ra2dr7w@tb-raspi4>
        <CABPp-BEzaSW_eY1yTpLr8tXHei0WV54PFGXmjCLAJNN03Zi3eQ@mail.gmail.com>
Date:   Mon, 13 May 2019 16:48:13 +0900
In-Reply-To: <CABPp-BEzaSW_eY1yTpLr8tXHei0WV54PFGXmjCLAJNN03Zi3eQ@mail.gmail.com>
        (Elijah Newren's message of "Sat, 11 May 2019 14:42:17 -0700")
Message-ID: <xmqq1s12dcci.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 76B9684A-7553-11E9-BD77-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sat, May 11, 2019 at 2:07 PM Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
>> On Fri, May 10, 2019 at 01:53:35PM -0700, Elijah Newren wrote:
>
>> This one is good:
>> > +     if (unset || !strcmp(arg, "abort"))
>> > +             reencode_mode =3D REENCODE_ABORT;
>>
>> But here: does it make sense to use REENCODE_YES/NO to be more consist=
ant ?
>> > +     else if (!strcmp(arg, "yes"))
>> > +             reencode_mode =3D REENCODE_PLEASE;
>> > +     else if (!strcmp(arg, "no"))
>> > +             reencode_mode =3D REENCODE_NEVER;
>
> Didn't realize there was any such convention, and even have difficulty
> finding it with grep (CONTAINS_{YES,NO} appears to be the only example
> I can find), but the alternate wording seems fine; I'm happy to adopt
> it.

I am OK with Yes/No. =20

Don't we want to treat this as "bool or literal 'abort'", though?
Other options that are "bool or something else" tend to accept
"true" as a synonym for "yes", and I am wondering if we want to
follow suit here, too.

Thanks.
