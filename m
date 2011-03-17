From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: fix #patchNN anchors when path_info is enabled
Date: Thu, 17 Mar 2011 03:43:12 -0700 (PDT)
Message-ID: <m3hbb258pw.fsf@localhost.localdomain>
References: <3ef1af6874437043a4451bfbcae59b2b@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 11:43:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Afo-0006rq-EC
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 11:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762Ab1CQKnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 06:43:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47468 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab1CQKnO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 06:43:14 -0400
Received: by fxm17 with SMTP id 17so2543228fxm.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=9Pioe//43Oc3eM0j8NTLu8quANjpoXUOJgqT/TdQC5I=;
        b=T02p1ZPQ8yOmEuxLuL/3/PJKF4tMmgcTdMn2uC5lCGk3B2XoXjGBKDhiHLVivuU6T+
         k0pBSGIvqGjySccVqPyfY0gZTarT4lK6YC/CCQM7zYGliAewMlt+I8AbXiUHyXIXbbkI
         ly1czBvO0n3KY1rRkTJBVO6TK94vo/NMeXChk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=vnPTUKi78SBZo2fR3qEneoANRRVEFjRLnRmHfL92gbwfaMJNBbMNeidvnYoYQUiPOk
         UvNpgtGsW6kmTkByEdqrFAHoA00Zg9IpywFwA9BbO/GRuyWvMSxy1K5S4cyn6iTfO1Xj
         i35dtLiusS+u5ZgQFxg+gtG0P9z5w97m98tEY=
Received: by 10.223.55.201 with SMTP id v9mr1273454fag.76.1300358593155;
        Thu, 17 Mar 2011 03:43:13 -0700 (PDT)
Received: from localhost.localdomain (aeho51.neoplus.adsl.tpnet.pl [79.186.196.51])
        by mx.google.com with ESMTPS id n7sm844040fam.11.2011.03.17.03.43.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 03:43:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2HAgfuI008093;
	Thu, 17 Mar 2011 11:42:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2HAgaS5008089;
	Thu, 17 Mar 2011 11:42:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <3ef1af6874437043a4451bfbcae59b2b@localhost>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169232>

Kevin Cernekee <cernekee@gmail.com> writes:

> My configuration is as follows:

Very minor issue: Documentation/SubmittingPatches states the
following:

    - describe changes in imperative mood, e.g. "make xyzzy do frotz"
      instead of "[This patch] makes xyzzy do frotz" or "[I] changed
      xyzzy to do frotz", as if you are giving orders to the codebase
      to change its behaviour.

I think this also means trying to avoid "My configuration..." and "My
solution..." etc. in commit message.  But this is just a side issue,
not worth worrying over in my opinion; perhaps something to think
about in the future.

> $feature{'pathinfo'}{'default'} = [1];

[...]

> The problem is that in this configuration, PATH_INFO is used to set the
> base URL:
> 
> <base href="http://git.example.com/gitweb.cgi">
> 
> This breaks the "patch" anchor links seen on the commitdiff pages,
> because they are computed relative to the base URL:
> 
> http://git.example.com/gitweb.cgi#patch1

I think that the above configuration is enough to trigger bug /
errorneous behavior that you describe, isn't it?  It is better to try
to find minimal way to reproduce a bug when describing it.

I guess that
 
> <Location /gitweb>
>         Options ExecCGI
>         SetHandler cgi-script
> </Location>
> 
> GITWEB_{JS,CSS,LOGO,...} all start with gitweb-static/
> 
> gitweb.cgi renamed to /var/www/html/gitweb
> 
> This gives me simple, easy-to-read URLs that look like:
> 
> http://HOST/gitweb/myproject.git/commitdiff/0faa4a6ef921d8a233f30d66f9a3e1b24e8ec906
 
is not strictly necessary to trigger a bug.

> 
> My solution is to add an "anchor" parameter to href(), so that the full
> path is included in the patchNN links.

This is a very good idea.  Thank you very much for sending this patch,
and contributing to gitweb.

Its implemetation could be though improved a bit; see below.

> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  gitweb/gitweb.perl |   31 +++++++++++++++++++++++++------
>  1 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1b9369d..3b6a90d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1199,6 +1199,7 @@ if (defined caller) {
>  # -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
>  # -replay => 1      - start from a current view (replay with modifications)
>  # -path_info => 0|1 - don't use/use path_info URL (if possible)
> +# -anchor           - add #ANCHOR to end of URL

Shouldn't it be:

  +# -anchor => ANCHOR - add #ANCHOR to end of URL

>  sub href {
>  	my %params = @_;
>  	# default is to use -absolute url() i.e. $my_uri
> @@ -1314,6 +1315,10 @@ sub href {
>  	# final transformation: trailing spaces must be escaped (URI-encoded)
>  	$href =~ s/(\s+)$/CGI::escape($1)/e;
>  
> +	if (defined($params{'anchor'})) {
> +		$href .= "#".esc_param($params{'anchor'});
> +	}
> +
>  	return $href;
>  }

Here you have slight mismatch between description, which uses
'-anchor', and code, which uses 'anchor'.

>  
> @@ -4334,8 +4339,10 @@ sub git_difftree_body {
>  			if ($action eq 'commitdiff') {
>  				# link to patch
>  				$patchno++;
> -				print "<td class=\"link\">" .
> -				      $cgi->a({-href => "#patch$patchno"}, "patch") .
> +				print $cgi->a({-href =>
> +				      href(action=>"commitdiff",
> +				      hash=>$hash, anchor=>"patch$patchno")},
> +				      "patch") .

It would be better (less error prone) and easier to use '-replay'
option to href(), i.e. write

> +				print $cgi->a({-href => href(-replay=>1, -anchor=>"patch$patchno")},
> +				              "patch") .

or even make it so 'href(-anchor=>"ANCHOR")' implies '-replay => 1'.
The href() part of patch would then look something like this:

  @@ -1199,6 +1199,7 @@ if (defined caller) {
   # -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
   # -replay => 1      - start from a current view (replay with modifications)
   # -path_info => 0|1 - don't use/use path_info URL (if possible)
  +# -anchor => ANCHOR - add #ANCHOR to end of URL, implies -replay if used alone
   sub href {
   	my %params = @_;
   	# default is to use -absolute url() i.e. $my_uri
  @@ -1310,6 +1310,7 @@ sub href {
  
  	$params{'project'} = $project unless exists $params{'project'};
  
 -	if ($params{-replay}) {
 +	if ($params{-replay} ||
 +	    ($params{-anchor} && keys %params == 1)) {
  		while (my ($name, $symbol) = each %cgi_param_mapping) {
  			if (!exists $params{$name}) {
  				$params{$name} = $input_params{$name};
  @@ -1314,6 +1315,10 @@ sub href {
   	# final transformation: trailing spaces must be escaped (URI-encoded)
   	$href =~ s/(\s+)$/CGI::escape($1)/e;
   
  +	if (defined($params{'anchor'})) {
  +		$href .= "#".esc_param($params{'anchor'});
  +	}
  +
   	return $href;
   }

Do you want to resend patch with those corrections yourself, or should
I do this?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
