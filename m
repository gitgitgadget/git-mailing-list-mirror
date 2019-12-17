Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD496C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 17:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C28C24655
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 17:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kz93QSsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfLQRd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:33:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59206 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLQRd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 12:33:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CA021C0CF;
        Tue, 17 Dec 2019 12:33:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KNW2+sWxhYiG5tPhSNVQuw5kup0=; b=Kz93QS
        snTuyPHVjx9wT+YJUtGEWXRs7HjhzQ7wKuyFIYGYViogPtWOMsS0hCZoDR2zvfx6
        NnO2ZNlsHewwc9te2KuZeaIQYGzGPwHvYsXkUm6ooCUEQDF/B0laPJH60mIUOA/t
        lOy/N3WX+tV1B3BXCfvmYG1LYQ5C3wvJ2+mCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ngmSxtoTJ424c08l7LNPk/Uj0+/pyrgs
        l5mQYZdkIM40tHRKw28O0XtSM/oZDz+LHY3FtuUL6jR5JzLDVJ+YyH6Z2pbAZB5a
        99vZb8SbratID8Ham35IhvXgJJCPOQBVohA9YN6+yOFhf0uGhGz4gff+x325h34+
        shcKc1yBcqA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 453471C0CE;
        Tue, 17 Dec 2019 12:33:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4C371C0CB;
        Tue, 17 Dec 2019 12:33:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
        <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
        <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet>
        <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com>
        <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com>
        <nycvar.QRO.7.76.6.1912170101230.46@tvgsbejvaqbjf.bet>
        <xmqqr213iz9z.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1912171157140.46@tvgsbejvaqbjf.bet>
Date:   Tue, 17 Dec 2019 09:33:49 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1912171157140.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 17 Dec 2019 12:08:12 +0100 (CET)")
Message-ID: <xmqqk16uj1qa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 638338F4-20F3-11EA-BF5F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > [XSI][Option Start]
>> > ino_t  d_ino       File serial number.
>> > [Option End]
>> > char   d_name[]    Filename string of entry.
>> >
>> > You will notice that not even `d_type` is guaranteed.
>>
>> I am reasonably sure that the code (without Elijah's patches anyway)
>> takes the possibility of missing d_type into account already.
>>
>> Doesn't the above mean d_name[] has to be an in-place array of some
>> size (i.e. even a flex-array is OK)?  It does not look to me that it
>> allows for it to be a pointer pointing at elsewhere (possibly on
>> heap), which may be asking for trouble.
>
> You are right, of course.
>
> ...
>
> Is this compliant with POSIX? I guess not. Does it work? Yes, it does.

I actually would not throw it into "it works" category.  The obvious
implication is that a program like this:

	static struct dirent *fabricate(const char *name)
	{
        	/* over-allocate as we do not know how long the	d_name[] is */
		struct dirent *ent = calloc(1, sizeof(*ent) + strlen(name) + 1);
		strcpy(ent->d_name, name);
		return ent;
	}

	static void show_name(const struct dirent *ent)
	{
		printf("%s\n", ent->d_name);
	}

	int main(int ac, char **av)
	{
		struct dirent *mine = fabricate("mine");
                show_name(mine);
		free(mine);
		return 0;
	}

would be broken if you do not have d_name as an array.

I would not be surprised if the segfaults you saw with Elijah's
series all were caused by your d_name not being an array, and if
that is the case, I'd rather see it fixed on your end than fixes
withdrawn.

Thanks.
