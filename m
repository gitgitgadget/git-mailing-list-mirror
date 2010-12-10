From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 18/18] gitweb: Add better error handling for gitweb caching
Date: Thu, 09 Dec 2010 17:56:16 -0800 (PST)
Message-ID: <m3mxoez90s.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-19-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 02:56:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQsDg-0001xG-GH
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 02:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab0LJB4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 20:56:19 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:55269 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab0LJB4T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 20:56:19 -0500
Received: by fxm18 with SMTP id 18so3200474fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 17:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=WqLICZVbrbKdz5Tv2mqzG2te+jRO23jHRxEZUOQj9Ns=;
        b=WSKF/CCYhx0A5zvIR9V3Vrv+ueH6UlE7M+ExiH9iAomYm70JzTjafCUKLKctwO1UTF
         079511z9upF1+Oov1miZnnlLh5UgE/VFs5e/uphJtnFmoCpXzkOWq45UHrGJtdmEjefG
         8xv1LnzzpV0EOEEqjqfNmzA8pbTuELjH7HflM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=l9p0UoyNPUfI7bhb2x8bpUk8NMS53dGXAQ4IRsu1d3iKf4mpUA+cuC6EUcKWyZ5liR
         SX0STnn+yd6E8fzFoorMCkTVVpT6iRRDxKZ5CpaICvgZhxLpyq3k1TqVwyg+oyPCzkci
         QCEk8sm4shcEyq0TChCpj9jsR/tUO7S2XQQPE=
Received: by 10.223.78.139 with SMTP id l11mr205980fak.31.1291946177379;
        Thu, 09 Dec 2010 17:56:17 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id n2sm750724fam.28.2010.12.09.17.56.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 17:56:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBA1tl9R021620;
	Fri, 10 Dec 2010 02:55:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBA1tVc6021616;
	Fri, 10 Dec 2010 02:55:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-19-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163381>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> This basically finishes the plumbing for caching the error pages
> as the are generated.
> 
> If an error is hit, create a <hash>.err file with the error.  This
> will interrupt all currently waiting processes and they will display
> the error, without any additional refreshing.
> 
> On a new request a generation will be attempted, should it succed the
> <hash.err> file is removed (if it exists).

Could you split 17 and 18 patches slightly differently, at least not
using variables which were not declared first?
 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

Hmmm... I certainly hope that this complication is not really needed.
I have trouble following code flow (no comments), so I'd try to do
fresh review again tomorrow.

> ---
>  gitweb/gitweb.perl  |    8 ++++++++
>  gitweb/lib/cache.pl |   14 ++++++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d39982a..5a9660a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -41,6 +41,7 @@ our $version = "++GIT_VERSION++";
>  
>  # Output buffer variable
>  our $output = "";
> +our $output_err = "";

It is used by earlier patches, and declared only there.

>  
>  our ($my_url, $my_uri, $base_url, $path_info, $home_link);
>  sub evaluate_uri {
> @@ -303,6 +304,9 @@ our $fullhashpath = *STDOUT;
>  our $fullhashbinpath = *STDOUT;
>  our $fullhashbinpathfinal = *STDOUT;
>  
> +our $cacheErrorCache = 0; # false

$capture_error_output, isn't it?

> +our $cacheErrorCount = 0;

$cached_error_count, or something like that, isn't it?

> +
>  our $full_url;
>  our $urlhash;
>  
> @@ -3786,6 +3790,7 @@ sub die_error {
>  	# Reset the output so that we are actually going to STDOUT as opposed
>  	# to buffering the output.
>  	reset_output() if ($cache_enable && ! $cacheErrorCache);
> +	$cacheErrorCount++ if( $cacheErrorCache );

Where it is decremented?  A comment, if you please.

>  
>  	git_header_html($http_responses{$status}, undef, %opts);
>  	print <<EOF;
> @@ -3801,6 +3806,9 @@ EOF
>  	print "</div>\n";
>  
>  	git_footer_html();
> +
> +	die_error_cache($output) if ( $cacheErrorCache );
> +

That's cache_die_error_output, or something like that, isn't it?

It's hard to review this patch when die_error_cache is defined in
separate (previous) patch.

>  	goto DONE_GITWEB
>  		unless ($opts{'-error_handler'});
>  }
> diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
> index 6cb82c8..2e7ca69 100644
> --- a/gitweb/lib/cache.pl
> +++ b/gitweb/lib/cache.pl
> @@ -240,8 +240,14 @@ sub cacheUpdate {
>  	# Trap all output from the action
>  	change_output();
>  
> +	# Set the error handler so we cache
> +	$cacheErrorCache = 1; # true
> +
>  	$actions{$action}->();
>  
> +	# Reset Error Handler to not cache
> +	$cacheErrorCache = 0; # false
> +
>  	# Reset the outputs as we should be fine now
>  	reset_output();
>  
> @@ -295,6 +301,8 @@ sub cacheUpdate {
>  		close($cacheFileBG);
>  	}
>  
> +	unlink("$fullhashpath.err") if (-e "$fullhashpath.err");
> +
>  	if ( $areForked ){
>  		exit(0);
>  	} else {
> @@ -339,6 +347,9 @@ sub cacheWaitForUpdate {
>  	my $max = 10;
>  	my $lockStat = 0;
>  
> +	# Call cacheDisplayErr - if an error exists it will display and die.  If not it will just return
> +	cacheDisplayErr($action);
> +
>  	if( $backgroundCache ){
>  		if( -e "$fullhashpath" ){
>  			open($cacheFile, '<:utf8', "$fullhashpath");
> @@ -402,6 +413,9 @@ EOF
>  		close($cacheFile);
>  		$x++;
>  		$combinedLockStat = $lockStat;
> +
> +		# Call cacheDisplayErr - if an error exists it will display and die.  If not it will just return
> +		cacheDisplayErr($action);
>  	} while ((! $combinedLockStat) && ($x < $max));
>  	print <<EOF;
>  </body>
> -- 
> 1.7.2.3
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
