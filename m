From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 15/29] ref_transaction_create(): disallow recursive
 pruning
Date: Wed, 27 Apr 2016 16:23:57 -0400
Organization: Twitter
Message-ID: <1461788637.11504.3.camel@twopensource.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	 <615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
	 <xmqq60v2anyo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:24:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avW0I-0000iu-RR
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbcD0UYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:24:01 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34638 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbcD0UYA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:24:00 -0400
Received: by mail-qk0-f178.google.com with SMTP id r184so23773909qkc.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=O8777DEaHHPvkvFPHi/0eQ2u6mYB0bvM1nJMN4vdmgE=;
        b=F2zzPSTNEckdwWvLeN0Ar962m+hGPx9AVxCEd6Mu3NDM6tlFak55YPhOXtjmsRpE2v
         PWY9kTn/ZNnQQBskN8fbKZVKtJruKCqntUIHYM2FtjIGBJ70z2k8sxhhSZVKe8w0A+HZ
         n6MB29FqAeZKLKpdQbE+9svIN2LhJR09hAhfe8aGVt/9srY2KDlCSZE1u9S4iGrjoooy
         DcX6ed785mNOypBLLoIB16i9a0ZJE3M1pCTvXg/yPxmzBjSW4LYW5IYQ1Rk1mdTxNZG2
         1oTjtG9WjYjAoLPYxeB8+1N9j9UodR2pCAA4tWEB4Y2TSuEpI3rCK+KgeDpiZ/2N/yGZ
         D65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=O8777DEaHHPvkvFPHi/0eQ2u6mYB0bvM1nJMN4vdmgE=;
        b=UMJLw+cO9h8fDTAi4rkGee9t7AxOng1MJEg4DiN/bl1WY76DycuR++hi8tC+nIwjZs
         NAZduAFFzduIoH33hwYgdjW68S0wRWcCynMpD9oyaVn2Z+j1HDUEIpw9bGpf+A4AZbeZ
         zSCmI2YZjUgwX6yJTYoyRLPUGEc33t3yJJZVlXrGGCS9ufB4GJoznSj4g6tDzQAIektk
         O6KaJbU3ifyW9/kH5uu5SotkezGQEEumM26Y6iZ3jSoeGgARTfJ/FB8JkakavdrS6Fwz
         Pz1BgrvXMWVc00DPXGhMuc1y/i+CbElvCIiCIKbdYh2lfjfVTSooqxmJJ2DpbgFAed5d
         nbeg==
X-Gm-Message-State: AOPr4FV35O7EVn4CLTcpzO3i6Yi0osCHXISq42/8Cx+EjohbklRzJ8Kz7CRLX2Jj4VE+Rw==
X-Received: by 10.55.76.15 with SMTP id z15mr10669893qka.32.1461788639421;
        Wed, 27 Apr 2016 13:23:59 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e63sm1731512qga.17.2016.04.27.13.23.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:23:58 -0700 (PDT)
In-Reply-To: <xmqq60v2anyo.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292814>

On Wed, 2016-04-27 at 11:47 -0700, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > It is nonsensical (and a little bit dangerous) to use REF_ISPRUNING
> > without REF_NODEREF. Forbid it explicitly. Change the one
> > REF_ISPRUNING
> > caller to pass REF_NODEREF too.
> > 
> > Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> > ---
> > This also makes later patches a bit clearer.
> 
> I wonder if it is more future-proof to solve this by doing
> 
>     -#define REF_ISPRUNING	0x04
>     +#define REF_ISPRUNING	(0x04 | REF_NODEREF)
> 
> instead.  It makes the intention clear that pruning is always about
> the single level (i.e. no-deref).

I think the approach in Michael's patch might be clearer than yours,
since someone reading the code doesn't have to look at the definition
of REF_ISPRUNING to understand what is going on.
