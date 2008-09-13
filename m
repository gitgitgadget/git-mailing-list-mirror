From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: externals program, way to do svn:externals-like subproject management without git-submodule
Date: Sat, 13 Sep 2008 18:17:05 -0400
Message-ID: <32541b130809131517k6d1e5e4dsc5f72d54c7e71e55@mail.gmail.com>
References: <853238710809131417v3818955sed4c0d3dd411a540@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miles Georgi" <azimux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 00:19:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KedSf-00042y-7a
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 00:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbYIMWRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 18:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbYIMWRK
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 18:17:10 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:59430 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbYIMWRI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 18:17:08 -0400
Received: by gxk9 with SMTP id 9so21798965gxk.13
        for <git@vger.kernel.org>; Sat, 13 Sep 2008 15:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GhbIxbQmGLi+PtiW+w3Jx2IeWvZBVA2mS/uCzPc1VN8=;
        b=iS6fgUsWWrz465SYbroY5oIvT1I0dsQRqXrfGwUvcjJ13yMMORiZ9rSnXSs5m2GCHt
         rwzD2CNIdwwC89xKT8EF2o0oMAEvPIEhNcu98kYnoKk4blcB2OqW/aBUuYjPYJ+zwnoP
         EqCPTdO02KsHANZHAktI6voc97Q2Pp3BDN7Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Fviqs/dJ6xTsipECJKTioZmAuMTgj3ORGR0qZ1IOqXEchn43ctpmH9qCz4aSDsJ4xq
         Chg65ofjpEYa/CeqccTedtJKOoZM8AKr5EnS4kIiGW5WDuImo9ecXjHSrVRlY2vP6D58
         Yq8amt7bUVMf61Jmev20I5NFDZA6TlTzRpbtU=
Received: by 10.151.44.18 with SMTP id w18mr8347817ybj.23.1221344225783;
        Sat, 13 Sep 2008 15:17:05 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Sat, 13 Sep 2008 15:17:05 -0700 (PDT)
In-Reply-To: <853238710809131417v3818955sed4c0d3dd411a540@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95818>

On Sat, Sep 13, 2008 at 5:17 PM, Miles Georgi <azimux@gmail.com> wrote:
> I posted this on the rails list a week ago (though it can certainly be
> used in non-rails applications (it does require ruby to be installed,
> and is best installed via rubygems))   I didn't get any feedback at
> all which was kind of dissapointing.  I decided to mention it here to
> see if I can get any feedback.
>
> I have a tutorial demonstrating how to use ext here:
> http://nopugs.com/ext-tutorial

Hi Miles,

Well, you asked for feedback :)

I myself have found that git-submodule doesn't really do it for me
either.  Someday, like you, I was planning to break down and write a
replacement that works more like how I want.  I haven't done that, and
now here you are, with a replacement that's *more* like what I want,
but not quite.  With that in mind, here is an assortment of
suggestions that I myself have been too lazy to implement.

(The suggestions are based on the tutorial you posted.  I haven't
tried ext itself yet.)

1. 'ext export' is not a good name for what it does.  It doesn't
actually export anything.  It's putting files *into* your working set!
 Worse, 'cvs export' for example does something totally different.
'ext qcheckout' (for "quick") or 'ext shallow' (because it makes
shallow clones) might be better names.

2. Your ini file is not quite in ini format.  To feel "normal", all
lines should be either [section] lines or key=value lines.  It's worth
having your ini-looking files really be ini-like partly because there
are existing tools for parsing/creating those files in any language,
and partly because humans get confused if they don't see what they
expect.  Section lines should also have a preceding blank line rather
than one following, though maybe that's just a side effect of your
blog software.

3. The ini file breaks things into sections based on scm, rather than
based on folder.  This is restrictive in multiple ways: you can't
define *options* per-scm because the per-scm section is already used
for lists of folders.  And you can't define options per-folder because
there is no section to put them into.  I'd recommend an ini structure
more like this:

      $ cat .externals

      [main]
      scm = git
      layout = rails

      [vendor/rails]
      url = git://github.com/rails/rails.git
      scm = git

      [vendor/plugins/acts_as_list]
      url = git://github.com/rails/acts_as_list.git
      scm = git

      [vendor/plugins/foreign_key_migrations]
      url = svn://rubyforge.org/var/svn/redhillonrails/trunk/vendor/plugins/foreign_key_migrations
      scm = svn

      [vendor/plugins/redhillonrails_core]
      url = svn://rubyforge.org/var/svn/redhillonrails/trunk/vendor/plugins/redhillonrails_core
      scm = svn

