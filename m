Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC5AC41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 17:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84BF2173E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 17:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vHA/DtC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgJGRJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 13:09:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56393 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgJGRJn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 13:09:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2513F0777;
        Wed,  7 Oct 2020 13:09:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=La1KIxsx611MJBlM6TAjPv+LSyI=; b=vHA/Dt
        C5WArxOu+/O6S/2JX0cLK4ZLcmP0OpZOZtuq+PNcSXTAY74NUkzIOPzXPx54u/bB
        1dbnNjhfjJsnGgyCeRWZr6pJMtObaHKshjtWGPfcDz3D5VZg402J0h39XyKb8Hz0
        yPXCaT0qLZK7y3JM/BUforvEWn0QObFKyigR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vQUKOK1CGKCrn4b5FoH6MhxTjk0qoSpl
        yMiEydANp6V667pvBKLIcvOUbWPc7zHrbmcXXqjcBA02e7dI9/TwCW6KlZFBV6g/
        m4Fu4xSgR6MuruNgOfKsYFmc6yrS3nm3esv3qpoKzuXe8TscJhsqZjNuZXbMLE/e
        xRXpn9M9HKo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B07DF0776;
        Wed,  7 Oct 2020 13:09:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE8DAF0775;
        Wed,  7 Oct 2020 13:09:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sohom Datta <sohom.datta@learner.manipal.edu>
Subject: Re: [PATCH] userdiff: expand detected chunk headers for css
References: <pull.866.git.git.1602062726316.gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 10:09:37 -0700
In-Reply-To: <pull.866.git.git.1602062726316.gitgitgadget@gmail.com> (Sohom
        Datta via GitGitGadget's message of "Wed, 07 Oct 2020 09:25:26 +0000")
Message-ID: <xmqqtuv62ca6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E20DC5A4-08BF-11EB-9C89-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sohom <sohom.datta@learner.manipal.edu>
>
> Added support for classes, ids, :root selectors
> as well as @-based statements (ex: @page, @media
> and @keyframes ).
>
> Also added tests for the same.
>
> Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
> ---
>     userdiff: Expand detected chunk headers for css
>     
>     Currently, the regex used for the CSS builtin diff driver in git is only
>     able to show chunk headers for lines that start with a number, a letter
>     or an underscore.
>     
>     However, the regex fails to detect classes (starts with a .), ids
>     (starts with a #), :root and attribute-value based selectors (for
>     example [class*="col-"]), as well as @based block-level statements like 
>     @page,@keyframes and @media since all of them, start with a special
>     character.

The above two would be much better beginning of the log message for
this change modulo a few nits.

 - We first explain what the current system does in the present
   tense.  "Currently, " at the beginning is a pure noise.

 - And we point out what may be lacking (which you did a very good
   job in the second paragraph).

 - And finally, we write in imperative mood to give an order to the
   codebase to "become like so." or an order to the patch monkey to
   "make the codebase like so."

As the last paragraph to follow the two paragraphs, something like

    Allow the selectors to begin with these special characters.

would be sufficient.

> -	 "^[_a-z0-9].*$",
> +	 "^(([_a-z0-9]|[:[@.#][_a-z0-9]).*)$",

As we seem to allow ? (i.e. zero or one) in the patterns, it probably
makes it easier to read to spell the above like this instead?

-	"^[_a-z0-9].*$",
+	"^[:[@.#]?[_a-z0-9].*$"

