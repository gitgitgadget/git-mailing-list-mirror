Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459F01F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 12:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932776AbeGFM0H (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 08:26:07 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:42842 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753611AbeGFM0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 08:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1530880169; bh=diuKWJKi2pE3Ay55n82dwziDKsG/crMUkgglx0lIbF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WcyevlXgF+2vty1rXPuTMPyxnIIJRdS5aHDJ39laA5Mm3gaVWZ5mQsylAut7S3qsh
         A6poOjR+pGOiTFupt1/HA7A4eLZc/LkhFDp0Nx7x82m3biVgo2m9iFvFG/RAhgbVR8
         NhzAjGRY6BXcS3hSfp8OmPBylhf0NhJY4Sp6HPB4=
Date:   Fri, 6 Jul 2018 08:26:04 -0400
From:   Drew DeVault <sir@cmpwn.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] send-email: accept long lines with suitable transfer
 encoding
Message-ID: <20180706122604.GA9255@homura.localdomain>
References: <20180706022357.739657-1-sandals@crustytoothpaste.net>
 <20180706022357.739657-3-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706022357.739657-3-sandals@crustytoothpaste.net>
X-GNU:  Terry Pratchett
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-07-06  2:23 AM, brian m. carlson wrote:
> diff --git a/git-send-email.perl b/git-send-email.perl
> index a76953c310..4ea30c4070 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1899,6 +1899,10 @@ sub validate_patch {
>  		return $hook_error if $hook_error;
>  	}
>  
> +	# Any long lines will be automatically fixed if we use a suitable transfer
> +	# encoding.
> +	return if $xfer_encoding =~ /^(?:auto|quoted-printable|base64)$/;

Rather than returning in this case I'd sooner wrap the length check in
this test. If additional checks are added in the future it'd be too easy
to accidentally skip them if the transfer encoding is quoted-printable.
