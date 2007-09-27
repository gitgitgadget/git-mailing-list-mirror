From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn and branches
Date: Thu, 27 Sep 2007 18:36:08 +1200
Message-ID: <46FB4F58.2080901@vilain.net>
References: <20070927021252.GA23777@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:36:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iamz7-0007bF-Tu
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 08:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbXI0GgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 02:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbXI0GgW
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 02:36:22 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43473 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbXI0GgV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 02:36:21 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id BF18F20C2D4; Thu, 27 Sep 2007 18:36:18 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 9F00323C263;
	Thu, 27 Sep 2007 18:36:11 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20070927021252.GA23777@dervierte>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59270>

Steven Walter wrote:
> Knowing just enough of what git-svn is doing to be dangerous, I
> whipped up a short little patch.  This patch seems to work for the
> common case, and avoids fetching every file from subversion.  It does
> break sometimes, however, and I don't understand why.
>
> Maybe someone with a better grasps of the code can see what I did
> wrong, or suggest a better means to my end?

Try also with the SVN trunk - the do_switch API has recently been added
and it also avoids this excess checkout.  I'm not sure why a solution
like you post isn't used, perhaps Eric can comment further.

Sam.

> diff --git a/git-svn.perl b/git-svn.perl
> index 484b057..1bc92b6 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1848,9 +1848,10 @@ sub find_parent_branch {
>                                               $self->full_url, $ed)
>                           or die "SVN connection failed somewhere...\n";
>                 } else {
> +                       $self->assert_index_clean($parent);
>                         print STDERR "Following parent with do_update\n";
>                         $ed = SVN::Git::Fetcher->new($self);
> -                       $self->ra->gs_do_update($rev, $rev, $self, $ed)
> +                       $self->ra->gs_do_update($rev, $r0, $self, $ed)
>                           or die "SVN connection failed somewhere...\n";
>                 }
>                 print STDERR "Successfully followed parent\n";
