From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git's database structure
Date: Wed, 5 Sep 2007 18:31:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709051823470.26016@reaper.quantumfyre.co.uk>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
 <7vtzqany0z.fsf@gitster.siamese.dyndns.org>
 <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
 <20070904212507.GA24434@thunk.org> <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>
 <46DE5861.4050201@op5.se> <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
 <46DEC26E.7030809@op5.se> <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com>
 <Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk>
 <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andreas Ericsson <ae@op5.se>, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 19:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISyjz-0006vy-6M
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 19:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbXIERbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 13:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755383AbXIERbr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 13:31:47 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:37289 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754943AbXIERbq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2007 13:31:46 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 8A91877B3FD
	for <git@vger.kernel.org>; Wed,  5 Sep 2007 18:31:44 +0100 (BST)
Received: (qmail 8431 invoked by uid 103); 5 Sep 2007 18:31:43 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91.2/4156. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.031175 secs); 05 Sep 2007 17:31:43 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 5 Sep 2007 18:31:43 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57724>

On Wed, 5 Sep 2007, Jon Smirl wrote:

> On 9/5/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
>> On Wed, 5 Sep 2007, Jon Smirl wrote:
>>
>>> On 9/5/07, Andreas Ericsson <ae@op5.se> wrote:
>>>> Jon Smirl wrote:
>>>>>
>>>>> The path name field needs to be moved back into the blobs to support
>>>>> alternative indexes. For example I want an index on the Signed-off-by
>>>>> field. I use this index to give me the SHAs for the blobs
>>>>> Signed-off-by a particular person. In the current design I have no way
>>>>> of recovering the path name for these blobs other than a brute force
>>>>> search following every path looking for the right SHA.
>>>>>
>>>>
>>>> Ah, there we go. A use-case at last :)
>>
>> But not a brilliant one.  You sign off on commits not blobs.  So you go
>> from the sign-off to paths, then to blobs.  There is no need to go from
>> blob to path unless you deliberately introduce such a need.
>
> Use blame for an example. Blame has to crawl every commit to see if it
> touched the file. It keeps doing this until it figures out the last
> author for every line in the file. Worse case blame has to crawl every
> commit in the data store.

And this is advantaged by having the path in the blob how?  The important 
information here is knowing which commits touched the file - this 
information is expensive in git because it is snapshot based.  You have to 
go back through all the commits looking for changes to the given path. 
The information you might want to cache is which commits touched the file, 
which you could do without changing the current data storage. Presumably 
you are suggesting that such a cache would be cleaner with the filename in 
the blob?  Or do you think that it would somehow be faster to create?  If 
so, how?

-- 
Julian

  ---
Humor in the Court:
Q: (Showing man picture.) That's you?
A: Yes, sir.
Q: And you were present when the picture was taken, right?
