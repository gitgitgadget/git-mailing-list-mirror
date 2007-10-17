From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitweb: speed up project listing by limiting find depth
Date: Tue, 16 Oct 2007 22:40:18 -0400
Message-ID: <20071017024018.GR13801@spearce.org>
References: <1192583606-14893-1-git-send-email-git@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pasky@suse.cz
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 04:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihypt-00021n-7V
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 04:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936292AbXJQCkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 22:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936264AbXJQCkY
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 22:40:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52469 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936160AbXJQCkW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 22:40:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhypM-0007Pv-2Y; Tue, 16 Oct 2007 22:40:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AE37E20FBAE; Tue, 16 Oct 2007 22:40:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192583606-14893-1-git-send-email-git@vicaya.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61320>

Luke Lu <git@vicaya.com> wrote:
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3064298..d62357f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1509,16 +1513,23 @@ sub git_get_projects_list {
...
> +				# don't traverse too deep (Find is super slow on os x)
> +				if (tr!/!! - $pfxdepth > $project_maxdepth) {
> +					$File::Find::prune = 1;
> +					return;
> +				}
>  
>  				my $subdir = substr($File::Find::name, $pfxlen + 1);

Your patch appears to be causing some errors in the test suite
in t/t9500-gitweb-standalone-no-errors.sh.  Perl is whining about
$subdir not getting initialized above due to the substr being off
the string.  I've got too many other topics tonight to figure out
why yours is failing, can you please run the test and resubmit when
you've resolved the error?

-- 
Shawn.
