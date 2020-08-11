Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A15BC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E03206DC
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mCc97V9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgHKVBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:01:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63534 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHKVBn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:01:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 105B084A98;
        Tue, 11 Aug 2020 17:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oeHYJ2cIh6S6
        +B0fo/9yiRup76w=; b=mCc97V9g342ZdVUwchtxQas25HGUTlxadeG2fEN8PFvb
        pxMGoHzYgAuIt3ep1NkgToN59cqpdAPBVBYxgM/PhlQLzFFr/U7Bf083sFGFrpuG
        yVBvG8sufbdo0t6hrGeJ/gmlVVeGbTdc4bxweTcEw573l+wvT+dBdNV7XndAo0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=q7rcaD
        NgImh/uINjNsCkMnvuWQs+w0lC7hMCAJ5WSo5ueLqgKWFr75OTh2M5s80f+yhEza
        Vrj7O2/2uma/t0Srkd9E2hnmGbihtbEh1f9l+TfZyQycvQLhB4PjbqNYx/CKQFbO
        +Dy8LBbTwKhSGHJVjtpOS7PKzjH1NOrAtVGnA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06A3E84A97;
        Tue, 11 Aug 2020 17:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4573984A96;
        Tue, 11 Aug 2020 17:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] upload-pack: remove superfluous sigchain_pop() call
References: <29ac165c-8458-9bb1-7e59-e7c2c68a9f2a@web.de>
        <20200811182603.GB33504@syl.lan>
Date:   Tue, 11 Aug 2020 14:01:39 -0700
In-Reply-To: <20200811182603.GB33504@syl.lan> (Taylor Blau's message of "Tue,
        11 Aug 2020 14:26:03 -0400")
Message-ID: <xmqqtux899sc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA4B2F9A-DC15-11EA-9898-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Aug 11, 2020 at 07:15:03PM +0200, Ren=C3=A9 Scharfe wrote:
>> 2997178ee6 (upload-pack: split check_unreachable() in two, prep for
>> get_reachable_list(), 2016-06-12) moved most code of has_unreachable()
>> into the new function do_reachable_revlist().  The latter takes care t=
o
>> ignore SIGPIPE during its operations, and restores the original signal
>> handler before returning.
>>
>> However, a sigchain_pop(SIGPIPE) call remained in the error handling
>> code of has_unreachable(), which does nothing because the stack is
>> empty after do_reachable_revlist() cleaned up after itself.  Remove it=
.
>
> Thanks for noticing. Your analysis seems correct to me after a quick
> inspection of the code, so this has my:
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  upload-pack.c | 1 -
>>  1 file changed, 1 deletion(-)

Yeah, looks good to me, too.  Thanks, both.


>> diff --git a/upload-pack.c b/upload-pack.c
>> index d087113d23e..1b068da0d26 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -731,7 +731,6 @@ static int has_unreachable(struct object_array *sr=
c, enum allow_uor allow_uor)
>>  	return 0;
>>
>>  error:
>> -	sigchain_pop(SIGPIPE);
>>  	if (cmd.out >=3D 0)
>>  		close(cmd.out);
>>  	return 1;
>> --
>> 2.28.0
>
> Thanks,
> Taylor
