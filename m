Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08CEA2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 17:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759277AbcJYRPP (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 13:15:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60193 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758312AbcJYRPO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 13:15:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 356FE496FD;
        Tue, 25 Oct 2016 13:15:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/6hhI1nhp5Teh+AN8XoxvY127bc=; b=Tv322s
        uqS2WLBd9sf/7Yo5xwV7031giwzEOd87CdqW2foN3JiktU/vjKC+ud8EDPETgsj8
        nxmzBFnh91ut2M0ikHfGDcWvOzHY/bhayOcCM1ee4NDHc0oZmPGzWwRjHbAAenY+
        lUuFJgR008ZhqcwHNT27BCXDgcFBQdSVJPyn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sSWHW/avx8VtzKlHSEyfd16aWrlycSZG
        GtGb5AlezhyyIzdp4/uHleT9h1gJ7jiR1G0vHypSX+q8TDI51u3pf06426Nw/S33
        M1hvWStKT4SCCP+Fo1VBvp3e5ZyHZfG8gaigGmliPlLgjw+j8IOmf+11iJpEKfld
        D9qD+Y7ZwpM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CCA9496FC;
        Tue, 25 Oct 2016 13:15:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FDF1496FB;
        Tue, 25 Oct 2016 13:15:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2016, #06; Mon, 24)
References: <xmqq1sz5tetv.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbtyuSXDiyi2eY6HKCAwEiKgk2KmNakSn=f+RiXCAC1bA@mail.gmail.com>
Date:   Tue, 25 Oct 2016 10:15:10 -0700
In-Reply-To: <CAGZ79kbtyuSXDiyi2eY6HKCAwEiKgk2KmNakSn=f+RiXCAC1bA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 24 Oct 2016 19:27:24 -0700")
Message-ID: <xmqqoa28s63l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96DBE47C-9AD6-11E6-9F42-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> One of the initial ways to work around the bugfix was to
>
>     git clone . root # <- add in this step and it works again.
>     git clone root super
>
> but instead I will do the preparation for the 'super' project not
> in '.' but in 'root', just called differently ("super_remote" ?)
>
> An additional new test for cloning from '.' will be introduced, too.
>
> I plan on working on that with highest priority for git after finishing
> some attr stuff that I currently have open. So expect a patch (or two)
> this week.

Hmph, I personally would prefer to defer the "correct behaviour for
/." part for the next cycle, which is why I wrote:

 - the "off-by-one fix" part of sb/submodule-ignore-trailing-slash
   needs to be in the upcoming release but the "trailing /. in base
   should not affect the resolution of ../relative/path" part that
   is still under discussion can wait.  Which means we'd need a few
   more !MINGW prerequisites in the tests by -rc0.

at the beginning of the message you are responding to, and I also
thought that was consistent and in agreement with what you said
earlier in <CAGZ79kaq85c1Gk1aRSrdQGp1Nm9p6tN0jXbFvTN0v+9ehooxYg@mail.gmail.com>

> On Sat, Oct 22, 2016 at 10:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> >
> > There isn't enough time to include this topic in the upcoming
> > release within the current https://tinyurl.com/gitCal calendar,
> > however, which places the final on Nov 11th.
> >
> > I am wondering if it makes sense to delay 2.11 by moving the final
> > by 4 weeks to Dec 9th.
> >
> > Thoughts?
> >
> > Speaking of what to and not to include in the upcoming release, we
> > do want to include Stefan's off-by-one fix to the submodule-helper,
> > but that is blocked on Windows end due to the test.
> 
> I'd be happy either way, i.e. we could revert that fix and make a release?
> AFAICT, Windows only has broken tests, not broken functionality with that
> submodule bug fix.

to which I responded in <xmqqpomp33km.fsf@gitster.mtv.corp.google.com>

> If you are referring the "trailing /. should not make difference
> when resolving ../relative/path" change with "rever that fix", I
> think that may be a reasonable way to proceed.  Even though that
> change is a bugfix (at least from the point of view by me and j6t in
> the recent discussion), it is a behaviour change that we would want
> to see feedback from existing submodule users and deserves a longer
> gestation period.  And that part is not yet in 'next' yet ;-)
> 
> > If we want a longer gestation period, we'd ideally merge it to master
> > just after a release, such that we "cook" it in master without having
> > it in any release (we had a similar discussion for the diff heuristics IIRC).
> 
> Yes.  
> 
> It would mean that we would need a separate patch that adds the
> !MINGW prerequisite to some tests to what is on 'next', as the early
> patches on sb/submodule-ignore-trailing-slash~ that fixes off-by-one
> is the right thing to do either way.  It of course needs help from
> Windows folks to validate the results.

So...
