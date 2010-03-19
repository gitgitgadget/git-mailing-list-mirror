From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Fri, 19 Mar 2010 14:32:59 -0400
Message-ID: <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 19:33:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsh0h-0004ZI-2S
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 19:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab0CSSdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 14:33:21 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51102 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab0CSSdU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 14:33:20 -0400
Received: by gwaa12 with SMTP id a12so1471235gwa.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=eTTPAk+QVR3zrGgaokII7AUCyPuZi2oIMb0dRigIoKY=;
        b=MGSl4WPWtAYkVp//jwdBKNdYic6obEUNrgkfyXBpEanMvROu5oIRd8xgQNitCQfyi4
         M04sE9zWkWOGYiWkNVt9vDAGS6xAGSKaS71cYlU+ixT7znc7m0eIHOd5cYrAUGipriMQ
         X85DYJJq9WUTf593iBv/dhN3BD37QJy3KJGq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=QRPrqYuC7cYjvtbkgaU2DzqI57+uuTOXOizYVyclw7FEFOXWsq0zFlPmxcpeUAs7zb
         GNvDEKYg0hCMRmb+OXgyveAeWvgJKD+hQT6TtsWP/B74RGmpGbj2S5UlHuVb7v/V5scF
         onYDngYQvHtRGBQB2WphhJQ2v27dW6H3TW3Is=
Received: by 10.150.242.40 with SMTP id p40mr5172856ybh.205.1269023599079; 
	Fri, 19 Mar 2010 11:33:19 -0700 (PDT)
In-Reply-To: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142628>

On Fri, Mar 19, 2010 at 1:18 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> 1. It is essentially an arcane 5000-line Perl script that doesn't use
> git-fast-import/ git-fast-export. It converts an SVN repository to a
> Git repository by hand. This makes it virtually unmaintainable.
> [...]
> My proposal is to start from scratch and build an application that
> makes dealing SVN repositories very easy. The plan is to build
> component-wise, in a modular manner. The project can be considered
> fully successful only after the functionality described in all the
> components have been written, and the project is merged into upstream.

"I don't understand the current implementation" is approximately the
worst possible reason to rewrite something from scratch.  Here is a
great article about this problem:
http://www.joelonsoftware.com/articles/fog0000000069.html (from back
before Joel "junked the sharp").

Now, git-svn is not as big a project as, say, Netscape or dBase or
Quattro Pro.  It's just a little piece.  So rewriting from scratch
*might* actually work in this case.  But you should be aware that:

- a lot of the complexity is there for a reason

- all those "extra commands" that git-svn supports are considered
backwards compatibility, even if they're absolutely obsolete because
of newer commands, and therefore will be very hard to justify getting
rid of

- getting your replacement merged into git is rather unlikely unless
you can provide this backwards compatibility *and* a comparable
feature set, or at least a compelling reason that yours should be
merged in *alongside* the existing git-svn, resulting in duplicate
functionality.

So if your goal is to write a possibly better replacement to git-svn,
that's a potentially great goal with an unfortunately high probability
of failure (but great upside if you don't fail).  If you won't
consider it successful unless it gets merged upstream... then you're
setting yourself up for disappointment, at least if you expect to be
done withing the GSoC timeframe.

So that's the "downer" part of my feedback.  On the other hand, I
don't really like how git-svn works either, so I'd be happy to also
offer some constructive suggestions if you really are brave enough to
start from scratch :)

> 3. It handles the standard trunk/branches/tags layout well, but it
> doesn't know how to handle non-standard/ changing SVN layout.

Indeed.  After fiddling with git-svn more than I'd like to think about
(we use a mishmash of git and svn at work, both with lots of branches,
and I'm basically the junction point between them), I have come to a
simple conclusion:

  ** Trying to map the svn branch-is-a-folder model to git's
branch-is-a-branch model is wrong. **

git-svn tries to take /trunk/* and /branches/foo/* and pretend that
the '*' in each corresponds to the same set of files, separated only
by history.  This is more-or-less true in most svn repositories...
some more and some less.  But the mapping is never 100% correct, and
once you've done the mapping, it's impossible to fix without doing a
whole new import.  Moreover, extracting these branches separately from
the svn history often involves downloading the same file contents over
and over, which is stupid and slow.  git-svn goes through many
contortions to *avoid* such re-downloading, but it isn't always
successful; sooner or later it ends up re-downloading a tonne of
stuff.  And this is despite the fact that svn has *explicit* recording
of renames and copies, which ought to be easy for git-svn to read and
say "just copy the treeid corresponding to the source and paste it
into the destination" as a trivial O(1) operation.

So anyway, my suggestion here is to do something so simple it's not
obvious: import the entire history, one revision at a time, from the
very top of the svn tree.  That means the git history will show
/branches/whatever/* *and* /trunk/*, and 99% of the files will be the
same.  Of course, the fact that they're the same costs you nothing,
because git is awesome.  You only pay for it if you check out that
magic history branch into your working tree.

And that's the trick: you never want to actually check out this
full-history branch.  Instead, use something like the technique from
'git subtree split' (http://github.com/apenwarr/git-subtree) to
extract sub-histories *from that primary imported history*.  That
split operation can happen *really* fast, since all you're doing is
creating a bunch of synthetic git commits where the toplevel tree
points at the subtree from the corresponding commit in the primary
history.  Creating a bunch of tiny commit objects is quick and easy.
And if you screw it up, no problem; just throw it away and regenerate
the subtree.  None of that requires re-importing stuff from the svn
server, which is the unbelievably slow and expensive part.

Separating these two concepts, svn importing from
svn-branch-directory-swizzling, ought to make git-svn much more
manageable, much faster, and much more flexible.

> 4. There's an array of other annoyances which makes it quite
> imperfect. For example, it ignores all SVN properties except
> svn:executable.

Yes, you'll have to find a good solution to this that balances one set
of disadvantages (file attributes that aren't stored, or are stored
invisibly) with another (file attributes that are stored in dotfiles
or something and thus clutter up the work tree).

Maybe git-notes would help.  Or maybe not :)

> The following resources are relevant to the project:
> 1. git_remote_helpers/git/git.py is a minimalistic remote helper
> written by Sverre. I plan to extend this as much as possible before
> rewriting it in C.

Are you sure you really want to rewrite git-svn in C?  svn is so slow
that interpreted vs. native performance is unlikely to be an issue.
git-svn is probably not going to be needed on embedded systems where
installing python or perl is a problem.  And managing the data
structures in a high-level language should be a lot easier.

You could always do your whole project in python or perl and make it
*work* the way you want.  If it's really good, you can maybe get that
accepted into the git core.  Then, if it's really modular enough, you
ought to be able to rewrite the modules one by one into C as needed.

Have fun,

Avery
