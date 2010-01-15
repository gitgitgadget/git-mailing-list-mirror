From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/9] gitweb: Load checking
Date: Fri, 15 Jan 2010 14:30:25 -0800 (PST)
Message-ID: <m33a27dmsk.fsf@localhost.localdomain>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:30:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVugf-0004n9-7K
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214Ab0AOWac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758194Ab0AOWac
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:30:32 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:61053 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab0AOWab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:30:31 -0500
Received: by fxm25 with SMTP id 25so652841fxm.21
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 14:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Y4jeS60Y1ajfKQewTV8gihVog6XjKzm+GOxdgcwKeO4=;
        b=l0DMeEE99VnEdASu5ou7ZhZgfTmslnNHhp9y45cUIoi3J2E7se5PgZRflYdfaYtdrd
         G3UnXsKQiwPQ3zZgxNCe19+RQ9UnH5L/On0Vgjdm9yDeTXLN7VXBr1vAY4clhoIeME7x
         mXrFV27NscgF6NS5nixP7wMJ1crH2dJpKmlvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=X5Sw3xDUHNaXn0QpqdEkuj2FF5/SGxNslEawKmGQDSb8vbnVzCZEREfmZbiFdo5r1n
         gAEKKAgS85X2ndX6KGpJR/SyaRolLoiOL7oxMXBmXMpkirsiTMl02yxKAWuJ9HOoIsV1
         Ov2SPY9KZlSRb13lcrChEZ2ejR1Lw3DlFfxV4=
Received: by 10.223.3.135 with SMTP id 7mr3407936fan.21.1263594628828;
        Fri, 15 Jan 2010 14:30:28 -0800 (PST)
Received: from localhost.localdomain (abwi123.neoplus.adsl.tpnet.pl [83.8.232.123])
        by mx.google.com with ESMTPS id p9sm1134081fkb.44.2010.01.15.14.30.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 14:30:25 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0FMU550030540;
	Fri, 15 Jan 2010 23:30:10 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0FMTm6E030530;
	Fri, 15 Jan 2010 23:29:48 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137143>

This one looks good, but while examining other patch in this series
I have noticed rare situation where we would get Perl error with
this patch.

I have added fix-up for this issue, although I guess that better
solution might be not to add any <script> element for git_footer_html
called from die_error.

I'm sorry I haven't noticed this earlier.


"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> From: John 'Warthog9' Hawley <warthog9@kernel.org>
> 
> This changes slightly the behavior of gitweb, so that it verifies
> that the box isn't inundated with before attempting to serve gitweb.
> If the box is overloaded, it basically returns a 503 Server Unavailable
> until the load falls below the defined threshold.  This helps dramatically
> if you have a box that's I/O bound, reaches a certain load and you
> don't want gitweb, the I/O hog that it is, increasing the pain the
> server is already undergoing.
> 
> This behavior is controlled by $maxload configuration variable.
> Default is a load of 300, which for most cases should never be hit.
> Unset it (set it to undefined value, i.e. undef) to turn off checking.
> 
> Currently it requires that '/proc/loadavg' file exists, otherwise the
> load check is bypassed (load is taken to be 0).  So platforms that do
> not implement '/proc/loadavg' currently cannot use this feature.
> (provisions are included for additional checks to be added by others)
>
While at it check that $action is defined before comparing it in
git_footer_html() subroutine.  Until this patch there were no direct
or indirect (via die_error) invocation of git_footer_html() with
$action undefined; each call was after dispatch, which sets $action to
default value if it is undefined.

This would cause Perl error ("Use of uninitialized value in string eq")
if load is too high _and_ gitweb was invoked without action parameter
explicitly set (e.g. for projects list).
 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/README      |    7 ++++++-
