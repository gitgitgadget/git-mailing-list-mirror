From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: new platform & S_IFGITLINK problem
Date: Tue, 4 May 2010 21:29:08 -0500
Message-ID: <20100505022907.GA17743@progeny.tock>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.co.uk>
X-From: git-owner@vger.kernel.org Wed May 05 04:32:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9UPt-00059k-VJ
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 04:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295Ab0EEC2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 22:28:47 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54722 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255Ab0EEC2q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 22:28:46 -0400
Received: by gwj19 with SMTP id 19so1967900gwj.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 19:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nJnmf/hDzni4VRZGJkE2Pa5By8PhqzEPViP9LpXv94I=;
        b=xoqRVKsBbX6bmYYHg/TOKxvIbqEVIpA6zuDHe43XEJMy12t+VNm051uwOOABJXaNdW
         i6HSjLvbSqoRHL6nDFXV5SXLzoqDXy0q9KNhbBBrqNFUvddEq9DHmmwCXapG/BuFgg13
         X7XAT+HjuQS1uoYo5S1eCGdp6OClLE23h1jj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jpVOosVTcKeH7S39bO6P4iAk2JTv0EGOpcMJgseJt1l1zvJkldoY1ZqVA0hBUl6KmV
         amtQpFNx3NPBYalLY9rn9RhdSyljIRwDZJHOqeKihkCqWpMwpyBkmeckPmlJgJy1oTUW
         bZt/Hg+2QXePpI0kmssLmnnTEHU2O+7mBv4UQ=
Received: by 10.150.237.21 with SMTP id k21mr11494213ybh.104.1273026525581;
        Tue, 04 May 2010 19:28:45 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm5775189iwn.12.2010.05.04.19.28.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 19:28:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146365>

Hi,

Alan Hourihane wrote:

> Additionally, attached is a patch that I currently need to apply in
> order to compile git successfully on the FreeMiNT platform (which is
> m68k based).
> 
> Comments appreciated.

While wiser people discuss the hard part, here are some tiny nitpicks. :)

> --- /dev/null	2008-12-07 20:01:52.000000000 +0000
> +++ compat/mint.h	2008-12-23 11:52:10.000000000 +0000
> @@ -0,0 +1,2 @@
> +#define SA_RESTART 0
> +#define ss_family sa_family

Does MiNT restart interrupted system calls by default?  Are most
operations generally not interruptible anyway?

> --- Makefile	2009-01-29 12:12:01.000000000 +0000
> +++ Makefile	2009-01-29 12:13:39.000000000 +0000
> @@ -1618,7 +1613,7 @@
>  
>  git-imap-send$X: imap-send.o $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
> +		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)

NEEDS_CRYPTO_WITH_SSL = YesPlease

[...]
>  git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -		$(LIBS) $(CURL_LIBCURL)
> +		$(LIBS) $(CURL_LIBCURL) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
[...]

CURL_LIBCURL = -lcurl $(OPENSSL_LIBSSL)

Hope that helps,
Jonathan
