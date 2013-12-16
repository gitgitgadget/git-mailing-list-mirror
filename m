From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Support svn:global-ignores property
Date: Mon, 16 Dec 2013 22:23:56 +0000
Message-ID: <20131216222356.GA13115@dcvr.yhbt.net>
References: <528DE354.1050804@ya.ru>
 <1385036908-10392-1-git-send-email-margtu-fivt@ya.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Benoit Sigoure <tsuna@lrde.epita.fr>,
	Thomas Rast <tr@thomasrast.ch>
To: Aleksey Vasenev <margtu-fivt@ya.ru>
X-From: git-owner@vger.kernel.org Mon Dec 16 23:33:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsgik-0007zC-6N
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 23:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205Ab3LPWc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 17:32:58 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52197 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab3LPWc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 17:32:57 -0500
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2013 17:32:57 EST
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3882244C2EF;
	Mon, 16 Dec 2013 22:23:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1385036908-10392-1-git-send-email-margtu-fivt@ya.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239370>

Aleksey Vasenev <margtu-fivt@ya.ru> wrote:
> ---

What Thomas said about commit messages.

Note: I hardly use git-svn or SVN anymore and don't pay attention
to SVN changes.

Some style nitpicks:

> @@ -1304,16 +1318,20 @@ sub cmd_create_ignore {
>  		# which git won't track
>  		mkpath([$path]) unless -d $path;
>  		my $ignore = $path . '.gitignore';
> -		my $s = $props->{'svn:ignore'} or return;
> +		my $s = &get_svn_ignore($props, 'svn:ignore');
> +		my $s_global = &get_svn_ignore($props, 'svn:global-ignores');

&sub(...) convention isn't consistent with the rest of our Perl code.
Do this instead:

		my $s = get_svn_ignore($props, 'svn:ignore');
		my $s_global = get_svn_ignore($props, 'svn:global-ignores');

> +		$s or $s_global or return;

Precedence should be more explicit:
		($s || $s_global) or return;

Likewise for cmd_show_ignore.  Thanks.
