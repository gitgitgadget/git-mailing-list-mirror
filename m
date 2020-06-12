Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EDAC433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 22:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CBA20789
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 22:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KKcMUw3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgFLWAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:00:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55807 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLWAr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 18:00:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCE45C36A6;
        Fri, 12 Jun 2020 18:00:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V+b/3Oo9pAcRwDgr6CAfBIpfwMI=; b=KKcMUw
        3Mdqpi3/i6QJnVEvv02RynlXrOEqvUAm/m7ubANOyq/QLk3yZKujnv9WxXHUfH9L
        uww77DyFeWU0+OgUrvBN6jc/TebLVY2FoCS+8IbEt/vycCQl2oE9ihUiHX6df2CF
        6RwW6p5s6gH+d7WvlOKFkDGs+8XgT/F4U5Uvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fOMATKTZFdq3yqX916aitm/lCp8JOjiA
        a4Ipy3Z6x92y8oOAmEAvEXrH8CxtwVn0+w9iXx05mXTUA3XJTVJpnS296q2emj7v
        JL2UNtyqN+JgCWmCLXvWZVlpvs4VmW5077t8De5mmSSjIoQCuPh+9FMZuCOJCPEF
        k7idzgFedro=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B453DC36A5;
        Fri, 12 Jun 2020 18:00:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE4A2C36A3;
        Fri, 12 Jun 2020 18:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jnareb@gmail.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/4] alloc: introduce parsed_commits_count
References: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
        <20200612184014.1226972-2-abhishekkumar8222@gmail.com>
        <xmqqtuzg11zv.fsf@gitster.c.googlers.com>
Date:   Fri, 12 Jun 2020 15:00:39 -0700
In-Reply-To: <xmqqtuzg11zv.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 12 Jun 2020 13:08:04 -0700")
Message-ID: <xmqqpna40ws8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27EC90A6-ACF8-11EA-931F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>
>>  static unsigned int alloc_commit_index(struct repository *r)
>>  {
>> -	return r->parsed_objects->commit_count++;
>> +	static unsigned int parsed_commits_count = 0;
>> +	r->parsed_objects->commit_count++;
>> +	return parsed_commits_count++;
>>  }
>
> Hmph, ugly.  
>
> The need for this hack, which butchers the function that explicitly
> takes a repository as its parameter so that parsed commits can be
> counted per repository to not count commits per repository, makes
> the whole thing smell fishy.
>
> There shouldn't be a reason why a commit in the superproject and
> another commit in the submodule need to be in the same commit graph
> in the first place.
>
> Instead of breaking the function like this, the right "fix" may be
> to make the commit slab per repository, because the commit index are
> taken from the separate namespace per repository.

Given a commit object (i.e. "struct commit *"), currently there is
no way to tell from which repository it came from.  So from that
point of view, we cannot identify which commit slab to use, unless
we add a back-pointer that says from which repository each commit
object came from, but that makes the commit object even heavier.

Back when 14ba97f8 (alloc: allow arbitrary repositories for alloc
functions, 2018-05-15) made the count per repository (which you are
reverting with this patch), there must have been a reason why it did
so.  We know that commit slab code wants you to count globally and
that is why you wrote this patch, but don't other parts of the code
expect and rely on the commits being counted per repository?  In
other words, with this change, who are you breaking to help the
commit slab code?

Cc'ing SZEDER who also have touched this and made the function
static early last year.

Thanks.
