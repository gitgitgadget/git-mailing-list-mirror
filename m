Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ECA720323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbdCVVeQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:34:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54750 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753612AbdCVVeM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:34:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE9947FF67;
        Wed, 22 Mar 2017 17:34:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uKFrz2TpNMgkRxGq9DPhWoIJoSA=; b=dBT0J1
        48KCr1TNEF6bUwF2zWyKFqlT0ZFMziy8JGfaKBT82plyVxcQuzgBHXBaWazwTs+3
        zUox3MywmSDUh0+gt/jSnNvwA2M2jpRQbECcF6y98pNW/+QWz3l+CuEaH12m5qS8
        Srg0ZlRa6c0aCDd5t+GxGeMMmf9UiH+0ltGjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DFWYUSJ0EYdhn0sx0lpsIOQD2DD4Dfb6
        0RjIhXeAjkT71R0+BcVa1asOHp45f/CFYynzlZ+qjM9hvTqGL7W58bHiTdLyJXhp
        b9DA9UdKaHjTv9GcSiFGd4++tCMR2k5xMysHyXH0MEvB4W4PqtNteuwpWidKu3Qe
        OFePQXmE8/E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A608B7FF66;
        Wed, 22 Mar 2017 17:34:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A6E07FF63;
        Wed, 22 Mar 2017 17:34:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 2/3] t7406: fix here-doc syntax errors
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
        <20170322200805.23837-1-gitster@pobox.com>
        <20170322200805.23837-3-gitster@pobox.com>
        <20170322210733.ohb7duy7bmmon6ny@sigill.intra.peff.net>
Date:   Wed, 22 Mar 2017 14:34:02 -0700
In-Reply-To: <20170322210733.ohb7duy7bmmon6ny@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 22 Mar 2017 17:07:33 -0400")
Message-ID: <xmqqfui5hu7p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4576B7DE-0F47-11E7-AA3A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> After applying this, I get a failure:
>
>   --- expect	2017-03-22 21:01:53.350721155 +0000
>   +++ actual	2017-03-22 21:01:53.346721155 +0000
>   @@ -1 +1 @@
>   -Execution of 'false $submodulesha1' failed in submodule path 'submodule'
>   +Execution of 'false 4301fd3e4110d3b6212c19aed3094150392545b9' failed in submodule path '../submodule'
>
> At the very least, we need to drop the "\" from EOF to expand
> $submodulesha1.

Right.

> But the submodule path seems wrong, too. I'm not sure if
> the expectation is wrong, or if there's a bug. +cc Stefan
