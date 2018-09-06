Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478361F404
	for <e@80x24.org>; Thu,  6 Sep 2018 18:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeIFW52 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 18:57:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34417 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIFW52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 18:57:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so12430958wrd.1
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UHGJ7a+lV3G+n3AGIJEDDA9JHo50UZrwPyZZtEixeSA=;
        b=MZBBBjSZoMJTnQKzM3hvS2l2S0ZOCLoUp2u5IvNmq2TCO2eBqdRn3+G2oxnfj3Btf8
         yfnch8JFWRCAxSPnTUZa+86cS2ol6RbLjs6KArJ8wbCPGlx85KgMcywildyj3Dh+TnVA
         W73LABS6fGoZr4K2jz4cnSubZtPVQWE1lZ//23/INEyq1c7/xPcSOuyMiZ+/yHvmXv+8
         hnvMxd4pLxuzhgFOL1V+7uLxJhobTx1Wsaa0L0eBQY6O06Mc5QlWBYqfJnszl1OLBCot
         XSdPfDa/B7OxKVKxrbM4NFm/GeIc1puF1Y1AfHo8DV6l2fpZfLVcbZleBTqAQtUdHc3U
         Y5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UHGJ7a+lV3G+n3AGIJEDDA9JHo50UZrwPyZZtEixeSA=;
        b=b78ubEtrByDZ5S67IxqHRImJrUA8NXhrAjHU+IXc3JaqkUasu+wwuwB1ZS+7a6KsJr
         oCDfFWAPWPeSTtcBgXu36bU3juu4XSAECJDaUdqWXPV70OXmPm0+C6udN6H1kUJmhc+C
         P1EeYXrMXQi53x81037S5xHI9QoWhPcQvM8OP/EFr2ZhydYb4TlnVuCUB4zzcvq5N3ne
         UDQ3/om9MLNYsnUSJVDHzDt8xfk5bDOvIAZJD2l4CLU8ZbW3vizyRVInu780ciKsQhX6
         NknPr0oYDoluutwE7CtwmYmaE3jDECREGwrv31cD4SG8+ZlaeN13xUX/untpv7UmeJNo
         N3zQ==
X-Gm-Message-State: APzg51AoTNuA8U6kqzuzQmAkANuIXAOdpd4T9zGR/4wXRZJrC1CuLkfU
        cb57XDqZs3rQFeGqRCsXtO4=
X-Google-Smtp-Source: ANB0VdZp0FHKZB02LJ07MMuTqokJiOeUfXyqs57C+OvDTMxBtDMQInsCdSQhBN4pIIgUNfkGzFZYTw==
X-Received: by 2002:adf:f687:: with SMTP id v7-v6mr3357747wrp.201.1536258046162;
        Thu, 06 Sep 2018 11:20:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 139-v6sm9388357wmp.4.2018.09.06.11.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 11:20:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/11] submodule.c: do not copy around submodule list
References: <20180904230149.180332-1-sbeller@google.com>
        <20180904230149.180332-9-sbeller@google.com>
Date:   Thu, 06 Sep 2018 11:20:44 -0700
In-Reply-To: <20180904230149.180332-9-sbeller@google.com> (Stefan Beller's
        message of "Tue, 4 Sep 2018 16:01:46 -0700")
Message-ID: <xmqq36um1o8z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> 'calculate_changed_submodule_paths' uses a local list to compute the
> changed submodules, and then produces the result by copying appropriate
> items into the result list.
>
> Instead use the result list directly and prune items afterwards
> using string_list_remove_empty_items.

That may describe what the patch does, but does not explain why we
would even want to do so in the first place.  

It may be a safe thing to do to munge the list in place as there is
nobody that looks at the list after we are done in the current code,
but the above description does not tell that to readers and fails to
give readers warm and fuzzy feeling that the safety likely will stay
with us in the future.

> As a side effect, we'll have access to the util pointer for longer that
> contains the commits that we need to fetch.

If this patch does not move free-submodules-oids call to out: label
(i.e. instead do so after the call to string-list-remove-empty-items
is made, perhaps), then the list of oids will have the same lifespan
as the original code, no?  Then it is not a "side effect" but is
deliberate change of behaviour this patch makes.  We can access the
list for longer time than before, which may be a good thing, in
which case we'd want to explain the potential benefit we could reap
with future changes, no?

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 582c0263b91..0efe6711a8c 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1128,8 +1128,7 @@ static void calculate_changed_submodule_paths(
>  	struct submodule_parallel_fetch *spf)
>  {
>  	struct argv_array argv = ARGV_ARRAY_INIT;
> -	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
> -	const struct string_list_item *name;
> +	struct string_list_item *name;
>  
>  	/* No need to check if there are no submodules configured */
>  	if (!submodule_from_path(the_repository, NULL, NULL))
> @@ -1146,9 +1145,9 @@ static void calculate_changed_submodule_paths(
>  	 * Collect all submodules (whether checked out or not) for which new
>  	 * commits have been recorded upstream in "changed_submodule_names".
>  	 */
> -	collect_changed_submodules(&changed_submodules, &argv);
> +	collect_changed_submodules(&spf->changed_submodule_names, &argv);
>  
> -	for_each_string_list_item(name, &changed_submodules) {
> +	for_each_string_list_item(name, &spf->changed_submodule_names) {
>  		struct oid_array *commits = name->util;
>  		const struct submodule *submodule;
>  		const char *path = NULL;
> @@ -1162,12 +1161,14 @@ static void calculate_changed_submodule_paths(
>  		if (!path)
>  			continue;
>  
> -		if (!submodule_has_commits(path, commits))
> -			string_list_append(&spf->changed_submodule_names,
> -					   name->string);
> +		if (submodule_has_commits(path, commits)) {
> +			oid_array_clear(commits);
> +			*name->string = '\0';
> +		}
>  	}
>  
> -	free_submodules_oids(&changed_submodules);
> +	string_list_remove_empty_items(&spf->changed_submodule_names, 1);
> +
>  	argv_array_clear(&argv);
>  	oid_array_clear(&ref_tips_before_fetch);
>  	oid_array_clear(&ref_tips_after_fetch);
> @@ -1362,7 +1363,7 @@ int fetch_populated_submodules(struct repository *r,
>  
>  	argv_array_clear(&spf.args);
>  out:
> -	string_list_clear(&spf.changed_submodule_names, 1);
> +	free_submodules_oids(&spf.changed_submodule_names);
>  	return spf.result;
>  }