>  gitweb/gitweb.perl |   45 +++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/gitweb/README b/gitweb/README
> index e34ee79..6c2c8e1 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -174,7 +174,7 @@ not include variables usually directly set during build):
>     Base URL for relative URLs in pages generated by gitweb,
>     (e.g. $logo, $favicon, @stylesheets if they are relative URLs),
>     needed and used only for URLs with nonempty PATH_INFO via
> -   <base href="$base_url>.  Usually gitweb sets its value correctly,
> +   <base href="$base_url">.  Usually gitweb sets its value correctly,
>     and there is no need to set this variable, e.g. to $my_uri or "/".
>   * $home_link
>     Target of the home link on top of all pages (the first part of view
> @@ -228,6 +228,11 @@ not include variables usually directly set during build):
>     repositories from launching cross-site scripting (XSS) attacks.  Set this
>     to true if you don't trust the content of your repositories. The default
>     is false.
> + * $maxload
> +   Used to set the maximum load that we will still respond to gitweb queries.
> +   If server load exceed this value then return "503 Service Unavaliable" error.
> +   Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
> +   undefined value to turn it off.  The default is 300.
>  
>  
>  Projects list file format
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7e477af..0a07d3a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -221,6 +221,12 @@ our %avatar_size = (
>  	'double'  => 32
>  );
>  
> +# Used to set the maximum load that we will still respond to gitweb queries.
> +# If server load exceed this value then return "503 server busy" error.
> +# If gitweb cannot determined server load, it is taken to be 0.
> +# Leave it undefined (or set to 'undef') to turn off load checking.
> +our $maxload = 300;
> +
>  # You define site-wide feature defaults here; override them with
>  # $GITWEB_CONFIG as necessary.
>  our %feature = (
> @@ -551,6 +557,32 @@ if (-e $GITWEB_CONFIG) {
>  	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
>  }
>  
> +# Get loadavg of system, to compare against $maxload.
> +# Currently it requires '/proc/loadavg' present to get loadavg;
> +# if it is not present it returns 0, which means no load checking.
> +sub get_loadavg {
> +	if( -e '/proc/loadavg' ){
> +		open my $fd, '<', '/proc/loadavg'
> +			or return 0;
> +		my @load = split(/\s+/, scalar <$fd>);
> +		close $fd;
> +
> +		# The first three columns measure CPU and IO utilization of the last one,
> +		# five, and 10 minute periods.  The fourth column shows the number of
> +		# currently running processes and the total number of processes in the m/n
> +		# format.  The last column displays the last process ID used.
> +		return $load[0] || 0;
> +	}
> +	# additional checks for load average should go here for things that don't export
> +	# /proc/loadavg
> +
> +	return 0;
> +}
> +
> +if (defined $maxload && get_loadavg() > $maxload) {
> +	die_error(503, "The load average on the server is too high");
> +}
> +
>  # version of the core git binary
>  our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
>  $number_of_git_cmds++;
> @@ -3354,14 +3386,19 @@ sub git_footer_html {
>  # 500: The server isn't configured properly, or
>  #      an internal error occurred (e.g. failed assertions caused by bugs), or
>  #      an unknown error occurred (e.g. the git binary died unexpectedly).
> +# 503: The server is currently unavailable (because it is overloaded,
> +#      or down for maintenance).  Generally, this is a temporary state.
>  sub die_error {
>  	my $status = shift || 500;
>  	my $error = shift || "Internal server error";
>  
> -	my %http_responses = (400 => '400 Bad Request',
> -			      403 => '403 Forbidden',
> -			      404 => '404 Not Found',
> -			      500 => '500 Internal Server Error');
> +	my %http_responses = (
> +		400 => '400 Bad Request',
> +		403 => '403 Forbidden',
> +		404 => '404 Not Found',
> +		500 => '500 Internal Server Error',
> +		503 => '503 Service Unavailable',
> +	);
>  	git_header_html($http_responses{$status});
>  	print <<EOF;
>  <div class="page_body">
@@ -3354,7 +3354,8 @@ sub git_footer_html {
 	}
 
 	print qq!<script type="text/javascript" src="$javascript"></script>\n!;
-	if ($action eq 'blame_incremental') {
+	if (defined $action &&
+	    $action eq 'blame_incremental') {
 		print qq!<script type="text/javascript">\n!.
 		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
 		      qq!           "!. href() .qq!");\n!.

> -- 
> 1.6.5.2
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
