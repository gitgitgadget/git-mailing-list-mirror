From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Added sub get_owner_file which checks if there's a file with project owner name
Date: Tue, 29 Jan 2008 03:26:31 -0800 (PST)
Message-ID: <m3lk6898kg.fsf@localhost.localdomain>
References: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Tue Jan 29 12:27:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJocM-0005OD-LA
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 12:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbYA2L0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 06:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbYA2L0f
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 06:26:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:3647 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbYA2L0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 06:26:34 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2057431fga.17
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 03:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=/TJgl/HXaNslQjOMRYo6HujdI7OXQAsSXX97DRojXkI=;
        b=UQJ+e7pH9IPo5zme1bduCtOY/xa8+nKC782M/9/FX6NIIowGRYf3NGiBGkLQn16C4G/I6ggnJK3t+u+/8xq8d3tjE4JitbcpP0HjzKylQHrj/jGfXnaXOAUGboUzFbCWxW6rlrruY0AtJ5/qUE9k/ZepwZhdd+Ef4/8Hku7aefA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=egQ6k1dSsFvOggeVrACv2r+2NHkgDwGLseXs5zg3Jx3pvkYC5b3Ba9keliv7PLKAOQQ31KPPr1cKbwvvWtCWLMOudv5UF4YId4C9ROIwooE036US4S8mhKLmatYriTuAmoUlwgWhu8Y6R+9zg3+IlM5zl4Xu276IXXbG1EuDYFo=
Received: by 10.82.171.16 with SMTP id t16mr11979890bue.11.1201605992341;
        Tue, 29 Jan 2008 03:26:32 -0800 (PST)
Received: from localhost.localdomain ( [83.8.244.23])
        by mx.google.com with ESMTPS id i6sm1498780gve.5.2008.01.29.03.26.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Jan 2008 03:26:31 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0TBQQ7R027410;
	Tue, 29 Jan 2008 12:26:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0TBQNjc027406;
	Tue, 29 Jan 2008 12:26:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71975>

Bruno Ribas <ribas@c3sl.ufpr.br> writes:

> This file ($projectroot/$project/owner) is good to have when we don't want to
> maintain a project  list AND when we share same SSH account for all projects,
> using ssh_acl for example.
>
> Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>

This explanation is a bit too complicated; it explains farther
reasons, instead of immediate ones: you don't want to maintain project
list file, and all repository directories have to have the same owner
(for example when the same SSH account is shared for all projects,
using ssh_acl to control access instead).

Besides with new faster config reader we probably would want to allow
to use config file to set owner, instead of adding yet another file to
the repo area; see commit 0e121a2cd42d28bc4034feedf8a13c5a91f85bd3
  "gitweb: Use config file for repository description and URLs"
This would have the advantage that you could use system config
(/etc/gitconfig) to set fallback owner instead of relying on
filesystem.  I'm not sure what should be the preference, though:
gitweb.owner, then $GIT_DIR/owner, or vice versa?  I guess that
reading $GIT_DIR/owner should take preference, as it is needed also
for projects list page, where ordinary we didn't read individual
repositories configuration.

I guess that it is meant to be post 1.5.4, isn't it?

> ---
>  gitweb/gitweb.perl |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6256641..fac5f78 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1754,6 +1754,15 @@ sub git_get_project_list_from_file {
>  	}
>  }
>  
> +sub get_owner_file {
> +    my $owner_file = shift;

Here you use spaces instead of tabs in indent.

> +
> +	open my $fd, "$owner_file" or return undef;

	open my $fd, $owner_file or return undef;

would be simpler.

> +	my $owner = <$fd>;
> +	close $fd;
> +	return to_utf8($owner);
> +}

I wonder if we should just bite the bullet and replace all such by
generic subroutine called e.g. read_singleline_file, or something like
that.  Or perhaps not, if we want to read alternatively from config,
with different config variable key names and different preferences of
file/config priority...

> +
>  sub git_get_project_owner {
>  	my $project = shift;
>  	my $owner;
> @@ -1767,6 +1776,11 @@ sub git_get_project_owner {
>  	if (exists $gitweb_project_owner->{$project}) {
>  		$owner = $gitweb_project_owner->{$project};
>  	}
> +
> +    if ( -f "$projectroot/$project/owner" ) {
> +        $owner = get_owner_file("$projectroot/$project/owner");
> +    }
> +

Here you use spaces. I think that you can lose spaces around condition
in the above 'if'.

>  	if (!defined $owner) {
>  		$owner = get_file_owner("$projectroot/$project");
>  	}
> -- 
> 1.5.3.8

I hope that doesn't mean that this patch is based on v1.5.3.8
gitweb...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
