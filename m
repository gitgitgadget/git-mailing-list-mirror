Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD9AC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B72120731
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVWw/F+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfKUNR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:17:57 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44309 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUNR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 08:17:57 -0500
Received: by mail-qt1-f195.google.com with SMTP id o11so3571439qtr.11
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 05:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YmNrzKtZkJqjyedEcLz7awIfSWAjGUIwoW+1ZBxshAA=;
        b=MVWw/F+Q9qiiFsL3UHmLr/Pz4mBWkf5zdUZN3x7jxsWnD9npl4sOiMlkGcZpqgN82Y
         9RJB1P17SZwLa/G1nnLKYAdAJDVPAcpdb6CdS82VZLMk2wOc1giKC+c7qWbjyIU6CDPL
         ylbTQO2qnchA3xaqKmCSpd/qdQE9QrEYR0sm8/hyzNxMeoqaaIzWsVJx793LtEbYOuHA
         6mjZuCqEIH2k3/QmKfoixnzOpcfdTDnIoHlT5gF5NIMiZWUbWv3ppSQHBb+ekBV3jTRl
         ki6yGloEy12rkpLS6MxGhg7HLKRbOwzF3/Gr9jf8DNFC35IF92e3+2gEKHMnLyQfoKc5
         XKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YmNrzKtZkJqjyedEcLz7awIfSWAjGUIwoW+1ZBxshAA=;
        b=gbaeneKLxtRH60YUdHy/gN9jUDsnn+MeGq8op3m6D+DI2db6Ncks6Q25J2jvY4bNw3
         w3jaxCvj0dBuAIr7YpemWVLI+8msdqFBLEqH3uQ9jY5y/wl/1c+MwTnKoEWo68rg9KE9
         kzjE30N8SwS28BApYjGqwj8RvYBYOowr4mdqZfiVUpgB08y9pD5nrjYDXxIkQZuDk5Mq
         bPtoLSCiGO6iEkE+o8jzzwsa3//D2yfxcEhLFFs6z7i5zzEr26lhbIys7eBtWkEgYXEM
         D665hfPgqM17q6gtu1zlpoSGpkCZf+pz3r6P2XcuRD/g8nlSg792M9+LwwAiIXSaa1bA
         QMvw==
X-Gm-Message-State: APjAAAW1KCHgf0Sex2GKPHzKhgKd1i7P1ZZM6TAypR5g4gPqI1HnQR3K
        0UGtsBgfTza/f1g/0EK/Ti4=
X-Google-Smtp-Source: APXvYqxEuwiUeOqnMM/c9fetL4H0Oknd3oQDn2RKqfIIF7ICCks+iM9QBIXKIkFqtcY47jYVNB/h/Q==
X-Received: by 2002:ac8:465a:: with SMTP id f26mr8648510qto.241.1574342274550;
        Thu, 21 Nov 2019 05:17:54 -0800 (PST)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id c23sm1482908qte.66.2019.11.21.05.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 05:17:54 -0800 (PST)
Subject: Re: [PATCH v5 06/17] sparse-checkout: create 'disable' subcommand
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <c48535cd5c00310403ffccac7507f399fca5a8a4.1571666187.git.gitgitgadget@gmail.com>
 <20191119161545.GH23183@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bdad792f-4050-691d-cfc1-f57e83d2b240@gmail.com>
Date:   Thu, 21 Nov 2019 08:17:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191119161545.GH23183@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2019 11:15 AM, SZEDER Gábor wrote:
> On Mon, Oct 21, 2019 at 01:56:15PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The instructions for disabling a sparse-checkout to a full
>> working directory are complicated and non-intuitive. Add a
>> subcommand, 'git sparse-checkout disable', to perform those
>> steps for the user.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  Documentation/git-sparse-checkout.txt | 27 ++++++++++++---------------
>>  builtin/sparse-checkout.c             | 26 +++++++++++++++++++++++++-
>>  t/t1091-sparse-checkout-builtin.sh    | 15 +++++++++++++++
>>  3 files changed, 52 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
>> index b933043b3d..f794d4797a 100644
>> --- a/Documentation/git-sparse-checkout.txt
>> +++ b/Documentation/git-sparse-checkout.txt
>> @@ -48,6 +48,10 @@ To avoid interfering with other worktrees, it first enables the
>>  	working directory to match the new patterns. Enable the
>>  	core.sparseCheckout config setting if it is not already enabled.
>>  
>> +'disable'::
>> +	Remove the sparse-checkout file, set `core.sparseCheckout` to
>> +	`false`, and restore the working directory to include all files.
> 
> I think it would make sense to leave the sparse-checkout file behind
> as-is, and only update the coonfiguration and the working tree.  That
> way users could quickly go back to their last sparse checkout setup by
> simply running 'git sparse-checkout init'.
> 
>   
>> +static int sparse_checkout_disable(int argc, const char **argv)
>> +{
>> +	char *sparse_filename;
>> +	FILE *fp;
>> +
>> +	if (sc_set_config(MODE_ALL_PATTERNS))
>> +		die(_("failed to change config"));
>> +
>> +	sparse_filename = get_sparse_checkout_filename();
>> +	fp = xfopen(sparse_filename, "w");
>> +	fprintf(fp, "/*\n");
>> +	fclose(fp);
>> +
>> +	if (update_working_directory())
>> +		die(_("error while refreshing working directory"));
>> +
>> +	unlink(sparse_filename);
>> +	free(sparse_filename);
>> +
>> +	return sc_set_config(MODE_NO_PATTERNS);
> 
> Hrm.  So disabling the sparse-checkout calls the same helper function
> to write the configuration as initializing or setting, but with a
> different parameter.  However, the error message in that function is:
> 
>   error(_("failed to enable core.sparseCheckout"));
> 
> So if something goes wrong while disabling the sparse-checkout, the
> user might get an error saying "error: failed to enable
> core.sparseCheckout".  That doesn't look quite right, does it?

Both of your comments are valid, but will be easier to implement
later in the series, after "sparse-checkout: update working directory
in-process" which previously did not interact with the "disable"
command. I'll add a new commit that adds that integration point
and should resolve your concerns raised here.

-Stolee
