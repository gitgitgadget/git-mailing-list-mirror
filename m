From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Introduce patch factorization in diffcore.
Date: Fri, 26 Sep 2008 00:39:54 +0200
Message-ID: <48DC133A.7010805@op5.se>
References: <20080925213819.27029.47944.stgit@gandelf.nowhere.earth> <20080925214707.27029.36260.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 00:41:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KizWR-0003ls-Fj
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 00:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbYIYWkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 18:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755422AbYIYWkG
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 18:40:06 -0400
Received: from mail.op5.se ([193.201.96.20]:42620 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755017AbYIYWkF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 18:40:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 55EC624B0013;
	Fri, 26 Sep 2008 00:30:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.137
X-Spam-Level: 
X-Spam-Status: No, score=-3.137 tagged_above=-10 required=6.6
	tests=[AWL=-0.638, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gOFLZEudH4aS; Fri, 26 Sep 2008 00:30:46 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 5F47C1B80081;
	Fri, 26 Sep 2008 00:30:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080925214707.27029.36260.stgit@gandelf.nowhere.earth>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96811>

Yann Dirson wrote:
>  "                try unchanged files as candidate for copy detection.\n" \
> +"  --factorize_renames\n" \
> +"                factorize renames of all files of a directory.\n" \


Use dashes to separate words in arguments, please.


>  
> +#include <libgen.h>
> +

 +#ifdef basename
 +# undef basename
 +#endif

We might as well use the GNU version of basename() at least. Even if
you don't use it, I'd rather not see this bite some unwary programmer
coming along after you. Worst case scenario, sha1's won't add up if
POSIX basename alters its argument, making for one fiendishly tricky
bug to find.

> +/*
> + * FIXME: we could optimize the 100%-rename case by preventing
> + * recursion to unfold what we know we would refold here.
> + * FIXME: do we want to replace linked list with sorted array ?

Either that or a hash. Most of the time seems to be spent in lookups.
With a hash you get quick lookups and reasonably quick inserts. With
a sorted array you get lower memory footprint than anything else and
can bisect your way to the right entry, which performs reasonably
close to skiplists. The sort overhead might be a deterrant factor,
but insofar as I understand it trees are always sorted in git anyway,
so perhaps that'd be the best solution.

Apart from that, I'd need to apply the patch to review it properly,
and I'm far too tired for that now.

I like the direction this is going though, so thanks a lot for doing
it :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
