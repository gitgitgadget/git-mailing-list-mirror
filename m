From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: don't use pathinfo for global actions
Date: Tue, 6 Jan 2009 18:37:22 +0100
Message-ID: <200901061837.23637.jnareb@gmail.com>
References: <1230896080-22801-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Devin Doucette <devin@doucette.cc>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 18:39:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKFtO-0000IS-6G
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 18:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbZAFRhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 12:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbZAFRhh
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 12:37:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:50466 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbZAFRhg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 12:37:36 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1554105ugf.37
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=CFkhV4tPgVfkUMJIKmgHx9JZ9VJq2Fllx/wAMfIBWuE=;
        b=pbgtnYni1ERCfGuzOoR7SNQr+H9I022BiOtDPK9pVJC3PMSU3Uw9eYAbLbCGsJoNQH
         MgOionIpZKup8rPJLRx1VPgAErJs3TkFG+nAQ/Ny2lyIZK0AKbh5dGpz0Pw+yRLh4F02
         1XG0yxQ7fRp1cQKN9otQ6AIUcRgLwSpFxvP20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vXuGdr/8KzCE5x4db3khtsbjt92Q9AaBaANFdYrIZ2lFGcvr7punVMuGlzR3kQsOX/
         A/axcwpreuB6Vx/NZ7maxcJN9AkHQW7UVyPM/T2I2xFo9El4LmmPogz2zv+9ZL9cMahX
         /OUvzQ+1CqzI04qYdYFJuuhIiO+StibAXC6DM=
Received: by 10.66.240.12 with SMTP id n12mr4673098ugh.75.1231263454141;
        Tue, 06 Jan 2009 09:37:34 -0800 (PST)
Received: from ?192.168.1.11? (abvs145.neoplus.adsl.tpnet.pl [83.8.216.145])
        by mx.google.com with ESMTPS id k2sm26240964ugf.21.2009.01.06.09.37.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jan 2009 09:37:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1230896080-22801-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104703>

On Fri, 2 Jan 2009, Giuseppe Bilotta wrote:

> With PATH_INFO urls, actions for the projects list (e.g. opml,
> project_index) were being put in the URL right after the base. The
> resulting URL is not properly parsed by gitweb itself, since it expects
> a project name as first component of the URL.

Therefore it really needs to be in, as df63fb also by Giuseppe
(gitweb: use href() when generating URLs in OPML) is already in,
and I think gitweb would generate broken OPML and TXT links without
this patch.

> 
> Accepting global actions in use_pathinfo is not a very robust solution
> due to possible present and future conflicts between project names and
> global actions, therefore we just refuse to create PATH_INFO URLs when
> the project is not defined.

I think it is quite robust solution and it makes sense; we use
shortcuts http://git.example.com for projects_list page, and
http://git.example.com/path/to/repo.git for overview 'summary'
action for a project, therefore pathinfo has to look like the
following: http://git.example.com/repo/action/hash with "action"
_after_ "project".  And there is also matter of backward compatibility
of URL (URLs shouldn't break).

Anyway, we have $home_link for default project_list page, which
is path_info without project, and query without query string...

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 99f71b4..fa7d8ad 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -830,7 +830,7 @@ sub href (%) {
>  	}
>  
>  	my $use_pathinfo = gitweb_check_feature('pathinfo');
> -	if ($use_pathinfo) {
> +	if ($use_pathinfo and defined $params{'project'}) {
>  		# try to put as many parameters as possible in PATH_INFO:
>  		#   - project name
>  		#   - action
> @@ -845,7 +845,7 @@ sub href (%) {
>  		$href =~ s,/$,,;
>  
>  		# Then add the project name, if present
> -		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
> +		$href .= "/".esc_url($params{'project'});
>  		delete $params{'project'};
>  
>  		# since we destructively absorb parameters, we keep this

Nice.

> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
