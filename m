From: Aaron Lehmann <aaronl@vitelus.com>
Subject: Re: Performance of various compressors
Date: Fri, 22 Apr 2005 13:38:01 -0700
Message-ID: <20050422203801.GE7437@vitelus.com>
References: <426734DE.3040606@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 22:34:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP4q9-0002Ya-Kv
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 22:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVDVUiF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 16:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVDVUiE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 16:38:04 -0400
Received: from dsl081-060-252.sfo1.dsl.speakeasy.net ([64.81.60.252]:14812
	"EHLO vitelus.com") by vger.kernel.org with ESMTP id S262125AbVDVUiC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 16:38:02 -0400
Received: from aaronl by vitelus.com with local (Exim 4.32)
	id 1DP4uX-0006bG-DM; Fri, 22 Apr 2005 13:38:01 -0700
To: Mike Taht <mike.taht@timesys.com>
Content-Disposition: inline
In-Reply-To: <426734DE.3040606@timesys.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2005 at 10:06:38PM -0700, Mike Taht wrote:
> That doing the compression at a level of 3, rather than the max of 9, 
> cuts the cpu time required for a big git commit by over half, and that 
> that actually translates into a win on the I/O to disk. (these tests 
> were performed on a dual opteron 842)

If (de)compression is slowing things down, you might want to check out
lzo (http://www.oberhumer.com/opensource/lzo/). I tested it on the
2.6.11 kernel source and found that lzo -7 output is only 2% larger
than gzip -3, but lzo decompression is almost 3 times faster. The
downside is that lzo took 5 times longer to perform the compression at
-7. Compression with lzo -3 is 3.5 times faster than gzip -3, but it
produces a file that's 37% bigger. Unfortunately, lzo has no settings
in between -3 and -7. I'd expect git to be more sensitive to
decompression speeds, though.

BTW, lzo decompression speed is not affected by the compression level.
