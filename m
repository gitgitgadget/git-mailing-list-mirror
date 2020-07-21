Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C433C433E1
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AFB20771
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QUbpOAyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgGUUGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:06:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60756 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUUGp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 16:06:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CC7CEAA8E;
        Tue, 21 Jul 2020 16:06:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=coPxZCgZUw/f7FxhLe9CaYjN4+8=; b=QUbpOA
        yzDgHnNL8Aarfz1+fefykThqVa3Os/E14UTuZ1Ad5EFRE4Vmh8gxTXRg/M36KNWD
        few/eUWOzqAgArYM2nkIdKrFSPvjCIIYhmo196vOuvqDNN4pcvwV4lIO3vis/Nvh
        qaINFJAULjr0/ktW7ZBtetA2Ij2EzqU2eWVE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VhxDNbuIwTW8AIIZtQuTSVgtW8Fbo/0u
        ezmVg1sO8ofSJwY/csf8Z1SICSVDkruVlsPiXSuERr9eKILOlnLAnCkDib/1p2zs
        8dgxDB/pthYSjdMJMg0kMZv80TUeuHdGwqfbb+iVHz821VcAIN9OYVKunGx1OnLo
        wjwd19Iy13o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 047E9EAA8D;
        Tue, 21 Jul 2020 16:06:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 50E65EAA8C;
        Tue, 21 Jul 2020 16:06:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org
Subject: Re: [PATCH 0/4] upload-pack: custom allowed object filters
References: <cover.1593720075.git.me@ttaylorr.com>
Date:   Tue, 21 Jul 2020 13:06:39 -0700
In-Reply-To: <cover.1593720075.git.me@ttaylorr.com> (Taylor Blau's message of
        "Thu, 2 Jul 2020 16:06:14 -0400")
Message-ID: <xmqqwo2w7hv4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B14A218E-CB8D-11EA-A02A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Taylor Blau (4):
>   list_objects_filter_options: introduce 'list_object_filter_config_name'
>   upload-pack.c: allow banning certain object filter(s)
>   upload-pack.c: pass 'struct list_objects_filter_options *'
>   upload-pack.c: introduce 'uploadpack.filter.tree.maxDepth'
>
>  Documentation/config/uploadpack.txt |  22 ++++++
>  list-objects-filter-options.c       |  23 ++++++
>  list-objects-filter-options.h       |   6 ++
>  t/t5616-partial-clone.sh            |  34 +++++++++
>  upload-pack.c                       | 104 ++++++++++++++++++++++++++++
>  5 files changed, 189 insertions(+)
>
> --
> 2.27.0.225.g9fa765a71d

With this series (I do not know which one of them is the culprit) in
the 'seen' branch, we seem to consistently get a segfault while
running t5616 on macOS clang build [*1*]

[Footnote]

*1* https://travis-ci.org/github/git/git/jobs/710504820 has the
    topic at the tip of 'seen' that fails.  Without that merge,
    https://travis-ci.org/github/git/git/jobs/710342598 seems to
    pass on all archs.





