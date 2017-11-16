Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B27201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 01:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933607AbdKPBfo (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 20:35:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65493 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933189AbdKPBfm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 20:35:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 772ACB4682;
        Wed, 15 Nov 2017 20:35:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b+jiGywwXKLGEkdv4UA5dThu6/M=; b=oseya3
        WeRAqd3lbiOc6wSd4xtiKeO24KFT1NDNXHMHwj9sPCZU+ua6fSFE5sqFadwh90JL
        /qVMfZYKMOp1haUMFwNlVR8fcNbkghMk4x56j/QUorm4c/6VIH4JCflxnlxv3tFN
        HdXepN1Du19WCzaYd3I3EjfPrhexcPBwiVh8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DW8jsIy7/odmy2AXXyQ8qoIdkVxkuqVV
        R39gIBnJtzt8GZ4KpUDNxNsfjq4N2q8a0HZDQNO5rTNpxaDsA25GZHKk1S1DyK2/
        Qzh3Kwj8LE6HiDk9sgJ5g8AQdqp0nuKEI/gfbdC4EgJ89GCAzLV2UvnRl3tDSEev
        SORWKzk+oBw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 645F4B4681;
        Wed, 15 Nov 2017 20:35:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8731B4680;
        Wed, 15 Nov 2017 20:35:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Dominik Mahrer <teddy@teddy.ch>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
References: <20171115125200.17006-1-chriscool@tuxfamily.org>
Date:   Thu, 16 Nov 2017 10:35:39 +0900
In-Reply-To: <20171115125200.17006-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Wed, 15 Nov 2017 13:52:00 +0100")
Message-ID: <xmqqbmk3xaxg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74921F62-CA6E-11E7-B1F8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> To improve the current behavior when Tcl/Tk is not installed,
> let's just check that TCLTK_PATH points to something and error
> out right away if this is not the case.
>
> This should benefit people who actually want to install and use
> git-gui or gitk as they will have to install Tcl/Tk anyway, and
> it is better for them if they are told about installing it soon
> in the build process, rather than if they have to debug it after
> installing.

Not objecting, but thinking aloud if this change makes sense.

If you are building Git for your own use on the same box, which is
presumably the majority of "build failed and I have no clue how to
fix" case that needs help, if you want gui tools, you need to have
tcl/tk installed anyway, whether you have msgfmt installed.  This
seems to be the _only_ class of users this patch wants to cater to.

I wonder if we are hurting people who are not in that category.

 - To run gui tools, tcl/tk must be available at runtime, but tcl/tk
   is not necessary in the packager's environment to produce a
   package of Git that contains working git-gui and gitk that will
   be used on an end-user box with tcl/tk installed, as long as the
   packager's environment has a working msgfmt.

 - To process .po files for the gui tools in the packager's
   environment without msgfmt, tcl/tk is required.

I suspect that this change will hurt those who package Git for other
people.

It used to be that, as long as they have msgfmt installed, they only
needed to _know_ what the path on the users' box to "wish" is, and
set it to TCLTK_PATH, and if they are distro packagers, most likely
they already have such an automated set-up working.  Now with this
change, they are forced to install tcl/tk on their possibly headless
box where tcl/tk is useless, and worse yet, an attempt to install it
may bring in tons of unwanted stuff related to X that is irrelevant
on such a headless development environment.

I doubt that this is quite a good trade-off; it feels that this
burdens packagers a bit too much, and we may need a way to override
this new check further.  I think "If I cannot run either wish or
msgfmt, then barf and give an error message" might at least be
needed.  Am I misinterpreting the motivation of the patch?

> diff --git a/Makefile b/Makefile
> index ee9d5eb11e..ada6164e15 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1636,6 +1636,13 @@ ifeq ($(TCLTK_PATH),)
>  NO_TCLTK = NoThanks
>  endif
>  
> +ifndef NO_TCLTK
> +	has_tcltk := $(shell type $(TCLTK_PATH) 2>/dev/null)
> +	ifndef has_tcltk
> +$(error "Tcl/Tk is not installed ('$(TCLTK_PATH)' not found). Consider setting NO_TCLTK or installing Tcl/Tk")
> +	endif
> +endif
> +
>  ifeq ($(PERL_PATH),)
>  NO_PERL = NoThanks
>  endif
