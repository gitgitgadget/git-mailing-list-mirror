From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: Tags
Date: Sun, 03 Jul 2005 02:04:19 +0200
Message-ID: <42C72B83.6030904@gmail.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com> <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com> <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com> <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com> <42C6D318.8050108@zytor.com> <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com> <42C6D5AD.9070304@zytor.com> <m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com> <42C7043C.9080904@zytor.com> <Pine.LNX.4.58.0507021432370.8247@g5.osdl.org> <42C70A5B.9070606@zytor.com> <Pine.LNX.4.58.0507021501450.8247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 02:04:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoryV-0005iS-6L
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 02:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVGCAEb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 20:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVGCAEb
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 20:04:31 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:3003 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261333AbVGCAEY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 20:04:24 -0400
Received: by rproxy.gmail.com with SMTP id r35so434352rna
        for <git@vger.kernel.org>; Sat, 02 Jul 2005 17:04:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iOpCB78w5sCJm8mPtOHF7B2yuhX0kbNZrRxbIdk6LRhEIW2veLmq6RukI7FbBHNuOOfKboLM5vSeL8+eewwi3umC1iCMfUbsispJiJQzsYpNwEEJ4A+eJ2lEmMwJW/efLSdCFrr0Rej7SZmlkeExmLPgfqNVduRegBIHA4q3hCw=
Received: by 10.38.151.38 with SMTP id y38mr1932467rnd;
        Sat, 02 Jul 2005 17:04:24 -0700 (PDT)
Received: from ?192.168.0.5? ([80.217.52.214])
        by mx.gmail.com with ESMTP id k21sm823378rnb.2005.07.02.17.04.21;
        Sat, 02 Jul 2005 17:04:24 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507021501450.8247@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> And a "tag ref" thing is really nothing more (and nothing less) than a
> branch. 

I'm guessing that this is the root of the confusion here. To you, and to 
git, a tag is just a another branch. And a tag object is pretty much a 
specialized commit object, that can't have children and only one parent.

But people seem to *expect* tags to be connected somehow to a specific 
repository. Or, rather, to a specific branch.

That's why people want e.g. cogito to get "all the tags" from 
torvalds/linux-2.6.git when they cg-pull.

 From git's point of view, that doesn't really make any sense; it's like 
saying that you should pull all the branches from a specific branch. But 
from a practical point of view, it *does* make sense if you hold the 
view that tags are connected to a branch, and that you should be able to 
diff against v2.6.12 as soon as you've pulled the latest head.

So why not add tags to the branch itself?

It should be pretty straightforward: just make git look for tag refs in, 
say, a .gittags tree in the current HEAD. The whole thing would pretty 
much as if you've symlinked .git/refs/tags to .gittags in the current 
working tree, except that tag refs would have to be read directly from 
the repository.

That way, tag refs could be handled pretty much just like any other 
git-managed file: they can be added, deleted, changed, merged, 
committed, etc. We could track their history, and see who tagged what 
and when.

And tags could easily be signed and contain arbitrary text, just like 
the present day tag objects, as long as they start with a sha1 ref.

This way, a git branch could have public, shared tags, with a minimum of 
hassle. No special-casing needed for storage or transfer.

And there would be no room for conflicting tag names (but you could 
easily use the same name in different branches, just as any file can 
differ in content between two branches).

It might be useful, though, to add some syntax for "tag in a specific 
branch", say <branch-name>@<tag-name>.

The present tagging mechanism should be kept. It is useful for private 
tagging, and may be useful for signalling that "this is a branch that is 
unlikely to change".

So, am I missing something obvious here?

/dan
