Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88261205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 18:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdAKS44 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 13:56:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56999 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754408AbdAKS4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 13:56:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F1275D34C;
        Wed, 11 Jan 2017 13:56:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dr0l44AkSN32wrbJSCA04djWIIA=; b=YW8rXD
        PEqvvC9v/4W06tZPy4YopvVER3Iqxvi8bYuSAQd8SZG6g6m9HsIWyrkWTfMq20iM
        9HOO2Mi2mUJeDxQAZURys6MvjT5WCnOGyVUD2aWRivWVpmsCnlfw5YO76rKTFDnu
        zXYPbwLt+0ynlOInitiZhHQD0eL8c9V8sqB5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LMGYbFWzPGF19Xf0OUomyl0yceB1Zn/K
        /fmdgLVNCQkoEfxXqQodIDRXYcCHlxlXDRVQ+vZuOw2+5sx3FPMGGRgVYRRQSazb
        yRj6py3fd89tBH/ch22YArU59SaBbIkgWibd+K8cuJjs4dBy6FPknc4w9HFa0QBS
        nD0AgkaKYQ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 269755D34B;
        Wed, 11 Jan 2017 13:56:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A23B5D346;
        Wed, 11 Jan 2017 13:56:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: git cat-file on a submodule
References: <1484093500.17967.6.camel@frank>
        <20170111125330.3skwxdleoooacts6@sigill.intra.peff.net>
Date:   Wed, 11 Jan 2017 10:56:52 -0800
In-Reply-To: <20170111125330.3skwxdleoooacts6@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 11 Jan 2017 07:53:30 -0500")
Message-ID: <xmqqshopo26j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B78B40E6-D82F-11E6-9068-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 10, 2017 at 07:11:40PM -0500, David Turner wrote:
>
>> Why does git cat-file -t $sha:foo, where foo is a submodule, not work?
> ...
> I'm not sure if I'm complaining or not. I can't immediately think of
> something that would be horribly broken. But it really feels like you
> are using the wrong tool, and patching the tool to handle this case will
> probably lead to weird cognitive dissonance down the road.

"git cat-file [any option] $sha" should fail and complain for any
$sha that does not name an object that exists in the object database
of the repository it is working on.  

So I'd complain if the first example command quoted above from
David's mail stopped failing when the commit bound at 'foo' in the
top-level treeish $sha (i.e. a commit in the submodule) does not
exist in the top-level repository's object database.

> Maybe it would help to describe your use case more fully. If what you
> care about is the presumed type based on the surrounding tree, then
> maybe:
>
>   git --literal-pathspecs ls-tree $sha -- foo
>
> would be a better match.

Yup.
