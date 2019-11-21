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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CD0C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 11:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB062089F
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 11:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNq/jQ1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfKULVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:21:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36620 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKULVR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 06:21:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so3923167wru.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 03:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yragzoGXmVzHgzWvgVcdNbMhCa42TrCLbEPIKwwMZSo=;
        b=SNq/jQ1PJzalJevNXoSpC+USxXnmFiNq0JHXEAT2QmLw9c6p92UDsC0Xaoc6SWD1+o
         ZtK2uinx2picoQUy2ucTMUv0qiw9GZ00IYz3SEW8kZU80isySPLkBwkjEzFWan4IJdJk
         xxDWM2NYenQdtHot6YnCuaq/PDtnx0vUZbgyBhQn2COQzrK2prQozfObNsz1u4lSTWFe
         CJdOvzkAgs+vJ7D3WgPueihpdz31WxgPsgKn4XcngWKmqg8384LMxR36gLB+UeYpFaWR
         +CBlbUoCF725XdfG2y3fd9ZJBKQY8yvQ3DfOcR4LC8ulbIdfqSzWsYcIY538rlBlz8mk
         L5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yragzoGXmVzHgzWvgVcdNbMhCa42TrCLbEPIKwwMZSo=;
        b=tvqGLg38cS6udQGS6ts74LJeydZ+xdzqG5k3E0Ung2gyGou5kyPfmNZVbMT5paV9Vz
         1uuGRPWjKbEwcWZBf+YLb4nIeXOMq4jJJ9L5/JdWrpnWI9A0AjWhyfGDa7d5tj+Zhg2N
         shSXvgJbw9fmlPKEyf4OFmLQz4chJgyW/BSny99lVg+vyUA5mrJC22ij3UDmzuc4n50P
         haRANZJhMGlU3PxkOQ9M0Ln/A3qUsgb5RZAEdvYkhv4KnvK91MYei5JCPtlhSgA/ngKq
         8ujkqfkq5r0PKi45+9/xti31YgEeJYRcoD54nd4XyhIxPX1CiVoOrYvuJiT5naK/yPw9
         N3nA==
X-Gm-Message-State: APjAAAVAkOpnf5dbeZcnaqFmJOSIRTbvZMBFOcH6zX8DAYiw3oZc8jH6
        gtwX6XwpM4vx6H+cdvWLPuY=
X-Google-Smtp-Source: APXvYqykkEzWdW5OZNKBb+P2T2bTogyjDNuvgj/AjkPFHhGdwewao7nfb5qs7qmuZgc55/itSNE2BA==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr9893979wrm.366.1574335274405;
        Thu, 21 Nov 2019 03:21:14 -0800 (PST)
Received: from szeder.dev (x4db6680d.dyn.telefonica.de. [77.182.104.13])
        by smtp.gmail.com with ESMTPSA id p9sm2865733wrs.55.2019.11.21.03.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 03:21:13 -0800 (PST)
Date:   Thu, 21 Nov 2019 12:21:11 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 05/17] sparse-checkout: add '--stdin' option to set
 subcommand
Message-ID: <20191121112111.GQ23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <0e08898dcb42bd38ca3692b49a7e9f5763150c80.1571666186.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e08898dcb42bd38ca3692b49a7e9f5763150c80.1571666186.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 01:56:14PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The 'git sparse-checkout set' subcommand takes a list of patterns
> and places them in the sparse-checkout file. Then, it updates the
> working directory to match those patterns. For a large list of
> patterns, the command-line call can get very cumbersome.
> 
> Add a '--stdin' option to instead read patterns over standard in.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c          | 35 ++++++++++++++++++++++++++++--
>  t/t1091-sparse-checkout-builtin.sh | 20 +++++++++++++++++

No documentation update.

