From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Thu, 6 Nov 2008 00:26:58 +0100
Message-ID: <200811060026.59340.jnareb@gmail.com>
References: <200811031943.30033.angavrilov@gmail.com> <200811032357.38893.jnareb@gmail.com> <200811060136.23806.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 00:28:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxrnU-0001as-Vy
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 00:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbYKEX1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 18:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754775AbYKEX1F
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 18:27:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:25003 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603AbYKEX1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 18:27:03 -0500
Received: by nf-out-0910.google.com with SMTP id d3so163962nfc.21
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 15:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ooSI+LXEqafsQTnVOnyNdLi0GvNYkr/Tkcuof4K/If0=;
        b=UC4OmkqMe3vIn/8N37k1h9STGD6hb2yLiFDoIva+AR3erWC8Y25uOXPD66hXyxQwiu
         ZWhm88vUyMveREGyRMpriJLKbIIGyItaWsu3dDHaYiTds5xduex3kTPbWkrQr8NEaIsa
         MLly0nNq8AQWuRfrwhcMoHOYdVIH9qZNI6G/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IrCtaag0txBU+tDyHRmvW1+c7UUolIpvRfNzxVVTqZUpX9Shv10wej8l4xk6cB9pvy
         Ws/rR77orwrZjLbbWo3FADGo26xZdkIXJ9NCAwW2ET6R9QFFvC0vKWieMftd8j6pp+IT
         lJWBBf4l8cm//suUhKDWUpi8UBNnBnotwkF8Y=
Received: by 10.210.58.17 with SMTP id g17mr1669874eba.63.1225927621347;
        Wed, 05 Nov 2008 15:27:01 -0800 (PST)
Received: from ?192.168.1.11? (abwq47.neoplus.adsl.tpnet.pl [83.8.240.47])
        by mx.google.com with ESMTPS id 7sm641031eyg.0.2008.11.05.15.26.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 15:27:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811060136.23806.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100201>

Alexander Gavrilov wrote:
 
> How about the following patch, that simply adds a hook, and provides
> an example using mod_perl in the documentation?

Very nice, simple yet powerfull solution.
 
> --- >8 ---
> Subject: [PATCH] gitweb: Add a per-repository authorization hook.
> 
> Add a configuration variable that can be used to specify an
> arbitrary subroutine that will be called in the same situations
> where $export_ok is checked, and its return value used
> to decide whether the repository is to be shown.
> 
> This allows the user to implement custom authentication
> schemes, for example by issuing a subrequest through mod_perl
> and checking if Apache will authorize it.
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>

If somebody could check out example given for this feature, I'd add
Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/INSTALL     |   21 +++++++++++++++++++++
>  gitweb/gitweb.perl |    8 +++++++-
>  2 files changed, 28 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/INSTALL b/gitweb/INSTALL
> index 26967e2..fa5917a 100644
> --- a/gitweb/INSTALL
> +++ b/gitweb/INSTALL
> @@ -166,6 +166,27 @@ Gitweb repositories
>    shows repositories only if this file exists in its object database
>    (if directory has the magic file named $export_ok).
>  
> +- Finally, it is possible to specify an arbitrary perl subroutine that
> +  will be called for each project to determine if it can be exported.
> +  The subroutine receives an absolute path to the project as its only
> +  parameter.
> +
> +  For example, if you use mod_perl to run the script, and have dumb
> +  http protocol authentication configured for your repositories, you
> +  can use the following hook to allow access only if the user is
> +  authorized to read the files:
> +
> +    $export_auth_hook = sub {
> +        use Apache2::SubRequest ();
> +        use Apache2::Const -compile => qw(HTTP_OK);
> +        my $path = "$_[0]/HEAD";
> +        my $r    = Apache2::RequestUtil->request;
> +        my $sub  = $r->lookup_file($path);
> +        return $sub->filename eq $path 
> +            && $sub->status == Apache2::Const::HTTP_OK;
> +    };

Can anybody check this? Or was it checked by author?

> +
> +
>  Generating projects list using gitweb
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 172ea6b..9329880 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -95,6 +95,11 @@ our $default_projects_order = "project";
>  # (only effective if this variable evaluates to true)
>  our $export_ok = "++GITWEB_EXPORT_OK++";
>  
> +# show repository only if this subroutine returns true
> +# when given the path to the project, for example:
> +#    sub { return -e "$_[0]/git-daemon-export-ok"; }
> +our $export_auth_hook = undef;
> +

Simple, yet powerfull. Nice short example.

>  # only allow viewing of repositories also shown on the overview page
>  our $strict_export = "++GITWEB_STRICT_EXPORT++";
>  
> @@ -400,7 +405,8 @@ sub check_head_link {
>  sub check_export_ok {
>  	my ($dir) = @_;
>  	return (check_head_link($dir) &&
> -		(!$export_ok || -e "$dir/$export_ok"));
> +		(!$export_ok || -e "$dir/$export_ok") &&
> +		(!$export_auth_hook || $export_auth_hook->($dir)));

Nice.

>  }
>  
>  # process alternate names for backward compatibility
> -- 
> tg: (0d4f9de..) t/authenticate/hook (depends on: t/authenticate/unify-exportok)
> 

P.S. Why doesn't TopGit add git and TopGit version to signature?

-- 
Jakub Narebski
Poland
