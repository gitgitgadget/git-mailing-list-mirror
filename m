From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Mon, 14 Jul 2008 01:28:43 +0200
Message-ID: <200807140128.44923.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 01:29:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIB0q-0005k9-3F
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 01:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbYGMX2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2008 19:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbYGMX2x
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 19:28:53 -0400
Received: from gv-out-0910.google.com ([216.239.58.186]:44358 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbYGMX2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 19:28:52 -0400
Received: by gv-out-0910.google.com with SMTP id e6so829276gvc.37
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 16:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xLp0cK1OamMTfjauFrs27XTvVQc/k1yPViUJqiS2pP8=;
        b=MCMNl9LZKEVuDWk9XbJUN2n4ObUjF9ZLzKQidK6ftWHeYbMlAsshMYa9t20xbP1xxh
         PoupIvo3zQhJwgBk2bVpspqnSTUJPdh/ATjKI5mjcFEkRBSgVD3JiqM38HQvcUsXcEJg
         nHm+DduQo7CD0p8cPN7vh2t8GXeHwRyAW56hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ATPN6oT1EO8Ra6m8VvT9mgHuDB2MiF9AEfVSAF9/vlbLKkzlNiktDKtD5SUe+N7rCF
         8YwMTk8bKsDWG79ZiI96+MqHRRrlwwERc+gwxOExxVs+Rqvrr+uVnGCB9pzWdoMv4yO3
         fj3dd0AEr+gwttAZJuW1fqdaTyczhQXdxOhfs=
Received: by 10.103.49.12 with SMTP id b12mr7350284muk.72.1215991730409;
        Sun, 13 Jul 2008 16:28:50 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.211.66])
        by mx.google.com with ESMTPS id u9sm17376756muf.12.2008.07.13.16.28.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jul 2008 16:28:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1215738665-5153-1-git-send-email-LeWiemann@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88357>

On Fri, 11 July 2008 03:11, Lea Wiemann napisa=B3:

> This also adds the Git::Commit and Git::Tag classes, which are used b=
y
> Git::Repo, the Git::Object base class, and the Git::RepoRoot helper
> factory class.

I think it would be perhaps better to explain relationship and purpose
of each class in more detail, including Git::Repo.

No signoff - is it deliberate, or just omission?

> ---
> Here's some elaboration on why I didn't use or extend Git.pm.
>=20
> Please note before starting a reply to this: This is not an argument;
> I'm just explaining why I implemented it the way I did.  So please
> don't try to argue with me about what I should or should have done.
> I'm not going to refactor Git::Repo to use Git.pm or vice versa; it's
> really a much more non-trivial task than you might think at first
> glance.
>=20
> Anyways, the following bullet points are my reasons for not extending
> Git.pm:
>=20
> - Git.pm doesn't do what I want: It's designed to provide access to
>   working copies.  Extending it to have more repository-access
>   functions might have resulted in a mess.

I don't quite understand.  True, Git->repository(...) has a bit strange
[optional] parameters, but you should remember that IIRC it predates
possibility of workdir / worktree / working copy separation.  That
I think is why it supports non-bare repositories (default), and bare
repositories, not separating working copy from repository.

Also, from what I understand and remember, Git.pm was created to have
one place, one single implementation for safe and operating system=20
independent (which means that it works with ActiveState Perl on=20
Windows) "pipe" and "backticks".  Everything else is just convenience.
=20
>   Some long-term thoughts on this issue: I don't think Git.pm's desig=
n
>   approach is sensible: It tries to do (a) WC access, (b) repo access=
,
>   and (c) frontend error handling (with sensible error messages).

I can see (b) and (c), but I have trouble seeing (a).

>   Those things should really be separated; e.g. one could write a
>   Git::WC class that *has* a Git::Repo instance (since every working
>   copy has a repository associated with it); so you can use $wc =3D
>   Git::WC->new to access the working copy, and $wc->repo to access it=
s
>   repository.

Please remember that the opposite relation is also true.  Non-bare=20
repository has working copy / worktree associated with it, either=20
implicitly (.git/.. is working copy), or explicitly (core.worktree).

Also even if worktree and repository are separated, there are a few
files in non-bare repository which refer to worktree condition, namely =
=20
$GIT_DIR/HEAD, $GIT_DIR/logs/HEAD and $GIT_DIR/index.

>   Git.pm will obviously have to stay since a few git=20
>   commands use it,=20

The following commands use Git.pm: contrib/examples/git-remote.perl,
git-add--interactive.perl (helper script), git-cvsexportcommit, git-svn=
,=20
git-send-email.

The following commands are written in Perl, but *do not* use Git.pm:
git-archimport (which probably should go to contrib, and be replaced by=
=20
fast-import / fast-export based Bazaar import), git-cvsimport,=20
git-cvsserver, git-relink (rarely used now, I think).

>   but I'd probably let it die a slow death, and (cleanly!) copy
>   functionality to a Git::WC module (and perhaps a Git::Frontend
>   module) in the long run.=20

I'm not so sure if it is a way to go.  Most git commands wants to just=20
invoke other git commands safely, either creating pipeline, or reading=20
whole input; sometimes command output is not important.

Non OO things, like ability to write

  print color('reset') . "\n";

