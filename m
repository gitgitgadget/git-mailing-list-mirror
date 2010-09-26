From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 03/12] gitweb: separate heads and remotes lists
Date: Sun, 26 Sep 2010 19:39:11 +0200
Message-ID: <201009261939.12107.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 19:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzvCQ-0000xj-Lc
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 19:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946Ab0IZRjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 13:39:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37840 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757197Ab0IZRjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 13:39:36 -0400
Received: by bwz11 with SMTP id 11so2865795bwz.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RmfbfKi2axfcW8yAjiVKczhGoCivI36G+JfJUAE2Rgo=;
        b=ciAHtWeOJX6OcHIy2OcvahLpN19k8jTzPZFx+h9E4UvzrFsaHC8NmaOf4I4lXxDB7r
         +oQm+WTEjFctrgHlRXEaSYcsx16O1ypMVBv6Hru/es6H+pP7+HCvF7UOeuGEaJi2bBsP
         WCN/sUXRTXTs+5YrhU/ighc5APlozKKC6sSFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DHwwhSnGkQo6c0SMJX/O4W+8sN2Mdy0miHRqsh3Ly+FdKqxSmjgiwyG5pc1RuNlE6W
         M2AipR8V6gqUGilyzb/aQtyb8OrxDIrA0UovPNwcKwuMdCBt3VfonUcwOtCAdGzKm7Y8
         TWT0KCG3SRHpjS66LnTSzraOBgCH2jHXVAsIk=
Received: by 10.204.117.136 with SMTP id r8mr4379273bkq.119.1285522760551;
        Sun, 26 Sep 2010 10:39:20 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id x13sm3565398bki.12.2010.09.26.10.39.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 10:39:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157242>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> We specialize the 'heads' action to only display local branches, and
> introduce a 'remotes' action to display the remote branches (only
> available when the remotes_head feature is enabled).
> 
> Mirroring this, we also split the heads list in summary view into
> local and remote lists, each linking to the appropriate action.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Nice (and still uncontroversial) solution.  FWIW

Acked-by: Jakub Narebski <jnareb@gmail.com>

> @@ -5118,7 +5120,8 @@ sub git_summary {
>  	# These get_*_list functions return one more to allow us to see if
>  	# there are more ...
>  	my @taglist  = git_get_tags_list(16);
> -	my @headlist = git_get_heads_list(16);
> +	my @headlist = git_get_heads_list(16, 'heads');
> +	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
>  	my @forklist;
>  	my $check_forks = gitweb_check_feature('forks');
>  
> @@ -5196,6 +5199,13 @@ sub git_summary {
>  		               $cgi->a({-href => href(action=>"heads")}, "..."));
>  	}
>  
> +	if (@remotelist) {
> +		git_print_header_div('remotes');
> +		git_heads_body(\@remotelist, $head, 0, 15,
> +		               $#remotelist <= 15 ? undef :
> +		               $cgi->a({-href => href(action=>"remotes")}, "..."));
> +	}

Nice thing.  This meanst that "remotes" section is displayed *only* if
'remote_heads' feature is enabled and we actually have remote-tracking
branches.

> @@ -5503,13 +5513,29 @@ sub git_heads {
>  	git_print_page_nav('','', $head,undef,$head);
>  	git_print_header_div('summary', $project);
>  
> -	my @headslist = git_get_heads_list();
> +	my @headslist = git_get_heads_list(undef, 'heads');

It's a pity that we can't simply write "git_get_heads_list('heads');",
but I think it would be serious overengineering for a tiny little gain.

>  	if (@headslist) {
>  		git_heads_body(\@headslist, $head);
>  	}
>  	git_footer_html();
>  }
>  
> +sub git_remotes {
> +	gitweb_check_feature('remote_heads')
> +		or die_error(403, "Remote heads view is disabled");
> +
> +	my $head = git_get_head_hash($project);
> +	git_header_html();
> +	git_print_page_nav('','', $head,undef,$head);
> +	git_print_header_div('summary', $project);
> +
> +	my @remotelist = git_get_heads_list(undef, 'remotes');
> +	if (@remotelist) {
> +		git_heads_body(\@remotelist, $head);
> +	}
> +	git_footer_html();
> +}

Hmmmm... what we have there is a bit of code repetition with git_heads
and git_remotes, but I think is unevitable... besides you would be 
extending git_remotes subroutine in subsequent patches.  So it doesn't
matter, I think.

-- 
Jakub Narebski
Poland
