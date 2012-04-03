From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Option to omit column with time of the last change
Date: Wed, 4 Apr 2012 01:12:01 +0200
Message-ID: <201204040112.02269.jnareb@gmail.com>
References: <20120403132735.GA12389@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:12:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCtW-0001Lc-3B
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 01:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958Ab2DCXMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 19:12:05 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58228 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab2DCXMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 19:12:03 -0400
Received: by wibhq7 with SMTP id hq7so195124wib.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 16:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=4nPqsFlMlc5S85pPsy8TmYotvNXM1q0icbIPdgOjNrY=;
        b=xJ6NfHYmetyNF1zozEqwRhm67Qp/wQnYRcKYtQ8+RU6iJp4Idqq3Nmj7g/FQlhbBIk
         7PVo2X80LO1JnMREDkq5UsoM27flJ2FGRxqaeDMdqBUdABJmG5qblFbK9EpmKSNIAgEe
         HPmwacO0aVILKd4SxzT/Aa8EfzF8H9e2WtNYmxw9tFsFiXmhR+mHC5znMQeranKj38x4
         Rkx9wBYirLw0Pxy1LzAyPVNHDlTSH4oNV7D4M8VPuqBhV4K3vjfayiyrRA/uUK4kAqMv
         vYemRTDSJakJk4YZWQ8wlUfZeHnVVKE0KwnboiAU6Y52/RMtP2VLQX/jb0hMlqfG7cLT
         3xqQ==
Received: by 10.180.104.137 with SMTP id ge9mr41010501wib.20.1333494721834;
        Tue, 03 Apr 2012 16:12:01 -0700 (PDT)
Received: from [192.168.1.13] (epp57.neoplus.adsl.tpnet.pl. [83.20.57.57])
        by mx.google.com with ESMTPS id n15sm46658030wiw.6.2012.04.03.16.12.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 16:12:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120403132735.GA12389@camk.edu.pl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194671>

On Tue, 3 Apr 2012, Kacper Kornet wrote:

> Generating information about last change for a large number of git
> repositories can be time consuming. This commit adds an option to
> omit 'Last Change' column when presenting the list of repositories.
>
This is quite a good idea, I think.

Even a better solution would be to add caching support to gitweb, but
first it is a long way from being ready, and second not in all cases
you are able to / wants to have a cache.
 
> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> ---
>  Documentation/gitweb.conf.txt |    3 +++
>  gitweb/gitweb.perl            |   16 +++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> index 7aba497..bfeef21 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -403,6 +403,9 @@ $default_projects_order::
>  	i.e. path to repository relative to `$projectroot`), "descr"
>  	(project description), "owner", and "age" (by date of most current
>  	commit).
> +
> +$no_list_age::
> +	Omit column with date of the most curren commit

s/curren/current/

Thanks for adding documentation, though I would prefer if you expanded
this description (for example including the information that it touches
projects list page).

>  +

This '+' here means "continuation".  You by accident inserted
description of new $no_list_age in the middle of description for
$default_projects_order variable...

>  Default value is "project".  Unknown value means unsorted.

...as you can see here.

>  
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a8b5fad..f42468c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -133,6 +133,9 @@ our $default_projects_order = "project";
>  # (only effective if this variable evaluates to true)
>  our $export_ok = "++GITWEB_EXPORT_OK++";
>  
> +# don't generate age column
> +our $no_list_age = 0;

"age" column where?

Hmmm... can't we come with a better name than $no_list_age?

> +
>  # show repository only if this subroutine returns true
>  # when given the path to the project, for example:
>  #    sub { return -e "$_[0]/git-daemon-export-ok"; }
> @@ -5462,9 +5465,11 @@ sub git_project_list_rows {
>  		                        : esc_html($pr->{'descr'})) .
>  		      "</td>\n" .
>  		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
> -		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
> -		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
> -		      "<td class=\"link\">" .
> +		unless ($no_list_age) {
> +		        print "<td class=\"". age_class($pr->{'age'}) . "\">" .
> +		            (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n";
> +		}
> +		print"<td class=\"link\">" .

O.K.  I guess that it ismore readable than

  +		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
  +		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
  +		      "<td class=\"link\">"
  +			unless ($no_list_age);

>  		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
>  		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
>  		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
> @@ -5495,7 +5500,8 @@ sub git_project_list_body {
>  	                                 'tagfilter'  => $tagfilter)
>  		if ($tagfilter || $search_regexp);
>  	# fill the rest
> -	@projects = fill_project_list_info(\@projects);
> +	my @all_fields = $no_list_age ? ('descr', 'descr_long', 'owner', 'ctags', 'category') : ();
> +	@projects = fill_project_list_info(\@projects, @all_fields);

That looks quite strange on first glance.  I know that empty list means
filling all fields, but the casual reader migh wonder about this
conditional expression.

Perhaps it would be better to write it this way:

  -	@projects = fill_project_list_info(\@projects);
  +	my @fields = qw(descr descr_long owner ctags category);
  +	push @fields, 'age' unless ($no_list_age);
  +	@projects = fill_project_list_info(\@projects, @fields);

or something like that.

Well, at least until we come up with a better way to specify "all fields
except those specified".

>  
>  	$order ||= $default_projects_order;
>  	$from = 0 unless defined $from;
> @@ -5527,7 +5533,7 @@ sub git_project_list_body {
>  		print_sort_th('project', $order, 'Project');
>  		print_sort_th('descr', $order, 'Description');
>  		print_sort_th('owner', $order, 'Owner');
> -		print_sort_th('age', $order, 'Last Change');
> +		print_sort_th('age', $order, 'Last Change') unless $no_list_age;

  +		print_sort_th('age', $order, 'Last Change')
  +			unless $no_list_age;

might be more readable.

>  		print "<th></th>\n" . # for links
>  		      "</tr>\n";
>  	}
> -- 
> 1.7.10.rc3
> 

-- 
Jakub Narebski
Poland