Note that it's longer this way, but much more extensible and it's
pretty obvious what it means just by looking at it.  Also, most of the
"scm=" lines are actually redundant: externals should be able to
auto-detect them anyhow.  In the [main] section, the scm in question
is obvious, because if you can read the .externals file, you know
which scm it is.  In the other sections, the URL method: string will
(most of the time) reveal the scm type.  For ones where it doesn't,
like http:, then you could supply scm= or default to the same scm as
[main].

4. The built-in rails directory layout support makes me nervous and is
decidedly non-obvious.  As a Rails developer, presumably I know that
when I check out (magic url string) that it should to into (magic path
string), and I can supply both.  I'd rather not supply just one and
*hope* that the ext program knows wtf I want.  In my own case, I'm not
even a Rails developer, so I'm even more nervous.

5. There is no reason to use the ext command to create new subtrees
anyway.  Why not let me check out the subtrees for the first time
however I might normally do it (git clone, svn co, etc) and *then*
tell ext to "take a look and write down what I just did"? It saves you
teaching people new command line syntax.  Plus I can do a trial run
without touching the ext command, and if it works, I can just say
"great, save these settings" by typing something like "ext save".

6. What about .externals files inside nested projects?  I (really do)
have a project that uses a git-submodule called myproj, and *that*
project contains a directory called mylib (ie. myproj/mylib).  I would
expect to have a main .externals file and a myproj/.externals file.
If I call ext from the toplevel, I'd expect it to be smart enough to
see both files and do something sane.

7. I really appreciate git-submodule's ability to lock to a specific
commit, although apparently you don't like this.  The reason it's
valuable is for consistency: whenever I check out my project, the unit
tests should *always* pass.  But if I automatically get the very
latest version of some subproject, they might break my tests, which is
highly annoying.  Sometimes we want to get the latest version of
everything (which svn:externals and current ext makes easy and
git-submodule makes hard).  But other times, we just want to get a
precisely accurate historical version, which git-submodule makes easy
but ext makes hard.  This would actually be pretty easy for you to
implement if we use the new ini file layout above: just add an
*optional* entry in each section called "revision =".  In svn, it's a
revision number; in git, it's a commit id.  Also, as you correctly
observed, git-submodule's tendency to check things out on a
disconnected HEAD is horrible and error prone.  A "branch =" ini
variable would solve that right away (defaulting to 'master' if not
provided), and also let you tell 'git clone' which branch to checkout
in the first place, which is not actually obvious.  You could
auto-record these variables as part of "ext save", and auto-grab the
latest in a new "ext latest" command.  ("ext update" is not a good
name, as updating does different things on different scms, while
"latest" is unambiguous).

8. Branch switching.  If I switch my main project from one branch to
another using git (and yes, I do this very frequently!) I need my
submodules to keep working properly.  git-submodule fails
spectacularly at this: 'git submodule init' writes stuff into my
.git/config file, which isn't per-branch, even though .gitmodules is,
but .gitmodules is ignored (except for *new* submodules) after the
first init.  It also never auto-unregisters submodules when they
disappear from .gitmodules, and totally can't handle a submodule that
moves from one place to another in the local repo.  svn:externals is
differently, but about equally, awful; it goes on wild deletion sprees
when it's in a bad mood.  Pretty much anything remotely sane you do
here will beat any existing implementation I know of.  Key feature:
don't *delete* submodule dirs when I switch to a branch that doesn't
need them, but stash them away somewhere and bring them back when I
switch back - remembering that when you go to bring them back, we may
want a different revision, branch, and directory name, but it still
makes sense to start with the version we had before.

9. Ordering of 'git push' operations.  Currently with git-submodule
it's easy to check something into a subproject, commit the new gitlink
into the parent project, and then push the parent project, while
forgetting to push the subproject back where it came from.  If ext
could enforce this somehow (eg. have a 'recursive push' sort of
operation that does innermost first) it would be awesome.

10. Self hosting.  Because ext isn't included with any scm, if I use
it in my project I have an extra dependency that people need in order
to build it, and not everybody has 'gem'.  It would be great if ext
could drop itself into a subdir of my project and manage updating
itself to the latest version automatically when I ask.  Sadly, I guess
it can't itself be a submodule because of the chicken-and-egg problem
:)

I look forward to hearing from you tomorrow when all my suggestions
are implemented :)

But seriously, I don't mind helping out with a few of these if you
like the sound of these ideas.  I don't have a tonne of time, but the
correct working of submodules is very important to me, and I'm
suffering a lot at work from the lack of it, so alleviating suffering
== worth my time.

Have fun,

Avery
