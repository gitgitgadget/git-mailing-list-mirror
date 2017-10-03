Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E927320281
	for <e@80x24.org>; Tue,  3 Oct 2017 00:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdJCAcY (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 20:32:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57059 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751101AbdJCAcX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 20:32:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 676A9A4FD5;
        Mon,  2 Oct 2017 20:32:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aEN0Ji/bzHAJ0FbWb/uhJ6pMmhs=; b=ZX0pId
        l7fkHUL+GH1LTvJ9/2EF+t0Z+KNf4VxbSvPvirdpWtLh1CqtaF7TDNcZsJOnoud+
        bnUz2JqU4SXgTHoBGxH1yN0mwAbCiqok/+iYCV05NJkhWfd4C1YbbGxz0zR4gWMp
        gLGsfFe4adfpTURGjqLQxWiY+k1HyiEkcUc/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vgChkDItEwPdN8iqFWWyBgwZqovhOo0P
        ITaF4lNrHWqjiEjESq8vf3Ion/iSiJfjjySvEMDHG2ZUeNFCib/ytZ4q5mdThJ8e
        8FyqSpyjrSq5bV4Hitoh/hlmaMJmzh2I3PGF6iv5zshngTBEGfwMhb8hECa+F6ft
        f8fmyypqTXc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F749A4FD4;
        Mon,  2 Oct 2017 20:32:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCFCCA4FD3;
        Mon,  2 Oct 2017 20:32:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [PATCH v2] setup: update error message to be more meaningful
References: <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
        <20171002173002.4278-1-kaarticsivaraam@gmail.com>
Date:   Tue, 03 Oct 2017 09:32:21 +0900
In-Reply-To: <20171002173002.4278-1-kaarticsivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 2 Oct 2017 23:00:02 +0530")
Message-ID: <xmqq7ewdm5pm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52949A7A-A7D2-11E7-95C3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Incorrect case,
>
>         $ git grep "some random regex" -n
>         fatal: bad flag '-n' used after filename
>
> The above case is incorrect as "some random regex" isn't a filename
> in this case.

The command line rule is to have dashed options first and then other
arguments, so I agree that "option '-n' used after non-option
argument(s)" would be a better alternative.

"grep" is an oddball, as it allows you to be lazy and omit the "-e"
option when there is only one pattern, making a perfectly reasonable
"grep -e regex -n" into an invalid "grep regex -n".

As an aside, I wonder if we want to _() the message.  It's outside
the scope of this fix, obviously.

>  setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index 860507e1f..09c793282 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -230,7 +230,7 @@ void verify_filename(const char *prefix,
>  		     int diagnose_misspelt_rev)
>  {
>  	if (*arg == '-')
> -		die("bad flag '%s' used after filename", arg);
> +		die("option '%s' must come before non-option arguments", arg);
>  	if (looks_like_pathspec(arg) || check_filename(prefix, arg))
>  		return;
>  	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
