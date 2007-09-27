From: Dan Nicholson <dbn.lists@gmail.com>
Subject: Re: [PATCH] quiltimport: Skip non-existent patches
Date: Thu, 27 Sep 2007 20:39:54 +0000 (UTC)
Message-ID: <loom.20070927T203413-499@post.gmane.org>
References: <Pine.LNX.4.62.0709271154440.10467@pademelon.sonytel.be> <1190925059-5233-1-git-send-email-dbn.lists@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 22:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib0FM-0005FL-GQ
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 22:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbXI0UqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 16:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754896AbXI0UqA
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 16:46:00 -0400
Received: from main.gmane.org ([80.91.229.2]:41501 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582AbXI0Up7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 16:45:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ib0Dg-0005WL-GZ
	for git@vger.kernel.org; Thu, 27 Sep 2007 20:44:24 +0000
Received: from 130.76.32.181 ([130.76.32.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 20:44:24 +0000
Received: from dbn.lists by 130.76.32.181 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 20:44:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 130.76.32.181 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.7) Gecko/20070914 Firefox/2.0.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59331>

Dan Nicholson <dbn.lists <at> gmail.com> writes:
> 
> When quiltimport encounters a non-existent patch in the series file,
> just skip to the next patch. This matches the behavior of quilt.
> 
> Signed-off-by: Dan Nicholson <dbn.lists <at> gmail.com>
> ---
>  git-quiltimport.sh |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
> index 74a54d5..880c81d 100755
> --- a/git-quiltimport.sh
> +++ b/git-quiltimport.sh
> @@ -71,6 +71,10 @@ commit=$(git rev-parse HEAD)
> 
>  mkdir $tmp_dir || exit 2
>  for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
> +	if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
> +		echo "$patch_name doesn't exist. Skipping."
> +		continue
> +	fi
>  	echo $patch_name
>  	git mailinfo "$tmp_msg" "$tmp_patch" \
>  		<"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3


I forgot to mention the rationale for this patch vs. what Junio sent. The issue
with Junio's patch is that the failure will occur before $tmp_patch is created
because the script tries to feed git-mailinfo a non-existent patch
($patch_name). You'll only get past the mailinfo if $patch_name exists.

The marker setting may still be useful in this context, though, to suppress the
"doesn't exist" message.

--
Dan
