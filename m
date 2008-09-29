From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/6] gitweb: prevent double slashes in PATH_INFO hrefs
Date: Mon, 29 Sep 2008 20:12:08 +0200
Message-ID: <200809292012.09460.jnareb@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com> <1222030663-22540-6-git-send-email-giuseppe.bilotta@gmail.com> <1222030663-22540-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 20:14:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkNGi-00048S-IU
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 20:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607AbYI2SMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 14:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756600AbYI2SMW
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 14:12:22 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:5981 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595AbYI2SMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 14:12:21 -0400
Received: by ey-out-2122.google.com with SMTP id 6so613104eyi.37
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 11:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SqS3P12ljD6Kq7X1npUpwl3u56CTfPtksLjcdTr9Kzo=;
        b=phGRnAU32oBet2JVSm5DtFhprQhmdQw0BnnCcq6CvWlW+YKKJbAK+dxIBKlquZDwI+
         WhJ5qa367LYFHtdd3f6rz+LWUr0QFZyALktwHgh1aPhiBMkaubni3Pp6rGnZV2Jwts4/
         zwcZMw9jZKWP1BfmRrcdhUDlNof7vrXS5coDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qqkms+s66+UDhg+DNlCcGD+5btUOdOA3sAwfherNDUUGMo2gxJcRLKaTtyB0oM6ZJu
         Hc95aRX8j7i1ieStj9nrxM+2r9jJ3egzZNi8sCMJu3wAYCgJfU37QZ24JOYjk2p12I9e
         TKd5RngS9/kKo822ytQsJbIyLgsbA53Yf6vsk=
Received: by 10.86.80.17 with SMTP id d17mr4598704fgb.33.1222711939331;
        Mon, 29 Sep 2008 11:12:19 -0700 (PDT)
Received: from ?192.168.1.11? (abvx193.neoplus.adsl.tpnet.pl [83.8.221.193])
        by mx.google.com with ESMTPS id l19sm1058838fgb.7.2008.09.29.11.12.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 11:12:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222030663-22540-7-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97038>

On Sun, 21 Sep 2008, Giuseppe Bilotta wrote:

> When using PATH_INFO in combination with a rewrite rule that hides the
> cgi script name, links to projects and/or actions without projects might
> be generated with a double slash.
> 

You mean here that base URL ends with '/'?

> Fix by removing the trailing slash (if present) from $href before
> appending PATH_INFO data.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

This is a good change, and worth applying even before the rest of
series (which probably would go through a few rounds of review).
I'm not sure if it applies cleanly, but conceptually it does not
depend on the rest of patches in this series.

> ---
>  gitweb/gitweb.perl |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4a91d07..ebab86b 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -675,6 +675,8 @@ sub href (%) {
>  
>  	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
>  	if ($use_pathinfo) {
> +		$href =~ s,/$,,;
> +
>  		# use PATH_INFO for project name
>  		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
>  		delete $params{'project'};
> -- 
> 1.5.6.5
> 
> 

Should not go wrong...

-- 
Jakub Narebski
Poland
