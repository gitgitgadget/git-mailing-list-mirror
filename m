From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: URL-decode the left-hand side of an svn
	refspec
Date: Wed, 4 Aug 2010 08:38:40 +0000
Message-ID: <20100804083840.GA19367@dcvr.yhbt.net>
References: <1280877685-4928-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Steven Walter <swalter@lpdev.prtdev.lexmark.com>
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 10:38:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgZUv-0005o1-SE
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 10:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254Ab0HDIio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 04:38:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43697 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755496Ab0HDIin (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 04:38:43 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22261F503;
	Wed,  4 Aug 2010 08:38:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1280877685-4928-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152566>

Steven Walter <stevenrwalter@gmail.com> wrote:
> From: Steven Walter <swalter@lpdev.prtdev.lexmark.com>
> 
> This change allows git-svn to handle an URL with colons in the path
> ---
>  git-svn.perl |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Thanks Steven.

Since git-svn already has a uri_decode() function, we should use that.
The decoding should apply to the local portion of branches/tags globs,
too.  Does the following work for you?

diff --git a/git-svn.perl b/git-svn.perl
index 8d2ef3d..34884b8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1820,6 +1820,7 @@ sub read_all_remotes {
 			die("svn-remote.$remote: remote ref '$remote_ref' "
 			    . "must start with 'refs/'\n")
 				unless $remote_ref =~ m{^refs/};
+			$local_ref = uri_decode($local_ref);
 			$r->{$remote}->{fetch}->{$local_ref} = $remote_ref;
 			$r->{$remote}->{svm} = {} if $use_svm_props;
 		} elsif (m!^(.+)\.usesvmprops=\s*(.*)\s*$!) {
@@ -1832,6 +1833,7 @@ sub read_all_remotes {
 			die("svn-remote.$remote: remote ref '$remote_ref' ($t) "
 			    . "must start with 'refs/'\n")
 				unless $remote_ref =~ m{^refs/};
+			$local_ref = uri_decode($local_ref);
 			my $rs = {
 			    t => $t,
 			    remote => $remote,
-- 
Eric Wong
