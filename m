Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0628D1F42D
	for <e@80x24.org>; Wed, 18 Apr 2018 00:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeDRAyP (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 20:54:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50604 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeDRAyP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 20:54:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 258931F404;
        Wed, 18 Apr 2018 00:54:15 +0000 (UTC)
Date:   Wed, 18 Apr 2018 00:54:15 +0000
From:   Eric Wong <e@80x24.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: avoid duplicate In-Reply-To/References
Message-ID: <20180418005415.GA31588@dcvr>
References: <20180417211630.22873-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180417211630.22873-1-stefan@agner.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Agner <stefan@agner.ch> wrote:
> This addresses the issue reported here:
> https://public-inbox.org/git/997160314bbafb3088a401f1c09ccb08@agner.ch/

Thanks for bringing this up.

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1642,10 +1642,15 @@ foreach my $t (@files) {
>  			elsif (/^Content-Transfer-Encoding: (.*)/i) {
>  				$xfer_encoding = $1 if not defined $xfer_encoding;
>  			}
> +			elsif (/^In-Reply-To: (.*)/i) {
> +				$in_reply_to = $1;
> +			}
> +			elsif (/^References: (.*)/i) {
> +				$references = $1;
> +			}

References: can span multiple lines with --thread=deep in format-patch
(technically any header can be, but References: is common)
