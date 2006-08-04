From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Introduce git-xxdiff to invoke xxdiff for manual conflict resolution
Date: Thu, 03 Aug 2006 17:01:11 -0700
Message-ID: <7v64h9pdx4.fsf@assigned-by-dhcp.cox.net>
References: <11546492331601-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 02:01:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8n7t-0005V2-CZ
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 02:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWHDABO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 20:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWHDABO
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 20:01:14 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:25259 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030236AbWHDABN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 20:01:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804000112.FURZ6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Aug 2006 20:01:12 -0400
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11546492331601-git-send-email-martin@catalyst.net.nz> (Martin
	Langhoff's message of "Fri, 4 Aug 2006 11:53:53 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24760>

Martin Langhoff <martin@catalyst.net.nz> writes:

> diff --git a/git-xxdiff.sh b/git-xxdiff.sh
> new file mode 100755
> index 0000000..d562ab2
> --- /dev/null
> +++ b/git-xxdiff.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +
> +USAGE='<path>'
> +SUBDIRECTORY_OK=No
> +. git-sh-setup
> +
> +FILE=$1
> +MERGE_HEAD=`git rev-parse MERGE_HEAD`
> +
> +# Sanity checks

We can have unmerged index without MERGE_HEAD (for example,
think "rebase --merge" or "am -3"); drop check for that and
instead check for stage 2 ("ours") for the path.

	git cat-file blob :2:$FILE

Can xxdiff take more than one file pairs?

If so you might want to list unmerged paths (ls-files -u) and
iterate through it when no paths are given from the command
line.  If not, you might want to take the first unmerged path
when no paths are given from the command line.

> +xxdiff -wbB --show-merged-pane --merged-filename $FILE~merged $FILE~HEAD $FILE~MERGE_HEAD
> \ No newline at end of file

;-).
