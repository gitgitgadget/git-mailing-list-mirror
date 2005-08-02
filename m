From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Under NO_OPENSSL -lssl should not be used
Date: Wed, 3 Aug 2005 08:43:18 +1000
Message-ID: <2cfc403205080215433786775f@mail.gmail.com>
References: <20050729085819.GL24895@pasky.ji.cz>
	 <20050729155051.GJ21909@pasky.ji.cz>
	 <Pine.LNX.4.58.0507292038160.29650@g5.osdl.org>
	 <7vek9g6g4f.fsf_-_@assigned-by-dhcp.cox.net>
Reply-To: Jon Seymour <jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 00:43:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E05Tr-00009R-CZ
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 00:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVHBWnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 18:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVHBWnU
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 18:43:20 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:607 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261807AbVHBWnT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 18:43:19 -0400
Received: by rproxy.gmail.com with SMTP id i8so1531572rne
        for <git@vger.kernel.org>; Tue, 02 Aug 2005 15:43:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p64XHiFjS+c1KyWBS/bGo5pbqvElDE+RZLRPoKDosWFYqnTOOXA5APTfYuZBxpKh78SqXrvi3xiX9Jo5Qn9rQjKnc6BEmOT+QmuACQdG6+mEy0Vmkk4Bb1fnILJXapfopgGMfKG89pMp5t+g8x1KBgP7ojsXqpu3sKgMFeMX3rU=
Received: by 10.38.181.38 with SMTP id d38mr21389rnf;
        Tue, 02 Aug 2005 15:43:18 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 2 Aug 2005 15:43:18 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek9g6g4f.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

G'day Junio,

> 
> Jon, do we really need bignum to do the flow computation?  From
> a quick glance, it appears to me that the fraction manipulation
> part is quite well isolated.  Do you think adding the support
> for using other bignum implementation be reasonable (assuming
> you do need to use bignum based fraction)?
>

Sorry, only just saw this. An alternative bignum implementation would
be ok, I just used the ssl stuff since it happened to do what I want
and was available. I also have a patch in the pipes that gets around
the need for arbitrary precision fractions completely.

jon.

> ------------
> This is quick and dirty but under NO_OPENSSL we should not
> attempt to link with -lssl (nor -lcrypto).
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> cd /opt/packrat/playpen/public/in-place/git/git.junio/
> jit-diff
> # - pu: Fetch from a packed repository on dumb servers.
> # + (working tree)
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -108,9 +108,11 @@ LIBS += -lz
> 
>  ifndef NO_OPENSSL
>         LIB_OBJS += epoch.o
> +       OPENSSL_LIBSSL=-lssl
>  else
>         CFLAGS += '-DNO_OPENSSL'
>         MOZILLA_SHA1=1
> +       OPENSSL_LIBSSL=
>  endif
>  ifdef MOZILLA_SHA1
>    SHA1_HEADER="mozilla-sha1/sha1.h"
> @@ -148,7 +150,7 @@ git-ssh-pull: rsh.o pull.o
>  git-ssh-push: rsh.o
> 
>  git-http-pull: LIBS += -lcurl
> -git-rev-list: LIBS += -lssl
> +git-rev-list: LIBS += $(OPENSSL_LIBSSL)
> 
>  $(LIB_OBJS): $(LIB_H)
>  $(DIFF_OBJS): diffcore.h
> 
> Compilation finished at Fri Jul 29 21:48:01
> 
> 


-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
