From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitweb: allow extra breadcrumbs to prefix the trail
Date: Wed, 3 Jul 2013 14:59:30 -0700
Message-ID: <20130703215930.GT408@google.com>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Wed Jul 03 23:59:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuV5Q-0001u4-W4
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 23:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738Ab3GCV7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 17:59:37 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:59864 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab3GCV7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 17:59:36 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so649948pac.40
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EAavzsYO3hQ9X6BJU1vi2BA8h/P0iN1f9Sw6x/Y15Fc=;
        b=ujnkGSbLU3dRG7Y1JQ80eqguSiKQVni7N9Z+KsjNI+v1tnNVUhfln4MoC/ljkUT9YD
         reMklEVyXGt+12XN+MGdMHGgMo9gl1aIQDD2r/SwoGavbvlzDL6hABPjPN//aYsjar7v
         GSqwdAADtmssMI6l9B83eRyMC+Cj3Tui/MyFiFidN+9Q5/kq4I4Md9iYCrunT+jxoDMH
         EmkBrmU+rZRCAJdtgpOKPJ+rU9KHL7XpD9cRHdmKDHUKv/xvczImr5LVXADOJ8CIV++U
         D+WpIHBO6Sij3XjuFgC6ZbRr8IE2s5oQZg6ORg+U2qSUTKE210pqN+ylLSd1xO+ms5JP
         hYDw==
X-Received: by 10.68.135.35 with SMTP id pp3mr2704737pbb.116.1372888775764;
        Wed, 03 Jul 2013 14:59:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id kc8sm45238pbc.18.2013.07.03.14.59.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 14:59:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229538>

(cc-ing Jakub, gitweb wrangler)

Tony Finch wrote:

> There are often parent pages logically above the gitweb projects
> list, e.g. home pages of the organization and department that host
> the gitweb server. This change allows you to include links to those
> pages in gitweb's breadcrumb trail.

Neat.

> Signed-off-by: Tony Finch <dot@dotat.at>
> ---
>  Documentation/gitweb.conf.txt | 8 ++++++++
>  gitweb/gitweb.perl            | 6 ++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> index ea0526e..4579578 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -339,6 +339,14 @@ $home_link_str::
>  	as this link leads to the list of projects.  Other popular choice it to
>  	set it to the name of site.
>  
> +@extra_breadcrumbs::
> +	Additional links to be added to the start of the breadcrumb trail,
> +	that are logically "above" the gitweb projects list. For example,
> +	links to the organization and department which host the gitweb
> +	server. Each element of the list is a reference to an array,
> +	in which element 0 is the link text and element 1 is the
> +	target URL.

Is arbitrary HTML permitted in the link text?

I think it makes sense to permit it for consistency with $home_link_str,
but it might be worth mentioning in the manpage so the administrator
knows not to set it to something user-controlled --- e.g.:

	The link text can contain arbitrary HTML --- to escape link
	text generated programatically, use esc_html($text).

For what it's worth, with or without such a change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

(Patch left unsnipped for reference.)
> +
>  $logo_url::
>  $logo_label::
>  	URI and label (title) for the Git logo link (or your site logo,
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8d69ada..436f17a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -85,6 +85,9 @@ our $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
>  # string of the home link on top of all pages
>  our $home_link_str = "++GITWEB_HOME_LINK_STR++";
>  
> +# extra breadcrumbs preceding the home link
> +our @extra_breadcrumbs = ();
> +
>  # name of your site or organization to appear in page titles
>  # replace this with something more descriptive for clearer bookmarks
>  our $site_name = "++GITWEB_SITENAME++"
> @@ -3982,6 +3985,9 @@ sub print_nav_breadcrumbs_path {
>  sub print_nav_breadcrumbs {
>  	my %opts = @_;
>  
> +	for my $crumb (@extra_breadcrumbs) {
> +		print $cgi->a({-href => esc_url($crumb->[1])}, $crumb->[0]) . " / ";
> +	}
>  	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
>  	if (defined $project) {
>  		my @dirname = split '/', $project;
> -- 
