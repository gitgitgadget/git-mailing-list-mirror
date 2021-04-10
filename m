Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D4C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 00:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592706113A
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 00:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhDJAwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 20:52:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54409 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhDJAwy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 20:52:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4783121D2F;
        Fri,  9 Apr 2021 20:52:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4RqGRa2jQQKhEX9+XQNODFgODY8=; b=AHR9Jg
        sQzyWOYt3WZAxMAICruPvkgxtD43H+48gfvJY1n6/Vbuw7ECJ3F+Gsdr/uE5w7FO
        Pvw8ldNjzfkcE89RWstHeF/nHdGNuCC9YOmkuhfeU/AnY6GxN/4aAl/cdgDk31KX
        bje+0xzMu91R8aFHKAwMSTI5JA1CSbBBDRf2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=llNt0q/2gg2G9bc4EWsSxRk0NwqJI2Aw
        G9X5EM3VbqHHcFbP2dcAKYEJSepJOoETdEKIo3jVaX3HcbcAvn6Lr+848kptAdsg
        gRNy8cA28juRZvbs97d3GmQyv6ysVHQXTXyq/yNWm/L/cewcZhAdwMIe+jmLLQzu
        X7K7rkygJ+I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADB4B121D2C;
        Fri,  9 Apr 2021 20:52:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 037EC121D2B;
        Fri,  9 Apr 2021 20:52:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: clarify SMTP encryption settings
References: <20210409211812.3869-1-sir@cmpwn.com>
Date:   Fri, 09 Apr 2021 17:52:36 -0700
In-Reply-To: <20210409211812.3869-1-sir@cmpwn.com> (Drew DeVault's message of
        "Fri, 9 Apr 2021 17:18:12 -0400")
Message-ID: <xmqqlf9rklkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BB2333C-9997-11EB-9DAA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> The present options are misleading; "ssl" enables generic, "modern" SSL
> support, which could use either SSL or TLS; and "tls" enables the
> SMTP-specific (and deprecated) STARTTLS protocol.

Hmph.

Isn't SMTPS (running SMTP over SSL encrypted connection) the one
that was once deprecated until it got resurrected)?

STARTTLS is not all that SMTP specific---POP and IMAP can also start
in cleartext and upgrade with STARTTLS the same way, no?

I couldn't find a justification for our log message to call
STARTTLS-style explicit TLS "deprecated".  When you send an updated
version, please give a reference.

> This changes the canonical config options to "ssl/tls" and "starttls",
> updates the docs to explain the options in more detail, and updates
> git-send-email to accept either form.
> ---

Missing Sign-off, ...

>  Documentation/git-send-email.txt | 11 ++++++++---
>  git-send-email.perl              |  4 ++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 93708aefea..3597935e41 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -168,9 +168,14 @@ Sending
>  	unspecified, choosing the envelope sender is left to your MTA.
>  
>  --smtp-encryption=<encryption>::
> -	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
> -	value reverts to plain SMTP.  Default is the value of
> -	`sendemail.smtpEncryption`.
> +	Specify the encryption to use, either 'ssl/tls' or 'starttls', whichever
> +	is recommended by your email service provider.  SSL/TLS is typically
> +	used on port 465 and is preferred if available.  STARTTLS is typically
> +	used on port 25 or 587. Any other value reverts to plain SMTP.  The
> +	default is the value of `sendemail.smtpEncryption`.

I think it is a vast improvement to describe what existing 'ssl' and
'tls' does, like the above does.  It is a documentation update that
deserves its own commit (i.e. [PATCH 1/3]), and it should be done
before adding the new ssl/tls and starttls synonyms.

Making it an error to give unrecognised string (i.e. other than
'ssl' and 'tls'), or at least warning, would be a good follow-up
change (i.e. [PATCH 2/3]), but that is optional.

And then, it may make sense to introduce the synonyms, but please
make it a separate patch that builds on top of the other two steps
(i.e. [PATCH 3/3]).

Honestly I am ambivalent about these two synonyms this patch added.

In the ideal world, it would have been nice if we could make 'tls'
as the name of the choice that has been known as 'ssl' (i.e. the
underlying transport protocol to run SMTP or any other higher layer
protocol on top, there used to be SSL but these days TLS is used as
an improved alternative---SSL 2.0/3.0 have been deprecated for some
time), but because we used 'tls' to mean the STARTTLS-style "start
SMTP as plain and then upgrade to encrypted channel", we can't reuse
the 'tls' for that purpose.

I do not have any qualm about the fully spelled out "starttls"
synonym for the latter.  In fact, if we can go back in time and redo
the history with hindsight, that is the name we should have used
from the beginning.  But I find it unfortunate that we need to say
'ssl/tls', i.e. prefixing the name of the choice with the name of a
deprecated thing, for the former.  Another reason I am hesitant
about 'ssl/tls' is because the description of it in documentation
naturally invites errors.  I.e. "You can set it to 'ssl/tls'..."
sounds as if the manual is telling me to use one of 'ssl' or 'tls',
which is not what it is sayng---it literally wants me to say
'ssl/tls' with a slash in it.

Thanks.
