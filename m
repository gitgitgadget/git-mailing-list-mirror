Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9EB31F609
	for <e@80x24.org>; Tue, 28 May 2019 01:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfE1Bb3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 21:31:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44518 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfE1Bb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 21:31:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 62B6E1F462;
        Tue, 28 May 2019 01:31:28 +0000 (UTC)
Date:   Tue, 28 May 2019 01:31:28 +0000
From:   Eric Wong <e@80x24.org>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Chris Mayo <aklhfex@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] send-email: remove documented requirement for
 Net::SMTP::SSL
Message-ID: <20190528013128.ynvvci4ul2exiyef@dcvr>
References: <20190526172242.13000-1-aklhfex@gmail.com>
 <20190527193517.GA22013@dcvr>
 <20190528000544.GX3654@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190528000544.GX3654@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> wrote:
> I wonder if it's (separately from this change) worth
> adjusting the conditional which sets $use_net_smtp_ssl to
> use "Net::SMTP->can('starttls')" rather than a strict
> version check?  (It might not be if using 'can' is too
> fragile or would only benefit the Red Hat 7 packages which
> likely won't officially be updated to a newer git with such
> a change.)
> 
> Something like:
> 
> diff --git i/git-send-email.perl w/git-send-email.perl
> index 24859a7bc3..84ac03994d 100755
> --- i/git-send-email.perl
> +++ w/git-send-email.perl
> @@ -1465,7 +1465,7 @@ sub send_message {
>  		}
>  
>  		require Net::SMTP;
> -		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("2.34");
> +		my $use_net_smtp_ssl = Net::SMTP->can('starttls') ? 0 : 1;
>  		$smtp_domain ||= maildomain();
>  
>  		if ($smtp_encryption eq 'ssl') {

Looks much better to me.
