Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790EE1FF76
	for <e@80x24.org>; Mon, 19 Dec 2016 11:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761920AbcLSLHd (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 06:07:33 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:52948 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761849AbcLSLHb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 06:07:31 -0500
X-AuditID: 1207440e-7dfff700000009ec-89-5857bf71413d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 36.95.02540.17FB7585; Mon, 19 Dec 2016 06:07:29 -0500 (EST)
Received: from [192.168.69.190] (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJB7Rne027364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 06:07:28 -0500
Subject: Re: [PATCH 2/5] check-ref-format: Refactor to make --branch code more
 common
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
 <20161104191358.28812-3-ijackson@chiark.greenend.org.uk>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <e93ee78a-aa5e-27f6-9703-6efa385f487b@alum.mit.edu>
Date:   Mon, 19 Dec 2016 12:07:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161104191358.28812-3-ijackson@chiark.greenend.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqFu4PzzCYNVrY4uuK91MFqtbFrE4
        MHl8O7WJ2ePzJrkApigum5TUnMyy1CJ9uwSujAWTz7AXnBOt6OyfyN7AOF+wi5GDQ0LAROL0
        JYcuRi4OIYHLjBKHli1mhnAuMEmsnzKVpYuRk0NYIFxi57qXjCC2iICbxNlPjUwgtpBAvcSF
        9klgcTYBXYlFPc1MIEN5BewlJm0UBAmzCKhK9F+YCDZGVCBE4vKco2wgNq+AoMTJmU/A4pwC
        rhIv58xkBbGZBfQkdlz/BWXLS2x/O4d5AiPfLCQts5CUzUJStoCReRWjXGJOaa5ubmJmTnFq
        sm5xcmJeXmqRrrFebmaJXmpK6SZGSNDx7WBsXy9ziFGAg1GJh7fgfViEEGtiWXFl7iFGSQ4m
        JVHeKWtDIoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8G7bGx4hxJuSWFmVWpQPk5LmYFES51Vb
        ou4nJJCeWJKanZpakFoEk5Xh4FCS4I3ZB9QoWJSanlqRlplTgpBm4uAEGc4DNNwbpIa3uCAx
        tzgzHSJ/ilFRSpzXD2SrAEgiozQPrheWFF4xigO9Isw7FaSdB5hQ4LpfAQ1mAhq8sBtscEki
        QkqqgbF+BedLhTlf0mOfz/v349Fu5lfHLtyru7mMyVV0+l6JiGsz81+++GJq371glUxSeDuD
        7ZRJGzQnhKj4LRMKtvxWvJT1Rrbe3idLPols2s0xJWSq+LYtO2ee1NZTSop8tiv0w//NZo2d
        6Sl7VmUcW6v7ftEBzvuLGmze8SbKtayYu+e/T980IflSJZbijERDLeai4kQAdxbDYeUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04/2016 08:13 PM, Ian Jackson wrote:
> We are going to want to permit other options with --branch.
> 
> So, replace the special case with just an entry for --branch in the
> parser for ordinary options, and check for option compatibility at the
> end.
> 
> No overall functional change.
> 
> Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
> ---
>  builtin/check-ref-format.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
> index 4d56caa..f12c19c 100644
> --- a/builtin/check-ref-format.c
> +++ b/builtin/check-ref-format.c
> @@ -49,13 +49,19 @@ static int check_ref_format_branch(const char *arg)
>  }
>  
>  static int normalize = 0;
> +static int check_branch = 0;
>  static int flags = 0;
>  
>  static int check_one_ref_format(const char *refname)
>  {
> +	int got;

`got` is an unusual name for this variable, and I don't really
understand what the word means in this context. Is there a reason not to
use the more usual `err`?

> +
>  	if (normalize)
>  		refname = collapse_slashes(refname);
> -	if (check_refname_format(refname, flags))
> +	got = check_branch
> +		? check_ref_format_branch(refname)
> +		: check_refname_format(refname, flags);
> +	if (got)
>  		return 1;
>  	if (normalize)
>  		printf("%s\n", refname);
> @@ -68,9 +74,6 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage(builtin_check_ref_format_usage);
>  
> -	if (argc == 3 && !strcmp(argv[1], "--branch"))
> -		return check_ref_format_branch(argv[2]);
> -
>  	for (i = 1; i < argc && argv[i][0] == '-'; i++) {
>  		if (!strcmp(argv[i], "--normalize") || !strcmp(argv[i], "--print"))
>  			normalize = 1;
> @@ -80,9 +83,15 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
>  			flags &= ~REFNAME_ALLOW_ONELEVEL;
>  		else if (!strcmp(argv[i], "--refspec-pattern"))
>  			flags |= REFNAME_REFSPEC_PATTERN;
> +		else if (!strcmp(argv[i], "--branch"))
> +			check_branch = 1;
>  		else
>  			usage(builtin_check_ref_format_usage);
>  	}
> +
> +	if (check_branch && (flags || normalize))

Is there a reason not to allow `--normalize` with `--branch`?
(Currently, `git check-ref-format --branch` *does* allow input like
`refs/heads/foo`.)

But note that simply allowing `--branch --normalize` without changing
`check_one_ref_format()` would mean generating *two* lines of output per
reference, so something else would have to change, too.

> +		usage(builtin_check_ref_format_usage);
> +
>  	if (! (i == argc - 1))
>  		usage(builtin_check_ref_format_usage);
>  
> 

Michael

