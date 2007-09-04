From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git's database structure
Date: Tue, 04 Sep 2007 18:29:50 +0200
Message-ID: <46DD87FE.7020007@op5.se>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>	 <46DD7FE4.1060908@op5.se> <9e4733910709040919u3d252b91s2785ed4d20086c88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:30:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISbHr-0002kz-NL
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbXIDQ3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbXIDQ3z
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:29:55 -0400
Received: from mail.op5.se ([193.201.96.20]:40117 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbXIDQ3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:29:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4FE95194412;
	Tue,  4 Sep 2007 18:29:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xBmBCFo4pUQR; Tue,  4 Sep 2007 18:29:51 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 8A2861943F9;
	Tue,  4 Sep 2007 18:29:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <9e4733910709040919u3d252b91s2785ed4d20086c88@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57611>

Jon Smirl wrote:
> On 9/4/07, Andreas Ericsson <ae@op5.se> wrote:
>> Jon Smirl wrote:
>>> Let's back up a little bit from "Caclulating tree node".  What are the
>>> elements of git's data structures?
>>>
>>> Right now we have an index structure (tree nodes) integrated in to a
>>> base table. Integrating indexing into the data is not normally done in
>>> a database. Doing a normalization analysis like this may expose flaws
>>> in the way the data is structured. Of course we may also decide to
>>> leave everything the way it is.
>>>
>>> What about the special status of a rename? In the current model we
>>> effectively have three tables.
>>>
>>> commit - a set of all SHAs in the commit, previous commit, comment, author, etc
>>> blob - a file, permissions, etc.
>>> file names - name, SHA
>> commit - SHA1 of its parent(s) and its root-tree, along with
>>          author info and a free-form field
>> blob - content addressable by *multiple trees*
>> file names - List of path-names inside a tree object.
>>
>>
>> To draw some sort of relationship model here, you'd have
>>
>> commit 1<->M roottree
>> tree M<->M tree
>> tree M<->M blob
> 
> By introducing tree nodes you have blended a specific indexing scheme
> into the data. There are many other ways the path names could be
> indexed hash tables, binary trees, etc.
> 
> This problem exists in files systems. Since the path names have been
> encoded into the directory structures there is no way to query
> something like "all files created yesterday" from a file system
> without building another mapping table or a brute force search. I keep
> using Google as an example, Google is indexing hierarchical URLs but
> they do not use a hierarchical index to do it.
> 

Pathnames are by far the most common search-/delimiting criteria for
git though, so I fail to see why this is a problem for you.

> Databases keep the knowledge of how things are indexed out of the
> data. A data structure analysis of git should remove the blended index
> and start from the set theory.
> 

Why? This is the core of the problem, really. You haven't specified a
single, real-life reason *why* it should be any other way than it
already is. It sounds a bit to me as if you've been to a really
inspiring seminar about "how database-like things *should* be done"
and then decided to go berserk on your favourite database-like thing,
which is git.

Code and benchmarks or bust. In the meantime, I'll settle for a recount
of what problems you're having with the current layout, or what gains
you're hoping to achieve with the new one. As it's the 3rd time I'm
asking, this'll be the last.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
