From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: Only follow first parents when populating
 svn:mergeinfo properties
Date: Fri, 14 Sep 2012 21:50:55 +0000
Message-ID: <20120914215055.GB16293@dcvr.yhbt.net>
References: <CAHkK2bpCjmxTKmBj6Wqgmky2YjRk8_MQF6th8xxc6XoStdVOeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bryan Jacobs <bjacobs@woti.com>,
	Sam Vilain <sam@vilain.net>
To: Avishay Lavie <avishay.lavie@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 23:51:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCdmy-0006sy-P8
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 23:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248Ab2INVu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 17:50:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43529 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab2INVuz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 17:50:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421641F50D;
	Fri, 14 Sep 2012 21:50:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAHkK2bpCjmxTKmBj6Wqgmky2YjRk8_MQF6th8xxc6XoStdVOeg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205536>

I'm awaiting Sam's comment on this patch.

Avishay Lavie <avishay.lavie@gmail.com> wrote:
> Subject: [PATCH] git svn: Only follow first parents when populating
> svn:mergeinfo
>  properties.
> 
> When svn.pushmergeinfo is set, git-svn tries to correctly populate mergeinfo
> properties when encountering a merge commit. It does so by first aggregating
> the mergeinfo property of the merged parent into the target, and then
> adding to it the SVN revision number of any commit reachable from the
> merged parent but not from the first (target) parent.
> 
> If a third branch was merged into the merged parent (e.g. X was merged into Y
> and Y was then merged into Z), its revisions will be listed twice --
> once as part
> of aggregating Y's mergeinfo property into Z's, and once more when walking
> the tree and finding X's commits reachable from Y's tip. While the first listing
> correctly lists those revisions as merged from X, the second listing
> will list them
> as merged from Y, creating incorrect mergeinfo properties that later cause
> unnecessary lookups and warnings when git-svn-fetching.
> 
> Adding '--first-parent' to the rev-list command fixes this by only walking the
> part of the tree that's directly included in the merged branch (Y) and not any
> branches merged into it (X).
> 
> Signed-off-by: Avishay Lavie <avishay.lavie@gmail.com>
> ---
>  git-svn.perl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 828b8f0..f69a4d6 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -728,7 +728,7 @@ sub populate_merge_info {
> 
>   next if $parent eq $parents[0]; # Skip first parent
>   # Add new changes being placed in tree by merge
> - my @cmd = (qw/rev-list --reverse/,
> + my @cmd = (qw/rev-list --first-parent --reverse/,
>     $parent, qw/--not/);
>   foreach my $par (@parents) {
>   unless ($par eq $parent) {
> -- 

Your patch seems badly whitespace mangled.  Fortunately it's a small
change and I can fix it by hand.
