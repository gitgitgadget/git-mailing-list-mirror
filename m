From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tags
Date: Sat, 2 Jul 2005 15:17:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507021501450.8247@g5.osdl.org>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 00:19:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoqL3-0006kt-Ez
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 00:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVGBWTL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 18:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVGBWTL
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 18:19:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261313AbVGBWRZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 18:17:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j62MHDjA027946
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 2 Jul 2005 15:17:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j62MH8Ss012191;
	Sat, 2 Jul 2005 15:17:10 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C70A5B.9070606@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 2 Jul 2005, H. Peter Anvin wrote:
> 
> OK, so let me retell what I think I hear you say:
> 
> - Store all the tags in the object store; they may conflict.

No. They cannot conflict.

A git "tag object" cannmot conflict in any way. It is just a generic 
"pointer object", and like all other objects, it is defined by its 
contents, and there are no "conflicts". If two people have exactly the 
same pointer, they'll just have the same object - that's not a conflict, 
that's just a fact of life with content-addressable filesystems.

The git "tag object" contains a suggested symbolic name, but that actually 
has no meaning except as being informational. So for example:

	[torvalds@g5 linux]$ git-cat-file tag v2.6.12
	object 9ee1c939d1cb936b1f98e8d81aeffab57bae46ab
	type commit
	tag v2.6.12
	
	This is the final 2.6.12 release
	-----BEGIN PGP SIGNATURE-----
	Version: GnuPG v1.2.4 (GNU/Linux)
	
	iD8DBQBCsykyF3YsRnbiHLsRAvPNAJ482tCZwuxp/bJRz7Q98MHlN83TpACdHr37
	o6X/3T+vm8K3bf3driRr34c=
	=sBHn
	-----END PGP SIGNATURE-----

here the "symbolic name" is "v2.6.12", but that's purely informational, 
and nothing at all cares if a million people have made their own tags that 
have that same tag-name. The git _object_ is:

	[torvalds@g5 linux]$ git-rev-parse v2.6.12
	26791a8bcf0e6d33f43aef7682bdb555236d56de

and that object name is going to be unique (modulo hash collissions)

> - Let each source user have a set of refs, and provide a method for the 
> end user to select which refs to get.

Right. Let users have any damn refs they want. They may be refs to tags
objects, but they may just be direct refs to the commit. The tag object 
really has no meaning to git, except it allows signing. That's really the 
_only_ thing a tag object does: it introduces trust. There's no other 
reason to ever use one, really.

And a "tag ref" thing is really nothing more (and nothing less) than a
branch. It's a 41-byte filename, although if you actually were to have a
"gitforge" deamon, it could also be just the raw 20-byte SHA1 in a
database. Let people have their own refs, and have some good way to create
them and delete them, and copy them from others (and refer to other
peoples refs - one common usage might be "I want to merge with that other
users ref 'xyzzy'".

Note that the .git/refs/tags/xxx files are _literally_ treated exactly the 
same as the same files under "heads". Or under "mydir". Git really doesn't 
care, it's purely syntactic sugar. To git, a ref is a ref is a ref. It 
just refers to an object, and it's nothing more than a way to specify some 
random SHA1 at any time.

> In other words, the only way (other than knowing what GPG keys to trust) 
> to distinguish between your "v2.6.12" and J. Random Hacker's "v2.6.12" 
> is that the former is referenced by *your* refs as opposed to JRH's 
> refs.  This also means the refs cannot be uniquely rebuilt from the 
> object storage.

Right. All the refs are personal and "fleeting" - some refs are actively
changed all the time (branch refs - aka "heads" - get updated when you
update the branch). Tags are really the same way in all technical ways,
and the only real difference between a "branch ref" and a "tag ref" is
your _expectation_ of them - one you expect to be mostly stable, the other
you expect to be updated with development. _Technically_ there's no
difference between the two, though.

(And you might also change tag contents occasionally. One reason might be
a bug and you decide to re-tag something else. But a more common reason
might be because you want to have tags like "latest" that don't actually
update with development, but they update with some other event, like a
release event or some automated test cycle completion or something like
that. So tags aren't _immutable_ even from an expectation standpoint, 
it's just that they tend to change _less_).

Now, from tag _objects_ (as opposed to tag refs) you _can_ build them if
somebody created a tag object, and you have the signature so that you can
re-associate the tag-name with the person. But you should consider that a
pretty heavy and unusual case. The normal case is that you just want to
back up peoples refs. They're like a part of a personal ".gitrc": you
could equally well think of them as "these are my shorthands, because I
don't want to talk about 40-digit hex numbers all the time". It's nothing
more than a personal address book, really.

		Linus
