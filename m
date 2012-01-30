From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 4/5] gitweb: show active project_filter in project_list page header
Date: Mon, 30 Jan 2012 17:38:30 +0100
Message-ID: <201201301738.31982.jnareb@gmail.com>
References: <20120128165606.GA6770@server.brlink.eu> <20120130095252.GA6183@server.brlink.eu> <20120130114852.GD9267@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Mon Jan 30 17:38:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RruFA-0005x1-2g
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 17:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab2A3QiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 11:38:04 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60973 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab2A3QiD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 11:38:03 -0500
Received: by eaal13 with SMTP id l13so1177307eaa.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 08:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=xEYdPmbmOCw61sMhNYBn9ho+srxlLsSRpXK09hOG3iQ=;
        b=L7rnfMEJHdc1P9lqA6TEKiCwCWi8/CjdzXuaW++z51W+zQeCUQ3+KpiHTPmcThBsS2
         lA5UlMV9B7RKSz8sCjtV08UOo/OPXx5DTIVMQzVe/ck5eYj8Ij/YjIDrWBKW/QIAuMRQ
         90gioN80JN6cKLapBDVH/KZ3SkEG1bDgxBxY8=
Received: by 10.213.3.5 with SMTP id 5mr1704658ebl.91.1327941481400;
        Mon, 30 Jan 2012 08:38:01 -0800 (PST)
Received: from [192.168.1.13] (abwi152.neoplus.adsl.tpnet.pl. [83.8.232.152])
        by mx.google.com with ESMTPS id t11sm47545578eea.10.2012.01.30.08.37.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 08:38:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120130114852.GD9267@server.brlink.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189372>

On Mon, 30 Jan 2012, Bernhard R. Link wrote:

> In a project_list view show breadcrumbs with the currently active
> project_filter (and those of parent directories) in the page header.

O.K. (though I'd prefer written it less concise and more clear).
 
> Signed-off-by: Bernhard R. Link <brlink@debian.org>
> ---
>  gitweb/gitweb.perl |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e022e11..dfc79df 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3836,6 +3836,18 @@ sub print_header_links {
>  	}
>  }
>  
> +sub print_nav_breadcrumbs_path {
> +	my $dirprefix = undef;
> +	while (my $part = shift) {

Hmmm... using agument list directly, without copying it?  Well, all right.

> +		$dirprefix .= "/" if defined $dirprefix;
> +		$dirprefix .= $part;
> +		print $cgi->a({-href => href(project => undef,
> +		                             project_filter => $dirprefix,
> +					     action=>"project_list")},

Minor nitpick: Let's use same whitespace rules for all key-value pairs

  +					     action => "project_list")},


> +			      esc_html($part)) . " / ";
> +	}
> +}
> +
>  sub print_nav_breadcrumbs {
>  	my %opts = @_;
>  
> @@ -3854,6 +3866,8 @@ sub print_nav_breadcrumbs {
>  			print " / $opts{-action_extra}";
>  		}
>  		print "\n";
> +	} elsif (defined $project_filter) {
> +		print_nav_breadcrumbs_path(split '/', $project_filter);
>  	}
>  }

Nice!

-- 
Jakub Narebski
Poland
