From: Andreas Ericsson <ae@op5.se>
Subject: Re: corrupt object on git-gc
Date: Fri, 09 Nov 2007 14:46:10 +0100
Message-ID: <473464A2.7080003@op5.se>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Yossi Leybovich <sleybo@mellanox.co.il>
To: Yossi Leybovich <sleybo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 14:46:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqUBr-0000Mu-NU
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 14:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759556AbXKINqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 08:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbXKINqQ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 08:46:16 -0500
Received: from mail.op5.se ([193.201.96.20]:54072 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529AbXKINqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 08:46:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7CC741F0871F;
	Fri,  9 Nov 2007 14:46:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1j7rRcVgAKUe; Fri,  9 Nov 2007 14:46:11 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 835A21F0871E;
	Fri,  9 Nov 2007 14:46:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64181>

Yossi Leybovich wrote:
> Yossi Leybovich wrote:
>>> Hi
>>>
>>>  I know its loose but still I think there are references in the
>>> repository to this object.
>>> How I can remove it from the repository ?
>>>
> 
>> That was not a very good idea. You just moved ALL objects whose hash
>> begin with 4b out of the object database.
> 
>> Try only moving the offending file out of the 4b directory.
> 
> Did not help still the repository look for this object?
> Any one know how can I track this object and understand which file is it
> 

Is this a super-secret project or you can make a tarball of the .git
directory and send it to me? Trying to track down the cause through
email is decidedly slow.

> 
> 
> ib]$ mv .git/objects/4b/9458b3786228369c63936db65827de3cc06200 ../
> 
> ib]$ git-fsck --full
> dangling commit 0d43a63623237385e432572bf61171713dcd8e98
> dangling commit 4fc6b1127e4a7f4ff5b65a2dd8a90779b5aff3e0
> dangling commit 7da607374fe2b1ae09228d2035dd608c73dad7c8
> dangling commit 004ef09ae022c60a30f9cd61f90d18df5db3628e
> dangling commit 85112c6fabb6b8913ab244a8645d67380616eba6
> broken link from    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
>              to    blob 4b9458b3786228369c63936db65827de3cc06200

One tree uses the object. I'm not sure if any commit-objects
use the tree. Try

for b in $(git branch --no-color -a | cut -b3-); do
for rev in $(git rev-list HEAD); do
	git ls-tree -r $rev | grep -q 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
	test $? -eq 0 && echo $rev && break
done
done

If it turns up empty, you *should* be able to safely delete
2d9263c6d23595e7cb2a21e5ebbb53655278dff8 and 
4b9458b3786228369c63936db65827de3cc06200

Make sure to take a backup first though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
