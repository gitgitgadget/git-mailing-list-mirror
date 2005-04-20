From: Tomas Mraz <t8m@centrum.cz>
Subject: Re: [Gnu-arch-users] Re: [GNU-arch-dev] [ANNOUNCEMENT] /Arch/
	embraces `git'
Date: Thu, 21 Apr 2005 00:40:48 +0200
Message-ID: <1114036849.5880.61.camel@perun.redhat.usu>
References: <200504201000.DAA04988@emf.net>  <877jixfjxw.fsf@star.lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gnu-arch-dev@lists.seyza.com, talli@museatech.net,
	git@vger.kernel.org, torvalds@osdi.org
X-From: git-owner@vger.kernel.org Thu Apr 21 00:36:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DONoN-0001Vm-OB
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 00:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVDTWlB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 18:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVDTWlA
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 18:41:00 -0400
Received: from prazak.kkcable.cz ([213.29.14.4]:648 "EHLO perun.redhat.usu")
	by vger.kernel.org with ESMTP id S261827AbVDTWkx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 18:40:53 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by perun.redhat.usu (Postfix) with ESMTP id AE0F42E3B6;
	Thu, 21 Apr 2005 00:40:49 +0200 (CEST)
To: duchier@ps.uni-sb.de
In-Reply-To: <877jixfjxw.fsf@star.lifl.fr>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-04-20 at 19:15 +0200, duchier@ps.uni-sb.de wrote:
...
> As data, I used my /usr/src/linux which uses 301M and contains 20753 files and
> 1389 directories.  To compute the key for a directory, I considered that its
> contents were a mapping from names to keys.
I suppose if you used the blob archive for storing many revisions the
number of stored blobs would be much higher. However even then we can
estimate that the maximum number of stored blobs will be in the order of
milions.

> When constructing the indexed archive, I actually stored empty files instead of
> blobs because I am only interested in overhead.
> 
> Using your suggested indexing method that uses [0:4] as the 1st level key and
                                                 [0:3]
> [4:8] as the 2nd level key, I obtain an indexed archive that occupies 159M,
> where the top level contains 18665 1st level keys, the largest first level dir
> contains 5 entries, and all 2nd level dirs contain exactly 1 entry.
Yes, it really doesn't make much sense to have so big keys on the
directories. If we would assume that SHA1 is a really good hashing
function so the probability of any hash value is the same this would
allow storing 2^16 * 2^16 * 2^16 blobs with approximately same directory
usage.

> Using Linus suggested 1 level [0:2] indexing, I obtain an indexed archive that
                                [0:1] I suppose
> occupies 1.8M, where the top level contains 256 1st level keys, and where the
> largest 1st level dir contains 110 entries.
The question is how many entries in directory is optimal compromise
between space and the speed of access to it's files.

If we suppose the maximum number of stored blobs in the order of milions
probably the optimal indexing would be 1 level [0:2] indexing or 2
levels [0:1] [2:3]. However it would be necessary to do some
benchmarking first before setting this to stone.

-- 
Tomas Mraz <t8m@centrum.cz>

