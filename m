Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515FF20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdK0EbQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:31:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64199 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750932AbdK0EbP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:31:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25FC9B18FD;
        Sun, 26 Nov 2017 23:31:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oJzUzauc+hIzm4pbSDJIVtVkML8=; b=wyeyMj
        FS3XpHQ7MM7AYEVvoRCm/30qtpUupJ0xF2MRgoW9wkJyvJQpGn6JxDAkvLgQfhmB
        m168gltnNDvlUuwbPD7mzKSzqxJvTK7MHAE3VMTFTEnao9gu+srZVIVFjXHbfJtH
        AP6gXxR723GjZR8jBrrG89Z8KWT9wrSNxqIc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F6wmzSmJ7i2MeSTZjoKeyeGYxJaxo6bW
        ToUlD4uQy2VapAMeICah/NuaALMGq4m7KDC10P0J/Llqw0e3mkYwTA9PDMEMnJRG
        h7HnMZPOORiWHL36DxDLprwCTClL/JyTkBuqXnbssqZj5Q46uLzwp3MVE+KvMv3n
        QGj+gicRw5E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CBDAB18FC;
        Sun, 26 Nov 2017 23:31:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BEF1B18FB;
        Sun, 26 Nov 2017 23:31:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
        <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
        <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com>
        <20171126191510.GA1501@sigill>
        <xmqqy3msfrr1.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 27 Nov 2017 13:31:13 +0900
In-Reply-To: <xmqqy3msfrr1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 27 Nov 2017 10:13:38 +0900")
Message-ID: <xmqqshd0e41a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDAE4FCE-D32B-11E7-8F58-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps the "else" part of the above should become a bit more
> careful, something along the lines of...
>
>     else
>             MSGFMT ?= msgfmt
> -           ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $$?),0)
> -                   MSGFMT := $(TCL_PATH) po/po2msg.sh
> -           endif
> +           MSGFMT_DRYRUN = --tcl -l C -d . /dev/null 2>/dev/null
> +            ifneq ($(shell $(MSGFMT) $(MSGFMT_DRYRUN); echo $$?),0)
> +               ifneq ($(shell $(TCL_PATH) po/po2msg.sh $(MSGFMT_DRYRUN); echo $$?),0)
> +                    MSGFMT := $(TCL_PATH) po/po2msg.sh
> +               else
> +                   $(error "no usable msgfmt to build gitk; set NO_TCLTK perhaps?")
> +               endif
>             endif
>     endif

Actually, at this point, I think the suggestion should primarily be
to install either msgfmt or tclsh; offering another choice to set
NO_TCLTK is OK, but it should be secondary, as the fact that the
make utility is running this recipe is a sign that the builder wants
to build gitk/git-gui.  

Whether the builder wants to run the result on the same box is a
separate and irrelevant matter.  Once built and installed, a box
without "wish" may not be able to run the result, but installing it
after the fact will fix it without need to rebuild anything.
