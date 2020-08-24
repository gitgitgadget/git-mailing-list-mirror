Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECCDC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661002067C
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rbmGbEAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgHXUqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:46:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51661 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUqy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 16:46:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2464B6C029;
        Mon, 24 Aug 2020 16:46:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=su/lU3LC0XHGxR75KxsJI7JEzaU=; b=rbmGbE
        AgclAN2M92wCL8416ZYCYSctGkPaCoPtX/VAJb6R1W27XsG3bn1e/iIuaSTNFF8w
        pSNFceql7xUUbJK1LIEA7Y1lcpAZADP1mbthsCDCxf7tehnPFk3o5aqBbFKVqG5f
        PsWdQaLWPDHZ1ErsjLB9qwRhhm/AuNApazJd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JXxiH7Nm1DbURXp8PXMKYvU5p43vIzvA
        OcNYBATtzZXHwVWuyF+rfwfqt9uAe7UpgwzrKbGBCUpsUrF9GwP8rqqzmUmqXYxn
        qWSy4xbksW1UBdUCe2lfs9EeHVIF62+e5qACRfvtMVVUqPBLfw/972QjbKJXnvWA
        Kq/dedLbslQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AB2C6C028;
        Mon, 24 Aug 2020 16:46:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92BCE6C026;
        Mon, 24 Aug 2020 16:46:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [GSoC][PATCH] submodule: port submodule subcommand 'add' from shell to C
References: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
        <xmqq8se36gev.fsf@gitster.c.googlers.com>
        <43337924c09119d43c74fdad3f00d4dab76edb51.camel@gmail.com>
Date:   Mon, 24 Aug 2020 13:46:48 -0700
In-Reply-To: <43337924c09119d43c74fdad3f00d4dab76edb51.camel@gmail.com>
        (Kaartic Sivaraam's message of "Tue, 25 Aug 2020 02:00:16 +0530")
Message-ID: <xmqq1rjv4vrb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF600FBA-E64A-11EA-80A8-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>> > 	else
>> > 		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
>> > 		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
>> > 	fi
>> 
>> Hmph.  So,
>> 
>>  - if we are not being 'force'd, we see if there is anything in the
>>    index for the path and error out, whether it is a gitlink or not.
>> 
>
> Right.
>
>>  - if there is 'force' option, we see what the given path is in the
>>    index, and if it is already a gitlink, then die.  That sort of
>>    makes sense, as long as the remainder of the code deals with the
>>    path that is not a submodule in a sensible way.
>> 
>
> With `force, I think it's the opposite of what you describe. That is:
>
>     - if there is 'force' option, we see what the given path is in the
>       index, and if it is **not** already a gitlink, then die. 
>
> Note the `-v` passed to sane_grep.

Thanks.

Yeah, "-v ^160000" passes (i.e. detects an error) if the path exists
and it is anything but gitlink, so missing path is OK (no input to
grep, and grep won't see a gitlink), a blob is not OK (grep sees
something that is not a gitlink), and a gitlink is not OK.

If $sm_path is a directory with tracked contents, ls-files would
give multiple entries, and some of which may or may not be a
gitlink, but most of them would not be, so it is likely that grep
would find one entry that is not gitlink and error out.  Which is a
good thing to do.

>> > 	} else {
>> > 		int err;
>> > 		if (index_name_pos(&the_index, path, strlen(path)) >= 0 &&
>> > 		    !is_submodule_populated_gently(path, &err))
>> > 			die(_("'%s' already exists in the index and is not a "
>> > 			      "submodule"), path);
>> 
>> Likewise.  The above does much more than the original.
>> 
>> The original was checking if the found cache entry has 160000 mode
>> bit, so the second test would not be is_submodule_populated_gently()
>> but more like !S_ISGITLINK(ce->ce_mode)
>
> Yeah, the C version does need a more proper check in both cases.

Especially, the case where $sm_path is a directory with tracked
contents in it would need a careful examination.

Thanks.
