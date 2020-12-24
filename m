Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A60C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 06:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E463522AAA
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 06:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgLXGOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 01:14:33 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59293 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgLXGOc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 01:14:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5C1410E8FB;
        Thu, 24 Dec 2020 01:13:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wrgBrgktl5OlKVd2MlvYwJLazkk=; b=lCFhoH
        LB4oGZyuLRw/RnH6PZjXNTQQWaWmWB/TklDys7Eq1p8bz9CYdBx2iU+f6EhSEzcE
        TEsHFeAbAycdolFTlGygzjz/HY/EkSp72uCNyPqLf/e84kfA5hT7bp4Qr4Ucqb7o
        5Fk8UwzlGhpbAVzcE04jVVGmeJ5EFRqBfuTDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XCRzXmNvDBUOs79E64DYrWNh2dULbfZC
        Snf/6JIydw8ksKPDhQhBF7Fgadj42I1DqrDaiuQcwx2ryLybc9MM1Xp/2EPXfa8Q
        xeF/7sw5pH2BbdUFW1VZTPBZjuKoVGu9hnNO96tFjdlyBsyMhcUi8Q/sofxHBMph
        8jdOWDvbGIQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF6BC10E8FA;
        Thu, 24 Dec 2020 01:13:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 16DB110E8F7;
        Thu, 24 Dec 2020 01:13:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Turner <mattst88@gentoo.org>
Cc:     gentoo-portage-dev@lists.gentoo.org, git@vger.kernel.org
Subject: Re: [RFC PATCH gentoolkit] bin: Add merge-driver-ekeyword
References: <20201221034452.307153-1-mattst88@gentoo.org>
        <CAEdQ38E9Fepp9gmidcf_HvFMacwPZBr0XgPT5HFs8bHw-SJDZQ@mail.gmail.com>
        <xmqqsg7w8fwx.fsf@gitster.c.googlers.com>
        <CAEdQ38En=HrG9A0STgaxFAwqxBjwNGQoV=U26Pia3x=gd-Attg@mail.gmail.com>
Date:   Wed, 23 Dec 2020 22:13:46 -0800
In-Reply-To: <CAEdQ38En=HrG9A0STgaxFAwqxBjwNGQoV=U26Pia3x=gd-Attg@mail.gmail.com>
        (Matt Turner's message of "Wed, 23 Dec 2020 23:47:22 -0500")
Message-ID: <xmqqmty34tph.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F5C0268-45AF-11EB-B554-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Turner <mattst88@gentoo.org> writes:

> ... is there a way git can be configured to
> fallback to another merge driver if the first returns a non-zero
> status due to unresolved conflicts? For example, if there are changes
> to other lines, how can I fall back to another merge driver?

There is no "fallback", but a merge driver should be able to first
run another merge driver (e.g. "git merge-file" or the "merge"
command from the RCS suite of programs would be line-oriented 3-way
drivers suitable for text files) and then fix up the leftover bits.

If your users don't want to contaminate the .gitattributes file that
is recorded in-tree, they can also use .git/info/attributes to locally
configure Git to use such a driver.

