From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 1/2] gitweb: add project_filter to limit project list to a subdirectory
Date: Sun, 29 Jan 2012 17:41:57 +0100
Message-ID: <201201291741.58532.jnareb@gmail.com>
References: <20120128165606.GA6770@server.brlink.eu> <201201291354.50241.jnareb@gmail.com> <20120129160615.GA13937@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Sun Jan 29 17:41:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrXop-00019r-PE
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 17:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082Ab2A2Ql1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 11:41:27 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38247 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab2A2Ql0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 11:41:26 -0500
Received: by eaal13 with SMTP id l13so843608eaa.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=az/VDsg9pOCNVxvgre0FFDxlczkS7w//ELs5zX+zIsA=;
        b=CZwv0jvSMeA5HINMFLx4YvaXaVnHthQx6P3UTve3n4/LLlYsa4lrUJG8LK5AGvPpVH
         z5KjfcRqkGuyC3aubrPJQ7UxmBbgavrfSNkFA9GGN9HOz9rOJSqMBb+Sa9wdJ7q8M/0O
         bUy7BeBfAGvxHDFKMDzN0BN3C1y3tv/wzkFUw=
Received: by 10.213.110.15 with SMTP id l15mr2361567ebp.62.1327855285201;
        Sun, 29 Jan 2012 08:41:25 -0800 (PST)
Received: from [192.168.1.13] (abwg78.neoplus.adsl.tpnet.pl. [83.8.230.78])
        by mx.google.com with ESMTPS id n56sm60534936eeh.6.2012.01.29.08.41.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 08:41:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120129160615.GA13937@server.brlink.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189294>

On Sun, 29 Jan 2012, Bernhard R. Link wrote:

> This commit changes the project listing views (project_list,
> project_index and opml) to limit the output to only projects in a
> subdirectory if the new optional parameter ?pf=directory name is used.
> 
> The change is quite minimal as git_get_projects_list already can limit
> itself to a subdirectory (though that was previously only used for
> 'forks').
> 
> If there is a GITWEB_LIST file, the contents are just filtered like
> with the forks action.
> 
> Without a GITWEB_LIST file only the given subdirectory is searched
> for projects (like with forks) unless GITWEB_STRICT_EXPORT is enabled.
> In the later case GITWEB_PROJECTROOT is traversed normally (unlike
> with forks) and projects not in the directory ignored.
> (As there is no check if the filter_path would have been found in
> the usual search as the project path is checked with forks).

I am still unsure if it is really necessary, but nevermind...
 
> Reusing $project instead of adding a new parameter would have been
> nicer from a UI point-of-view (including PATH_INFO support) but
> would complicate the $project validating code that is currently being
> used to ensure nothing is exported that should not be viewable.
> 
> Signed-off-by: Bernhard R. Link <brlink@debian.org>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
[...]
> @@ -3823,6 +3836,18 @@ sub print_header_links {
>  	}
>  }
>  
> +sub print_nav_breadcrumbs_path {
> +	my $dirprefix = undef;
> +	while (my $part = shift) {
> +		$dirprefix .= "/" if defined $dirprefix;
> +		$dirprefix .= $part;
> +		print $cgi->a({-href => href(project => undef,
> +		                             project_filter => $dirprefix,
> +					     action=>"project_list")},
> +			      esc_html($part)) . " / ";
> +	}
> +}
> +
>  sub print_nav_breadcrumbs {
>  	my %opts = @_;
>  
> @@ -3841,6 +3866,8 @@ sub print_nav_breadcrumbs {
>  			print " / $opts{-action_extra}";
>  		}
>  		print "\n";
> +	} elsif (defined $project_filter) {
> +		print_nav_breadcrumbs_path(split '/', $project_filter);
>  	}
>  }
>  

This could have been split into a separate 2/3 commit, but nevermind;
it can be squashed here.

-- 
Jakub Narebski
Poland
