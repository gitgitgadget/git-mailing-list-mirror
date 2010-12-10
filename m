From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 14/18] gitweb: add print_transient_header() function for central header printing
Date: Thu, 09 Dec 2010 16:36:09 -0800 (PST)
Message-ID: <m34oam1n3t.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-15-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:36:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQqyA-0004eD-D3
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757150Ab0LJAgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 19:36:13 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:34347 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756306Ab0LJAgM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 19:36:12 -0500
Received: by bwz16 with SMTP id 16so3404042bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 16:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=GKqney7jp78tHr2c3TEz/drohIhRU3ssvx47VJDtlmM=;
        b=LvFHXq3ZBrP2hU8YZVPglqmtO4FAl+CsYPAZ11k7+DuIdEbCrQpsTrYFh9Tk2jvw8u
         DfP0VH3jwL/Yd81S37laB8FxJ+HNR+/xMUPfkznTdB4fSXsICGGsRVIMXiIBjFfWT9ja
         ssH4L9k1RIiVBR4CO/fM1EYiNNrsR2SVe/qpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=vlQZpZUdNtcyKjpP6u9GsFNcY01nsPvt9X2Z7egtdnYNmrYRNCyyC+GfTiwJCohiu3
         Pcv0ZQ2iQTki+AeqUN7URJn9O5r7GoGaDHiHxomvg6bZCJHviYd0mzM8ORctg/4Atteu
         nQegPgQLdArgOoTDYvXUyJrxIa6XAGH9jUyCw=
Received: by 10.204.73.155 with SMTP id q27mr54724bkj.200.1291941369918;
        Thu, 09 Dec 2010 16:36:09 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id v1sm1255386bkt.17.2010.12.09.16.36.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 16:36:09 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBA0ZY46020560;
	Fri, 10 Dec 2010 01:35:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBA0ZISX020556;
	Fri, 10 Dec 2010 01:35:18 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-15-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163368>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> There are a few things I would like to reuse the transient header
> information I'm using, currently this is only the 'Generating...'
> page, but there is at least one additional warning page I would
> like to use this on.
> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/lib/cache.pl |   47 ++++++++++++++++++++++++++---------------------
>  1 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
> index 63dbe9e..723ae9b 100644
> --- a/gitweb/lib/cache.pl
> +++ b/gitweb/lib/cache.pl
> @@ -94,6 +94,31 @@ sub cache_fetch {
>  	#$actions{$action}->();
>  }
>  
> +sub print_transient_header {
> +	print $::cgi->header(

Why you use $::cgi->header() instead of equivalent $cgi->header()?
Note that $::cgi->header() is $main::cgi->header(), and is not
CGI::header().

> +				-type=>'text/html',
> +				-charset => 'utf-8',
> +				-status=> 200,
> +				-expires => 'now',
> +				# HTTP/1.0
> +				-Pragma => 'no-cache',
> +				# HTTP/1.1
> +				-Cache_Control => join(
> +							', ',
> +							qw(
> +								private
> +								no-cache
> +								no-store
> +								must-revalidate
> +								max-age=0
> +								pre-check=0
> +								post-check=0
> +							)
> +						)
> +				);
> +	return;
> +}

Why not use

	our %no_cache = (
		# HTTP/1.0
		-Pragma => 'no-cache',
		# HTTP/1.1
		-Cache_Control => join(', ', qw(private no-cache no-store must-revalidate
		                                max-age=0 pre-check=0 post-check=0)),
	);

(or something like that).  This way you can reuse it even if content
type is different (e.g. 'text/plain').

But that is just a proposal.

> +
>  sub isBinaryAction {
>  	my ($action) = @_;
>  
> @@ -292,27 +317,7 @@ sub cacheWaitForUpdate {
>  
>  	$| = 1;
>  
> -	print $::cgi->header(
> -				-type=>'text/html',
> -				-charset => 'utf-8',
> -				-status=> 200,
> -				-expires => 'now',
> -				# HTTP/1.0
> -				-Pragma => 'no-cache',
> -				# HTTP/1.1
> -				-Cache_Control => join(
> -							', ',
> -							qw(
> -								private
> -								no-cache
> -								no-store
> -								must-revalidate
> -								max-age=0
> -								pre-check=0
> -								post-check=0
> -							)
> -						)
> -				);
> +	print_transient_header();
>  
>  	print <<EOF;
>  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www/w3.porg/TR/html4/strict.dtd">
> -- 
> 1.7.2.3
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
