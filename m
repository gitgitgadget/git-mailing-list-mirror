From: Paul Jackson <pj@sgi.com>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 10:40:22 -0700
Organization: SGI
Message-ID: <20050426104022.0c53167d.pj@sgi.com>
References: <20050426032422.GQ13467@pasky.ji.cz>
	<426DBF94.3010502@timesys.com>
	<20050426122304.GD18971@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: mike.taht@timesys.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 19:57:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUHY-0002ze-DG
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 19:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVDZRt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 13:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDZRsP
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 13:48:15 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11225 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261505AbVDZRkw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 13:40:52 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3QI5NV4014191;
	Tue, 26 Apr 2005 11:05:26 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3QHeP5w18646884;
	Tue, 26 Apr 2005 10:40:25 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050426122304.GD18971@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> some way to deal with renames sensibly. 

For a Linux kernel merge tool that I did inside SGI, I come to the
conclusion the following heuristics identified renames fairly
accurately, coming up with the same renames as a careful manual
examination.

The key heuristic was to consider one file A to be a rename of another B
if the size (number of lines) of the diff of A and B (diff -auw A B | wc
-l) is less than 50% of the combined size of A and B (cat A B | wc -l).

Only pathname pairs with the same basename were considered - I was
focused here on renames due to directory restructuring.  I'm not sure
now if this is a good assumption - but it sure saved some computation.

Any file with the string "Makefile" in its name had to be excluded from
consideration.

In case of multiple potential renames (say one file is copied to two
places, removing the original and modifying each copy a little), the
'best' rename was selected, where 'best' meant the lowest ratio of
diff 'diff -auw' size to combined 'cat' size.

The end result of the above was a fairly natural identification of
renames.  If say I moved kernel/cpuset.c to mm/cpuset.c and changed
it a little bit, the above heuristics would show a rename, plus
a few changes.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
