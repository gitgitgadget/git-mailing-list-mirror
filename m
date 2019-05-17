Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE32C1F461
	for <e@80x24.org>; Fri, 17 May 2019 03:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfEQDnP (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 23:43:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59641 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfEQDnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 23:43:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B6847A43E;
        Thu, 16 May 2019 23:43:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pRjosE6+rt7cfDdIGYvn9KnqtLM=; b=Cp9siE
        JbKKuuvagz3pT0BatIroatLHA9fsKDMQSLtZ6h5hG/AvvVqUU8ydpOXYOEnruXZ7
        noJ+2zc057ycFKj+Vqx8O4nXMk8Nayz1GVWVyMY1d8ogAmSwF+WVHlapg7q3RaOr
        HvJcCJsCMz4DefcUzzLOFNHe1ccHoN4hiVzQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E6zXHi7gl9ODT2nkKRTyCkEjI7oZzKGD
        hPepyCvtNH3liAY4y2CCMwZ5h1SZJkL3Q13R5wB0JVuieVEj+V7RZe0t7yslst9h
        wbfGOe4ltPTWXZyEJCGFTYEF69CjKi6VQe8jBcsDLYMLXufA+BkcqjbIBsyAG4yZ
        EnutgIKYPlo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 826457A43D;
        Thu, 16 May 2019 23:43:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B06327A43A;
        Thu, 16 May 2019 23:43:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     avarab@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        xypron.glpk@gmx.de
Subject: Re: [PATCH v3 3/3] send-email: do defaults -> config -> getopt in that order
References: <20190508105607.178244-1-gitster@pobox.com>
        <20190508105607.178244-1-gitster@pobox.com>
        <5cddeb61.1c69fb81.47ed4.e648@mx.google.com>
        <xmqqh89u3sdw.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 17 May 2019 12:43:08 +0900
In-Reply-To: <xmqqh89u3sdw.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 17 May 2019 08:13:15 +0900")
Message-ID: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E42FD792-7855-11E9-BA99-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ah, sorry that nobody noticed that case, but you are right.  Because
> the ident is used as a part of the key to find identity-specific
> configuration values, if the command line gives one, we must have an
> access to it before we start reading the configuration.  In that sense,
> it is more fundamental to special-case the option.
>
> We are past -rc0, so I am inclined to revert the change (and perhaps
> replace it with the other "fix" that did not break the parsing order
> like these patches did), with an expectation that a clever fix will
> be found later, *unless* a simple and correct fix is found quickly.

Oops, spoke too soon.  The topic hasn't escaped to 'master' yet, so
I'll make sure it stays that way.  Thanks for catching a regression
before it gets too late.


