From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] gitweb: Use the config file to set repository owner's
	name.
Date: Tue, 12 Feb 2008 22:52:02 -0200
Message-ID: <20080213005202.GA5965@c3sl.ufpr.br>
References: <1202488684-13266-1-git-send-email-ribas@c3sl.ufpr.br> <1202488684-13266-2-git-send-email-ribas@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 01:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP5re-0007XQ-AV
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 01:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbYBMAwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 19:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754320AbYBMAwG
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 19:52:06 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:43842 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbYBMAwF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 19:52:05 -0500
Received: from localhost (unknown [201.21.136.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 94791700003DE;
	Tue, 12 Feb 2008 22:52:02 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <1202488684-13266-2-git-send-email-ribas@c3sl.ufpr.br>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73723>

Was it forgotten ? 8^)

On Fri, Feb 08, 2008 at 02:38:03PM -0200, Bruno Ribas wrote:
> Now gitweb checks if gitweb.owner exists before trying to get filesystem's
> owner.
> 
> Allow to use configuration variable gitweb.owner set the repository owner,
> it checks the gitweb.owner, if not set it uses filesystem directory's owner.
> 
> Useful when we don't want to maintain project list file, and all
> repository directories have to have the same owner (for example when the
> same SSH account is shared for all projects, using ssh_acl to control
> access instead).
> 
> Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
> ---
>  gitweb/gitweb.perl |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8ef2735..c8fe22a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1759,6 +1759,7 @@ sub git_get_project_owner {
>  	my $owner;
>  
>  	return undef unless $project;
> +	$git_dir = "$projectroot/$project";
>  
>  	if (!defined $gitweb_project_owner) {
>  		git_get_project_list_from_file();
> @@ -1767,8 +1768,11 @@ sub git_get_project_owner {
>  	if (exists $gitweb_project_owner->{$project}) {
>  		$owner = $gitweb_project_owner->{$project};
>  	}
> +	if (!defined $owner){
> +		$owner = git_get_project_config('owner');
> +	}
>  	if (!defined $owner) {
> -		$owner = get_file_owner("$projectroot/$project");
> +		$owner = get_file_owner("$git_dir");
>  	}
>  
>  	return $owner;
> -- 
> 1.5.4.24.gce08d

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
