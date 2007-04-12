From: Junio C Hamano <junkio@cox.net>
Subject: Re: Teach git-update-index about gitlinks
Date: Thu, 12 Apr 2007 15:45:57 -0700
Message-ID: <7vtzvli53u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704121218130.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 00:46:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc83G-0007vm-IB
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 00:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbXDLWp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 18:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbXDLWp7
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 18:45:59 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51369 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbXDLWp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 18:45:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412224559.ITGU1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Apr 2007 18:45:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id mNlx1W00m1kojtg0000000; Thu, 12 Apr 2007 18:45:58 -0400
In-Reply-To: <Pine.LNX.4.64.0704121218130.4061@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 12 Apr 2007 12:29:40 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44361>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Junio - if you prefer Alex' patch instead, I won't be upset. This is 
> definitely a bigger re-org, and while I think it makes sense as a patch 
> even *aside* from the gitlink support, it's probably largely a matter of 
> taste.

I find the result of applying this patch much easier to read
than the original.

> +/*
> + * Process a regular file
> + */
> +static int process_file(const char *path, int len, struct stat *st)
> +{
> +	int pos = cache_name_pos(path, len);
> +	struct cache_entry *ce = pos < 0 ? NULL : active_cache[pos];
> +
> +	if (ce && S_ISDIRLNK(ntohl(ce->ce_mode)))
> +		return error("%s is already a gitlink, not replacing", path);
> +
> +	return add_one_path(ce, path, len, st);	
> +}

I may be missing the obvious but if I have a subproject at
"path/S" and I say "update-index path/S/Makefile", what should
happen?  There is ISDIRLNK entry at path/S and add_one_path()
would allow removal of "path/S" to make room for
path/S/Makefile, when --replace is given.
