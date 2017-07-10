Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C08620357
	for <e@80x24.org>; Mon, 10 Jul 2017 15:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbdGJPNn (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 11:13:43 -0400
Received: from avasout06.plus.net ([212.159.14.18]:57491 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbdGJPNm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 11:13:42 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id j3Df1v00618PUFB013Dgcz; Mon, 10 Jul 2017 16:13:41 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=sb0zPjwrPAVbVh1yPTYA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/4] hook: add signature using "interpret-trailers"
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        gitster@pobox.com
Cc:     git@vger.kernel.org
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
 <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
 <20170710141744.8541-3-kaarticsivaraam91196@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2e957be5-980b-1d7b-812f-bf18d12313d6@ramsayjones.plus.com>
Date:   Mon, 10 Jul 2017 16:13:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170710141744.8541-3-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/07/17 15:17, Kaartic Sivaraam wrote:
> The sample hook to prepare the commit message before
> a commit allows users to opt-in to add the signature
> to the commit message. The signature is added at a place
> that isn't consistent with the "-s" option of "git commit".
> Further, it could go out of view in certain cases.
> 
> Add the signature in a way similar to "-s" option of
> "git commit" using git's interpret-trailers command.
> 
> It works well in all cases except when the user invokes
> "git commit" without any arguments. In that case manually
> add a new line after the first line to ensure it's consistent
> with the output of "-s" option.
> 

Again, s/signature/sign-off/g, or similar (including subject line).

ATB,
Ramsay Jones


> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  templates/hooks--prepare-commit-msg.sample | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
> index 708f0e92c..a15d6d634 100755
> --- a/templates/hooks--prepare-commit-msg.sample
> +++ b/templates/hooks--prepare-commit-msg.sample
> @@ -32,4 +32,8 @@ SHA1=$3
>  # esac
>  
>  # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
> -# grep -qs "^$SOB" "$COMMIT_MSG_FILE" || echo "$SOB" >> "$COMMIT_MSG_FILE"
> +# git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
> +# if test -z "$COMMIT_SOURCE"
> +# then
> +#   @PERL_PATH@ -i.bak -pe 'print "\n" if($first_line++ == 0)' "$COMMIT_MSG_FILE"
> +# fi
> 
