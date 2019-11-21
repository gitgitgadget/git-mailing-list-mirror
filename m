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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A9CC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F68D20731
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM444XUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKUNPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:15:53 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46989 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUNPx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 08:15:53 -0500
Received: by mail-qv1-f67.google.com with SMTP id w11so1338107qvu.13
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 05:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RUJkwez7vNpiRKzaYVWtODiKCPqWcr61ifo7HePBHyw=;
        b=gM444XUKkM5/+PaKNjz3wSvYywGW7cXVlQwibFRL+fhAygKKccW4UBMDMNWsFHKYxr
         QV7v4a+qy2tLdyXQvqrbV+w3eP7CVYjPngi94JXyr/Fhqu1Mo2MP9niHBwWS3EejQi00
         IAvCH7Oy/sSmtuWyADnCAr7l8N6lXbd+UE79Ai4pPSKBrxL8SP0dD5ie5zATmvjhW76H
         bSq6roVMDZi8qr8Z3SwieAIcy3aZqsYGHTckqt/aXq7Ko0gyk0YMl7DxKG5q9wcmcYs4
         k8OOi+iZdxbK/id9Oi3ynJfXv+/KliybRVxzPpaOS65UsL4Q9hbBXlD7/TUmn3oQtmJo
         6xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RUJkwez7vNpiRKzaYVWtODiKCPqWcr61ifo7HePBHyw=;
        b=C39QxZBcVv12qXuAVLTXIhrmM0D59Ifdx7kyREii5iKxoOPHpfYMahCWOgzevwTxB3
         Z7Q9UElZWanUkhEONTNPuoCcmR56DlOL9hXgs2bxyLNxCZXuD3hfEyohEa0pWbKy4NvQ
         yYi9E2I05cQw4CJOKK1KP6UUDHNtZyL4TsYQbNfT5vMrAAtcVZjKLaOwRPVSpAAqAQaQ
         4vcZ5LWFFVx+HPFZRd+nUqXBcjItbLe1cKMgvnN8ldw8MFJfktTnygZH1O7a6w2V6+Vn
         UV0SY0dEciutrP9nSR4PpSwXMjPKuzx8wslKFCUUaVqRZsVzNLSgZsWq/vNpRQgLh0/M
         vHqQ==
X-Gm-Message-State: APjAAAUkN30l9ULLEJEoujdcG3ubyJNcYnEyiNQk4OBe0VZK40QeWtB4
        NTHxFvBRg1dEsskQg3st+dxHEs47New=
X-Google-Smtp-Source: APXvYqzHvBDfuDhS8Ow+OaovV3vZlIxv/axYKhS2rOfMQ2CShjvXT0iGu+zfskqq6oc2z45RqXNx9w==
X-Received: by 2002:a05:6214:11f2:: with SMTP id e18mr1002769qvu.86.1574342151603;
        Thu, 21 Nov 2019 05:15:51 -0800 (PST)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id d13sm1474269qta.67.2019.11.21.05.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 05:15:50 -0800 (PST)
Subject: Re: [PATCH v5 05/17] sparse-checkout: add '--stdin' option to set
 subcommand
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <0e08898dcb42bd38ca3692b49a7e9f5763150c80.1571666186.git.gitgitgadget@gmail.com>
 <20191121112111.GQ23183@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7ad1d044-cb3f-9d9c-22de-a35c6e608c4e@gmail.com>
