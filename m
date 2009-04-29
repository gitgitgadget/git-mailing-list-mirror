From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: escape searchtext and parameters for replay
Date: Wed, 29 Apr 2009 14:28:44 +0200
Message-ID: <200904291428.46244.jnareb@gmail.com>
References: <337ECD47-D343-40F2-9E41-9E7D8531C5DF@aepfle.de> <1241005459-17311-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Olaf Hering <olaf@aepfle.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 14:29:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz8uM-0004Fg-1y
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 14:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbZD2M2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 08:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbZD2M2w
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 08:28:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:25550 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbZD2M2w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 08:28:52 -0400
Received: by rv-out-0506.google.com with SMTP id f9so868258rvb.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=y9PDqgCfp6AMPSMB5Yp5DAubrvdOo10IWx0eWlUtAgU=;
        b=MJAahjQhjhjmelYEgSll3/w30qHEGlyItV1MwKNwatlYx9RanR1dH0Pw1SqDwOVjCw
         I64TCAlkSDBHu97sOKCGovhOawktZJI189tDnJmJpbs8BvyqnzKFFbT3yLK/PsPoGnqx
         PxCRV+nux3k63dZP7QRlAbhUwexeOLwYYet0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gRrnh66Rr9eWIzVpDF3pSD501KXXKIAxUQGcpYE6YGqufrjKwEP1KPQBdXdmLg3wKR
         r+KilCSJ6A2YPAvFY0107oe2uF7xJOH15Wf6Xa3wa2H2pacf23cGB/MqRtTTSOOup5HL
         mB4PZn2nIgNDelIFvqk09w98Ee6nYZp7WFbs4=
Received: by 10.141.37.8 with SMTP id p8mr87193rvj.35.1241008131903;
        Wed, 29 Apr 2009 05:28:51 -0700 (PDT)
Received: from ?192.168.1.13? (abwr45.neoplus.adsl.tpnet.pl [83.8.241.45])
        by mx.google.com with ESMTPS id b8sm2170102rvf.14.2009.04.29.05.28.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Apr 2009 05:28:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1241005459-17311-1-git-send-email-git@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117879>

On Wed, 29 April 2009, Michael J Gruber wrote:

> Search texts may very likely include characters like '@' when grepping
> for author names. Currently, gitweb produces first/prev/next links with
> incorrectly escaped characters.
> 
> Make gitweb escape searchtext and parameters which are reused in href()
> when replay is set. (cgi params are de-escaped when put into the
> parameter dictionary and need to be re-escaped when reused.)
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---

> Olaf Hering <olaf@aepfle.de> wrote:
>
>> An 'author' search string like "torvalds@linux" at
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git
>> generates a 'next' link due to the huge number of commits.
>>
>> This link has an incorrect escaping for the @ sign.
>> The backslash does not work, it generates an error:
>>
>> 403 Forbidden - Invalid search parameter
>>
>> It should be s=torvalds%40linux instead of s=torvalds\@linux

If you by hand edit URL changing '\@' to simply '@', does changed
gitweb URL works correctly?

>
> Maybe something like this? Highly untested!

No, the problem is not with lack of URI escaping in 's' parameter
('@' character is not forbidden for query string; it has special
meaning and has to be escaped only in the hostname part), but with
passing value _quoted for Perl_ (quotemeta) to href() subroutine.

I'll try to come with the solution soon.

>  gitweb/gitweb.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3f99361..e1b09f8 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -848,7 +848,7 @@ sub href (%) {
>  	if ($params{-replay}) {
>  		while (my ($name, $symbol) = each %cgi_param_mapping) {
>  			if (!exists $params{$name}) {
> -				$params{$name} = $input_params{$name};
> +				$params{$name} = esc_url($input_params{$name});
>  			}
>  		}
>  	}
> @@ -5775,7 +5775,7 @@ sub git_search {
>  		if ($page > 0) {
>  			$paging_nav .=
>  				$cgi->a({-href => href(action=>"search", hash=>$hash,
> -				                       searchtext=>$searchtext,
> +				                       searchtext=>esc_url($searchtext),
>  				                       searchtype=>$searchtype)},
>  				        "first");
>  			$paging_nav .= " &sdot; " .

This would result in double URI escaping, as at the end of href()
subroutine we have:

	push @result, $symbol . "=" . esc_param($params{$name});

   [...]

   $href .= "?" . join(';', @result) if scalar @result;

   return $href;

Note that gitweb uses esc_param() and not esc_url() here; the rules are
slightly different (you need to quote/escape ';', '?', '=' etc. for
query parameter).

-- 
Jakub Narebski
Poland
