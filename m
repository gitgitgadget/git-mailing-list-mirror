From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3] gitweb: allow extra breadcrumbs to prefix the trail
Date: Thu, 4 Jul 2013 19:42:19 +0200
Message-ID: <CANQwDwf56CQZJ25-Lc9WJYeB4Q7_4LVPx45yq9EQ8c17NsJp4g@mail.gmail.com>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk> <E1UunDD-0004Xd-Vv@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Jul 04 19:42:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UunYL-0002cO-Am
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 19:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752Ab3GDRmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 13:42:40 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:44328 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756593Ab3GDRmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 13:42:40 -0400
Received: by mail-qc0-f177.google.com with SMTP id n1so861804qcx.22
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 10:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GmRZs06Q2SmygB9Tw6KX+FrfsssFzdPdpiiy+fSllfw=;
        b=u3q7P5FiYjT35WbSHyq47/5GxJs9Gbgscg14KA1jJuMiH+KEAMFq2Fty3jY3c5BKWg
         i69ufslzHkZiAbxUgJFIvuseb157YBn/i+tQDSARVn7TR8t9IVH4w4Y5DerKGQWtVscW
         52R+bxp2IW+Ups6etN+NnjYEtFYQFLtPj3nkas5PTWPbBeHIv2XnxK0BsTdEWEb30XWF
         soTGXb//UhOZQ+6qyJV4+rhWxFJreIp++lIfhSVK74bOerGpmOm776zCxh6uvcDkV8Of
         Po6sb9lu3ov+IFcyqtsLcpQnqF9uj6a8TSj3vXA4rgUjgxGsoYIg1R6QW0DfmBL4Pzid
         iY/A==
X-Received: by 10.224.128.132 with SMTP id k4mr7798731qas.58.1372959759460;
 Thu, 04 Jul 2013 10:42:39 -0700 (PDT)
Received: by 10.49.75.169 with HTTP; Thu, 4 Jul 2013 10:42:19 -0700 (PDT)
In-Reply-To: <E1UunDD-0004Xd-Vv@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229602>

On Thu, Jul 4, 2013 at 7:02 PM, Tony Finch <dot@dotat.at> wrote:

> There are often parent pages logically above the gitweb projects
> list, e.g. home pages of the organization and department that host
> the gitweb server. This change allows you to include links to those
> pages in gitweb's breadcrumb trail.
>
> Signed-off-by: Tony Finch <dot@dotat.at>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

For what it is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  Documentation/gitweb.conf.txt | 22 ++++++++++++++++++++--
>  gitweb/gitweb.perl            |  7 ++++++-
>  2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> index ea0526e..305db63 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -336,8 +336,26 @@ $home_link_str::
>         used as the first component of gitweb's "breadcrumb trail":
>         `<home link> / <project> / <action>`.  Can be set at build time using
>         the `GITWEB_HOME_LINK_STR` variable.  By default it is set to "projects",
> -       as this link leads to the list of projects.  Other popular choice it to
> -       set it to the name of site.
> +       as this link leads to the list of projects.  Another popular choice is to
> +       set it to the name of site.  Note that it is treated as raw HTML so it
> +       should not be set from untrusted sources.

I wonder if we should change this... but it is issue unrelated to current
patch, which doesn't make situation worse.

> +
> +@extra_breadcrumbs::

@external_breadcrumbs ???

> +       Additional links to be added to the start of the breadcrumb trail before
> +       the home link, to pages that are logically "above" the gitweb projects
> +       list, such as the organization and department which host the gitweb
> +       server. Each element of the list is a reference to an array, in which
> +       element 0 is the link text (equivalent to `$home_link_str`) and element
> +       1 is the target URL (equivalent to `$home_link`).
> ++
> +For example, the following setting produces a breadcrumb trail like
> +"home / dev / projects / ..." where "projects" is the home link.
> +----------------------------------------------------------------------------
> +    our @extra_breadcrumbs = (
> +      [ 'home' => 'https://www.example.org/' ],
> +      [ 'dev'  => 'https://dev.example.org/' ],
> +    );
> +----------------------------------------------------------------------------
>
>  $logo_url::
>  $logo_label::
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8d69ada..f429f75 100755
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
> @@ -3982,7 +3985,9 @@ sub print_nav_breadcrumbs_path {
>  sub print_nav_breadcrumbs {
>         my %opts = @_;
>
> -       print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
> +       for my $crumb (@extra_breadcrumbs, [ $home_link_str => $home_link ]) {
> +               print $cgi->a({-href => esc_url($crumb->[1])}, $crumb->[0]) . " / ";
> +       }
>         if (defined $project) {
>                 my @dirname = split '/', $project;
>                 my $projectbasename = pop @dirname;
> --
> 1.8.3.1.605.g85318f5
>
