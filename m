Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB0520951
	for <e@80x24.org>; Fri, 17 Mar 2017 21:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbdCQViv (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 17:38:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59804 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751061AbdCQViv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 17:38:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F5EC77F48;
        Fri, 17 Mar 2017 17:23:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mE/ZtyB6K1V29JjonTeEBt2xMTg=; b=UbIoRw
        JmhzF3yspzKvvugqi4uFcv+8XWg9Cx8Lu1fDYgt0o+c0ZWfS3AgWCZQIG21D+k17
        gF86SP3srR1lqbGt+rg4AXMSaEl3fYrAJuUKKdDiwIHAhVjiOFvWSctHfR2ntf8s
        rB20NFoDW8SQRpgnwysMqb9lY6ddrGmapxM6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vgRbh9QQ3zX3AkucymTtcXW5r2tRYDgJ
        6XiBcN1Jt3nIGjIBjv5ULnlUZ5oy6lyBBZRkCozUVtjZuaTrzMxMBi/cBGMTS2F1
        WbdRWEv6TdzgTz501GtvR4Lv5c4YYtrxQ7IlHqsxS6SBKFeF6vllHFgSWEL/zPiO
        UgA6EFTE2y0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38FFF77F47;
        Fri, 17 Mar 2017 17:23:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98A1A77F43;
        Fri, 17 Mar 2017 17:23:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nevada Sanchez <sanchez.nevada@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug with .gitignore and branch switching
References: <CAPUVn2u0Uos2mT5+4ejj8m0okNK6XwerL6ce2miHfhtuEs-ZnQ@mail.gmail.com>
Date:   Fri, 17 Mar 2017 14:23:13 -0700
In-Reply-To: <CAPUVn2u0Uos2mT5+4ejj8m0okNK6XwerL6ce2miHfhtuEs-ZnQ@mail.gmail.com>
        (Nevada Sanchez's message of "Fri, 17 Mar 2017 16:42:35 -0400")
Message-ID: <xmqqmvcj61j2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE4FE22A-0B57-11E7-807C-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nevada Sanchez <sanchez.nevada@gmail.com> writes:

> Here's an easy to reproduce bug. It's the only example I know of where
> git legitimately loses data in a way that is unrecoverable,
> unexpected, and without warning.

This is an example of a user explicitly telling git to discard data
and git performing as it is told.

There is no "untracked but precious" vs "untracked and expendable"
difference in the current system.  An untracked file that matches
patterns listed in .gitignore is treated as the latter.

When you have an untracked file that .gitignore knows about in the
working tree while you are on "feature", if switching to another
branch requires to remove that file, the content there is deemed
expendable, because the user said so by listing it in .gitignore.

We've discussed the lack of "untracked but precious" class a few
times on the list in the past, but I do not recall the topic came up
in the recent past.  It perhaps is because nobody found that class
useful enough so far.
