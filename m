Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AFAC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E991216FD
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KpVD2ZaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgEHQNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 12:13:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60739 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHQNz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 12:13:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C3A19D7A77;
        Fri,  8 May 2020 12:13:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gIB5IToJWkfRpq4Qu95qGQtYdX8=; b=KpVD2Z
        aCRonpNiy5m2YEFYnaEzU1aO2P6CTGUW/L7hINajfD5ydJ3wsrEL5qSo1XVUwG+R
        dNz2G6eVExaAbAjEOhiTPRWOXUdFXwU5SEsrfJjIkou3egxNB4R4ze+xpgn+DNHq
        E6XYR1GHVUnbd9AlONzC/Nzkf01gH7lW9cllc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yY79T2i7HV8nSKxECldB6ELMX1E5ZGTF
        KiZDV/gRvhpxGM0qZfBDyO0xXWp8pXr3Wm0eaEP/40GKsBFgGtQL8RFxiBEXUmts
        Yoa8G+SqrJTm32L1HnJgWyf7HvhK51ZGlrmXix6VGwrHUvNFEUikiPg8Nq8pFss1
        DVwr/Kv5z/o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB394D7A76;
        Fri,  8 May 2020 12:13:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 080EAD7A73;
        Fri,  8 May 2020 12:13:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v5] submodule: port subcommand 'set-url' from shell to C
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
        <20200508062136.15257-1-shouryashukla.oo@gmail.com>
        <20200508063022.GA18557@generichostname>
Date:   Fri, 08 May 2020 09:13:50 -0700
In-Reply-To: <20200508063022.GA18557@generichostname> (Denton Liu's message of
        "Fri, 8 May 2020 02:30:22 -0400")
Message-ID: <xmqqlfm2z9oh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E85EA43C-9146-11EA-BEA8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Shourya,
>
> It looks good to me except for one tiny nit:
>
> On Fri, May 08, 2020 at 11:51:36AM +0530, Shourya Shukla wrote:
>> Convert submodule subcommand 'set-url' to a builtin. Port 'set-url' to
>> 'submodule--helper.c' and call the latter via 'git-submodule.sh'.
>> 
>> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
>> ---
>>  builtin/submodule--helper.c | 37 +++++++++++++++++++++++++++++++++++++
>>  git-submodule.sh            | 22 +---------------------
>>  2 files changed, 38 insertions(+), 21 deletions(-)
>> 
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 1a4b391c88..8bc7b4cfa6 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -2246,6 +2246,42 @@ static int module_config(int argc, const char **argv, const char *prefix)
>>  	usage_with_options(git_submodule_helper_usage, module_config_options);
>>  }
>>  
>> +static int module_set_url(int argc, const char **argv, const char *prefix)
>> +{
>> +	int quiet = 0;
>> +	const char *newurl;
>> +	const char *path;
>> +	char* config_name;
>
> The asterisk should be stuck with the name, not the type, similar to how
> you wrote it above.

Right.

>> +
>> +	struct option options[] = {
>> +		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
>> +		OPT_END()
>> +	};
>> +	const char *const usage[] = {
>> +		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
>> +		NULL
>> +	};
>> +
>> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
>> +
>> +	path = argv[0];
>> +	newurl = argv[1];
>> +
>> +	if (argc != 2 || !path || !newurl) {

Checking argc at this point is too late to protect against the
potential out-of-bounds access we have already made to argv[0]
and argv[1].
