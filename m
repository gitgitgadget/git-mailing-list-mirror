Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F08C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C5561626
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEKXKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 19:10:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61775 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhEKXKS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 19:10:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84B6AC4B8F;
        Tue, 11 May 2021 19:09:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IdXjr67NsP2kPfbld+8HuP27/x4tk8dpYh1A+J
        Fz4KU=; b=NreYwf3Kfkfb/7yc77bKs756X9HUEi7OiGBG6vJ733l1cvArgIfMmJ
        8hNnkDQLXkUtor/HGNMuKfIgP/VwsLFPy3jUb9PUlFbbLLsiRr3JjMIIlR2tmYcm
        jblMfp1sjXoowCwhyouUFxgTGu5zRkDyET06hxwuz0yed4kLeHlaE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B202C4B8E;
        Tue, 11 May 2021 19:09:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F172BC4B8D;
        Tue, 11 May 2021 19:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gregory Anders <greg@gpanders.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] git-send-email: use ! to indicate relative path to
 command
References: <YJrZ7Hho6jrVyM7f@coredump.intra.peff.net>
        <20210511204044.69047-1-greg@gpanders.com>
Date:   Wed, 12 May 2021 08:09:10 +0900
In-Reply-To: <20210511204044.69047-1-greg@gpanders.com> (Gregory Anders's
        message of "Tue, 11 May 2021 14:40:44 -0600")
Message-ID: <xmqqk0o4j2ax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E53E33A6-B2AD-11EB-9AE5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders <greg@gpanders.com> writes:

> Presently, the smtpServer config option can use a sendmail-like program

s/Presently, t/T/;  Also if I understand it correctly this is not
just about configuration varible but equally applies to the command
line option --smtp-server, so mention both of them in their full
name, i.e.

    The sendemail.smtpServer configuration variable and the
    "--smtp-server" command line option can name a program to use by
    providing ...

> by providing an absolute path to the program as the value for this
> option. However, an absolute path is not always portable and it is often
> preferable to simply specify a program name and have `git-send-email`
> find that program on $PATH.
>
> For example, if a user wishes to use msmtp to send emails, they might
> be able to simply use
>
>     [sendemail]
>             smtpServer = !msmtp
>
> instead of using the full path. This is particularly useful when a
> common git config file is used across multiple systems where the
> absolute path to a given program may differ.

Nicely explained.

> To that end, this patch allows the smtpServer config option to be
> prefixed with a ! character that implements the above behavior; namely,
> the specified value (sans the ! character) is used as if the user had
> entered it directly on the command line.

	Allow the value of the configuration variable and the
	command line option to be prefixed with a '!' to signal that
	the specified command needs to be looked up on $PATH.

> See also https://lore.kernel.org/git/YJrH8uqzapnpNEsb@gpanders.com/.

You summarised the problem description in that message pretty well
in the proposed log message (which is much better than leaving only
a URL and forcing readers to go there), and I suspect there aren't
much readers can learn from by seeing also the article, though.

> +	} elsif (file_name_is_absolute($smtp_server) || $smtp_server =~ /^!/) {
> +		my $prog = $smtp_server;
> +		$prog =~ s/^!//;
> +
>  		my $pid = open my $sm, '|-';
>  		defined $pid or die $!;
>  		if (!$pid) {
> -			exec($smtp_server, @sendmail_parameters) or die $!;
> +			exec($prog, @sendmail_parameters) or die $!;
>  		}

Looking good.

Thanks.
