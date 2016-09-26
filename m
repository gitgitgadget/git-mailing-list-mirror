Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29730207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 20:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941552AbcIZUyu (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 16:54:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52707 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752097AbcIZUyt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 16:54:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF43D41E72;
        Mon, 26 Sep 2016 16:54:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P9UUPtzYGiW5754lbCQWMHbvW7g=; b=aBOfJK
        pBl3uP5K3xxnGvcvKGtyj+Dv8mR7I077cpwndCje701LsuAMw2fzIcMZX3+27tXg
        bxxQ7fdDxDvUdbXmqInK3b73TQjmZpJ8+7MaUfvXi1EV/mCfhZP7pMBu+UAMjUZ4
        Z08GBrhiCrfTilNPuk1DiIn+HUmjpsvRI30EI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jrrJhkIvZHBoBLEpbTvVrS/XNXTnSvyS
        mmdanqtIVsb+HPZogsb9M1TgkagAerhnfcAQ/ts1G9i+x+LUPfixiDZNUSH+9EAN
        xCvIAGM1o0CltoEQLmX0eSNglrC+GyLkAAzgd9dhQyWhPx4cMM/sjQNCY9JPDvwH
        2gDgkxbhirE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D83E941E71;
        Mon, 26 Sep 2016 16:54:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B7A941E70;
        Mon, 26 Sep 2016 16:54:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Documentation/fetch-options: emit recurse-submodules, jobs unconditionally
References: <20160926193553.32631-1-sbeller@google.com>
        <xmqq7f9yqu9w.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbeq+Wznm=ChWO0tU5A_haPQ6DvKNHbK+8Y3es5OVcRag@mail.gmail.com>
Date:   Mon, 26 Sep 2016 13:54:45 -0700
In-Reply-To: <CAGZ79kbeq+Wznm=ChWO0tU5A_haPQ6DvKNHbK+8Y3es5OVcRag@mail.gmail.com>
        (Stefan Beller's message of "Mon, 26 Sep 2016 13:44:19 -0700")
Message-ID: <xmqq37kmqt4a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75A94FCC-842B-11E6-A0B4-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> After a bit more research, I think 8f0700dd33f (fetch/pull: Add the
> 'on-demand' value to the --recurse-submodules option) is the culprit,
> where this patch should have been squashed into, as that made the
> both locations word for word equal.

Hmph, my digging points to elsewhere.  7811d960 ("pull: Document the
"--[no-]recurse-submodules" options", 2011-02-07) which is older
than 8f0700dd ("fetch/pull: Add the 'on-demand' value to the
--recurse-submodules option", 2011-03-06) seems to be the real
change that pulled the description of recurse-submodules made in
fetch-options into "show this only when we are not describing pull".

Unfortunately it is not clear why we actively wanted to be sketchier
when showing "git help fetch"; otherwise the change would have been
made to the existing description there without adding a new entry to
"git-pull.txt".