>  2 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 834ee421f0..f2e2bd772d 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -154,6 +154,15 @@ static int write_patterns_and_update(struct pattern_list *pl)
>  	return update_working_directory();
>  }
>  
> +static char const * const builtin_sparse_checkout_set_usage[] = {
> +	N_("git sparse-checkout set [--stdin|<patterns>]"),

In the usage string [...] denotes optional command line parameters.
However, they are not optional, but either '--stdin' or at least one
pattern is required:

  $ git sparse-checkout set
  error: Sparse checkout leaves no entry on working directory
  error: Sparse checkout leaves no entry on working directory
  $ echo $?
  255

So this should be (--stdin | <patterns>).

> +	NULL
> +};
> +
> +static struct sparse_checkout_set_opts {
> +	int use_stdin;
> +} set_opts;
> +
>  static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>  {
>  	static const char *empty_base = "";
> @@ -161,10 +170,32 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>  	struct pattern_list pl;
>  	int result;
>  	int set_config = 0;
> +
> +	static struct option builtin_sparse_checkout_set_options[] = {
> +		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
> +			 N_("read patterns from standard in")),
> +		OPT_END(),
> +	};
> +
>  	memset(&pl, 0, sizeof(pl));
>  
> -	for (i = 1; i < argc; i++)
> -		add_pattern(argv[i], empty_base, 0, &pl, 0);
> +	argc = parse_options(argc, argv, prefix,
> +			     builtin_sparse_checkout_set_options,
> +			     builtin_sparse_checkout_set_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +
> +	if (set_opts.use_stdin) {
> +		struct strbuf line = STRBUF_INIT;
> +
> +		while (!strbuf_getline(&line, stdin)) {

This reads patterns separated by a newline character.

What if someone is doomed with pathnames containing newline
characters, should we provide a '-z' option for \0-separated patterns?

  $ touch foo bar $'foo\nbar'
  $ git add .
  $ git commit -m 'filename with newline'
  [master (root-commit) 5cd7369] filename with newline
   3 files changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 bar
   create mode 100644 foo
   create mode 100644 "foo\nbar"
  $ git sparse-checkout set foo
  $ ls
  foo
  $ git sparse-checkout set 'foo*'
  $ ls
  foo  foo?bar
  $ git sparse-checkout set $'foo\nbar'
  $ ls
  foo?bar
  # Looks good so far, but...
  $ cat .git/info/sparse-checkout 
  foo
  bar
  $ git read-tree -um HEAD
  $ ls
  bar  foo
  # Not so good after all.
  # Let's try to hand-edit the sparse-checkout file.
  $ echo $'"foo\\nbar"' >.git/info/sparse-checkout 
  $ git read-tree -um HEAD
  error: Sparse checkout leaves no entry on working directory
  $ echo $'foo\\nbar'
  >.git/info/sparse-checkout 
  $ git read-tree -um HEAD
  error: Sparse checkout leaves no entry on working directory
  $ echo $'foo\\\nbar'
  >.git/info/sparse-checkout 
  $ git read-tree -um HEAD
  $ ls
  bar
  # OK, I give up :)

So, it seems that the sparse-checkout file format doesn't support
paths/patterns containing a newline character (or if it does, I
couldn't figure out how), and thus there is no use for a '-z' option.

However, as shown above a newline in a pattern given as parameter
eventually leads to undesired behavior, so I think 'git
sparse-checkout set $'foo\nbar' should error out upfront.

> +			size_t len;
> +			char *buf = strbuf_detach(&line, &len);

Nit: this 'len' variable is unnecessary, as it's only used as an out
variable of this strbuf_detach() call, but strbuf_detach() accepts a
NULL as its second parameter.

> +			add_pattern(buf, empty_base, 0, &pl, 0);
> +		}
> +	} else {
> +		for (i = 0; i < argc; i++)
> +			add_pattern(argv[i], empty_base, 0, &pl, 0);
> +	}

According to the usage string this subcommand needs either '--stdin'
or a set of patterns, but not both, which is in line with my
interpretation of the commit message.  I think this makes sense, and
it's consistent with the '--stdin' option of other git commands.
However, the above option parsing and if-else conditions allow both
'--stdin' and patterns, silently ignoring the patterns, without
erroring out:

  $ echo README | git sparse-checkout set --stdin Makefile
  $ echo $?
  0
  $ find . -name README |wc -l
  51
  $ find . -name Makefile |wc -l
  0

>  	if (!core_apply_sparse_checkout) {
>  		sc_set_config(MODE_ALL_PATTERNS);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index bf2dc55bb1..a9ff5eb9ec 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -128,4 +128,24 @@ test_expect_success 'set sparse-checkout using builtin' '
>  	test_cmp expect dir
>  '
>  
> +test_expect_success 'set sparse-checkout using --stdin' '
> +	cat >expect <<-EOF &&
> +		/*
> +		!/*/
> +		/folder1/
> +		/folder2/
> +	EOF
> +	git -C repo sparse-checkout set --stdin <expect &&
> +	git -C repo sparse-checkout list >actual &&
> +	test_cmp expect actual &&
> +	test_cmp expect repo/.git/info/sparse-checkout &&
> +	ls repo >dir  &&
> +	cat >expect <<-EOF &&
> +		a
> +		folder1
> +		folder2
> +	EOF
> +	test_cmp expect dir
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 
