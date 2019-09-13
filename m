Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8321F463
	for <e@80x24.org>; Fri, 13 Sep 2019 17:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfIMRGo (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 13:06:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56115 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMRGo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 13:06:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 720F5744E2;
        Fri, 13 Sep 2019 13:06:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VmEzUmUy+o4i3SMcjFnIivEkfJk=; b=I1l8gC
        Kc6osrxGNdyO5RFJ8VzSENaqti0fyI11E9mOYJ+PSB5dGmTO4qC3miITB+4CY1hi
        jeGTmT84HpGuMY7/i+wgt2XNW++qDD9cADYmPvFJUZguUGhQm+jfGGYSBq7kzhLt
        lY7FExN9RiIVillvKnqX5uRvcZ2ggZf+Ss9aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VKpa21GqQ4j5MWpMzgePcz7noUgkLFgM
        4ZGz2FZ9E//0mA8FuxsQd3RkFb14BSqCSvRKW3WFWtjIPX3JbBHPni2kMLVMhneF
        3DnPWPrJaefD3usn2bl5D+DDqdgHv62Cq6/65iGAM5ehao5A8RsQy5pfueCJezyB
        zXQiJE9zHMw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A168744E1;
        Fri, 13 Sep 2019 13:06:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F67C744DF;
        Fri, 13 Sep 2019 13:06:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2] Documentation: fix build with Asciidoctor 2
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
        <20190913015240.686522-1-sandals@crustytoothpaste.net>
        <20190913050634.GB21172@sigill.intra.peff.net>
Date:   Fri, 13 Sep 2019 10:06:33 -0700
In-Reply-To: <20190913050634.GB21172@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 13 Sep 2019 01:06:35 -0400")
Message-ID: <xmqq1rwkf7mu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D800F180-D648-11E9-B7EA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Sep 13, 2019 at 01:52:40AM +0000, brian m. carlson wrote:
>
>> We also need to teach xmlto how to use the namespaced DocBook XSLT
>> stylesheets instead of the non-namespaced ones it usually uses.
>> Normally these stylesheets are interchangeable, but the non-namespaced
>> ones have a bug that causes them not to strip whitespace automatically
>> from certain elements when namespaces are in use.  This results in
>> additional whitespace at the beginning of list elements, which is
>> jarring and unsightly.
>
> Thanks, this fixed most of the rendering problems I saw from the earlier
> patch.
>
>> We can do this by passing a custom stylesheet with the -x option that
>> simply imports the namespaced stylesheets via a URL.  Any system with
>> support for XML catalogs will automatically look this URL up and
>> reference a local copy instead without us having to know where this
>> local copy is located.  We know that anyone using xmlto will already
>> have catalogs set up properly since the DocBook 4.5 DTD used during
>> validation is also looked up via catalogs.  All major Linux
>> distributions distribute the necessary stylesheets and have built-in
>> catalog support, and Homebrew does as well, albeit with a requirement to
>> set an environment variable to enable catalog support.
>
> This did give me one minor hiccup: I had the debian docbook-xsl package
> installed, but not docbook-xsl-ns. The error message was pretty standard
> for XML: obvious if you know what catalogs are, and utterly confusing
> otherwise. :)
>
> Everything worked fine after installing docbook-xsl-ns. I wonder if
> could/should provide some guidance somewhere (maybe in INSTALL, which
> discusses some catalog issues?).
>
>> Finally, we need to filter out some messages from other stylesheets that
>> when invoking dblatex in the CI job.  This tool strips namespaces much
>
> s/that/that occur/ or something?
>
>> like the unnamespaced DocBook stylesheets and prints similar messages.
>> If we permit these messages to be printed to standard error, our
>> documentation CI job will because we check standard error for unexpected
>
> s/will/will fail/?
>
>> ---
>>  Documentation/Makefile    | 4 +++-
>>  Documentation/manpage.xsl | 3 +++
>>  ci/test-documentation.sh  | 2 ++
>>  3 files changed, 8 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/manpage.xsl
>
> Running with this patch on asciidoctor 2.0.10, plus Martin's recent
> literal-block cleanups, plus his refmiscinfo fix, I get pretty decent
> output from:
>
>   ./doc-diff --from-asciidoc --to-asciidoctor origin HEAD
>
> The header/footer are still a little funny (but I think Martin said that
> he needs to update the refmiscinfo patches for later versions of
> asciidoctor, which is probably what's going on here):
> ...
> So overall, I think we're getting very close to parity.

Thanks, both.  Have queued with your log message typofixes.

