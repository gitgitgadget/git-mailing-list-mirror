From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 10/18] gitweb: Adding isBinaryAction() and isFeedAction() to determine the action type
Date: Thu, 09 Dec 2010 16:06:53 -0800 (PST)
Message-ID: <m3lj3y1ogb.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-11-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:07:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQqVu-0001Eo-Tn
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546Ab0LJAG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 19:06:57 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:53730 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757538Ab0LJAG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 19:06:56 -0500
Received: by bwz16 with SMTP id 16so3376146bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 16:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=2V85qeKQ43QphG3/AcHfiqfslTlWYmA6savdkkQ/VMs=;
        b=J5RYbZQWueZR8/bzvrfjzaRjwxurrBU/Feo8yeDxcdVt6APUmbwkCrZrV94NVtoyun
         vWhQ0apOvpMIf8uKJBXfkO1J7mN7p6gnuoWYqR+dXIKDfxxuGjH6I/zOLUI1TCufVDbD
         xWzvfCWdPPFNJvVXzxgwunE29aFZGmvGk06Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=SXekJBecGAWMx5kQQqA0niG3ihwr8qsvTpmd/QD3//qowIjyWrwqBGu9Xuz3gaRfB4
         GXdoB0k6weMGOKBJGwyaxZEyybTec9Xf7YZ9pZJl6tiUhSJtU3bpunMvpPJ/aKUp5hAA
         U6tcnXVwtFzFuYCUf9hVCDdpU351HYNl/iSrc=
Received: by 10.204.63.2 with SMTP id z2mr102686bkh.66.1291939614684;
        Thu, 09 Dec 2010 16:06:54 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id v1sm1248830bkt.5.2010.12.09.16.06.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 16:06:53 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBA06Up9020171;
	Fri, 10 Dec 2010 01:06:36 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBA06Du6020167;
	Fri, 10 Dec 2010 01:06:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-11-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163362>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> This is fairly self explanitory, these are here just to centralize the checking
> for these types of actions, as special things need to be done with regards to
> them inside the caching engine.
> 
> isBinaryAction() returns true if the action deals with creating binary files
> (this needing :raw output)

Why do you need special case binary / :raw output?  It is not really
necessary if it is done in right way, as shown in my rewrite.

> isFeedAction() returns true if the action deals with a news feed of some sort,
> basically used to bypass the 'Generating...' message should it be a news reader
> as those will explode badly on that page.

Why blacklisting 'feed', instead of whitelisting HTML-output?


BTW., please don't use mixedCase names, but underline_separated.

> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/lib/cache.pl |   69 ++++++++++++++++++++++++++-------------------------
>  1 files changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
> index a8ee99e..d55b572 100644
> --- a/gitweb/lib/cache.pl
> +++ b/gitweb/lib/cache.pl
> @@ -88,6 +88,34 @@ sub cache_fetch {
>  	#$actions{$action}->();
>  }
>  
> +sub isBinaryAction {
> +	my ($action) = @_;
> +
> +	if(
> +		$action eq "snapshot"
> +		||
> +		$action eq "blob_plain"
> +	){
> +		return 1;	# True
> +	}
> +
> +	return 0;		# False
> +}
> +
> +sub isFeedAction {
> +	if(
> +		$action eq "atom"
> +		||
> +		$action eq "rss"
> +		||
> +		$action eq "opml"
> +	){
> +		return 1;	# True
> +	}
> +
> +	return 0;		# False
> +}

Compare to:

+our %actions_info = ();
+sub evaluate_actions_info {
+       our %actions_info;
+       our (%actions);
+
+       # unless explicitely stated otherwise, default output format is html
+       foreach my $action (keys %actions) {
+               $actions_info{$action}{'output_format'} = 'html';
+       }
+       # list all exceptions; undef means variable (no definite format)
+       map { $actions_info{$_}{'output_format'} = 'text' }
+               qw(commitdiff_plain patch patches project_index blame_data);
+       map { $actions_info{$_}{'output_format'} = 'xml' }
+               qw(rss atom opml); # there are different types (document formats) of XML
+       map { $actions_info{$_}{'output_format'} = undef }
+               qw(blob_plain object);
+       $actions_info{'snapshot'}{'output_format'} = 'binary';
+}

Instead of 'xml' you can use 'feed'.

Then e.g.:

+sub action_outputs_html {
+       my $action = shift;
+       return $actions_info{$action}{'output_format'} eq 'html';
+}


See 
  "gitweb: Introduce %actions_info, gathering information about actions"
  "gitweb: Show appropriate "Generating..." page when regenerating cache"
  http://repo.or.cz/w/git/jnareb-git.git/shortlog/refs/heads/origin..refs/heads/gitweb/cache-kernel-v6

-- 
Jakub Narebski
Poland
ShadeHawk on #git
