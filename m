From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Introduce patch factorization in diffcore.
Date: Fri, 26 Sep 2008 21:21:08 +0200
Message-ID: <20080926192108.GC17458@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20080925213819.27029.47944.stgit@gandelf.nowhere.earth> <20080925214707.27029.36260.stgit@gandelf.nowhere.earth> <48DC133A.7010805@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Sep 26 21:20:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjIrk-0003ps-6c
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 21:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbYIZTT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 15:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbYIZTT0
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 15:19:26 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51963 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbYIZTTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 15:19:25 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E49351AB2E2;
	Fri, 26 Sep 2008 21:19:23 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id C4E0C1AB312;
	Fri, 26 Sep 2008 21:19:23 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id CA4841F0C2; Fri, 26 Sep 2008 21:21:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48DC133A.7010805@op5.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96884>

On Fri, Sep 26, 2008 at 12:39:54AM +0200, Andreas Ericsson wrote:
> Yann Dirson wrote:
>>  "                try unchanged files as candidate for copy detection.\n" \
>> +"  --factorize_renames\n" \
>> +"                factorize renames of all files of a directory.\n" \
>
>
> Use dashes to separate words in arguments, please.

Fortunately, the typo only made it to the help string, thanks for
catching it :)

>>  +#include <libgen.h>
>> +
>
> +#ifdef basename
> +# undef basename
> +#endif
>
> We might as well use the GNU version of basename() at least. Even if
> you don't use it, I'd rather not see this bite some unwary programmer
> coming along after you. Worst case scenario, sha1's won't add up if
> POSIX basename alters its argument, making for one fiendishly tricky
> bug to find.

I'll look into that, thanks

>> +/*
>> + * FIXME: we could optimize the 100%-rename case by preventing
>> + * recursion to unfold what we know we would refold here.
>> + * FIXME: do we want to replace linked list with sorted array ?
>
> Either that or a hash. Most of the time seems to be spent in lookups.
> With a hash you get quick lookups and reasonably quick inserts. With
> a sorted array you get lower memory footprint than anything else and
> can bisect your way to the right entry, which performs reasonably
> close to skiplists. The sort overhead might be a deterrant factor,
> but insofar as I understand it trees are always sorted in git anyway,
> so perhaps that'd be the best solution.

Thanks for this insight - I'll wait before changing the data structure,
since the current implementation may need to be able to recurse (consider
renamed subdirs as well as renamed files).

> Apart from that, I'd need to apply the patch to review it properly,
> and I'm far too tired for that now.
>
> I like the direction this is going though, so thanks a lot for doing
> it :)

Great :)

Best regards,
-- 
Yann
