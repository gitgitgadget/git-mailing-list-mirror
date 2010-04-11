From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] More flexible URL patterns for gitweb
Date: Sun, 11 Apr 2010 10:33:24 -0700 (PDT)
Message-ID: <m37hodhp3e.fsf@localhost.localdomain>
References: <1270946429-5366-1-git-send-email-damien@tournoud.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Damien Tournoud <damien@tournoud.net>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:33:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O112L-0002SX-SL
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab0DKRd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 13:33:29 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:65470 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab0DKRd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 13:33:28 -0400
Received: by bwz19 with SMTP id 19so22536bwz.21
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=NBoRVeN+CQGgKfG0CoTi96OGU+tOqTJ2Xph4tXb0vbE=;
        b=qJjbzA7TtVh5GqGHLzU4aJJ7VG7wSDdmTe0QXI44Ubk70tZ8qeP2z/34ZjMKz6LMew
         wcZcczggOFwg5fgyp82ZEuVvBWCH2YoGtOt0oo0vDp83/nsjVfLFIl3bpfUj/1IGVePR
         MNMSuBWgQ0nHbQ9x3QxjBo+rZajg2vMR6W31w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=dvmdTPFEbHpy8f8U0QqT+65qmd+dRSSWpQp9vm9P5wkzmKhmHSh8OMjtfKbSnyUXqM
         gGVCldfOb5cwCdJa6cP3+aFhp9XIsgw5OSPwTDhU+VW9pEw1dSlRZetnuIGop0woxG49
         P9ZZiPy7u6WSqvx2jMO3B5cbBjMumZHQI7iqA=
Received: by 10.204.21.1 with SMTP id h1mr3356394bkb.171.1271007205979;
        Sun, 11 Apr 2010 10:33:25 -0700 (PDT)
Received: from localhost.localdomain (abwq147.neoplus.adsl.tpnet.pl [83.8.240.147])
        by mx.google.com with ESMTPS id s17sm30213835bkd.22.2010.04.11.10.33.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 10:33:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3BHWmET008943;
	Sun, 11 Apr 2010 19:32:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3BHWbvh008932;
	Sun, 11 Apr 2010 19:32:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1270946429-5366-1-git-send-email-damien@tournoud.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144662>

Damien Tournoud <damien@tournoud.net> writes:

> @git_base_url_list hardcodes URLs in the form "$git_base_url/$project",
> which makes impossible to generate proper URLs for SSH access scenarios.

As I understand it, current way of creating project's URLs from
@git_base_url_list and $project (and project name), via joining
with '/' as separator in the form of "$git_base_url/$project"
does not work for a class of scp-like relative "URLs".  You can't
create 'git@git.example.com:path/to/project' URL using current form
of @git_base_url_list support.

Current form of @git_base_url_list support works well both for
absolute scp-like URLs for SSH sccess, for example
'git@git.example.com:/srv/git' + 'path/to/project', and also for
"ssh://" URLs like 'ssh://git.example.com/srv/git' or 
'ssh://git@git.example.com/~' + 'path/to/project'.

> 
> This patch implements a more flexible replacement scheme, using a
> simple placeholder for the project path, and fixes the associated
> documentation.

NAK, at least in this form, for it breaks backwards compatibility.
We do not want to have upgrading gitweb break one's existing gitweb
configuration.  But see below for proposed amendment of this patch.
 
> Signed-off-by: Damien Tournoud <damien@tournoud.net>
> ---
>  gitweb/README      |   13 ++++++-------
>  gitweb/gitweb.perl |    2 +-
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/gitweb/README b/gitweb/README
> index ad6a04c..f16729c 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -197,13 +197,12 @@ not include variables usually directly set during build):
>     full description is available as 'title' attribute (usually shown on
>     mouseover).  By default set to 25, which might be too small if you
>     use long project descriptions.
> - * @git_base_url_list
> -   List of git base URLs used for URL to where fetch project from, shown
> -   in project summary page.  Full URL is "$git_base_url/$project".
> -   You can setup multiple base URLs (for example one for  git:// protocol
> -   access, and one for http:// "dumb" protocol access).  Note that per
> -   repository configuration in 'cloneurl' file, or as values of gitweb.url
> -   project config.
> + * @git_base_url_patterns
> +   List of git base URLs patterns used to build the URLs displayed in the
> +   project summary page. Examples include "git://git.example.com/%project",
> +   "http://git.example.com/%project" and "git@git.example.com:%project".
> +   Note that per repository configuration in a 'cloneurl' file, or configuration
> +   values of gitweb.url in the project config take precedence over this.

Here it looks like you would be using @git_base_url_patterns for the
new mechanism, while below one can see that you re-use @git_base_url_list...
and break backwards compatibility with existing gitweb configuration using
@git_base_url_list.

Also, you use %project as placeholder... while %project is valid path part
of URLs (although unlikely one).

>   * $default_blob_plain_mimetype
>     Default mimetype for blob_plain (raw) view, if mimetype checking
>     doesn't result in some other type; by default 'text/plain'.
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c356e95..0fc5957 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4904,7 +4904,7 @@ sub git_summary {
>  	# or make project git URL from git base URL and project name
>  	my $url_tag = "URL";
>  	my @url_list = git_get_project_url_list($project);
> -	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
> +	@url_list = map { my $url = $_; $url =~ s/%project/$project/g; $url } @git_base_url_list unless @url_list;
>  	foreach my $git_url (@url_list) {
>  		next unless $git_url;
>  		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";

To not break backward compatibility, wouldn't it be better to check if
elements of @git_base_url_list end with ':' or '/', and join base with
project path depending on this condition, i.e.:

+	@url_list = map { m/[/:]$/ ? "$_$project" : "$_/$project" } @git_base_url_list
+               unless @url_list;

This means: if base ends with colon ':' or slash '/', concatenate base
and project path, otherwise join them using '/' as field separator.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
