Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29221F428
	for <e@80x24.org>; Fri,  5 Jan 2018 19:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeAETxx (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 14:53:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57289 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeAETxw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 14:53:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9F83C6A05;
        Fri,  5 Jan 2018 14:53:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=omayGwpeHGA5QbS4orRQ/g0x0Cc=; b=W/RJkO
        U7Ci8MT3Xen8K84MbIKU9NChjBX+3Uoe6KycNM5fEZDJrLn17tQJo0+UEeftrR8q
        gTj/y8iFuOc1HhJtDsmnZ3+WPsWWwx/Xiv/G0HQ/8dV7BU/brme56pNzsbyyqPZ+
        o0s1ipxJN36xdPjz9HThNfEweLPp7PmO2Rtqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wiuJkV2t6X1TFZuYnR17rB1eQYY4I3xA
        MRkzctIuegYf+O5JcCA5aUQgN3cBGhInffW98zu8o9j436cGWqTX0GU3XczPoMOP
        khGZaFyKE6N0DCtbUr+nGlank+zGvNyloSpAcP5WpTeuSsRZOZ8QzhvAmQdLDXVb
        U9GDqVmur7E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2B34C6A04;
        Fri,  5 Jan 2018 14:53:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 316E1C6A03;
        Fri,  5 Jan 2018 14:53:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Isaac Shabtay <isaac@shabtay.com>, git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
        <20180103222821.GA32287@sigill.intra.peff.net>
        <CAK2k7nQcY+QQBfda6CHM8tFo3i4XX2tXxHKv73t6SJ4rRvWo1w@mail.gmail.com>
        <20180104040124.GA11626@sigill.intra.peff.net>
Date:   Fri, 05 Jan 2018 11:53:50 -0800
In-Reply-To: <20180104040124.GA11626@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 3 Jan 2018 23:01:25 -0500")
Message-ID: <xmqqfu7kcca9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26E999F0-F252-11E7-9B5D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 03, 2018 at 02:42:51PM -0800, Isaac Shabtay wrote:
>
>> Indeed interesting... this one's for the books...
>> Thanks for the patches. Any idea when these are going to make it to the
>> official Git client builds? (specifically the Windows one)
>
> They haven't even been reviewed yet. If they get good feedback, then the
> maintainer will pick them up, then merge them to 'next', and then
> eventually to 'master', after which they'd become part of the next
> major release. For a pure bug-fix, it may instead go to 'maint' and
> become part of the next minor release.

Even a pure bug-fix, unless it is something no longer needed on the
'master' front, goes thru 'pu'->'next'->'master' avenue first, and
is recorded in the RelNotes with the notes like "(merge d45420c1c8
jk/abort-clone-with-existing-dest later to maint)" when it happens.

	side note: in fact "grep -e 'later to maint' RelNotes" is
	how I remind myself what to merge down to 'maint'; the
	actual procedure is a bit more involved (those interested in
	the details can find the 'ML' script on the 'todo' branch;
	its name stands for 'merge later')

Later, after not hearing from people that the "fix" breaks things,
the topic is also mreged to 'maint' and becomes part of the next
minor release.

> Right now we're entering release freeze for v2.16.0. We'd still take
> fixes for recent breakages there, but given the age of the problem I
> doubt it will make the cutoff. But as this is a bug-fix, it might make
> it into v2.16.1.

Yup.  From the usual timeline, I'd expect this to be part of
'master' working towards 2.17 and to become a part of 2.16.x
series.

Thanks.
