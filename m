Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455ABC433B4
	for <git@archiver.kernel.org>; Sun, 16 May 2021 03:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149B5611C9
	for <git@archiver.kernel.org>; Sun, 16 May 2021 03:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhEPD4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 23:56:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61845 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhEPD4j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 23:56:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0528E1318F6;
        Sat, 15 May 2021 23:55:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ir0arKoARENFSZ1hd1cZhzcvFqSFm8CmKde7aA
        SuMVQ=; b=BqbptkplIuStdGXZPF0ISDMo1MG1UJIraTm1MWExMN9sqBjGKbAsl0
        WNWH29YBOeN6OlvoFI25Et0et7ftQQdpwS4yElFf6IBD7YRx+Y1Xi9kwIT+vhQiY
        xX4bGzKP1SkqSfe9WFGUQwICJTCDTSmvhoMyCBl+hDDy3VjBcamYo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F00101318F5;
        Sat, 15 May 2021 23:55:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 30C6F1318F3;
        Sat, 15 May 2021 23:55:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [QUESTION] ref-filter: how to support atom like %an
References: <CAOLTT8QBOgcz+Q_ODnbGq5r5CzrSdX+=DMT0pJS6iPTcP0VRjA@mail.gmail.com>
Date:   Sun, 16 May 2021 12:55:20 +0900
In-Reply-To: <CAOLTT8QBOgcz+Q_ODnbGq5r5CzrSdX+=DMT0pJS6iPTcP0VRjA@mail.gmail.com>
        (ZheNing Hu's message of "Sat, 15 May 2021 22:52:49 +0800")
Message-ID: <xmqqk0nz72on.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89BB8C90-B5FA-11EB-9DF2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> My current thinking is this:
>
> First add a new member `short_name` in `struct valid_atom`,
> Then we can share a valid_atom item for the long name of
> an atom such as `%(authoremail)` and the short name of
> the atom `%ae` (%aE is not considered at the time).
> Something like:
>
> [ATOM_AUTHOREMAIL] = { "ae", "authoremail", SOURCE_OBJ, FIELD_STR,
> person_email_atom_parser },

My assumption has always been that when enriching "--format" of the
"log" family (e.g. "status", "show") with ingredients from the
"for-each-ref" family (e.g. "branch", "tag"), we would adopt the
notation the latter uses, i.e. "git log --format='%s %(notes)'",
with the full intention that eventually users would choose between
the synonyms to make it "git log --format='%(subject) %(notes)'" for
consistency, without wasting brain cycles to come up with and to
remember two-letter shorthands that will not scale.

