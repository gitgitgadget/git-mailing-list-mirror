From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Mon, 9 Oct 2006 22:15:45 -0700 (PDT)
Message-ID: <20061010051545.15859.qmail@web31801.mail.mud.yahoo.com>
References: <20061010025627.19317.70511.stgit@rover>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 07:15:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX9y1-0003l0-8d
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 07:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWJJFPq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 01:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWJJFPq
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 01:15:46 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:20866 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964979AbWJJFPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 01:15:46 -0400
Received: (qmail 15861 invoked by uid 60001); 10 Oct 2006 05:15:45 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=sJFPWHrWmQwhJ9rOQyHEAb5Q47ssJIlijKwRoqj8LkoMHGySavHOw3gCE/0I4Gb69z+PbJN5IRldjkgjOF85CNizrVUcRiLdov40RwFnIp2lpxKh/3rjNIWhvdzuCh0RaiGNGdnZU/pNooF3b7bZPJvu0+MwQv0/KHCW5dAeQpc=  ;
Received: from [71.80.233.118] by web31801.mail.mud.yahoo.com via HTTP; Mon, 09 Oct 2006 22:15:45 PDT
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061010025627.19317.70511.stgit@rover>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28602>

--- Petr Baudis <pasky@suse.cz> wrote:
> If the project includes a README file, show it in the summary page.
> The usual "this should be in the config file" argument does not apply here
> since this can be larger and having such a big string in the config file
> would be impractical.
> 
> I don't know if this is suitable upstream, but it's one of the repo.or.cz
> custom modifications that I've thought could be interesting for others
> as well.

I don't see how a read-me file relates to gitweb.

People may call those files "00README" or "README.txt"
or "README.TXT" or "README_001", etc.

The contents of such a file has nothing to do with gitweb,
and or git.  It may work for repo.or.cz but is unlikely that
it would work for all projects for all git repos and for all
gitweb interfaces.

The contents of a read-me file could be quite large and thus
not suitable for the "summary" page.  Both the contents and the
size may not be suitable.  "repo.or.cz" is the exception, not
the rule.

A readme file isn't written with the intent of git or gitweb.
It is a function of the project, not the SCM used to keep it in, or
the SCM web interface used to show it.

I don't understand why the "description"  file doesn't do what
you want?  Do you need it to be multi-line or slightly larger?
Why not just extend "description" and/or create/use a second
file called "description_long" to store multi-line descriptions?

Or why not extend the "description" file s.t. only the first
line would be shown in the "description" line of "summary" and
down below, show the rest of the description file if present?

This way it is known that this is a function of gitweb.

     Luben

> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
> 
>  gitweb/gitweb.perl |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7547c4d..4e56af9 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2535,6 +2535,14 @@ sub git_summary {
>  	}
>  	print "</table>\n";
>  
> +	if (-s "$projectroot/$project/README") {
> +		if (open my $fd, "$projectroot/$project/README") {
> +			print "<div class=\"title\">readme</div>\n";
> +			print $_ while (<$fd>);
> +			close $fd;
> +		}
> +	}
> +
>  	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
>  		git_get_head_hash($project)
>  		or die_error(undef, "Open git-rev-list failed");
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
