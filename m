Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD9A1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbcJEQGF (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 12:06:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55776 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754077AbcJEQGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:06:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78DFD4180F;
        Wed,  5 Oct 2016 12:06:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aPi9PFnHyOfGliez6YlcJ8wWYvg=; b=ReLjav
        HYYWz/PEUmogH4VdwVAcK9S78H+O4IGLsffUOSfmU7lxOAp7poFkxLuGYwccaYgo
        ULkONG1rL6Ot7hqpTDVla9Oi3VAqUkR+AJnk/BL0XyTTJs+C+1LY998thnEmMk7z
        UrcStnx/m5bFc3Tg6Zjs07dPTzsbaQivAI0mA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r2P7BQ4LVfocip8RExxnWwIf5mkWbXaL
        woxF0CA8IFyL5dMZ0mXS+QCyZT/WgKAz82NxprA+xo/ds2B1hsOfIb/+XoVejpMU
        dE8VLmLf+BQSm2ChHe9+1PRLBoNH2Q0fcF9K/y+0w4RAx/Dv+KghetcC2urPA1bR
        dLXQnkWEywM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E1DC4180B;
        Wed,  5 Oct 2016 12:06:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CADE4180A;
        Wed,  5 Oct 2016 12:06:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josef Ridky <jridky@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature Request: user defined suffix for temp files created by git-mergetool
References: <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com>
        <1499287628.1324571.1475653631366.JavaMail.zimbra@redhat.com>
Date:   Wed, 05 Oct 2016 09:05:59 -0700
In-Reply-To: <1499287628.1324571.1475653631366.JavaMail.zimbra@redhat.com>
        (Josef Ridky's message of "Wed, 5 Oct 2016 03:47:11 -0400 (EDT)")
Message-ID: <xmqqponerdaw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C5C78EC-8B15-11E6-B22F-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josef Ridky <jridky@redhat.com> writes:

> Hi, 
>
> I have just realize, that my attachment has been cut off from my previous message.
> Below you can find patch with requested change.
>
> Add support for user defined suffix part of name of temporary files
> created by git mergetool
> ---

The first two paragraphs above do not look like they are meant for
the commit log for this change.

Please sign-off your patch.

> -USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
> +USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [--local=name] [--remote=name] [--backup=name] [--base=name] [file to merge] ...'
>  SUBDIRECTORY_OK=Yes
>  NONGIT_OK=Yes
>  OPTIONS_SPEC=
>  TOOL_MODE=merge
> +
> +#optional name space convention
> +local_name=""
> +remote_name=""
> +base_name=""
> +backup_name=""

If you initialize these to LOCAL, REMOTE, etc. instead of empty,
wouldn't it make the remainder of the code a lot simpler?  For
example,

> +	if [ "$local_name" != "" ]  && [ "$local_name" != "$remote_name" ] && [ "$local_name" != "$backup_name" ] && [ "$local_name" != "$base_name" ]
> +	then
> +		LOCAL="$MERGETOOL_TMPDIR/${BASE}_${local_name}_$$$ext"
> +	else
> +		LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
> +	fi

This can just be made an unconditional

	LOCAL="$MERGETOOL_TMPDIR/${BASE}_${local_name}_$$$ext"

without any "if" check in front.  The same for all others.

The conditional you added is doing two unrelated things.  It is
trying to switch between an unset $local_name and default LOCAL,
while it tries to make sure the user did not give the same string
for two different things (which is a nonsense).  It is probably
better to check for nonsense just once just before all these
assuments of LOCAL, REMOTE, etc. begins, not at each point where
they are set like this patch does.
