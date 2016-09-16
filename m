Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B237B207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 18:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbcIPS25 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 14:28:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61411 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751704AbcIPS2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 14:28:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D9DC3ECEF;
        Fri, 16 Sep 2016 14:28:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fs+6b+2iePuXzwWGL9LjQXVWodw=; b=mCCGgj
        MiBhlhZyLRxMwnRet7FWHNbPGnNCrXmDdrfPVtmtSuVjrnnYk58jAqhmTSFSO/mC
        doqU4CwcFp51sa+tKqFifh9jOGWkDWF04SK2oqkU6dvO4FEf0MDzM/yQPG2ifZgm
        PZ1kid5X8XbQ0v3XuDsCjQx4XT/MZ1dJklHVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JUhf2n+auPJ2zWlwPTtyDagU6kJguvQC
        +9Z0OuxgsSprBWHDVaRQUUF1XGAOgkKZM1WiiZXXOXuqd0DeiEbmLRcch0SgNQnU
        cBz6PJlWlaRLempUr3LIVzdQZOI3PXBwm4CKNzEVc8ihCrHsO1QFnyXhSTXAamzS
        OvHyMihNVCI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45E8F3ECEE;
        Fri, 16 Sep 2016 14:28:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C08CC3ECED;
        Fri, 16 Sep 2016 14:28:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [wishlist?] make submodule commands robust to having non-submodule Subprojects
References: <20160915130233.GC9833@onerussian.com>
        <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
        <xmqqwpidniry.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbYEqbr0h_0U=Ed-NRrsjb4XmznL8C45gTyJCVx+X-LTQ@mail.gmail.com>
        <xmqqsht1nhlh.fsf@gitster.mtv.corp.google.com>
        <20160916141143.GA47240@book.hvoigt.net>
Date:   Fri, 16 Sep 2016 11:28:51 -0700
In-Reply-To: <20160916141143.GA47240@book.hvoigt.net> (Heiko Voigt's message
        of "Fri, 16 Sep 2016 16:11:43 +0200")
Message-ID: <xmqqwpibk8bg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BFD0BAA-7C3B-11E6-9410-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Thu, Sep 15, 2016 at 11:27:54AM -0700, Junio C Hamano wrote:
>
>> If the trend in Git community collectively these days is to make
>> usage of submodules easier and smoother, I'd imagine that you would
>> want to teach "git add" that was given a submodule to "git submodule
>> add" instead by default, with an option "git add --no-gitmodules
>> sub" to disable it, or something like that.
>> 
>> >          $ git submodule add --fixup-modules-file ./sub sub
>> >          Adding .gitmodule entry only for `sub` to use `git -C remote
>> > show origin` as URL.
>> 
>> I agree that a feature like this is needed regardless of what
>> happens at "git add" time.
>
> How about just
>
>    git submodule add <submodulepath>

When I said "a feature like this is needed", I didn't care about
exact syntax.  I am not sure how often people need the "fixup", what
kind of causes there are that they need the "fixup", and what the
distribution of vaious causes would be like.  If the _ONLY_ kind of
fixup necessary is "I meant to say 'git submodule add ./path path'
but I said 'git add path' instead", then I think it makes sense to
teach "submodule add" that the form "git submodule add <path>" is a
short-pand for "git submodule add ./<path> <path>".  I am not sure
if we want to _ignore_ a gitlink that is already in the index
unconditionally, i.e. if it is a good idea to let the second one
override the first one

	git submodule add $URL sub &&
        git submodule add sub

in this sequence, though.

> ? I remember back in the days when I started with submodules thats the
> way I imagined submodules would work:
>
> 1. clone the submodule into a directory
> 2. git submodule add it
> 3. git commit everything
>
> Because that how you basically work with files.  So instead of adding
> another option I would rather like to autodetect that:
>
>  * its a relative path inside this repo that is passed to
>    'git submodule add'
>  * there is no .gitmodules entry
>  * and no .git/config
> ==> create those from a remote in the submodule

In other words, I agree with the general direction but I'd add
another condition to the above three, i.e.

   * and there is no gitlink for that path in the index yet.

