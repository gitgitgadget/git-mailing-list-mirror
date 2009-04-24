From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 16:24:04 -0400
Message-ID: <20090424202403.GB13561@coredump.intra.peff.net>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com> <20090424141847.GD10761@coredump.intra.peff.net> <91225E09-505A-4CD6-AC8E-FBB500A95984@boostpro.com> <20090424181539.GB11360@coredump.intra.peff.net> <0FC64949-689C-43A4-B656-9618E808962B@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 22:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxRxz-0001lO-2n
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 22:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbZDXUYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 16:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbZDXUYN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 16:24:13 -0400
Received: from peff.net ([208.65.91.99]:38413 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbZDXUYN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 16:24:13 -0400
Received: (qmail 31210 invoked by uid 107); 24 Apr 2009 20:24:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 16:24:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 16:24:04 -0400
Content-Disposition: inline
In-Reply-To: <0FC64949-689C-43A4-B656-9618E808962B@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117485>

On Fri, Apr 24, 2009 at 03:00:19PM -0400, David Abrahams wrote:

>> How did you find out about them?
>
> The first time?
>
>  $ man git
>
> [...]
>
> which makes no distinction [between porcelain and plumbing].

Really? The command list in my version is divided into "HIGH-LEVEL
COMMANDS (PORCELAIN)" and "LOW-LEVEL COMMANDS (PLUMBING)", with the
commands you mentioned falling into the latter. And skimming "git log
Documentation/git.txt", it looks like it has been that way for some
time.

There is a little discussion under the plumbing section of what plumbing
is. It could perhaps be more emphatic in warning regular users away.

>> They are not in your PATH, so shell
>> completion doesn't find them.
>
> Huh?  `which git` works.  ls-tree is an argument to git as far as I know.

Yes, but shell completion will never present you with the text
"ls-tree". You have to have found out about it somewhere else (and
completion used to show, because git-ls-tree was in the PATH).

>   $ xxx [--]help
>
> is usually OK if I already know xxx pretty well and just want a  
> refresher.  If know I'll need a little more than that, I use man straight 
> away.

git --help shows a list of common commands, but otherwise "git help
foo" and "git foo --help" _do_ show the manpage. It may be that "man
git" could use some cleanup; specific suggestions are welcome.

> What is "porcelain," please?  This is one among many examples of jargon 
> used only (or encountered by me for the first time) in the Git community.

I think I ended up explaining it later in my email, but let me know if
you are still confused.

>> The idea was to give a uniform calling convention without
>> unnecessarily confusing users by presenting a large number of
>> infrequently-used commands.
>
> It's not working, I'm sorry to say.

Right, that's why I'm trying to figure out why you are hung up on the
low-level commands. The idea was that you wouldn't need to be exposed to
them at all, but obviously you were (or if you were exposed, it would be
in a list that was clearly marked as "this is low-level stuff that you
don't really need to worry about". So I'm trying to figure out where it
went wrong.

>> At any rate, it is too late to change the calling convention for
>> plumbing.
>
> I disagree.  You can leave the old functionality there in a "deprecated" 
> state and change the way you advertise it.

But does that really help? It means that "git hash-object" is still
there, which I thought was the problem you had. You can argue that it
wouldn't be advertised to users, and so wouldn't be a problem, but that
is _already_ the strategy we are using. So either that strategy is fine,
in which case we are on the right track but may still have some work to
do in properly implementing it. Or it's not, in which case your proposal
is no better.

> It would even help a lot if the plumbing were all spelled "git-xxx"
> and the high level stuff were "git xxx."

Differentating calling conventions like that was proposed when dashed
forms were deprecated and removed from the PATH. But if we had dashed
forms for plumbing (i.e., not forwarding them via the "git" wrapper),
then you have to do one of:

  - put them in the user's PATH. Now tab completion or looking in your
    PATH means you see _just_ the plumbing commands, and none of the
    high level ones. Which is one of the reasons they were removed from
    the PATH in the first place (due to numerous user complaints).

  - put them elsewhere, and force plumbing users to add $GIT_EXEC_PATH
    to their PATH. That becomes very annoying for casual plumbing users.
    If you come to the mailing list with a problem, I would have to jump
    through extra hoops to ask you to show me the output of "git
    ls-files".

Not to mention that the git wrapper does other useful things besides
simply exec'ing. For example, it supports --git-dir, --bare, etc.
So the problem is that the low-level commands _are_ still useful, and
many people still want to call them, just like regular git commands.
It's just that they are numerous and low-level, which makes them
daunting for new users.

And it has become obvious over several years of the git mailing list
that users, once they see mention of a command, must start investigating 
it to find out if and how it is useful. And I am not saying that is a
failing of users; on the contrary, I think it is quite a healthy
behavior on a unix-ish system. But it means that if we want not to
advertise low-level commands, we have to be very careful about the ways
in which we mention them.

Perhaps it would make sense for each plumbing command's man page to
start with something like "this is a low-level command used for
scripting git or investigating its internals. For high-level use, you
may be more interested in $X", where $X may be "git commit" for
write-tree, commit-tree, etc. And that would at least help intercept
users before they get too confused.

>>> [excuse me, but what the #@&*! is "porcelainish" supposed to mean?
>>> (http://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html)]
>>
>> Heh. That one is particularly egregious, because it rests on several
>> layers of git jargon. The low-level tools are plumbing, like pipes and
>> valves.
>
> ? I use the valves on my kitchen sink all the time.

Sorry, I meant the ones under the sink, that you would use if you were
replacing the faucet. I would call the ones above "taps". But hopefully
you get a sense of the distinction between plumbing and porcelain.

-Peff
