From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 14:15:39 -0400
Message-ID: <20090424181539.GB11360@coredump.intra.peff.net>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com> <20090424141847.GD10761@coredump.intra.peff.net> <91225E09-505A-4CD6-AC8E-FBB500A95984@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 20:17:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxPxk-0007ZY-GI
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 20:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758825AbZDXSPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 14:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757599AbZDXSPs
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 14:15:48 -0400
Received: from peff.net ([208.65.91.99]:46756 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbZDXSPs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 14:15:48 -0400
Received: (qmail 30516 invoked by uid 107); 24 Apr 2009 18:15:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 14:15:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 14:15:39 -0400
Content-Disposition: inline
In-Reply-To: <91225E09-505A-4CD6-AC8E-FBB500A95984@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117477>

On Fri, Apr 24, 2009 at 01:28:35PM -0400, David Abrahams wrote:

>> I think this is a bit better than it used to be. Plumbing commands are
>> mostly hidden outside of the user's PATH.
>
> Huh?
>
> git hash-object
> git cat-file -t ...
> git ls-tree
> git rev-parse
> git write-tree
> git commit-tree

How did you find out about them? They are not in your PATH, so shell
completion doesn't find them. They are not in the programmable bash
completion. They are not in the short command list git gives you when
you type "git help" or "git" without arguments.

So you must have read about them somewhere...

> These are just some of the ones I learned about by reading John Wiegley's 
> "Git From the Bottom Up."

...like here. So if that document gave you the impression that those are
part of an everyday git workflow, then I think the document is at fault,
not git itself.

I admit I haven't read "Git From the Bottom Up" carefully, but I think
what Michael is proposing would probably start a little higher from the
bottom than that document. You can give the concepts of the object
types, show them in pretty-printed form with "git show", and not worry
about telling the user "this is how 'git commit' could be implemented in
terms of primitive operations". And then you can avoid most of the
low-level commands entirely.

> Maybe I'm wrong about rev-parse, but for the most part, having all these 
> low-level commands available through the same executable that's used for 
> "git add," "git merge," "git commit," et. al. makes the whole shebang hard 
> to approach.  It would be better for users if the low-level stuff was 
> accessed some other way.

Perhaps. The general approach is to make those commands accessible as
"git foo", but not to _advertise_ them in the same way as the porcelain
commands. The idea was to give a uniform calling convention without
unnecessarily confusing users by presenting a large number of
infrequently-used commands.

At any rate, it is too late to change the calling convention for
plumbing. The whole point of them is to be a stable interface for
scripting. Changing them to "git low-level rev-parse" (if it was even
something that we wanted to do, which I don't think it is) would break
everyone's scripts.

>> A lot of that is historical baggage. The original git was not a VCS but
>> rather a _toolkit_ for building a VCS. So the natural place for talking
>> about parsing revisions was rev-parse, because that was the only way to
>> access the revision parsing code. :)
>
> I understand that, but it doesn't change the present reality.

Right. I'm just trying to say how we got here, which I think is relevant
because it gives a hint of what directions we can go in. In other words,
nobody _designed_ what we have now. It evolved into this state, which
obviously has some drawbacks. So I think you won't find much resistance
in trying to evolve the documentation to present git more as a coherent
tool, and less as a set of unrelated commands.

> [excuse me, but what the #@&*! is "porcelainish" supposed to mean? 
> (http://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html)]

Heh. That one is particularly egregious, because it rests on several
layers of git jargon. The low-level tools are plumbing, like pipes and
valves. The high-level commands intended for end users are porcelain,
like sinks and toilets. The -ish suffix is often used in git to refer to
a type, or something we can convert into a type (like a "tree-ish" could
be a tree object, or a commit object which points to a tree, or a tag
object which points to a commit which points to a tree). So I think by
saying "porcelain-ish" here, the author meant "not just porcelain, but
other things which take revisions and behave sort of like porcelain".

Which is a truly horrible thing to throw at a new user who just wants to
see how to specify a revision.

So yeah, if you are saying that could be worded better, I absolutely
agree. There are a lot of spots like that. They are getting fixed slowly
over time. I'm not sure if that is enough, or if somebody knowledgeable
really needs to take a sledge hammer to the existing documentation and
just reorganize and rewrite a lot of it.

-Peff
