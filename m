From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 07/18] gitweb: Revert back to $cache_enable vs. $caching_enabled
Date: Thu, 09 Dec 2010 15:38:01 -0800 (PST)
Message-ID: <m3y67y1psd.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-8-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 00:38:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQq41-00061z-S3
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 00:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190Ab0LIXiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 18:38:07 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:36146 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756490Ab0LIXiE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 18:38:04 -0500
Received: by fxm18 with SMTP id 18so3097776fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 15:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=6ul7u3xHHiNU6fk+NnOnctp543YHcduYdx9SINtothA=;
        b=bH3aOwje5T0SxYDMymxeCgRlB7tRX/lzE1EREnKpR5rSdtjFBCUjH6ld/3w1rNieZi
         M7VTCFZi5YIX7zeoVHZOjfbhlIy/LaR/L7fW4npLTWC4MSLnOljEIlIrgWJYu6no6TC7
         iqqzyThUouFVq75a9CqlVRpNiR3sjMhifZZi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Owu3drDZcvuyRDplicspl2TGbpR6JMlmMCKl3+qU+xjGVq18kzNNQWQ4Nk2T5c5VzO
         A8GW4LTol9s34bU09K3kGqSnA/+5hAJzphifAy9WLkjMN3LeFj+Bn3ec9P9vSitQngtl
         f85NnbQ3qPyRsA0e36oT+y5/yk4lf0a+6HjSo=
Received: by 10.223.79.72 with SMTP id o8mr59161fak.83.1291937881830;
        Thu, 09 Dec 2010 15:38:01 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id r24sm738038fax.3.2010.12.09.15.38.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 15:38:01 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB9NbYQ6019800;
	Fri, 10 Dec 2010 00:37:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB9NbMZJ019796;
	Fri, 10 Dec 2010 00:37:22 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-8-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163359>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> Simple enough, $cache_enable (along with all caching variables) are
> already in production in multiple places and doing a small semantic
> change without backwards compatibility is pointless breakage.

Formally, there is no backward compatibility with any released code.
Using out-of-tree patches is on one's own risk.

But even discarding that, I'd rather use the same solution as in

  [PATCHv6/RFC 22/24] gitweb: Support legacy options used by kernel.org caching engine
  http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163058
  http://repo.or.cz/w/git/jnareb-git.git/commitdiff/27ec67ad90ecd56ac3d05f6a9ea49b6faabf7d0a

i.e.

  our $cache_enable;

  [...]

  # somewhere just before call to cache_fetch()
  $caching_enabled = !!$cache_enable if defined $cache_enable;

> 
> This reverts back to the previous variable to enable / disable caching

[...]
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -258,7 +258,7 @@ our $maxload = 300;
>  # that the cache directory be periodically completely deleted, and this is safe to perform.
>  # Suggested mechanism
>  # mv $cacheidr $cachedir.flush;mkdir $cachedir;rm -rf $cachedir.flush
> -our $caching_enabled = 0;
> +our $cache_enable = 0;
>  
>  # Used to set the minimum cache timeout for the dynamic caching algorithm.  Basically
>  # if we calculate the cache to be under this number of seconds we set the cache timeout
> @@ -1138,7 +1138,7 @@ sub dispatch {
>  	    !$project) {
>  		die_error(400, "Project needed");
>  	}
> -	if ($caching_enabled && is_cacheable($action)) {
> +	if ($cache_enable && is_cacheable($action)) {
>  		cache_fetch($action);
>  	} else {
>  		$actions{$action}->();

-- 
Jakub Narebski
Poland
ShadeHawk on #git