is also important.

> - It would have needed refactoring and more features.
>=20
>   - For example, the Error module should be removed (and normal die
>     and eval should be used instead).  At some point when I was tryin=
g
>     to debug it through gitweb, Git.pm would error out somewhere and =
I
>     would randomly get either a blank page (usually) or an error page
>     (rarely).  I suspect that this is because of the Error module or
>     some strange interaction with another.

I'm not sure if using Error module and syntactic sugar in the form of=20
try { ... } catch <class> with { ... } was a good idea for (c),=20
frontend error handling.  Or if it was a good idea (the explanation in=20
http://www.perl.com/pub/a/2002/11/14/exception.html is compelling)
if it was implemented fully, completely, and correctly.

How would you like to catch errors from frontend in Git::Repo and=20
friends?

>     [...]                                (Besides, Error is not in
>     the Perl distribution, so it would be an unnecessary dependency
>     for gitweb; the only one as far as I can see.)

Git Makefile installs Error module from local copy if one is not=20
available.  perl-Git module (which would be unfortunately required to=20
use gitweb; well, that or you could install it locally) has=20
"perl(Error)" as one of dependencies.  perl-Error module is a standard
module and I think it can be found in any modern Linux distribution; if=
=20
not, see first sentence in this paragraph.

>   - Also, I needed something like max_exit_code and a custom path to
>     the git binary; adding max_exit_code would have been non-trivial.

What is max_exit_code (and why for example you couldn't just create you=
r=20
own derivative of Error)?
=20
>   Now I'm all in favor of re-using existing code, but refactoring
>   Git.pm would have taken *much* longer than simply writing a new
>   module.  I'm working on caching for gitweb, not on implementing the
>   next great Perl API for Git.  (And Git::Repo isn't great, FTR.)

Well, I can understand that.

Besides, having more than one implementation of some new feature was=20
quite common in early stages of feature development.  See for example=20
wit and gitweb, git-applymbox and git-am, git-annotate and git-blame.

> - It's buggy and untested.  Neither of these is a problem by itself,
>   but the combination is deadly.

Haven't you added t/t9700-perl-git.sh?

>   E.g. I was trying to refactor the=20
>   'repository' constructor (to be able to do instantaneous
>   instantiation) and stumbled upon a missing semicolon that rendered
>   the surrounding code syntactically correct but obviously buggy (lin=
e
>   214 on master).  Adding a semicolon there seemed to cause other
>   errors, and given that (a) I don't understand what the code does an=
d
>   no test or comment tells me what it should, and (b) it doesn't work
>   (or maybe it half-works?), I lost all my confidence that I could do
>   anything resembling a (behavior-preserving) refactoring on that
>   code.

This is not that the code should not be rewritten... but git-blame (and=
=20
git log -S, aka pickaxe search) can be created to find who is the=20
author of said code, and ask him via email (probably Cc-ing git mailing=
=20
list).

>   I might have been able to work with this particular problem, but
>   such a problem (buggy and completely untested code) are indicative
>   that the rest of the code might bear similar surprises.

I think that the pipe and command code might be tested best, as it is=20
collation and condensation of many different "safe pipe" (etc.) code=20
fragments.

> - It's overly lengthy, and it's a lot of code for not much
>   functionality.  Git.pm has 1200 LOC, with a large stack of tiny
>   subroutines to handle pipes, and a complicated error handling
>   system.  I can make out ~400 lines of actual Git functionality, plu=
s
>   a 100-lines constructor (all including documentation).  The part of
>   Git::Repo that overlaps with Git.pm (in terms of duplicate
>   functionality) seems to be in the range of 150-200 lines, and it's
>   mostly pipe-handling.  That's not a whole lot.

Pipe handling is IMHO most important part.  Well, other parts such as=20
color(...) are important too, but not for gitweb.

> - When I decided I didn't want to use Git.pm, it took me 2-3 hours to
>   replicate the functionality in Git.pm that I needed; it would have
>   taken me *much* longer to extend Git.pm to do what I want.  Again,
>   I'm not working on the next great Git Perl API.
>=20
> So where do we go with Git.pm and Git::Repo?  I would suggest that
> they both stay.
>=20
> Thus we'd have two APIs (both of them obviously incomplete).  If
> there's enough objection to having two competing official APIs, I'll
> be happy to move Git::Repo to the gitweb directory, and make it a
> gitweb-specific thing (though it's not gitweb-specific at all in term=
s
> of functionality); I really don't care, as my goal is to get caching
> for gitweb working.  Again, if you're bothered by the fact that
> there's duplicate functionality at all, please don't complain, but
> send patches to reconcile the APIs; I will not take care of that
> myself, since it's a very much non-trivial task.

What I worry about is that dependence on Git.pm or Git::Repo would make=
=20
gitweb installation too hard for some.

> Unrelatedly, should I add copyright notices at the bottom of each per=
l
> module so they are displayed in the perldoc/man pages?  I'm not
> generally a fan of such notices, since they tend to establish code
> ownership, but if it's desired I can add them.

Well, most manpages have information about who made them... which means=
=20
who was initial author, usually, and/or who is current maintainer.


[Comments on patch itself in separate email, later]

--=20
Jakub Narebski
Poland
