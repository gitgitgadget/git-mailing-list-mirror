Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34481C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9882076C
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 20:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vrZcwmxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHZUUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:20:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64968 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZUUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 16:20:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7636EE8494;
        Wed, 26 Aug 2020 16:20:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F7W5BruTkxi67kPKJDfpX/yuBRs=; b=vrZcwm
        xc44h5Yv1DBgSBraXWKKi2c4lP+AXHKW9GvdvMA++rHi4lJe6jMUxjNgIcwBw96h
        GdBBkUB6Mhk3HEcxElRmyfCqkmJ+ZSvWmUV6s/U7kFcMKMeSBeh5QloHRqwgdmSS
        18Eqq/7oqLd5J3J7H8KNEwDaByQ1M95C+Oiow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GiTMg8OVg8JcHE66BYbMO7xS2cS8lplk
        KRaY+oTqwVQzMhJPxH8VnoQt0ueK3QPZdTu3nBE1CMGKbVh8AMz3TuOGMjpCOwhp
        KPvwARHhwirwEp6CtHh3mubfLwW7h48ws1kUisI5g/JhhTqXC3Ui/2nrQdfyA9XH
        3o6PCcrmDKY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D8D0E8493;
        Wed, 26 Aug 2020 16:20:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A59C0E8492;
        Wed, 26 Aug 2020 16:20:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] revision: set rev_input_given in handle_revision_arg()
References: <CAGyf7-G_ciVpgvvOiH1Fq9kNuWunCpM1fhv3ao_RMXBB0K=HMA@mail.gmail.com>
        <xmqq8se21pl1.fsf@gitster.c.googlers.com>
        <20200825194619.GB1419759@coredump.intra.peff.net>
        <xmqq4koq1p28.fsf@gitster.c.googlers.com>
        <20200825195511.GD1419759@coredump.intra.peff.net>
        <20200826201305.GA1595824@coredump.intra.peff.net>
Date:   Wed, 26 Aug 2020 13:20:09 -0700
In-Reply-To: <20200826201305.GA1595824@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 26 Aug 2020 16:13:05 -0400")
Message-ID: <xmqqa6yhupl2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A91A838-E7D9-11EA-B22F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] revision: set rev_input_given in handle_revision_arg()
>
> Commit 7ba826290a (revision: add rev_input_given flag, 2017-08-02) added
> a flag to rev_info to tell whether we got any revision arguments. As
> explained there, this is necessary because some revision arguments may
> not produce any pending traversal objects, but should still inhibit
> default behaviors (e.g., a glob that matches nothing).

Ah, that explains the symptom under discussion quite well; the topic
that introduced the commit was to fix "git log --tag=no-such-tag"
that used to default to HEAD.  We should be able to reuse the same
mechanism to prevent --stdin codepath from falling back to HEAD, of
course.

> However, it only set the flag in the globbing code, but not for
> revisions we get on the command-line or via stdin. This leads to two
> problems:
>
>   - the command-line code keeps its own separate got_rev_arg flag; this
>     isn't wrong, but it's confusing and an extra maintenance burden
>
>   - even specifically-named rev arguments might end up not adding any
>     pending objects: if --ignore-missing is set, then specifying a
>     missing object is a noop rather than an error.

Yup, nicely described.

> diff --git a/revision.c b/revision.c
> index 96630e3186..08c2ad23af 100644
> --- a/revision.c
> +++ b/revision.c

The patch of course looks straightforward and good.  Thanks.


