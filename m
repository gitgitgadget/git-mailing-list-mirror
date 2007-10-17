From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitweb: speed up project listing by limiting find depth
Date: Tue, 16 Oct 2007 20:41:25 -0400
Message-ID: <20071017004125.GI13801@spearce.org>
References: <1192580691-14308-1-git-send-email-git@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, Petr Baudis <pasky@suse.cz>
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 02:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihwyn-0001E6-Lo
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 02:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601AbXJQAlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 20:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbXJQAlf
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 20:41:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48349 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbXJQAle (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 20:41:34 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhwyN-0005p3-Qd; Tue, 16 Oct 2007 20:41:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 33EC620FBAE; Tue, 16 Oct 2007 20:41:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192580691-14308-1-git-send-email-git@vicaya.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61292>

Luke Lu <git@vicaya.com> wrote:
> diff --git a/Makefile b/Makefile
> index 8db4dbe..b70ba8c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -165,6 +165,7 @@ GITWEB_CONFIG = gitweb_config.perl
>  GITWEB_HOME_LINK_STR = projects
>  GITWEB_SITENAME =
>  GITWEB_PROJECTROOT = /pub/git
> +GITWEB_PROJECT_MAXDEPTH = 2

I'd rather see this default to an unlimited (or maybe insane?) depth.
Current users may be surprised upon upgrading to a more recent git
when their gitweb stops showing projects because the default depth
is too small.

repo.or.cz is up at 3 deep, maybe 4 right now, right Pasky?
I think letting admins control the depth is a good idea, but its
a performance tuning thing and probably shouldn't break existing
setups.

> +				# don't traverse too deep (Find is super slow on os x)
> +				return if tr!/!! - $pfxdepth > $project_maxdepth && ($File::Find::prune = 1);

I don't do much gitweb hacking, but I usually don't like to find
code that mutates a value as an important side-effect in the middle
of a boolean condition that is used to determine if we are breaking
out of this function now, or falling through to do more work.  yea
its more lines of code but I think it would be easier to grok if this
was a proper if {...}.

-- 
Shawn.
