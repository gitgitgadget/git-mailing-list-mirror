Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E13C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 17:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJKRXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 13:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJKRXA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 13:23:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E85AA2E
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 10:22:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CDDC14BA28;
        Tue, 11 Oct 2022 13:22:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BbFSb/KwbIdekovAUWqzo11TurdZEAfuUXacDG
        YZUq4=; b=fHJR61u9WJST+oEmr4gebNl9X1qi3er5RI57HMWGdLk/LyL0/u8KGg
        GsfFFNIXNR3qltsSYhlCtrZesGWUxvlby89YBkuf9MvdoW7vaE+7I2xbh8qJdWFP
        wlZQIzjnz3kHl6VyEHW5uTH8OW6SDE5II4XanJnYt2Fu5oUo5JY/w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73EF914BA26;
        Tue, 11 Oct 2022 13:22:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C92A214BA25;
        Tue, 11 Oct 2022 13:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     sndanailov@wired4ever.net
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        aaron@schrab.com, philipoakley@iee.email
Subject: Re: [PATCH v2] docs: git-send-email: difference between ssl and tls
 smtp-encryption
References: <20221011164927.1516-1-sndanailov@wired4ever.net>
Date:   Tue, 11 Oct 2022 10:22:56 -0700
In-Reply-To: <20221011164927.1516-1-sndanailov@wired4ever.net>
        (sndanailov@wired4ever.net's message of "Tue, 11 Oct 2022 18:49:27
        +0200")
Message-ID: <xmqqh70auvf3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5972DCCC-4989-11ED-9EF4-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sndanailov@wired4ever.net writes:

> From: Sotir Danailov <sndanailov@wired4ever.net>
>
> New explanation for the difference between these values.
> It's hard to understand what they do based only on the names.
> New description of used default ports.
>
> Signed-off-by: Sotir Danailov <sndanailov@wired4ever.net>
> ---
> Changes since v1: Expanded explanation, covering more terms.
> Link to v1: https://public-inbox.org/git/20221010172859.13832-1-sndanailov@wired4ever.net/
>
>  Documentation/git-send-email.txt | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 3290043053..d64a46fa87 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -178,9 +178,18 @@ Sending
>  	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
>  
>  --smtp-encryption=<encryption>::
> -	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
> -	value reverts to plain SMTP.  Default is the value of
> -	`sendemail.smtpEncryption`.
> +	Valid values are 'ssl' and 'tls'. Any other value reverts to plain
> +	(unencrypted) SMTP, which defaults to port 25.

Please always start the description of a thing by explaining what
the thing is.  After reading two lines, we learned what values to
plug <encryption> are valid, but we still do not know what good
giving --smtp-encryption=<encryption> is supposed to give us.

> +	Despite the names, both values will use the same newer version of TLS,
> +	but for historic reasons have these names. The difference between the
> +	two values for Git is the following. 'ssl' refers to "implicit"
> +	encryption (sometimes called SMTPS), that uses port 465 by default.

And we still haven't said what the option is about at this point,
even though the reader may be able to guess that this is about a
mechanism to specify something about encryption after reading this
much text.

None of what we see in the updated text may be wrong per-se, but the
readers need "what it is about" upfront to be motivated to read it
through.

Perhaps start the description like this?

	Specify how SMTP connection should be entered into encrypted
	mode. The valid values are 'ssl' and 'tls'. Any other value ...

> +	'tls' refers to "explicit" encryption (often known as STARTTLS),
> +	that uses port 25 by default. Other ports might be used by the SMTP
> +	server, which are not the default. Commonly found alternative port for
> +	'tls' and unencrypted is 587. You need to check your provider's
> +	documentation or your server configuration to make sure
> +	for your own case. Default is the value of `sendemail.smtpEncryption`.

I think the updated text is otherwise good, but it would be better
to remove "The difference between ... is the following."  The text
is easier to read without that sentence.

Thanks.
