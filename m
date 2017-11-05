Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133302055E
	for <e@80x24.org>; Sun,  5 Nov 2017 02:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbdKECAP (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 22:00:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55331 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751508AbdKECAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 22:00:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A3299FBFE;
        Sat,  4 Nov 2017 22:00:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lJsejBOBKC6t
        kggg1zshFM9/pTk=; b=jwqp9BoK8if0kQPJ8r1HyGSNkFGJXwQYG8gTl3oOdW4W
        JznXLq1Zg7Kju4i+L+GM449rdY1aZaQxvpVuICqAGAPZI0NVZ8VtxtjfWyim8bpG
        R8JJJNpsPSaMxosHINdgZwg6V4zCm9ClUCXR3pJGac/Nwwlksj+GC9m+toi9INg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NVG+wm
        IjSNAap8L635uV96l4zZFSmLXdCrk8UhGfHzdlgE4XTr98rdcn2qcufKaaDVJFpa
        OSnNy6m8UXsw0pa7erCzOj+bEw9wV2OkLcaMhOa5cG9LaX0muwO5myo9z5wT88O4
        xytrHa/HBoGqf9yTOoFnKyJuHf9zRxZw9iJSs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62B879FBFD;
        Sat,  4 Nov 2017 22:00:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C376F9FBFB;
        Sat,  4 Nov 2017 22:00:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
Subject: Re: [PATCH v1 2/2] log: add option to choose which refs to decorate
References: <20171104004144.5975-1-rafa.almas@gmail.com>
        <20171104004144.5975-3-rafa.almas@gmail.com>
        <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
        <b0e3856b-e627-0d22-90da-3da1781f98b3@gmail.com>
Date:   Sun, 05 Nov 2017 11:00:11 +0900
In-Reply-To: <b0e3856b-e627-0d22-90da-3da1781f98b3@gmail.com> ("Rafael
        =?utf-8?Q?Ascens=C3=A3o=22's?= message of "Sat, 4 Nov 2017 07:34:20 +0000")
Message-ID: <xmqq1sldmqms.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F6593F2-C1CD-11E7-B6F6-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:

>>> The pattern follows similar rules as `--glob` except it doesn't assum=
e a
>>> trailing '/*' if glob characters are missing.
>>
>> Why should this be a special case that burdens users to remember one
>> more rule?  Wouldn't users find "--decorate-refs=3Drefs/tags" useful
>> and it woulld be shorter and nicer than having to say "refs/tags/*"?
>
> I wanted to allow exact patterns like:
> "--decorate-refs=3Drefs/heads/master" and for that I disabled the flag
> that adds the trailing '/*' if no globs are found. As a side effect, I
> lost the shortcut.
>
> Is adding a yet another flag that appends '/*' only if the pattern
> equals "refs/{heads,remotes,tags}" a good idea?

No.

> Because changing the default behavior of that function has
> implications on multiple commands which I think shouldn't change. But
> at the same time, would be nice to have the logic that deals with
> glob-ref patterns all in one place.
>
> What's the sane way to do this?

Learn to type "--decorate-refs=3D"refs/heads/[m]aster", and not twewak
the code at all, perhaps.  The users of existing "with no globbing,
/* is appended" interface are already used to that way and they do
not have to learn a new and inconsistent interface.

After all, "I only want to see 'git log' output with 'master'
decorated" (i.e. not specifying "this class of refs I can glob by
using the naming convention I am using" and instead enumerating the
ones you care about) does not sound like a sensible thing people
often want to do, so making it follow the other codepath so that
people can say "refs/tags" to get "refs/tags/*", while still allowing
such a rare but specific and exact one possible, may not sound too
bad to me.

