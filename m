Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C8BC433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39C2619D6
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhC3VyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:54:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62900 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhC3Vxf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 17:53:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EE61AFEB7;
        Tue, 30 Mar 2021 17:53:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OTmCZPEGgKnGL62xqPSemk1+lAk=; b=YmTM/2
        q9HZh/xBe2TikpJBXW7VvxDH1rI0sHhyeqH5FfSOli7VBgjaYTvKCPxPNvIeFLlu
        1tyAqE+ThdZbdIssM9t8Eq9dtQyq8XRBIYJlQTF6B/uoAFwYsqfLRWi5uHiKQje2
        BwbczcbDEYOPN+rdLICuaMtSG7lyaXtOVfhuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VqIItIVm5tpfqz2WB83rZxbBd/MdVmPl
        /zyu/f3RyDzFAYcK/9ZagKqX8I0TtXLTz/sqD49R0HFo8uuwjBLuldeAYhDSlUEn
        hnc6e1zeYQrJ+WlAb3W4TYruiNtNLbvkIquYTXFFjvyrAqtpOpzddjbeddvHH/5P
        +jdZouT4OVM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 654B6AFEB6;
        Tue, 30 Mar 2021 17:53:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9C83AFEB5;
        Tue, 30 Mar 2021 17:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug report: git branch behaves as if --no-replace-objects is
 passed
References: <CABPp-BEAbN05+hCtK=xhGg5uZFqbUvH9hMcCNMcBWp5JWLqzPw@mail.gmail.com>
        <YGLNBFJv8NKmrbvz@coredump.intra.peff.net>
        <xmqq35wceae6.fsf@gitster.g>
        <CABPp-BEE0eksCJSAviDh5GyqsOu=i_mW3VY6SEULa4kx0NsUMg@mail.gmail.com>
Date:   Tue, 30 Mar 2021 14:53:33 -0700
In-Reply-To: <CABPp-BEE0eksCJSAviDh5GyqsOu=i_mW3VY6SEULa4kx0NsUMg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 30 Mar 2021 14:19:35 -0700")
Message-ID: <xmqqa6qkcnqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F9C0592-91A2-11EB-BEC8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Using your own words:
>
> "the replace mechanism is about telling Git: when anybody refers to
> deadbeef, use its replacement if defined instead."

"When anybody wants the contents of deadbeef, give the contents of
its replacement" is what the replace (graft, too) is.

> git branch didn't do that; it put deadbeef into refs/heads/foobar.

Yes, but refs/heads/foobar having deadbeef does not have a problem,
as long as you get the contents of the replacement object when you
ask for the contents of deadbeef (or "the object referred to by
the refs/heads/foobar ref").

