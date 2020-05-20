Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08722C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 15:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79352072C
	for <git@archiver.kernel.org>; Wed, 20 May 2020 15:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rBS7om5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgETPE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 11:04:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61667 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETPE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 11:04:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0CD4D91F8;
        Wed, 20 May 2020 11:04:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=W4uB142+oJJO
        4woPuTkhJFq1f+s=; b=rBS7om5w0fC2uOAXa+RH/UFObj1hHS8yOf+5fsczOYsK
        lu4dFhudhqZbXeFfyg17Q4Qfq49PsOpnwUqekm66cdVFxX3o7CI9HWJ8tyyx0zFf
        v2I41angSnqSQgIkqBVJGxZzPR/oXjVap7Fdlxkcx6ivu8zq0DxTHA6AvQnX0Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=d5TQt4
        MP8U59bXlSdQkTGZ4eirhVz9Nvr+VjuaURHRru0bE+GUfBBpOxkJY5Dwq4ntG/b2
        qGaCLq7aOhoe9Lw+jePBDOJfYbT4l2/TDRIJyBo4B4yvwdXRBzX+9zOXAJqPZG7Z
        +nIfduQSflliKBkNzNTs1t/AZQu6YYcvMKU0w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9C49D91F7;
        Wed, 20 May 2020 11:04:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 047DBD91F6;
        Wed, 20 May 2020 11:04:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, liu.denton@gmail.com, chwarr@microsoft.com,
        garima.singh@microsoft.com
Subject: Re: [PATCH 1/3] t4216: avoid unnecessary subshell in test_bloom_filters_not_used
References: <20200520034444.47932-1-carenas@gmail.com>
        <20200520034444.47932-2-carenas@gmail.com>
Date:   Wed, 20 May 2020 08:04:23 -0700
In-Reply-To: <20200520034444.47932-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 19 May 2020 20:44:42 -0700")
Message-ID: <xmqqr1vewsug.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3197FD20-9AAB-11EA-824C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Seems to trigger a bug in at least OpenBSD's 6.7 sh where it is
> interpreted as a history lookup and therefore fails 125-126, 128,
> 130.
>
> Remove the subshell and get a space between ! and grep, so tests
> pass successfully.

It's strange that somebody thinks of doing history lookup in
non-interactive use.

But even more curious is why we have this in a subshell in the first
place.  I do not see a reason why we need subshell, nor use of the
double-quote in the outer layer that forces us to use backslashes.

>  test_bloom_filters_not_used () {
>  	log_args=3D$1
>  	setup "$log_args" &&
> -	!(grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/tra=
ce.perf") &&
> +	! grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/tra=
ce.perf" &&

This is obviously the minimum fix, so I'm willing to take the change
as-is, but if we were writing it today, perhaps

	! grep 'statistics:{"filter_not_present":' "$TRASH_DIRECTORY/trace.perf"=
 &&

is how we write it.  I do not see any reason why we want to use the
"-q" option either.

