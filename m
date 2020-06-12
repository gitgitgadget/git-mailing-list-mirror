Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F2C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 22:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36023206C3
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 22:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ceCUd2AK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgFLWUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:20:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64583 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgFLWUX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 18:20:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE8D67BD67;
        Fri, 12 Jun 2020 18:20:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tIKcacn7EqtKs+N0Ol1LN9wG+p8=; b=ceCUd2
        AKrs30U92tgg7IM17VGmauFa+bdEYTcl8A/f56Llbiz68+e43E5AGeRx5JDixp8e
        itnpPOP8K3Iv1bL6879sBGpvsjlfRUb0lH+QN2AXxP8Pxbfqu0xXkrI/5QgLV1ER
        bhKK3wIeyGWBc5cl66M1sjtkPFT8Pu/uVzW8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=as8njMk2G0TT7YaOrwYmp2lmC4hD+CgJ
        sVLQLx95Q9cKIMifze1osXVOIFfkVkWfDH5TbJBq67YrmIHpK/x3oGMLc18sV0gI
        jC5ugH+iFDkNzmcrJUpUE2xT+HzNLhppczaqkmgZaQIQrJxHOqQd29U0s8Yg69XA
        6UpmuKwc1QU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D43817BD66;
        Fri, 12 Jun 2020 18:20:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C2B47BD61;
        Fri, 12 Jun 2020 18:20:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jnareb@gmail.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/4] alloc: introduce parsed_commits_count
References: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
        <20200612184014.1226972-2-abhishekkumar8222@gmail.com>
        <xmqqtuzg11zv.fsf@gitster.c.googlers.com>
        <xmqqpna40ws8.fsf@gitster.c.googlers.com>
Date:   Fri, 12 Jun 2020 15:20:18 -0700
In-Reply-To: <xmqqpna40ws8.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 12 Jun 2020 15:00:39 -0700")
Message-ID: <xmqqlfks0vvh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E63AFFC8-ACFA-11EA-B903-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Back when 14ba97f8 (alloc: allow arbitrary repositories for alloc
> functions, 2018-05-15) made the count per repository (which you are
> reverting with this patch), there must have been a reason why it did
> so.  We know that commit slab code wants you to count globally and
> that is why you wrote this patch, but don't other parts of the code
> expect and rely on the commits being counted per repository?  In
> other words, with this change, who are you breaking to help the
> commit slab code?

I did a bit more digging, as I had a bit of time after pushing
today's integration result out, and it turns out that in the today's
code, c->index is the only thing that uses this counter.  It is set
in init_commit_node() function, which is called from object.c when
an in-core commit object is created.  The callchain looks like this:

object_as_type(struct repository *, struct object *, enum object_type, int quiet)
  -> init_commit_node(struct repository *, struct commit *)
       -> alloc_commit_index(struct repository *)

What is interesting is that object_as_type() takes the parameter
"struct repository *" ONLY BECAUSE it needs to pass something to
init_commit_node(), which in turn takes it ONLY BECAUSE the
alloc_commit_index() wants one to be passed.

Since the ONLY reason why there needs a monotorically increasing
counter of in-core commit objects is because we need to be able to
index into the commit slab, and because we cannot make commit slabs
per-repository due to the lack of backpointer from an in-core commit
object to the repository it belongs to, reverting 14ba97f8 (alloc:
allow arbitrary repositories for alloc functions, 2018-05-15) is a
reasonable thing to do, but then since the only reason the above
three functions in the callchain take "struct repository *" is
because the bottom-most alloc_commit_index() wants it WHEN IT DOES
NOT USE IT, it would be good to get rid of the "struct repository"
parameter from the functions involved in the callchain altogether.

Then we won't have to ask the "who are we breaking with this change"
question.  At that point it would be clear that everybody would be
OK with a single counter to ensure uniqueness of in-core commit
across all the in-core repository instances.

Thanks.
