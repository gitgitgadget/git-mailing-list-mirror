Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68618C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377FC613B6
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244094AbhDWVMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:12:09 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:8649 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244111AbhDWVLc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:11:32 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1la34e-00017z-B4; Fri, 23 Apr 2021 22:10:52 +0100
Subject: Re: [PATCH] [GSOC] pretty: provide human date format
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.939.git.1619195245606.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c6b43262-7ce4-b32e-3ff4-9edb66f2a20b@iee.email>
Date:   Fri, 23 Apr 2021 22:10:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <pull.939.git.1619195245606.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/2021 17:27, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
>
> Add the placeholders %ah and %ch to format author date and committer
> date, like --date=human does, which provides more humanity date output.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] pretty: provide human date format
>     
>     Reasons for making this patch: --date=human has no corresponding
>     --pretty option.
>     
>     Although --date=human with --pretty="%(a|c)d" can achieve the same
>     effect with --pretty="%(a|c)h", but it can be noticed that most time
>     formats implement the corresponding option of --pretty, such as
>     --date=iso8601 can be replaced by --pretty=%(a|c)i, so add
>     "--pretty=%(a|c)h" seems to be a very reasonable thing.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-939%2Fadlternative%2Fpretty_human-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-939/adlternative/pretty_human-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/939
>
>  Documentation/pretty-formats.txt | 2 ++
>  pretty.c                         | 3 +++
>  t/t4205-log-pretty-formats.sh    | 6 ++++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 45133066e412..9cdcdb8bb414 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -190,6 +190,7 @@ The placeholders are:
>  '%ai':: author date, ISO 8601-like format
>  '%aI':: author date, strict ISO 8601 format
>  '%as':: author date, short format (`YYYY-MM-DD`)
> +'%ah':: author date, human style

An example may be useful. There's no other mention of human date style
in the pretty-formats doc. Or a link to the definitive man page.

>  '%cn':: committer name
>  '%cN':: committer name (respecting .mailmap, see
>  	linkgit:git-shortlog[1] or linkgit:git-blame[1])
> @@ -206,6 +207,7 @@ The placeholders are:
>  '%ci':: committer date, ISO 8601-like format
>  '%cI':: committer date, strict ISO 8601 format
>  '%cs':: committer date, short format (`YYYY-MM-DD`)
> +'%ch':: committer date, human style
Likewise, an `(e.g. ????)` to unconfuse readers.
>  '%d':: ref names, like the --decorate option of linkgit:git-log[1]
>  '%D':: ref names without the " (", ")" wrapping.
>  '%(describe[:options])':: human-readable name, like
> diff --git a/pretty.c b/pretty.c
> index e5b33ba034bd..b1ecd039cef2 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -745,6 +745,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
>  	case 'I':	/* date, ISO 8601 strict */
>  		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
>  		return placeholder_len;
> +	case 'h':	/* date, human */
> +		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(HUMAN)));
> +		return placeholder_len;
>  	case 's':
>  		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
>  		return placeholder_len;
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index cabdf7d57a00..d4d75b0b350e 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -539,6 +539,12 @@ test_expect_success 'short date' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'human date' '
> +	git log --format=%ad%n%cd --date=human >expected &&
> +	git log --format=%ah%n%ch >actual &&
> +	test_cmp expected actual
> +'
> +
>  # get new digests (with no abbreviations)
>  test_expect_success 'set up log decoration tests' '
>  	head1=$(git rev-parse --verify HEAD~0) &&
>
> base-commit: b0c09ab8796fb736efa432b8e817334f3e5ee75a
--
Philip
