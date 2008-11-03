From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Mon, 3 Nov 2008 23:57:38 +0100
Message-ID: <200811032357.38893.jnareb@gmail.com>
References: <200811031943.30033.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 23:59:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx8O2-0006fU-9N
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 23:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbYKCW5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 17:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbYKCW5w
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 17:57:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:2255 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbYKCW5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 17:57:51 -0500
Received: by ug-out-1314.google.com with SMTP id 39so64634ugf.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 14:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lGm+/cwfrVrLsPUUyCz4hvoRKvOyWinjgu3zSXFLyS4=;
        b=oGPSM3/CjRFHEJXd44fx2Zu/SuQ8YF000qPC+Ff5vp4ZoPsAtjhOceXIr+tqs11DCm
         9XA+uz/VYoC1vn0a7gel4zI0JnCDFs024oHfE0FD0MhHZ3LduvleHMJYHEKo6Cx5HHaV
         MFQmTVJp+zxkhepEVYgUc3qVosoY2jYr7E7sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Tzbx1+/fWkWWaCLwjVjhtwQC1Ak5ONn694N+X3sWFSitOz6mi+h1YN+NPCvr+9+V50
         MdHn7w9N0ONViw9jjPI5IiMZ4R6oPKaGTol3APAAwXKqIQeS1r41XZlAwQjfvL7DoLF/
         Jo0vTe6i6pU5N21GkY3gPrmJQ9z1jiSQ0VN8w=
Received: by 10.210.47.7 with SMTP id u7mr819568ebu.59.1225753069838;
        Mon, 03 Nov 2008 14:57:49 -0800 (PST)
Received: from ?192.168.1.11? (abvp247.neoplus.adsl.tpnet.pl [83.8.213.247])
        by mx.google.com with ESMTPS id k5sm5343271nfd.22.2008.11.03.14.57.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 14:57:44 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811031943.30033.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100008>

Nice idea, but for now certainly an RFC

On Mon, 3 Nov 2008, Alexander Gavrilov wrote:

> Some environments may require selective limiting of read access to
> repositories. While even dumb http transport supports it through .htaccess
> files, gitweb currently does not implement discretionary access control.
> 
> This patch adds a configuration-contolled check that matches simple
> 'Reguire user'/'Reguire group' lines in the .htaccess files with the

Typo: Reguire -> Require

> authenticated user name. Using group authentication requires specifying
> a path to the Apache group file in the configuration.
> 
> Using .htaccess has an additional bonus that the same authentication
> data can be used both for gitweb and the dumb http transport.

I'm not sure if it wouldn't be a better solution to try to ask web
server to do authentication, for example in MOD_PERL case via $r
object (if I remember correctly)...

> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
> ---
> 
> 	I also created a gitosis fork that can generate the necessary files:
> 
> 		http://repo.or.cz/w/gitosis/httpauth.git
> 
> 	-- Alexander
> 
>  gitweb/INSTALL     |   14 ++++++++++
>  gitweb/gitweb.perl |   68 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/INSTALL b/gitweb/INSTALL
> index 26967e2..0841db6 100644
> --- a/gitweb/INSTALL
> +++ b/gitweb/INSTALL
> @@ -166,6 +166,20 @@ Gitweb repositories
>    shows repositories only if this file exists in its object database
>    (if directory has the magic file named $export_ok).
>  
> +- Finally, it is possible to use primitive .htaccess authentication by
> +  enabling the $check_htaccess variable in the config file. Gitweb
> +  recognizes the following htaccess commands:
> +
> +    Require user name1 name2 ...     # grant access to the listed users
> +    Require group group1 group2 ...  # grant access to the listed groups
> +    Deny from all                    # deny unless overridden by a Require
> +
> +  Access is granted if the currently authenticated user matches one
> +  of the Require lines, or if the file does not contain any of the listed
> +  commands, or if .htaccess does not exist. If the file exists but cannot
> +  be opened, access is denied. To use group authentication you have to
> +  point $auth_group_file to the group list in Apache format.
> +
>  Generating projects list using gitweb
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 63c793e..4b962c3 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -98,6 +98,12 @@ our $export_ok = "++GITWEB_EXPORT_OK++";
>  # only allow viewing of repositories also shown on the overview page
>  our $strict_export = "++GITWEB_STRICT_EXPORT++";
>  
> +# check basic authentication rules in .htaccess
> +our $check_htaccess  = 0;
> +
> +# name of the file that lists groups for htaccess check
> +our $auth_group_file = "";
> +
>  # list of git base URLs used for URL to where fetch project from,
>  # i.e. full URL is "$git_base_url/$project"
>  our @git_base_url_list = grep { $_ ne '' } ("++GITWEB_BASE_URL++");
> @@ -397,10 +403,64 @@ sub check_head_link {
>  		(-l $headfile && readlink($headfile) =~ /^refs\/heads\//));
>  }
>  
> +# set of htaccess groups for the current user
> +our %cur_auth_groups = ();

Why it is hash, and not list? What are the keys, and what are values?

> +
> +sub find_current_groups($$) {

Style: I think we prefer not using function prototypes.

> +	my ($gfile, $user) = @_;
> +	return () unless $gfile && $user;

Style: you can use simple "return" which means '()' in list context,
and 'undef' in scalar context.

So it could have been written as:

+	($gfile && $user) or return;


But I'd rather someone better in Perl decided...

> +
> +	my @groups;
> +	open my $gf, $gfile or return ();
> +
> +	while(<$gf>) {
> +		next unless /^\s*(\S+)\s*:\s*(\S.*\S)\s*$/;
> +		my ($grp, $usrs) = ($1, $2);
> +		push @groups, $grp if grep { $_ eq $user } split (' ', $usrs);

Wouldn't it be better to use regexp match instead of this split+grep
pipeline?

> +	}
> +
> +	close $gf;
> +	return @groups;
> +}
> +
> +sub check_htaccess_files($) {

Style: I think we prefer not using function prototypes.

This function lack description: where it tries to find '.htaccess'
files, what does it return, etc.

> +	my ($dir) = @_;
> +	my $user = $cgi->remote_user() || ' ';

Why "|| ' '" here?

> +
> +	while (length $dir >= length $projectroot) {
> +		my $file = "$dir/.htaccess";
> +		next unless -e $file;
> +		open my $htf, $file or return 0;
> +
> +		my $ok = 0;
> +		my $need_ok = 0;
> +		while (<$htf>) {
> +			if (/^\s*Require\s+user\s+(\S.*\S)\s*$/i) {
> +				$ok++ if grep { $_ eq $user; } split (' ', $1);
> +				$need_ok++;
> +			} elsif (/^\s*Require\s+group\s+(\S.*\S)\s*$/i) {
> +				$ok++ if grep { $cur_auth_groups{$_}; } split(' ', $1);
> +				$need_ok++;
> +			} elsif (/^\s*Deny\s+from\s+all\s*$/ix) {
> +				$need_ok++;
> +			}
> +		}
> +		close $htf;
> +
> +		return $ok if $need_ok;
> +		last;
> +	} continue {
> +		$dir =~ s/\/[^\/]*$// or last;
> +	}

First, this loop is IMHO very hacky and unclean, using 'continue' block
(which is not very visible on first glance) to advance through loop.

Second, while this loop might be good for _single_ repository, it is
cleanly suboptimal in the case of 'projects_list' action... unless you
want to list projects which are not accessible (I think it is the case
for accessing static pages / static files).

Third, again there is split+grep (well, this is at least consistent).

> +
> +	return 1;
> +}
> +
>  sub check_export_ok {
>  	my ($dir) = @_;
>  	return (check_head_link($dir) &&
> -		(!$export_ok || -e "$dir/$export_ok"));
> +		(!$export_ok || -e "$dir/$export_ok") &&
> +		(!$check_htaccess || check_htaccess_files($dir)));
>  }

O.K. Nice and clean.

>  
>  # process alternate names for backward compatibility
> @@ -626,6 +686,9 @@ if (defined $action) {
>  	}
>  }
>  
> +# compute authenticated groups
> +$cur_auth_groups{$_}++ for find_current_groups($auth_group_file, $cgi->remote_user());
> +

This is a bit hacky. And I am not sure if its place should be here...

>  # parameters which are pathnames
>  our $project = $input_params{'project'};
>  if (defined $project) {
> @@ -853,8 +916,7 @@ sub validate_project {
>  	my $input = shift || return undef;
>  	if (!validate_pathname($input) ||
>  		!(-d "$projectroot/$input") ||
> -		!check_head_link("$projectroot/$input") ||
> -		($export_ok && !(-e "$projectroot/$input/$export_ok")) ||
> +		!check_export_ok("$projectroot/$input") ||
>  		($strict_export && !project_in_list($input))) {
>  		return undef;
>  	} else {

And this is independent change, and should be in separate patch...
...or should be dropped (I'd have to examine this code better).

> -- 
> 1.6.0.3.15.gb8d36
> 

-- 
Jakub Narebski
Poland
