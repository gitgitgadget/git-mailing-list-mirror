Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5595D1F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 13:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeKQXVv (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 18:21:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57213 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeKQXVu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 18:21:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53A5610E9E6;
        Sat, 17 Nov 2018 08:05:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TGesiA75kays
        uCn2/JlD2g25LbY=; b=It/iwHh8kt4iG2LZW1ngT8nZlqecD257XfXoJjSceQAe
        wipgi5nbkOmtjistaYmWnd3y0OZOUPUkEwLc1lBrP3oXiKgmwEp7r5snrI2JdZNZ
        fdzRR6HIcBJGci0xO0+b44xr+xTMzKC6szVKGnDoxwckDMWYYJyuAwfU4RPUWek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dQhGq+
        ZFZIu6mLY45AxkcVYK6L50/n35zlqzuVyNbB+qrBfvcOQeFxMHaTugmPNFYMqDJn
        unxcUjbTdQXjCedmPGU8nS60d5RFHRRNzct2+jt+D1aBAUPDTOvzUy+4oui0nUdl
        FI002TaS+uGEXjJwjmSJhqXVN0YtPW7c/ccnE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C24410E9E5;
        Sat, 17 Nov 2018 08:05:11 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B51C410E9E3;
        Sat, 17 Nov 2018 08:05:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
References: <20181116173105.21784-1-chriscool@tuxfamily.org>
        <xmqqpnv4gigi.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD0f_oD2cm61exc9mCczD59ze0Qj1cHGn-MvtSMWNXA+gg@mail.gmail.com>
Date:   Sat, 17 Nov 2018 22:05:09 +0900
In-Reply-To: <CAP8UFD0f_oD2cm61exc9mCczD59ze0Qj1cHGn-MvtSMWNXA+gg@mail.gmail.com>
        (Christian Couder's message of "Sat, 17 Nov 2018 12:19:41 +0100")
Message-ID: <xmqqftvzhn22.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A1D2C2C-EA69-11E8-A85C-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> "However, as noted in those commits we'd still create the file as
> 0600, and would just re-chmod it only if core.sharedRepository is set
> to "true" or "all". If core.sharedRepository is unset or set to
> "false", then the file mode will not be changed, so without
> core.splitIndex a system with e.g. the umask set to group writeability
> would work for a group member, but not with core.splitIndex set, as
> group members would not be able to access the shared index file.

That is irrelevant.  The repository needs to be configured properly
if it wanted to be used by the members of the group, period.

> It is unfortunately not short lived when core.sharedrepository is
> unset for example as adjust_shared_perm() starts with:
>
> int adjust_shared_perm(const char *path)
> {
>         int old_mode, new_mode;
>
>         if (!get_shared_repository())
>                 return 0;
>
> but get_shared_repository() will return PERM_UMASK which is 0 when
> git_config_get_value("core.sharedrepository", ...) returns a non zero
> value which happens when "core.sharedrepository" is unset.

Which is to say, you get an unwanted result when your repository is
not configured properly.  It is not a news, and I have no sympathy.

Just configure your repository properly and you'll be fine.

>> > Ideally we'd split up the adjust_shared_perm() function to one that
>> > can give us the mode we want so we could just call open() instead of
>> > open() followed by chmod(), but that's an unrelated cleanup.
>>
>> I would drop this paragraph, as I think this is totally incorrect.
>> Imagine your umask is tighter than the target permission.  You ask
>> such a helper function and get "you want 0660".  Doing open(0660)
>> would not help you an iota---you'd need chmod() or fchmod() to
>> adjust the result anyway, which already is done by
>> adjust-shared-perm.
>
> It seems to me that it is not done when "core.sharedrepository" is unse=
t.

So?  You are assuming that the repository is misconfigured and it is
not set to widen the perm bit in the first place, no?

>> > We already have that minor issue with the "index" file
>> > #leftoverbits.
>>
>> The above "Ideally", which I suspect is totally bogus, would show up
>> whey people look for that keyword in the list archive.  This is one
>> of the reasons why I try to write it after at least one person
>> sanity checks that an idea floated is worth remembering.
>
> It was in =C3=86var's commit message and I thought it might be better t=
o
> keep it so that people looking for that keyword could find the above
> as well as the previous RFC patch.

So do you agree that open(0660) does not guarantee the result will
be group writable, the above "Ideally" is misguided nonsense, and
giving the #leftoverbits label to it will clutter the search result
and harm readers?  That's good.

Thanks.
