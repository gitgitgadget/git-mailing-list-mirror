From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tags
Date: Sat, 2 Jul 2005 17:17:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507021656250.8247@g5.osdl.org>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com>
 <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com>
 <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com>
 <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com>
 <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com>
 <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com>
 <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com> <42C6D318.8050108@zytor.com>
 <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com> <42C6D5AD.9070304@zytor.com>
 <m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com> <42C7043C.9080904@zytor.com>
 <Pine.LNX.4.58.0507021432370.8247@g5.osdl.org> <42C70A5B.9070606@zytor.com>
 <42C70EEF.6050207@gmail.com> <Pine.LNX.4.58.0507021517220.8247@g5.o
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 02:18:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DosBh-0006jM-Pq
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 02:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVGCASO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 20:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVGCASO
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 20:18:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261335AbVGCASD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 20:18:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j630HmjA002811
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 2 Jul 2005 17:17:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j630Hhph015763;
	Sat, 2 Jul 2005 17:17:45 -0700
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <42C727FC.3030900@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 2 Jul 2005, A Large Angry SCM wrote:
>
> Linus Torvalds wrote:
> > 
> > None of git itself normally has any "trust". The SHA1 means that the 
> > _integrity_ of the archive is ensured, but for some things (notably 
> > releases), you want to have something else. That's the "tag object".
> > 
> 
> But can't the commit object do this just as well by signing the commit text?

Yes and no.

Technically yes, absolutely, you could add a signature to the commit text.

However, that's just wrong for several reasons:

First off, the signing is not necessarily done by the person committing
something. Think of any paperwork: the person that signs the paperwork is 
not necessarily the same person that _wrote_ the paperwork. A signature is 
a "witness".

For an example of this, look at the signatures that we've had for a long 
time on kernel.org: check out the files like "patch-2.6.8.1.sign". That's 
a signature, but it's not a signature by _me_. It's kernel.org signing the 
thing so that downstream people can verify things.

And it would be not only wrong, but literally _impossible_ for me to do it 
in the commit. I don't have (or want to have) the kernel.org private key. 
That's not what the signature is about. kernel.org is signing that "this 
is what I got, and what I passed on". It's not signing that "this is what 
I wrote".

In a lot of systems, you tag something good after it has passed a
regression test. Ie the _tag_ may happen days or even weeks after the
commit has been done.

So any system that signs commits directly is doing something _wrong_. 

Secondly, you can say that you trust other things. In git, you can tag 
individual blobs, and you can tag individual trees. For an example of 
where it makes sense to tag (sign) individual file versions, we've 
actually had things like ISDN drivers (or firmware) that passed some telco 
verification suite, and in certain countries it used to be that you 
weren't legally supposed to use hadrware that hadn't passed that suite. In 
cases like that, you could sign the particular version of the driver, and 
say "this one is good".

(Yeah, those laws are happily going away, but I think the ISDN people in 
germany actually ended up doing exactly that, except they obviously didn't 
use git signatures. I think they had a list of file+md5sum).

Finally, it's a tools issue. It's wrong to mix up the notion of committing 
and signing in the same thing, because that just complicates a tool that 
has to be able to do both. Now you can have a nice graphical commit tool, 
and it doesn't need to know about public keys etc to be useful - you can 
use another tool to do the signing.

Small is beautiful, but "independent" is even more so.

> Your tendency is to use tag objects as a permanent, public label of some 
> state. Signing the commit text or the email stating that commit 
> ${COMMIT_SHA} would work just as well for verification purposes.

Well, according to that logic, you'd never need signatures at all - you 
can always keep them totally outside the system.

But if they are totally outside the system, then you have to have some
other mechanism to track them, and you can never trust a git archive on
its own. My goal with the tag objects was that you can just get my git
archive, and the archive is _inherently_ trustworthy, because if you care,
you can verify it without any external input at all (except you need to
know my public key, of course, but that's not a tools issue any more,
that's about how signatures work).

So by having tag objects, I can just have refs to them, and anything that 
can fetch a ref (which implies _any_ kind of "pull" functionality) can get 
it. No special cases. No crap.

Do one thing, and do it well. Git does objects with relationships. That's 
really what git is all about, and the "tag object" fits very well into 
that mentality.

		Linus
