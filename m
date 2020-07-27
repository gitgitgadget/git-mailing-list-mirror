Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AEEC433E0
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC07206E7
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NwlXijYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgG0QUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:20:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51047 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgG0QUi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 12:20:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E93D3CA400;
        Mon, 27 Jul 2020 12:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hc6ox/Cp12Fh5L3ta41ajQOYFpg=; b=NwlXij
        YCrBk9PGKhQe+3jEmt7TyeZWV9VLl4+U3oETVUYKaBhQOPYhbiGpXzWT2o7JqjDW
        UUh2RQc5xTpfAwn8E88tjRj0pklvWJBi7SkqJhGoK2LcIXmBTKBtYQOt8EVrjD27
        M9oK3ZSMqA07RZ6fmEezsjmLAFfDW1Qdbo4bI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nkJ80Ue41JXZZpNgHkA0jXEV3DXQI3fq
        ry/sE8bh3vZ9Q0QdwQWcsXpxnz3SyX9pIogwOljM04Uc9jduACxplQas9PB4AjeD
        YX+F+iQJoI8LFQkM5TLmN4z2XX3reGUo3aMs6aYsurbEypNM1YNUrKEpK2xJNl29
        kITjT+Zno7I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E18B2CA3FF;
        Mon, 27 Jul 2020 12:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2723ECA3CB;
        Mon, 27 Jul 2020 12:20:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
        <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
        <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
Date:   Mon, 27 Jul 2020 09:20:32 -0700
In-Reply-To: <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 27 Jul 2020 10:50:50 +0200")
Message-ID: <xmqqpn8hgca7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 191A7ACA-D025-11EA-8BB8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Fri, Jul 17, 2020 at 12:10 AM Junio C Hamano <gitster@pobox.com> wrote:
>> I reviewed some codepaths that deal with FETCH_HEAD recently.
>>
>> As the file is quite different from all the other pseudo references
>> in that it needs to store more than one object name and in that each
>> ref in it needs more than just the object name, I doubt that it
>> makes much sense to enhance the refs API so that its requirements
>> can be covered.
>
> I agree. Do we ever pretend that FETCH_HEAD is a ref today?

"git rev-parse FETCH_HEAD", "git show FETCH_HEAD" etc. all should keep
working, so in that sense, it is treated as a ref.  It does not
protect the history leading to the objects listed in it from being
collected, though.

"git merge FETCH_HEAD" is an interesting case---I haven't thought it
through.

Jung fubhyq unccra nsgre "tvg chyy bevtva sbb one" nggrzcgf gb teno
gjb oenapurf naq znxr na bpgbchf zretr vagb gur oenapu pheeragyl
purpxrq bhg, naq gura "tvg erfrg --uneq && tvg zretr SRGPU_URNQ" vf
tvira?
