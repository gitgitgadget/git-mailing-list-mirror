Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PI_IMPORTANCE_HIGH,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DEBB208B4
	for <e@80x24.org>; Mon,  7 Aug 2017 16:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbdHGQf7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 12:35:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58720 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751860AbdHGQf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 12:35:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5F619FA33;
        Mon,  7 Aug 2017 12:35:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yeaX/BFvNjc99Pfubc1Hx8svaMs=; b=wxM8wY
        jG43TjKmJMZ5+bKon4h50Z8hCWuMZtEtMElkePRJtHrMvp9cIOImZbB1vFcy4RFY
        NkWENkmmWHSZT/baF6861g/v6pAqiEP087mAfEDV1SJDIY3uqpYnJwKzs0kwyLeg
        b9ulwypYk3a0AGFYVh2qPmybQD9ue33Hq1Mys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jpXty7LqXy5CaYYBfSwpcnF+Yq8LtIEM
        /AgH686lOu7AoHjulq18vgmjLlkXEp07fFT4SclxHHNuJmM+/xRlWlu48eZt58Lw
        cI3plGdoFuu6P1WJ+RwhoLsILvu+hPEhA8PpWIvrD1pfsK+NRa4+GN2HEn3PSib4
        kHfjdBw/aiQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DB219FA32;
        Mon,  7 Aug 2017 12:35:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03C9F9FA31;
        Mon,  7 Aug 2017 12:35:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Forney <mforney@mforney.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
References: <20170805064905.5948-1-mforney@mforney.org>
Importance: high
Date:   Mon, 07 Aug 2017 09:35:55 -0700
In-Reply-To: <20170805064905.5948-1-mforney@mforney.org> (Michael Forney's
        message of "Fri, 4 Aug 2017 23:49:05 -0700")
Message-ID: <xmqqshh3qqs4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CF86EA6-7B8E-11E7-BA0D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Forney <mforney@mforney.org> writes:

> This way, they still work even if the built-in symlinks aren't
> installed.
>
> Signed-off-by: Michael Forney <mforney@mforney.org>
> ---
> It looks like there was an effort to do this a number of years ago (through
> `make remove-dashes`). These are just a few I noticed were still left in the
> .sh scripts.

Our goal was *not* to have *no* "git-foo" on the filesystem,
though.  It happened in v1.6.0 timeframe and it was about removing
"git-foo" from end-user's $PATH.

Earlier there was a more ambitious proposal to remove all "git-foo"
even from $GIT_EXEC_PATH for built-in commands, but that plan was
scuttled [*1*].

The changes in your patch still are good changes to make sure people
who copy & paste code would see fewer instances of "git-foo", but
"will still work even if I break my installation of Git by removing
them from the filesystem" is not the project's goal.  

IIUC, you will need "$GIT_EXEC_PATH/git-checkout" on the filesystem
if you want your "git co" alias to work, as we spawn built-in as a
dashed external.


[Reference]

*1* https://public-inbox.org/git/alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org/


