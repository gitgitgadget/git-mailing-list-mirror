From: Kevin Smith <yarcs@qualitycode.com>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Mon, 18 Apr 2005 22:05:46 -0400
Message-ID: <4264677A.9090003@qualitycode.com>
References: <20050418210436.23935.qmail@science.horizon.com>	 <1113869248.23938.94.camel@orca.madrabbit.org>	 <42645969.2090609@qualitycode.com> <1113874931.23938.111.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Tue Apr 19 04:02:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNi45-0003XW-NC
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 04:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVDSCGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 22:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVDSCGN
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 22:06:13 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:11916 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S261269AbVDSCGC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 22:06:02 -0400
Received: from [10.10.10.20] (147-49.35-65.tampabay.res.rr.com [65.35.49.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id AE8583C12;
	Tue, 19 Apr 2005 02:05:53 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
To: Ray Lee <ray-lk@madrabbit.org>
In-Reply-To: <1113874931.23938.111.camel@orca.madrabbit.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ray Lee wrote:
> On Mon, 2005-04-18 at 21:05 -0400, Kevin Smith wrote:
> 
>>>>The other is "replace very instace of identifier `foo` with identifier`bar`".
>>>
>>>That could be derived, however, by a particularly smart parser [1].
>>
>>No, it can't. Seriously. A darcs replace patch is encoded as rules, not
>>effects, and it is impossible to derive the rules just by looking at the
>>results. Not difficult. Impossible.
> 
> 
> Okay, either I'm a sight stupider than I thought, or I'm not
> communicating well. Same net effect either way, I 'spose.
> 
> If I do a token replace in an editor (say one of those fancy new-fangled
> refactoring thangs, or good ol' vi), a token-level comparator can
> discover what I did. That link I sent is an example of one such beast.

The big feature of a darcs replace patch is that it works forward and
backward in time. Let me try to come up with an example that can help
explain it. Hopefully I'll get it right. Let's start with a file like
this that exists in a project for which both you and I have darcs repos:

cat
dog
fish

Now, you change it to:

cat dog
dog
fish

while I simultaneously do a replace of "dog" with "plant", resulting in:

cat
plant
fish

We merge. The final result in both of our trees is:

cat plant
plant
fish

Notice that just by looking at my diffs, you can't tell that I used a
replace operation. I didn't just replace the instances of "dog" that
were in my file at that moment. I conceptually replaced all instances,
including ones that aren't there yet.

Now, I should mention here that I personally dislike the replace
operation, and I think it is more dangerous than helpful. However, other
darcs users are quite happy with it, and it certainly is a creative and
powerful feature.

Other creative patch types have also been dreamed of. For example, a
powerful language-specific refactoring operation has been discussed as a
far-future possibility. That would be safe, and cool.

>>Automated refactoring tools, for example, perform the
>>rename+modify as an atomic operation.
> 
> And that's harder, I agree. But unless I'm missing some nifty
> refactoring editor out there that integrates with darcs during the edit
> session, the user *still* has to tell the SCM about the rename manually.

Although there are no such nifty refactoring tools available today, they
will exist at some point. If they existed today, the world would be a
better place.

Even without tools, many shops have policies against checking in code
that won't compile. If you rename a java class, you must simultaneously
perform the rename and modify the class name inside. If you commit
between those steps, it's broken. [I do realize that the kernel doesn't
have java code, by the way.]

I should also mention that I currently believe that Linus is correct
that explicit rename tracking is not required for git. I have every hope
that his plan for handling the more general case of "moved text" will
take care of renames as a side effect. I don't know if that will be
sufficient to allow a two-way lossless gateway between git and darcs or
other systems that do track renames explicitly.

Kevin
