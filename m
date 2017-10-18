Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9D2202A2
	for <e@80x24.org>; Wed, 18 Oct 2017 10:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbdJRK6D (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 06:58:03 -0400
Received: from ikke.info ([178.21.113.177]:54960 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbdJRK6C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 06:58:02 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 1449E44039C; Wed, 18 Oct 2017 12:58:01 +0200 (CEST)
Date:   Wed, 18 Oct 2017 12:58:01 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Christian Couder <chriscool@tuxfamily.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/9] perf/run: add '--config' option to the 'run'
 script
Message-ID: <20171018105801.GF19335@alpha.vpn.ikke.info>
References: <CAP8UFD3tG3fOgftFJAB4mKD2N+uAH0aac4RmFmdXZ=ORHmKzQQ@mail.gmail.com>
 <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2017 at 07:55:56PM +0000, Christian Couder wrote:
> It is error prone and tiring to use many long environment
> variables to give parameters to the 'run' script.
> 
> Let's make it easy to store some parameters in a config
> file and to pass them to the run script.
> 
> The GIT_PERF_CONFIG_FILE variable will be set to the
> argument of the '--config' option. This variable is not
> used yet. It will be used in a following commit.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/perf/run | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/t/perf/run b/t/perf/run
> index beb4acc0e428d..1e7c2a59e45dc 100755
> --- a/t/perf/run
> +++ b/t/perf/run
> @@ -2,9 +2,14 @@
>  
>  case "$1" in
>  	--help)
> -		echo "usage: $0 [other_git_tree...] [--] [test_scripts]"
> +		echo "usage: $0 [--config file] [other_git_tree...] [--] [test_scripts]"
>  		exit 0
>  		;;
> +	--config)
> +		shift
> +		GIT_PERF_CONFIG_FILE=$(cd "$(dirname "$1")"; pwd)/$(basename "$1")

Is the idea of this construct to do some kind of normalization?
Otherwise it seems to just result in $1 again.

> +		export GIT_PERF_CONFIG_FILE
> +		shift ;;
>  esac
>  
>  die () {
> 
> --
> https://github.com/git/git/pull/408
