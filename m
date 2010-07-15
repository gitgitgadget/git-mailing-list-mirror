From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 01/11] gitweb: fix esc_url
Date: Thu, 15 Jul 2010 15:52:21 +0200
Message-ID: <201007151552.23324.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <1279178951-23712-2-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 15:52:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZOrg-00029k-OT
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 15:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933261Ab0GONwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 09:52:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45915 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933234Ab0GONwf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 09:52:35 -0400
Received: by bwz1 with SMTP id 1so583930bwz.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=stMSPi63TohLXZO7X1mGOu6L7H4mCWRuBZZj9ZTaHJY=;
        b=iq7bht4HOQsZjjAG8JAOgVRXFBUXJ0H5GCHuxxOybYR39Y8CcntIMExf5fg0oVQX3O
         yzywq8qk81E03725nc9x5ygnG8mxnJaOA1JIwstcBoCa37210rBx3XyFxoafk48+QNPx
         /mHbBH6wb+6nTBuSzOe0pZ+X5UPUtNUG+0Agc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VixcW9KwC1Dr+KcCLTD350errLXNq8ov4L3nsPKgLWEzkXASinw3m6uVwqV5ljDYE2
         GQAflshzZKhL3SigZkYs5o/zTxy0lktGqdRcgwvOahnc1RaEM4P7ckKgORyxJ7CeIVrs
         Rh9mFYTcJ2o2I3E6vE0+yGDwLxO15tqoBudt0=
Received: by 10.204.19.83 with SMTP id z19mr14725434bka.43.1279201950264;
        Thu, 15 Jul 2010 06:52:30 -0700 (PDT)
Received: from [192.168.1.13] (abwm47.neoplus.adsl.tpnet.pl [83.8.236.47])
        by mx.google.com with ESMTPS id g11sm6047993bkw.10.2010.07.15.06.52.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 06:52:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279178951-23712-2-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151080>

On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:
> The custom CGI escaping done in esc_url failed to escape UTF-8
> properly. Fix by using CGI::escape on each sequence of matched
> characters instead of sprintf()ing a custom escaping for each byte.
> 
> Additionally, the space -> + escape was being escaped due to greedy
> matching on the first substitution. Fix by adding space to the
> list of characters not handled on the first substitution.
> 
> Finally, remove an unnecessary escaping of the + sign.
> 
> commit 452e225 has missed fixing esc_url.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

First, as this patch is independent and unrelated to either splitting
gitweb, or write support, it would be better if this patch was sent
individually to git mailing list, and not only as a part of a large
patch series.  It would likely to be applied, as it is pure bugfix.

Second, I would probably write commit message differently, to emphasize
that it is just finishing work of commit 452e225 (gitweb: fix esc_param,
2009-10-13) by fixing esc_url like it fixed esc_params.  But it is not
something very important.

For what it is worth, ACK from me for this patch.

> ---
>  gitweb/gitweb.perl |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9446376..518328f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1322,8 +1322,7 @@ sub esc_param {
>  sub esc_url {
>  	my $str = shift;
>  	return undef unless defined $str;
> -	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&=])/sprintf("%%%02X", ord($1))/eg;
> -	$str =~ s/\+/%2B/g;
> +	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&= ]+)/CGI::escape($1)/eg;
>  	$str =~ s/ /\+/g;
>  	return $str;
>  }
> -- 
> 1.7.1.455.g8f441
> 
> 

-- 
Jakub Narebski
Poland
