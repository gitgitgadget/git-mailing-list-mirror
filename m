Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6A91F462
	for <e@80x24.org>; Sun, 16 Jun 2019 22:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfFPWl0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 18:41:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54915 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfFPWl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 18:41:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63D8A14B70C;
        Sun, 16 Jun 2019 18:41:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E03kwwC6du3WVRIOkUnot+vLI3o=; b=XRTJne
        PYaBegjAmEU6WFRaag1EL631UwNmt16uAwkD8j6Rtq4yAYuCeJ/wjWAvq+59E0J9
        qrPLik2Rf64abL0a5IqtSVQoQdfxX7DYXrFwzZX60mFBcTYrbpKPNUifuMAuUUfN
        cGK6rpW6XqouCLM+3OCF+uJk7aROvR+R6k0pE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QTJpNyjcELT7APxwru1JW1X/Uoj5TWTr
        u8KtGyYdDbKfI3voCRUQzf6fhbsuDqC73ts6v4SZ8ORXAjGNlC2TCT2rOQtS6LrY
        7W1zvWAczeURZQAchP3rMgBaIvq33lDx9XT7Mw+VNQ8gGAJotRcift5l2AIOe9dZ
        w6wPCiyxG/o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5660814B70A;
        Sun, 16 Jun 2019 18:41:24 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9C8814B709;
        Sun, 16 Jun 2019 18:41:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     michael@platin.gs, git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] Use an intermediate file between between git blame and sed to avoid git blame's exit code being hidden.
References: <20190615184039.3711-1-michael@platin.gs>
        <20190616190202.GA15262@archbookpro.localdomain>
Date:   Sun, 16 Jun 2019 15:41:22 -0700
In-Reply-To: <20190616190202.GA15262@archbookpro.localdomain> (Denton Liu's
        message of "Sun, 16 Jun 2019 15:02:02 -0400")
Message-ID: <xmqqy321rw4t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE676812-9087-11E9-A0E4-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> For yours, I would reword your commit message to something like
>
> 	t8014: avoid git command in upstream pipe
> 	
> 	Use an intermediate file between between git blame and sed to avoid
> 	git blame's exit code being hidden.

I agree that the main "points" of this patch that should be
highlighted on the title line are that it is about a test, and it is
about not hiding a failure of a Git command by placing it on the
upstream side of a pipe---the above title is very nicely written.

>> +	"git blame -M9 --ignore-rev $IGNOREME $i >output &&
>> +	sed -e \"$pick_author\" <output >actual &&
>
> We should take advantage of the fact that sed can open its own input
> here. So we should drop the `<` and just pass the filename to sed. Same
> applies to the below.

While I do not think it matters too much in this case, I agree it is
a good habit to get into, because it would give the command a chance
to produce a better error diagnosis (i.e. "malformed input on line
X" vs "malformed input on line X in file F"), when it wants to
report an error in input, if we give the name of the file to open to
the command instead of an already-open file descriptor, for one thing.


