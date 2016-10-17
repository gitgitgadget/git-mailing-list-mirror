Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1D301F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 18:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758551AbcJQS2s (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 14:28:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54402 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758541AbcJQS2q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 14:28:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 634B645447;
        Mon, 17 Oct 2016 14:28:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h4i0XbJDodLNWa9cLkMlsXSPA94=; b=d9D7uZ
        wsFQygpz6rP5hRaskMSj5BPNitziE6rBvQ1wv5rV5Q/DXQj7f0VX/09k0UCGIXRR
        aKt7vmbtDt2mj1TuKr3qDikkVHoCeNWKGg/BQ5NMa4G1fAcLrMcxm1xAvhVrE96d
        8x7uVZt2hWWVKUVL1ceZaBwT8Ok3gb907gtRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lkwHNpwq6pnkEU9fOduHrVxffy3+q7zP
        TH8SYMOKNHGtJA1b/69IaQ6EAzy8aRKsOstqB7OybqkSkccE0XX5m0MhpI3uVkfU
        k7kYzbtkFGJQI4amrInQh3INDhWYGFINWMfFSmQyoRt5Pv0zVSzQnoCF9jDfaJqe
        9d6i36dFNJI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AB4945446;
        Mon, 17 Oct 2016 14:28:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C84BA45445;
        Mon, 17 Oct 2016 14:28:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject URL
References: <20161010175611.1058-1-sbeller@google.com>
        <alpine.DEB.2.20.1610121501390.3492@virtualbox>
        <CAGZ79kYDpth7YDbN0VRD0dcpp7aeQ-y4HSEhsmd_c46ggZoXsg@mail.gmail.com>
        <alpine.DEB.2.20.1610131255001.197091@virtualbox>
        <xmqqfunvxxgu.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYW2qK1GKxoKy_mkVkjjqEUzkh5aPSzDEfRd6U=PYDdzw@mail.gmail.com>
Date:   Mon, 17 Oct 2016 11:28:42 -0700
In-Reply-To: <CAGZ79kYW2qK1GKxoKy_mkVkjjqEUzkh5aPSzDEfRd6U=PYDdzw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 17 Oct 2016 10:58:59 -0700")
Message-ID: <xmqqh98avnhh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 897340AE-9497-11E6-B631-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> In any case, I find it more disturbing that we somehow ended up with
>> a system where these three things are expected to behave differently:
>>
>>         A - path/to/dir
>>         B - path/to/dir/
>>         C - path/to/dir/.
>>
>> Is that something we can fix?
>
> Well A, B are the same.
> C is "obviously" different, when it comes to counting slashes for relative
> path/url purposes, in the way that there are characters after the last slash
> and just by coincidence '.' refers to the directory itself, C behaving like
> 'path/to/dir/sub' seems right to me.

It doesn't look right to me at all.  If you were contrasting

	cd path/to/dir/sub && cd ..
	cd path/to/dir/bus && cd ..

then I would understand, but why should these two

	cd path/to/dir/. && cd ..
	cd path/to/dir/sub && cd ..

behave the same?

> So how do you imagine this fix going forward?
> * Breaking existing users with /. at the end? by treating it the same as A,B
> * Do some check based on time/version of Git and cover the old data?
> * Forbid /. at the end from now on?

Where at the end-user facing level does this trailing "/." surface
and how does the difference appear to them?  I think that is the
crucial question.

Unless there is some convincing argument why "." is not special
(i.e. counter-argument to the above "bus vs sub" and ". vs sub"
example), I would think "existing users with /." does not matter.
If they are "relying" on the behaviour, I would think it is not
because they find that behaviour intuitive, but only because they
learned to live with it.  IOW, treating all of A/B/C the same way
would appear to them a strict bugfix, I would think.

It is totally a different matter if OUR code that consumes the
output from the submodule-helper --resolve-relative" internally is
confused and relies on "../. relative to path/to/dir/. is the same
as ../. relative to path/to/dir/sub" for whatever reason.  Without
fixing that, I would not surprised if fixing things to treat A/B/C
the same way would surface differences in the end-user observable
behaviour in a negative way.

