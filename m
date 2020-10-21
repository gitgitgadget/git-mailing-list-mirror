Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF21C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AA2241A3
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fcLOyQXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506607AbgJUWTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:19:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54883 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506551AbgJUWTc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:19:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DBC461048EB;
        Wed, 21 Oct 2020 18:19:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rQLp9uYpeAOuxFmmcyOZlgGfoLA=; b=fcLOyQ
        XqqhyMa4hY+W86tkOhYawEjtTo2WTtgQ7fKx0QMDjy6KX2T5aEIK+ZtzW7Vhu739
        fMc7KtjngZUmNrADaF6SjDIYaI0ikV9usKZTUxe8UjXtEjB/ER5XaY5/kXKlUhia
        tRTULqPeZylwije6QPZ6n3CSYysCUCoGWXwbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gc/r1GdTMAKXme9X52HBkf0wadNNCnry
        YuUydj+sAEqI4y6zpqsJELr9Cq6goDQJoOOuzXljkcomek7oLdJQKajDB1sK+v3K
        B1QibDLQlYUodvtVzV5pLLb8KKodF4mXaLMt9SnyS6CakHnn3AXKYPfUvP1XidwP
        zspVDuHlnGw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D48941048EA;
        Wed, 21 Oct 2020 18:19:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 282591048E6;
        Wed, 21 Oct 2020 18:19:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/10] t9801: use `--` in preparation for default branch
 rename
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <5849eda331e09732026f0432cf1040a4e973a702.1603135902.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 15:19:26 -0700
In-Reply-To: <5849eda331e09732026f0432cf1040a4e973a702.1603135902.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 19 Oct 2020
        19:31:33 +0000")
Message-ID: <xmqq36275ij5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BE5236C-13EB-11EB-A71A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Seeing as we want to use `main` as the new default branch name used by
> `git init`, and that `main` is used as directory name in t9801, let's
> tighten the rev-list arguments to make it explicit when we are referring
> to a ref instead of a directory.

Interesting.  s/master/main/g would introduce "that name is both a
revision and a path" ambiguity?  An obvious alternative would be to
use a word that is not 'main' or 'master' for the path and that way
we will keep the current property that tests do not have to worry
about the rev/path ambiguity.  But given that even "git p4" should
be safe against rev/path ambiguity, I think this is good in the long
run---if "git p4" is not prepared to handle the ambiguity correctly,
then this approach may reveal such an existing breakage when the
branch name 'master' is replaced with 'main', and at that point, we
have to scramble and fix it (or rename the path from 'main' to
something else as a workaround).

Looking good.

