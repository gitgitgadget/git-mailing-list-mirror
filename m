Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A591F461
	for <e@80x24.org>; Tue, 16 Jul 2019 19:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfGPT4y (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 15:56:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58995 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGPT4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 15:56:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79C8E6F2DC;
        Tue, 16 Jul 2019 15:56:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8H5AHZNjs+LC
        p4vu+VqT3oOEiXo=; b=BMT1ElgMt9fM7nhHKahjHOFZQqA++jUesuDSto0+h8O4
        vKQKfrHaF2gUILP1iwOmah70g38WCY3mzzQ6xZQB5oPlpYXqTfHiPcz+IXFVndxI
        ICqZ1HhwbvORRayRJDfWRoe7aEfd26fdfmXBHOlQ4+DVn66rsorx31OCTRgVcYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Yt1CZl
        zlmWtzdxerO5Nq4r3b/5wNNUNTS1nIJPTBWAEYhWoyVDw4tSODw6fIFUJYLYXRNX
        NWGoH/i7wBzJ5j8WIeDvpHkciIrJBSFo4AI2UFzZqF1wVYXaXz4yoqyTv2ICEdH2
        QPKiaZBle1xJ9zugGGswYXym+0GBILYa7rw/k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 704026F2DA;
        Tue, 16 Jul 2019 15:56:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D9656F2D9;
        Tue, 16 Jul 2019 15:56:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] clean: show an error message when the path is too long
References: <pull.219.git.gitgitgadget@gmail.com>
        <36677556a26cca9eafd859c88aa9b2c5a6cde309.1563285862.git.gitgitgadget@gmail.com>
        <a7fee3c7-8fd5-11ef-8b0d-ff8053987b0c@web.de>
Date:   Tue, 16 Jul 2019 12:56:44 -0700
In-Reply-To: <a7fee3c7-8fd5-11ef-8b0d-ff8053987b0c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 16 Jul 2019 17:01:27 +0200")
Message-ID: <xmqqftn53g8z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D821BD66-A803-11E9-B48A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index aaba4af3c2..7be689f480 100644
>> --- a/builtin/clean.c
>> +++ b/builtin/clean.c
>> @@ -194,7 +194,8 @@ static int remove_dirs(struct strbuf *path, const =
char *prefix, int force_flag,
>>  		strbuf_setlen(path, len);
>>  		strbuf_addstr(path, e->d_name);
>>  		if (lstat(path->buf, &st))
>> -			; /* fall thru */
>
> I don't understand the "fall thru" comment here.  It only makes sense i=
n
> switch statements, doesn't it?  And the code after this if/else-if/else
> block is only executed if we pass through here, so why was it placed wa=
y
> down in the first place?  Perhaps for historical reasons.

f538a91e ("git-clean: Display more accurate delete messages",
2013-01-11) introduced that line when it first introduced the
function and it is not inherited from anything else.  As the if/else
cascade has a catch-all else that always continues at the end, failing
lstat is the only way for the entire loop to break out early, so as
you hinted above, having the "fail, break and return" right there would
probably be a better organization of this loop.

> Anyway, I'd keep that strange comment, as I don't see a connection to
> your changes.  (Or explain in the commit message why we no longer "fall
> thru", whatever that may mean.  Or perhaps I'm just thick.)
>
>> +			warning("Could not stat path '%s': %s",
>> +				path->buf, strerror(errno));
>
> The other warnings in that function are issued using warning_errno()
> (shorter code, consistency is enforced) and messages are marked for
> translation.  That would be nice to have here as well, no?

Absolutely.  Also, downcase "Could" and perhaps use _() around.

As to the "fall thru" comment, I tend to agree that it does not fall
through to the next "case" in the usual sense and is confusing.
Mentioning that we removed a confusing and pointless comment in the
log message would be nice, but I'd vote for removing it if I was
asked.

Thanks.





