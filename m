Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081541F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 16:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfHPQlu (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 12:41:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62159 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfHPQlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 12:41:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 055C67CCDF;
        Fri, 16 Aug 2019 12:41:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iVeL8Tmfk0prCHw1MD9Lfmrmv/w=; b=bHB08Y
        rlksZSSEskgGApf+0NkA4mDoDO2J9+BUziqQu/Xx1WwPnWM63BR1deP04ZprpKt3
        eEhhOKsGLw+OCbcpFVDVfSfj+ZO/rKJVHBsQFEueBIJeAN0tYYLYmrr4dXVV5mmD
        K68k7CU4ECrpTo7e5jB2q+aN0oKWr0Q0Z4sKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gWHQNYA0VjuHXyT6NCXwTNtSdW65VKd4
        YyfzSndnjiahq7kL72tftBsU3nMIEUw0UsDRnyzYidAiYPzWVHnUD+Fk2ng+1ue3
        NbLwzwKwDZVVx9XbE3D7KaYZ4NJMw5yYyxbGOrFEgMZ/Uf+LXU1OKFncogOM6LHP
        CAByStvooHI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F0B697CCDC;
        Fri, 16 Aug 2019 12:41:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 008B77CCDB;
        Fri, 16 Aug 2019 12:41:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
References: <20190815023418.33407-1-emilyshaffer@google.com>
        <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
        <xmqqy2zu4hrq.fsf@gitster-ct.c.googlers.com>
        <20190815225231.GD208753@google.com>
        <xmqqwofe0zgd.fsf@gitster-ct.c.googlers.com>
        <20190816012519.GF208753@google.com>
Date:   Fri, 16 Aug 2019 09:41:41 -0700
In-Reply-To: <20190816012519.GF208753@google.com> (Emily Shaffer's message of
        "Thu, 15 Aug 2019 18:25:19 -0700")
Message-ID: <xmqqpnl512re.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB0F5F86-C044-11E9-8BA0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I think comparing this habit to the .gitignore isn't quite fair -
> .gitignore tells me I forgot to add my new command binary to it, when I
> run `git status` to see what I need to add to my commit with new
> command.

That is why I said that we need to actively work on, if we care
about getting quality reports.

I do not think it is unreasonable to expect the build procedure for
"git bugreport" to involve scanning in Documentation/config/ to pick
up variable names, annotated in such a way that is invisible to
AsciiDoc to allow us tell which ones are sensitive and which ones
are not.  A test in t/ could even check if a documented
configuration variable has such an annotation.  A commit that adds
configuration variables without documentiong them does exist, but
variables without documentation are (1) bugs, and (2) are not worth
serious engineering effort on until they get documented.

I am not saying that you must implement the whitelist exactly like
the above.  I am not even saying that this must be whitelist and not
blacklist---you'd have the same issue maintaining the list anyway.

The above is merely to illustrate the reason why I think that the
kind of "active work" to make sure that the list will not go stale
would be feasible.

Thanks.
