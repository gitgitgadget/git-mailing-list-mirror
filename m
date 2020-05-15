Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F686C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122CC2073E
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JtwIRd1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgEORDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 13:03:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50979 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEORDE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 13:03:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0916656DD;
        Fri, 15 May 2020 13:03:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7IOIm09Z/+pY+57Og2zOWbcU0K0=; b=JtwIRd
        1fow41sFEwBvqAqorOcdMOeRDWma3Hok2VMzwUPpSCBs9hWDp+X1gA4UxUyKZX+S
        8G/1o9YiM/YtT5P9SYPT2KUKdu7QZgLmLh+xVEU73HH2qf8HbbAo3I+OLAc+1ie9
        qh+ItS6lvHjee4pcMEHU4N7wz1Y9RYhEI8nAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qyRbfnDWjyQztmM+9aphylpXknD+/a4Q
        CptszbiK+TQbx1dJtyZw5aotVuUxLZPugc3O2INLn2rq6q5N0QodO6q5adVIMoYF
        058iMd0ZyPAlXceR4/EmMlABs1XLfMqhN//ATNYb/dwqMbeUvzx2LSzo0oUMiJOG
        if28wsxQtTM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7D87656DC;
        Fri, 15 May 2020 13:03:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D566656DB;
        Fri, 15 May 2020 13:03:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, liu.denton@gmail.com
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
        <20200510164424.GA11784@konoha>
        <CAOEXN9yyL8T8kDmpHKTjjaG9tVS1kh34B-=PuH1hRaA7jF_K6A@mail.gmail.com>
        <20200512141520.GA8133@konoha>
        <b45268b1-de5f-051c-f956-8a17c067f4c6@gmail.com>
Date:   Fri, 15 May 2020 10:03:01 -0700
In-Reply-To: <b45268b1-de5f-051c-f956-8a17c067f4c6@gmail.com> (Guillaume
        Galeazzi's message of "Fri, 15 May 2020 18:51:57 +0200")
Message-ID: <xmqq7dxdm8qi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFB5A474-96CD-11EA-87A7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Guillaume Galeazzi <guillaume.galeazzi@gmail.com> writes:

> Goal here was to avoid magic number, but after looking to the code it
> seem accepted that true is 1 and false is 0. To comply with that, in
> next version it will be replace it with:
>
> 	if (FOREACH_BOOL_FILTER_NOT_SET != info->active_only) {

It still is unusual to have a constant on the left hand side of the
"!=" or "==" operator, though.  Having a constant on the left hand
side of "<" and "<=" is justifiable, but not for "!=" and "==".
