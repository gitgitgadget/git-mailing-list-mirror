From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 11/18] gitweb: add isDumbClient() check
Date: Thu, 09 Dec 2010 16:12:33 -0800 (PST)
Message-ID: <m3hbem1o7a.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-12-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:12:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQqbO-0003fT-V5
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572Ab0LJAMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 19:12:40 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:55868 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab0LJAMj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 19:12:39 -0500
Received: by fxm18 with SMTP id 18so3125344fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 16:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=fCcJycOg1lQ5axKpKiybxRpFR9vt09zYLRuqw70G/LA=;
        b=PgnF1N49rnqNFg0xBWXV7whQglvA1M5LcMajZzG4iqTtCiRqEJYF3/Xs0ZH/ECTOMN
         JMB7hYht2Kxd7AzLcpasCR9DzkIylKqS56pKDT+7zRkWUwRJWn61Nj5iku30zx2DWStU
         WfbwpTyi/5FQaxzvt1TZ3D2c6N6oIargKvQb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=sF210KK6+iTevlbhVl3ku+xz2YZC4WBTYLu/YF0VwOJJAwetbSP5+RyOEpfG+PrQ6x
         aas5oONishI4xEyh/BSGg3V+oyXTWVTcoP3wfoE2QcvmTvMqB3SiNYXBPgjDSUyYCq2z
         5VLoMEeQdgLkJW5VaGAjDPx+rKxBQUf+E421o=
Received: by 10.223.81.67 with SMTP id w3mr81653fak.110.1291939957839;
        Thu, 09 Dec 2010 16:12:37 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id n7sm729442fam.35.2010.12.09.16.12.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 16:12:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBA0Bto9020248;
	Fri, 10 Dec 2010 01:12:06 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBA0BcIe020243;
	Fri, 10 Dec 2010 01:11:39 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-12-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163364>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> Basic check for the claimed Agent string, if it matches a known
> blacklist (wget and curl currently) don't display the 'Generating...'
> page.
> 
> Jakub has mentioned a couple of other possible ways to handle
> this, so if a better way comes along this should be used as a
> wrapper to any better way we can find to deal with this.
> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/lib/cache.pl |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
> index d55b572..5182a94 100644
> --- a/gitweb/lib/cache.pl
> +++ b/gitweb/lib/cache.pl
> @@ -116,6 +116,34 @@ sub isFeedAction {
>  	return 0;		# False
>  }
>  
> +# There have been a number of requests that things like "dumb" clients, I.E. wget
> +# lynx, links, etc (things that just download, but don't parse the html) actually
> +# work without getting the wonkiness that is the "Generating..." page.
> +#
> +# There's only one good way to deal with this, and that's to read the browser User
> +# Agent string and do matching based on that.  This has a whole slew of error cases
> +# and mess, but there's no other way to determine if the "Generating..." page
> +# will break things.
> +#
> +# This assumes the client is not dumb, thus the default behavior is to return
> +# "false" (0) (and eventually the "Generating..." page).  If it is a dumb client
> +# return "true" (1)
> +sub isDumbClient {

Please don't use mixedCase, but underline_separated words,
e.g. browser_is_robot(), or client_is_dumb().

> +	my($user_agent) = $ENV{'HTTP_USER_AGENT'};

What if $ENV{'HTTP_USER_AGENT'} is unset / undef, e.g. because we are
runing gitweb as a script... which includes running gitweb tests?

> +	
> +	if(
> +		# wget case
> +		$user_agent =~ /^Wget/i
> +		||
> +		# curl should be excluded I think, probably better safe than sorry
> +		$user_agent =~ /^curl/i
> +	  ){
> +		return 1;	# True
> +	}
> +
> +	return 0;
> +}

Compare (note: handcrafted solution is to whitelist, not blacklist):

+sub browser_is_robot {
+       return 1 if !exists $ENV{'HTTP_USER_AGENT'}; # gitweb run as script
+       if (eval { require HTTP::BrowserDetect; }) {
+               my $browser = HTTP::BrowserDetect->new();
+               return $browser->robot();
+       }
+       # fallback on detecting known web browsers
+       return 0 if ($ENV{'HTTP_USER_AGENT'} =~ /\b(?:Mozilla|Opera|Safari|IE)\b/);
+       # be conservative; if not sure, assume non-interactive
+       return 1;
+}

from

  "[PATCHv6 17/24] gitweb: Show appropriate "Generating..." page when regenerating cache"
  http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163040
  http://repo.or.cz/w/git/jnareb-git.git/commitdiff/48679f7985ccda16dc54fda97790841bab4a0ba2

-- 
Jakub Narebski
Poland
ShadeHawk on #git
