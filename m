From: Vietor Liu <vietor@vxwo.org>
Subject: Re: [PATCH] imap-send.c: fix pointer to be const
Date: Thu, 29 Oct 2009 08:13:12 +0800
Message-ID: <1256775193.2040.6.camel@localhost.localdomain>
References: <1256706591-2763-1-git-send-email-vietor@vxwo.org>
	 <7vk4ygxce6.fsf@alter.siamese.dyndns.org>
	 <1256713526.3333.0.camel@localhost.localdomain>
	 <4AE8482F.7020807@drmicha.warpmail.net>
	 <7vhbtjo10s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 01:10:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Iat-0003qj-By
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951AbZJ2AKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755441AbZJ2AKG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:10:06 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:35200 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbZJ2AKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:10:04 -0400
Received: by ewy4 with SMTP id 4so1325796ewy.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 17:10:09 -0700 (PDT)
Received: by 10.210.7.16 with SMTP id 16mr1850960ebg.14.1256775008852;
        Wed, 28 Oct 2009 17:10:08 -0700 (PDT)
Received: from ?192.168.254.103? ([123.113.74.202])
        by mx.google.com with ESMTPS id 7sm4181899eyg.41.2009.10.28.17.10.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 17:10:07 -0700 (PDT)
In-Reply-To: <7vhbtjo10s.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.0 (2.28.0-2.fc12) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131541>

On Wed, 2009-10-28 at 10:56 -0700, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > Since this is only about warnings, maybe git 1.7.0 is the right time
> > frame to adjust this to the upcoming standard?
> 
> This does not look like "one group wants this way, but the others want
> differently.  We have to pick one and sacrifice the other because it is
> impossible to have it both ways"; there is no excuse to bring up 1.7.0 for
> something like this.
> 
> Doesn't inclusing "ssl.h" give us some indication whether "const" is
> needed to allow us to use #if/#else/#endif in order to compile with
> headers from either versions?  I.e. something like...
> 
> diff --git a/imap-send.c b/imap-send.c
> index 3847fd1..a199db8 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -273,7 +273,11 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
>  	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
>  	return -1;
>  #else
> +#if (OPENSSL_VERSION_NUMBER >= 0x1000000fL)
> +	const SSL_METHOD *meth;
> +#else
>  	SSL_METHOD *meth;
> +#endif
>  	SSL_CTX *ctx;
>  	int ret;
>  

It's better than my patch, thanks.
