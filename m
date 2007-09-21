From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-svn: handle changed svn command-line syntax
Date: Fri, 21 Sep 2007 15:15:00 +1200
Message-ID: <46F33734.3080408@vilain.net>
References: <1190340155146-git-send-email-sam.vilain@catalyst.net.nz> <11903401551014-git-send-email-sam.vilain@catalyst.net.nz> <11903401551812-git-send-email-sam.vilain@catalyst.net.nz> <11903401552164-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 05:15:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYYz8-0006vj-Vv
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 05:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbXIUDPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 23:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbXIUDPM
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 23:15:12 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:46902 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbXIUDPL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 23:15:11 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 8774E21CFC0; Fri, 21 Sep 2007 15:15:08 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 328E421CFBC;
	Fri, 21 Sep 2007 15:15:03 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <11903401552164-git-send-email-sam.vilain@catalyst.net.nz>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58822>

Sam Vilain wrote:
> Previously, if you passed a revision and a path to svn, it meant to look
> back at that revision and select that path.  New behaviour is to get the
> path then go back to the revision.  The old syntax is selected with new
> syntax PATH@REV.  This new syntax is not supported by the old tools, so we
> have to try both in turn.

Blast, this analysis is wrong.  Hold off, I'll see what's really going
on and re-submit.

Sam.

> 
> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
> ---
>  t/t9104-git-svn-follow-parent.sh |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
> index 9eab945..7ba7630 100755
> --- a/t/t9104-git-svn-follow-parent.sh
> +++ b/t/t9104-git-svn-follow-parent.sh
> @@ -51,8 +51,10 @@ test_expect_success 'init and fetch from one svn-remote' "
>          "
>  
>  test_expect_success 'follow deleted parent' "
> -        svn cp -m 'resurrecting trunk as junk' \
> -               -r2 $svnrepo/trunk $svnrepo/junk &&
> +        (svn cp -m 'resurrecting trunk as junk' \
> +               $svnrepo/trunk@2 $svnrepo/junk ||
> +         svn cp -m 'resurrecting trunk as junk' \
> +               -r2 $svnrepo/trunk $svnrepo/junk) &&
>          git config --add svn-remote.svn.fetch \
>            junk:refs/remotes/svn/junk &&
>          git-svn fetch -i svn/thunk &&
