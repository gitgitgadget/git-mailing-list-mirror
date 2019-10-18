Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA09D1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 01:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441716AbfJRBc1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 21:32:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61931 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfJRBc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 21:32:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B825F95DD4;
        Thu, 17 Oct 2019 21:32:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bPYo+taCUrQ87KwPo/1mnlSSsz0=; b=NBSbF5
        bYfWgOOrM0kD+d9DZQzZrHZ6+2ycxRGmKHVAV0Fncw+yJHLvSSdDdTVXpVrz7ezk
        asrKRUU3FAEqwWFzagOAqFoIlLYxXw0kjz/9rL45sIxg/4Q0kJtbBoUmCOkrWBFp
        B20oqCneb0cJUYWDNjAhNLR+jo3URDZ1J+SLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ne5ct7DzYHvDRqjnr3O2zsbY2cvyoCY5
        X1nMWzb5cD8hBeKQJ4yNzeBbn3ZXWOHooJ3xDbSF8V3QdQY6SA135b1qG+FQfMpd
        gkSyum9loQhJkDcyqtQZi1S/L84xcihcciO39n4WBR2XNl4IL/TXxdJpIIqzILnO
        w62tolw8GAE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADCBC95DD3;
        Thu, 17 Oct 2019 21:32:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DAA8295DD1;
        Thu, 17 Oct 2019 21:32:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>
Subject: Re: [PATCH v1] config/branch: state that <name>.merge is the remote ref
References: <20191016112822.1701-1-philipoakley@iee.email>
Date:   Fri, 18 Oct 2019 10:32:20 +0900
In-Reply-To: <20191016112822.1701-1-philipoakley@iee.email> (Philip Oakley's
        message of "Wed, 16 Oct 2019 12:28:22 +0100")
Message-ID: <xmqqwod26dp7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22217D8E-F147-11E9-B667-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>  branch.<name>.merge::
>  	Defines, together with branch.<name>.remote, the upstream branch
> -	for the given branch. It tells 'git fetch'/'git pull'/'git rebase' which
> +	for the given branch. It defines the branch name _on the remote_,
> +	which may be different from the local branch name.

While I do agree with the goal of make things more clear, I'd avoid
being overly redundant and giving irrelevant information (e.g. the
copy you have locally may be made under arbitrary name that is
different from the name used at the remote).  After all, the users
do not even need to know about the remote-tracking branch to
understand this naming mechanism.

Perhaps something along this line instead:

    The name of the branch at the remote `branch.<name>.remote` that
    is used as the upstream branch for the given branch.  It tells
    `git fetch`, etc., which branch to merge and ...

