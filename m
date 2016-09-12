Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3966120984
	for <e@80x24.org>; Mon, 12 Sep 2016 10:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbcILKix (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 06:38:53 -0400
Received: from ikke.info ([178.21.113.177]:46710 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932235AbcILKix (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 06:38:53 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id EF5454400B9; Mon, 12 Sep 2016 12:38:50 +0200 (CEST)
Date:   Mon, 12 Sep 2016 12:38:50 +0200
From:   Kevin Daudt <me@ikke.info>
To:     KES <kes-kes@yandex.ru>
Cc:     git <git@vger.kernel.org>
Subject: Re: Diff impromements: keep block whole
Message-ID: <20160912103850.GA31326@ikke.info>
References: <1190311473672986@web29o.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1190311473672986@web29o.yandex.ru>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2016 at 12:36:26PM +0300, KES wrote:
> Does it be more meaning full which change was done when diff will be displayed as:
> @@ -1278,6 +1311,16 @@ sub process {
>  		if( ref $result eq 'HASH' ) {
>  			$code =  $result->{ code };
>  			@args =  DB::eval( $result->{ expr } );
>  
>  			redo PROCESS;
> 		}
> +		elsif( ref $result eq 'ARRAY' ) {
> +			$code =  shift @$result;
> +			@args =  ();
> +			for my $expr ( @$result ) {
> +				push @args, [ DB::eval( $expr ) ];
> +			}
> +
> + 			redo PROCESS;
> + 		}
>  
> 
> instead of:
> 
> @@ -1278,6 +1311,16 @@ sub process {
>  		if( ref $result eq 'HASH' ) {
>  			$code =  $result->{ code };
>  			@args =  DB::eval( $result->{ expr } );
> +
> +			redo PROCESS;
> +		}
> +		elsif( ref $result eq 'ARRAY' ) {
> +			$code =  shift @$result;
> +			@args =  ();
> +			for my $expr ( @$result ) {
> +				push @args, [ DB::eval( $expr ) ];
> +			}
> +
>  			redo PROCESS;
>  		}
>  

Yes, it would definately be more meaningfull, but for an algorithm it's
not that clear cut. Michael Hagerty is currently working on a patch
series[1] to give git some heuristics to get better diffs, but is hard
to get right.

You can already enable this by adding --compaction-heuristic to the diff
command, but this can also give odd results in other cases, so it's not
enabled by default.

Kevin.


[1]:https://public-inbox.org/git/cover.1473068229.git.mhagger@alum.mit.edu/
