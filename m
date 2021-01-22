Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61407C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F7423AA1
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbhAVWa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:30:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52895 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbhAVWaR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 17:30:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0723112971;
        Fri, 22 Jan 2021 17:29:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oKYVbYz3q35N
        ipnGOqppCJBh6TY=; b=UWZoXsNIApD89VRVRL/lW3H/GcjRFE/2FS0A7vAV+tsg
        HjtZGNf5JPpfRyrsI7W6gQvc1jrT++fDOh61YaqKYbC/7OVyeCXRzae4pc9WfWMj
        f7NYdS0rkvjDRdx1BVYhAmjBUbAMwB+MEiMj9FdUo+yyNEyNV3/a/0sq+16kLbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KzIXgn
        ZDw6Lc1h8+D3+jZcXVLcNRZ71uaqXwqgTlbK+hu+LyzBWCi9Ir1PwCM9i/fW8/eu
        Hl8LePJ2VWmTdpJTtVgnpgcAf1pa3bomkdvgXotnxv/f45JpaoxP7seREo/lJOsF
        zkEfWFxBu9zGMQNFffDNhBzYGxKytdMpQKrPo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8C4F112970;
        Fri, 22 Jan 2021 17:29:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 26EF411296E;
        Fri, 22 Jan 2021 17:29:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: git archive setting user and group
References: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us>
        <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de>
Date:   Fri, 22 Jan 2021 14:29:29 -0800
In-Reply-To: <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 22 Jan 2021 22:00:04 +0100")
Message-ID: <xmqqsg6s61x2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4BB99F1A-5D01-11EB-BC97-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 22.01.21 um 21:40 schrieb Jason Pyeron:
> ...
>>         xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
>>         xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
>>         strlcpy(header->uname, "root", sizeof(header->uname));
>>         strlcpy(header->gname, "root", sizeof(header->gname));
>
> Adding support for using a custom user and group should be easy.  Is
> this just a cosmetic thing?  Regular users would ignore the user info i=
n
> the archive, and root should not be used for extracting, and on systems
> that don't have a logwatch user this wouldn't make a difference anyway,
> right?

I am not particularly interested in cosmetics, but it probably is OK
to make uname/gname overridable.  I do not see any point in uid/gid
numeric values overridable, though.  Just like user names and group
names do not name the same user and group on every machine, uid/gid
are even less so.