Date:   Thu, 21 Nov 2019 08:15:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191121112111.GQ23183@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21/2019 6:21 AM, SZEDER Gábor wrote:
> On Mon, Oct 21, 2019 at 01:56:14PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The 'git sparse-checkout set' subcommand takes a list of patterns
>> and places them in the sparse-checkout file. Then, it updates the
>> working directory to match those patterns. For a large list of
>> patterns, the command-line call can get very cumbersome.
>>
>> Add a '--stdin' option to instead read patterns over standard in.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  builtin/sparse-checkout.c          | 35 ++++++++++++++++++++++++++++--
>>  t/t1091-sparse-checkout-builtin.sh | 20 +++++++++++++++++
> 
> No documentation update.
> 
>>  2 files changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>> index 834ee421f0..f2e2bd772d 100644
>> --- a/builtin/sparse-checkout.c
>> +++ b/builtin/sparse-checkout.c
>> @@ -154,6 +154,15 @@ static int write_patterns_and_update(struct pattern_list *pl)
>>  	return update_working_directory();
>>  }
>>  
>> +static char const * const builtin_sparse_checkout_set_usage[] = {
>> +	N_("git sparse-checkout set [--stdin|<patterns>]"),
> 
> In the usage string [...] denotes optional command line parameters.
> However, they are not optional, but either '--stdin' or at least one
> pattern is required:
> 
>   $ git sparse-checkout set
>   error: Sparse checkout leaves no entry on working directory
>   error: Sparse checkout leaves no entry on working directory
>   $ echo $?
>   255
> 
> So this should be (--stdin | <patterns>).
> 
>> +	NULL
>> +};
>> +
>> +static struct sparse_checkout_set_opts {
>> +	int use_stdin;
>> +} set_opts;
>> +
>>  static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>>  {
>>  	static const char *empty_base = "";
>> @@ -161,10 +170,32 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>>  	struct pattern_list pl;
>>  	int result;
>>  	int set_config = 0;
>> +
>> +	static struct option builtin_sparse_checkout_set_options[] = {
>> +		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
>> +			 N_("read patterns from standard in")),
>> +		OPT_END(),
>> +	};
>> +
>>  	memset(&pl, 0, sizeof(pl));
>>  
>> -	for (i = 1; i < argc; i++)
>> -		add_pattern(argv[i], empty_base, 0, &pl, 0);
>> +	argc = parse_options(argc, argv, prefix,
>> +			     builtin_sparse_checkout_set_options,
>> +			     builtin_sparse_checkout_set_usage,
>> +			     PARSE_OPT_KEEP_UNKNOWN);
>> +
>> +	if (set_opts.use_stdin) {
>> +		struct strbuf line = STRBUF_INIT;
>> +
>> +		while (!strbuf_getline(&line, stdin)) {
> 
> This reads patterns separated by a newline character.
> 
> What if someone is doomed with pathnames containing newline
> characters, should we provide a '-z' option for \0-separated patterns?
> 
>   $ touch foo bar $'foo\nbar'
>   $ git add .
>   $ git commit -m 'filename with newline'
>   [master (root-commit) 5cd7369] filename with newline
>    3 files changed, 0 insertions(+), 0 deletions(-)
>    create mode 100644 bar
>    create mode 100644 foo
>    create mode 100644 "foo\nbar"
>   $ git sparse-checkout set foo
>   $ ls
>   foo
>   $ git sparse-checkout set 'foo*'
>   $ ls
>   foo  foo?bar
>   $ git sparse-checkout set $'foo\nbar'
>   $ ls
>   foo?bar
>   # Looks good so far, but...
>   $ cat .git/info/sparse-checkout 
>   foo
>   bar
>   $ git read-tree -um HEAD
>   $ ls
>   bar  foo
>   # Not so good after all.
>   # Let's try to hand-edit the sparse-checkout file.
>   $ echo $'"foo\\nbar"' >.git/info/sparse-checkout 
>   $ git read-tree -um HEAD
>   error: Sparse checkout leaves no entry on working directory
>   $ echo $'foo\\nbar'
>   >.git/info/sparse-checkout 
>   $ git read-tree -um HEAD
>   error: Sparse checkout leaves no entry on working directory
>   $ echo $'foo\\\nbar'
>   >.git/info/sparse-checkout 
>   $ git read-tree -um HEAD
>   $ ls
>   bar
>   # OK, I give up :)
> 
> So, it seems that the sparse-checkout file format doesn't support
> paths/patterns containing a newline character (or if it does, I
> couldn't figure out how), and thus there is no use for a '-z' option.
> 
> However, as shown above a newline in a pattern given as parameter
> eventually leads to undesired behavior, so I think 'git
> sparse-checkout set $'foo\nbar' should error out upfront.

I will add this to the list of things to do as a follow-up. There are
lots of ways users can abuse the command-line right now, especially in
cone mode.

The goal right now is to get the typical usage figured out, then we can
look for atypical cases (such as newlines in filenames, which...who even
does that?).

>> +			size_t len;
>> +			char *buf = strbuf_detach(&line, &len);
> 
> Nit: this 'len' variable is unnecessary, as it's only used as an out
> variable of this strbuf_detach() call, but strbuf_detach() accepts a
> NULL as its second parameter.
> 
>> +			add_pattern(buf, empty_base, 0, &pl, 0);
>> +		}
>> +	} else {
>> +		for (i = 0; i < argc; i++)
>> +			add_pattern(argv[i], empty_base, 0, &pl, 0);
>> +	}
> 
> According to the usage string this subcommand needs either '--stdin'
> or a set of patterns, but not both, which is in line with my
> interpretation of the commit message.  I think this makes sense, and
> it's consistent with the '--stdin' option of other git commands.
> However, the above option parsing and if-else conditions allow both
> '--stdin' and patterns, silently ignoring the patterns, without
> erroring out:
> 
>   $ echo README | git sparse-checkout set --stdin Makefile
>   $ echo $?
>   0
>   $ find . -name README |wc -l
>   51
>   $ find . -name Makefile |wc -l
>   0

I'll add this to the list, too.

Thanks,
-Stolee

