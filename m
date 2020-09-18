Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB2C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3563A21741
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Du6ulVSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIRRn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:43:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55608 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRRnz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:43:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D8B8BF9949;
        Fri, 18 Sep 2020 13:43:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1MHY4EMmuDgoGXgUFV3HsoABPUU=; b=Du6ulV
        Snm7GrN/T56ZnuIRRkJO+OS0MSg4pVglvloMI8zgHVyqKOhdxK3RjQ2i1BhkY6dE
        kj5b/lC0hvl7G2LsOP1F3aq3UwW8zXXspAk0o3tN19aM+LdlnXZKjdfHPzKITx21
        kWL4dBnoMzK0idoqs5xl8ZzwULRLUFys9UaEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BPV3j/19bLzOnTFLLeTT5y5ssdXj1JZC
        ciyTnGg51v2YPXYF3FnMrH+vx5lBmj2P+p5qj3WsFwF7NGSWSrROgtIEA1WzjhGH
        kQJArCHD4cs9o/tlTwtngAhhcefYKGETnXZ6EvBRJGmi9NaRPrzQnlTzY1lsYj1U
        3su8w77ZklM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D23CEF9948;
        Fri, 18 Sep 2020 13:43:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27DD5F9947;
        Fri, 18 Sep 2020 13:43:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 13/13] commit-graph: introduce
 'commitGraph.maxNewFilters'
References: <cover.1599664389.git.me@ttaylorr.com>
        <cover.1600397826.git.me@ttaylorr.com>
        <375ecf1f3651b250982216d40167e4c23b8e15ff.1600397826.git.me@ttaylorr.com>
        <20200918132937.GA1601745@nand.local>
Date:   Fri, 18 Sep 2020 10:43:48 -0700
In-Reply-To: <20200918132937.GA1601745@nand.local> (Taylor Blau's message of
        "Fri, 18 Sep 2020 09:29:37 -0400")
Message-ID: <xmqqft7fm14b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82D8F83A-F9D6-11EA-BEC6-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Sep 17, 2020 at 10:59:57PM -0400, Taylor Blau wrote:
>> Introduce a configuration variable to specify a default value for the
>> recently-introduce '--max-new-filters' option of 'git commit-graph
>> write'.
>
> The replacement in [1] causes a conflict when applying this patch after
> it, so here is a suggested resolution:
>
> [1]: https://lore.kernel.org/git/cover.1600397826.git.me@ttaylorr.com/

I think you meant <20200918132727.GB1600256@nand.local> not the
cover letter.  Here is what I ended up with:

    $ git checkout tb/bloom-improvements
    $ git diff @{yesterday}
    diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
    index 60df4e4bfa..de6b6de230 100644
    --- a/Documentation/git-commit-graph.txt
    +++ b/Documentation/git-commit-graph.txt
    @@ -69,8 +69,9 @@ data.
     +
     With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
     filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
    -enforced. Commits whose filters are not calculated are stored as a
    -length zero Bloom filter. Overrides the `commitGraph.maxNewFilters`
    +enforced. Only commits present in the new layer count against this
    +limit. To retroactively compute Bloom filters over earlier layers, it is
    +advised to use `--split=replace`.  Overrides the `commitGraph.maxNewFilters`
     configuration.
     +
     With the `--split[=<strategy>]` option, write the commit-graph as a

Thanks.
