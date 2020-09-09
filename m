Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97714C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED722080C
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CHUm8rpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIIUIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:08:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62912 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIIUIy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 16:08:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 020546C9E3;
        Wed,  9 Sep 2020 16:08:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZVnqeh9NL2TdFG5JvRgmit6R5Ms=; b=CHUm8r
        pnnIqlajUI8APuoyo9uZAC5t67jXui7fOfXNcDYLZtCocKGKQUCrvj3eBylnYuLw
        xC5jcp3+4n9fuiYG1i17ayTOl8629DD3ZkB9/4u2mnO9Z6xP56AtRwxm/zkkSiUS
        NmQKwNqs4ObKEUfHvpJHkLvyT/k8nz+Ctw0js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BCnF2QNO+1Zp+UEeHrUvJ9zNW+6YDmQi
        GtYLohvdX7vd2SK8o8TXvV3Y20W3aW9s5ZiqtT9scRdaf/RGl3q11kyrRIPPRSSx
        YerliEqmRmDETSF0Dk9fBD3MfnbpM3fKbto/bJstKAm7NmsQ7clDu5Y4dEzXSI00
        nw5/GtvapRI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3F2D6C9E0;
        Wed,  9 Sep 2020 16:08:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C3486C9DD;
        Wed,  9 Sep 2020 16:08:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, dstolee@microsoft.com,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] blame.c: replace instance of !oidcmp for oideq
References: <20200908211053.807194-1-eantoranz@gmail.com>
        <6b84f112-7e3f-3a78-3766-033fcf494464@gmail.com>
        <xmqqmu1yvlv7.fsf@gitster.c.googlers.com>
        <CAOc6etZOOZLQ4Vh_94d6cwPEAoAjuoqqvPWPHWWkw0rB73=hrQ@mail.gmail.com>
Date:   Wed, 09 Sep 2020 13:08:50 -0700
In-Reply-To: <CAOc6etZOOZLQ4Vh_94d6cwPEAoAjuoqqvPWPHWWkw0rB73=hrQ@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Wed, 9 Sep 2020 13:13:53
        -0600")
Message-ID: <xmqq1rjavhkd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 477FC818-F2D8-11EA-8E35-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> On Wed, Sep 9, 2020 at 12:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>> I'll still
>> take this patch as it is a contribution from a new contributor,
>
> I don't know why you say I'm a new contributor. I would have sworn you
> have my picture
> on a wall with something written like: do not take patches from this guy. ;-)
> It's good to at least know that I haven't messed up so badly that I'm
> in Junio's name's cache.

Sorry, it appears that two patches from late 2015 weren't enough to
retain your name kept in cache X-<.

