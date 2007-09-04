From: Andreas Ericsson <ae@op5.se>
Subject: Re: Calculating tree nodes
Date: Tue, 04 Sep 2007 17:14:40 +0200
Message-ID: <46DD7660.2030109@op5.se>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>	 <20070904025153.GS18160@spearce.org>	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>	 <Pine.LNX.4.64.0709040439070.28586@racer.site>	 <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com>	 <46a038f90709032121v54454c6fi500ee15497eec85c@mail.gmail.com>	 <9e4733910709032237y65ccafdai4889078533908fb0@mail.gmail.com>	 <Pine.LNX.4.64.0709041131030.28586@racer.site> <9e4733910709040731s2695ab14kb9750923fcac007@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:15:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISa7B-0008Lp-BN
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 17:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbXIDPOp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 11:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754523AbXIDPOp
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 11:14:45 -0400
Received: from mail.op5.se ([193.201.96.20]:37418 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579AbXIDPOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 11:14:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6BAFB194410;
	Tue,  4 Sep 2007 17:14:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zwoPoXIZ6uVr; Tue,  4 Sep 2007 17:14:41 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 6A0EA1943D3;
	Tue,  4 Sep 2007 17:14:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <9e4733910709040731s2695ab14kb9750923fcac007@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57595>

Jon Smirl wrote:
> On 9/4/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Tue, 4 Sep 2007, Jon Smirl wrote:
>>
>>> In my scheme the path info is moved into the file object nodes and the
>>> SHA list is in the commit node.
>> And how should this "SHA list" be any different from a single tree object,
>> except that you now merge it with the commit object?
>>
>> Really, go back to the mail Martin mentioned.  Having all objects in one
>> list kills performance.
> 
> You are ignoring the fact the in this scheme temp indexes can be
> created as needed. These temp indexes could look just like tree nodes.
> 

What's the cost associated with creating such an index?
What are the estimated savings in size?
What other performance penalties will git take due to this?

While I'm certainly interested in improving git (well, discussing its
improvements anyway - I write too shabby code to participate fully),
I fail to see how this scheme of storing things could help doing that,
seeing as it's already the fastest SCM out there and does an insanely
good job at storing large repositories packed up tight.

What you're proposing would effectively shave off ~4kb or so of stored
data and save a *possible* disk access (note that there will most
likely be none, as most users pack large repos, and for small ones it
shouldn't matter much either way). The way you propose to do so
involves fundamental and backwards-incompatible alterations to the
very core of the git plumbing.

Yet you haven't shown a single estimate of how much diskspace would
be saved, or what other gains are to be had, let alone any code to 
implement even a prototype of this new storage scheme.

Note that I'm currently in a state of mind where I'm feeling inclined
to whoop and cheer at every small suggestion that sounds even the
slightest bit of fun. No, I'm not doing drugs, but I just met the 
possible love of my life, got a big fat raise and my stocks just
went ballistic. Someone less fortunate than I am right now is probably
too bored to even argue against it.

> I'm saying that it may be a mistake to be recording the indexes (aka
> file names) as part of the commit when they really aren't.

But they are, since they're part of the snapshot.

> The
> essential part of the commit is the SHA1 list. The path names belong
> to the file objects and should be stored there.
> 

Sorry, but it'll take code and benchmarks to convince me this is a
good idea. Not that it matters much what I think, but I've got an
inkling Junio will need the same before he's swayed to your point
of view.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
