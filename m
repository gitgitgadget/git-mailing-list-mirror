From: Pavel Roskin <proski@gnu.org>
Subject: Re: gitk changing line color for no reason after merge
Date: Tue, 07 Feb 2006 00:18:37 -0500
Message-ID: <1139289517.15955.23.camel@dv>
References: <1138900897.28967.18.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 06:18:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6LFX-00014K-FE
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 06:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWBGFSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 00:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWBGFSo
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 00:18:44 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:63921 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964982AbWBGFSo
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 00:18:44 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F6LDx-0004en-53
	for git@vger.kernel.org; Tue, 07 Feb 2006 00:17:09 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F6LFN-00056d-ER; Tue, 07 Feb 2006 00:18:37 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1138900897.28967.18.camel@dv>
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15684>

Hello!

Sorry for replying to myself, but there is nobody else to reply to.

> I think it would be much better if line colors only change at
> non-trivial nodes, i.e. those with more than one child or parent.

I didn't realize that the colors correspond to nodes, not branches.
Every node has one color that is used for lines to all of its children.
It would be much better to assign colors to "branches" consisting of
individual lines connecting nodes, but changing that would require many
changes in gitk.

> diff --git a/gitk b/gitk
> index f12b3ce..14ff570 100755
> --- a/gitk
> +++ b/gitk
> @@ -770,7 +770,7 @@ proc assigncolor {id} {
>  
>      if [info exists colormap($id)] return
>      set ncolors [llength $colors]
> -    if {$nparents($id) <= 1 && $nchildren($id) == 1} {
> +    if {$nchildren($id) == 1} {
>  	set child [lindex $children($id) 0]
>  	if {[info exists colormap($child)]
>  	    && $nparents($child) == 1} {
> 
> 

I still stand behind this patch because it eliminates color changes on
the nodes that have exactly one child and parent.  $nparents($id) is
irrelevant here, because it characterizes the current node, but the code
decides whether the line should change color at the child node.

However, further changes to reduce color changes didn't produce nice
results for me.  If I try to keep one color running as long as possible,
I get branches of the same color because, as I said, gitk uses the same
color for connections to all children.  So, every node on the branch
spurs branching lines of the same color, which can intersect or run
side-by-side.

I can submit this patch formally, but I hope to get some comments first.

-- 
Regards,
Pavel Roskin
