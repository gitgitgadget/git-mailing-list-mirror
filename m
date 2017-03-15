Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56361202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 19:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbdCOTVk (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 15:21:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64122 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751884AbdCOTVj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 15:21:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACE2A78B32;
        Wed, 15 Mar 2017 15:21:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1bR6EH4M0tS9++oqddzh0p/HuNw=; b=mgekNZ
        AltGMLppgPlzwa+kzqm5gGDacoMWUbX5kXqZEoVphkkEu8n8CYG0orxssiqSlnfe
        bV9thC5AMLUd0yvRhGolXGIIxfatcObYV5/5j+Y4T4glG/0pP6Gir+ZPol3FsVLI
        Fqx7rSlyTJBqxC5SaOJU4dSo7Ux/jbOs2Vrmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VMq9ILu7dbfFrQmbMIl/9yfeMRHfH/wj
        7kyRMMzQHSOxPibDUdZ/TQxtVMt1F3u+M0zApc2oWLWYvv56ZCEQdfjceKRGI97j
        9EEY17oIx0ilVA9pq33VBaPMOHkYotHkTiZpaB9aC0PJ49yuT+QHFaCf+rhj5X0K
        Q2x5GI9VqDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A600078B31;
        Wed, 15 Mar 2017 15:21:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 178CD78B30;
        Wed, 15 Mar 2017 15:21:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] describe: debug is incompatible with contains
References: <cover.1489581340.git.git@drmicha.warpmail.net>
        <d8477234d20fe3b4db43b23cc192c18af1ecdaff.1489581340.git.git@drmicha.warpmail.net>
Date:   Wed, 15 Mar 2017 12:21:35 -0700
In-Reply-To: <d8477234d20fe3b4db43b23cc192c18af1ecdaff.1489581340.git.git@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Wed, 15 Mar 2017 14:15:08 +0100")
Message-ID: <xmqqzigme474.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BD1BFF4-09B4-11E7-8242-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> `git describe --contains` calls into `git name-rev` which does not have
> any searching to do and thus does not display any debug information.
>
> Say so in the documentation and catch the incompatible arguments.

I am not sure if this is worth it.  Those who are really doing the
debugging would be staring at the code while running it anyway, so
it is not like this new error condition would help anybody from
wasting time scratching her head before viewing the source and
realize that the underlying name-rev does not honor the option.

If "--debug" is truly valuable, "name-rev" can gain "--debug" later
and then we can pass it down if we want.

Also, it is not like "--debug" is incompatible.  It is just the
"--contains" codepath is overly silent and does not give any useful
information when run in the debug mode.  "incompatible" is more like
"would not work correctly when both are given", which is not the
case here.

>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-describe.txt | 2 +-
>  builtin/describe.c             | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index 8755f3af7b..0f9adb6e9a 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -69,7 +69,7 @@ OPTIONS
>  --debug::
>  	Verbosely display information about the searching strategy
>  	being employed to standard error.  The tag name will still
> -	be printed to standard out.
> +	be printed to standard out. This is incompatible with --contains.
>  
>  --long::
>  	Always output the long format (the tag, the number of commits
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 76c18059bf..01a6d159a0 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -462,6 +462,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  
>  	if (longformat && abbrev == 0)
>  		die(_("--long is incompatible with --abbrev=0"));
> +	if (contains && debug)
> +		die(_("--debug is incompatible with --contains"));
>  
>  	if (contains) {
>  		struct string_list_item *item;
