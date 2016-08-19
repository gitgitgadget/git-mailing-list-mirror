Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2501F859
	for <e@80x24.org>; Fri, 19 Aug 2016 15:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbcHSPxk (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 11:53:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58298 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753616AbcHSPxj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 11:53:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4362535694;
        Fri, 19 Aug 2016 11:53:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gg1041M4+2U4IRQe+g7aO1iyBms=; b=uIuQ/v
        XFfCt2R6poiBKcwjX25MXb5ZRjphyeC07sjqG6uWdRpfPANAfz91dxw0tjGYmEBx
        NKZFfxKh8T2Cc7wSbESJN1j9gJ3Rp/IJJo1I5pBfw9tqXLJerdQ+1drjGqYjv8zr
        /emBR+QEJw0A2XNgJ5IC2+9ni0PDPnJ+dhF/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K6fJ1VF9qao091PR3i03C+1jqi8H5+6O
        El+pwMw3RuWwsKQ6j3pqRT4rTqWrcwYEmD4pG6Sn05AhjXOsqe0/XLxXpjc+4d1g
        pIdsB8vm0bKRSRXBKFOCBjDTwb1y4Pz2qTXgtkjLXYRRQOzABPYU/dJKS39hYsVh
        0y0Uti+dTBc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BCE235693;
        Fri, 19 Aug 2016 11:53:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B429535692;
        Fri, 19 Aug 2016 11:53:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org,
        larsxschneider@gmail.com, me@jnm2.com, philipoakley@iee.org,
        john@keeping.me.uk
Subject: Re: [PATCH 1/2] help: introduce option --command-only
References: <20160816162030.27754-1-ralf.thielow@gmail.com>
        <20160818185719.4909-1-ralf.thielow@gmail.com>
        <20160818185719.4909-2-ralf.thielow@gmail.com>
        <alpine.DEB.2.20.1608190954461.4924@virtualbox>
Date:   Fri, 19 Aug 2016 08:53:35 -0700
In-Reply-To: <alpine.DEB.2.20.1608190954461.4924@virtualbox> (Johannes
        Schindelin's message of "Fri, 19 Aug 2016 10:32:30 +0200 (CEST)")
Message-ID: <xmqqinuw4uww.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17A881D2-6625-11E6-9FB8-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> - configure help.format = html (for "man", the current code would always
>   add $(prefix)/share/man to the MANPATH when testing, not what we want,
>   and hacking this code *just* for testing is both ugly and unnecessary).

A very constructive suggestion to show a good direction.  Because we
are not in the business of verifying the "man" works as expected and
how it wants the files in MANPATH are structured, it is a very good
idea to do our testing with the HTML format, which gives us tighter
control of what we actually use for our testing with help.browser
configuration variable.  I really like it.

> - configure help.htmlpath to point to a subdirectory that is created and
>   populated in the same test script.

Yup!

> - configure help.browser to point to a script that is created in the same
>   script and whose output we can verify, too.

Yup, yup!  The "browser" can be something that parrots its command
line to the standard output and does not even have to care if the
file pointed at is HTML at all.

> The last point actually requires a patch that was recently introduced into
> Git for Windows [*1*] (and that did not make it upstream yet) which
> reverts that change whereby web--browse was sidestepped. That sidestepping
> was well-intentioned but turned out to cause more harm than good.

Good.
