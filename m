Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E953A200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 21:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbcL0VSS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 16:18:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61643 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752397AbcL0VSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 16:18:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4303359712;
        Tue, 27 Dec 2016 16:17:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=B3eooUdb063smSNKfjrsX1AQhPs=; b=qci9fYfd0tv6wO4eyJ9b
        lh5OFeBvfDlsilwbLiLW3AGhQwp0UpYjQqRtXuzkyGm9WsgAexcc5mKGJJBloLmc
        ZIo54CppJ5+9qEgYAwDSvOd3D73Y/sPDrW6VWxCRoAhvwFZ+tEh/EzDeGO7zvi25
        auUxdFZDYyBswNxmgiOUc60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ajvhJfbSBzVOg4K8okzdD4TmRR3bXr3KHqN8eBIgTJWucJ
        InD0fkwUkKMcagpvY84wdfR0HKyoSnKybRBMln0wjp0/3ypr8PP2QH/4KpGWaF+/
        k5Q2PjNHMVo9yDO+3ufh7WDbkn/Q2Lk3rdugzHmkM7VEzTWs9qk9O3oq8dJkA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3691859711;
        Tue, 27 Dec 2016 16:17:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A580E5970F;
        Tue, 27 Dec 2016 16:17:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v9 01/20] ref-filter: implement %(if), %(then), and %(else) atoms
Date:   Tue, 27 Dec 2016 12:58:04 -0800
References: <20161227162357.28212-1-Karthik.188@gmail.com>
        <20161227162357.28212-2-Karthik.188@gmail.com>
Message-ID: <xmqqbmvx842i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDDFCD28-CC79-11E6-8488-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

>  
> +Some atoms like %(align) and %(if) always require a matching %(end).
> +We call them "opening atoms" and sometimes denote them as %($open).
> +
> +When a scripting language specific quoting is in effect, everything
> +between a top-level opening atom and its matching %(end) is evaluated
> +according to the semantics of the opening atom and its result is
> +quoted.

What is unsaid in the last paragraph is that you assume "is
evaluated according to the semantics of the opening atom" does not
involve quoting and only the result from the top-level is quoted.  I
am not sure if that is clear to the first-time readers.

>  
>  EXAMPLES
>  --------
> @@ -273,6 +291,22 @@ eval=`git for-each-ref --shell --format="$fmt" \
>  eval "$eval"
>  ------------
> ...
> +------------
> +git for-each-ref --format="%(refname)%(if)%(authorname)%(then) %(color:red)Authored by: %(authorname)%(end)"
> +------------

This makes readers wonder how "red"ness is reset, but that is not
something this example is interested in demonstrating.  Let's drop
the %(color:red) bit to avoid distracting readers.
