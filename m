From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] Common library for Git GUIs
Date: Tue, 17 Feb 2009 20:28:25 +0100
Message-ID: <20090217192825.GA2216@efreet.light.src>
References: <20090216212459.GA25046@efreet.light.src> <e5bfff550902162337m43156398kb06320796838c953@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZVe6-0004HI-S5
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 20:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbZBQT2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 14:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbZBQT2a
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 14:28:30 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:55238 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbZBQT23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 14:28:29 -0500
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by mail.bluetone.cz (Spam Firewall) with ESMTP
	id 6196029AD51; Tue, 17 Feb 2009 20:28:26 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by mail.bluetone.cz with ESMTP id sX2l8lseiF4HNnXU; Tue, 17 Feb 2009 20:28:26 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1LZVcH-000133-V4; Tue, 17 Feb 2009 20:28:25 +0100
Content-Disposition: inline
In-Reply-To: <e5bfff550902162337m43156398kb06320796838c953@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110442>

On Tue, Feb 17, 2009 at 08:37:13 +0100, Marco Costalba wrote:
> On Mon, Feb 16, 2009 at 22:24, Jan Hudec <bulb@ucw.cz> wrote:
> > Looking at the current situation with Git GUIs, I thought it might be
> > useful
> > to create a generic library that would make it easier to develop git guis
> > (especially plugins to various tools) and to add a new features to many of
> > them with less effort. What do you people think about such idea?
>  I fail to see the reason to do it given that git GUIs are already quite
> mature and stable tools, feature addition at this stage is only very limited
> and for only small things. Big features are already in from a long time, as
> example (I speak about QGit but the same applies to the others):

Unfortunately I would not say that. There are many, many GUIs, but for me
each of them fails in something. Qgit does not have pull/push and per-hunk
staging (which git gui does), while git gui does not integrate with gitk (to
eg. select revision to merge or cherry-pick from the version tree). Most
others don't have version tree etc.

Currently we finally dropped ConfusingCase at work, but my boss does not want
to switch to git until it has good shell extension and visual studio plugin.
Git Extensions are starting to look pretty good, but does not have the file
status at all yet and in current TortoiseGit it does not work yet (some icons
are overlaid, but they are not correct). When that works, that's windows, but
what about KDE, Gnome and OS X...

So the motivation is to create something, that could factor out the features
from the existing GUIs to make it easier for other GUIs to adopt. So all
plugins can adopt version tree easily etc. Also the goal is to make writing
new GUIs -- meaning mainly plugins to more IDEs and other tools -- easier.

> >    - Tree of all files in the work area with their status
> Already in. Modified files are bolded.
> 
> What qgit misses is new files (but this could be easily added if needed
> because alre already known to qgit) and staged files (but I dont understund
> the useful of this info).

In a stand-alone GUI not big, but in a plugin for an IDE it is nice to see in
the list of files in a project which ones are modified etc. Also all other
version control plugins do that, so it's what people expect.

> >    - Tree of files in given revision
> Already in.
> >    - History *tree*
> Already in.
> >    - Blob data
> Already in.
> >    - Commit properties
> Already in.
> >    - Diffs
> Already in.  Obviously :-)
> >    - Annotations
> Already in.

Yes - in Qgit. However, if I wanted to e.g. write a plugin for e.g. KDevelop,
I would have to re-implement it all by direct calls to git program, because
the implementation inside existing guis is not much reusable. Which is why
I propose to create some reusable code for such tasks.

> >    - Configuration
> >      Many tools (eg. gui designers) feature a tree view of all properties
> >      of some object (property grid) with editable values and short
> >      descriptions. It's not as nice gui designed for individual options,
> >      but can provide good-enough easy-to-write way to set all valid
> >      options from the gui.
> To what should this feature apply? Some examples please?

Often I need to configure some options in ~/.gitconfig and .git/config, but
the GUIs generally only allow to set very few basic ones. I had to resort to
editing ~/.gitconfig to turn off the cursed core.autocrlf, because git gui
does not have that setting. And there are many more settings like that that
users may want to tweak and something to guide them would be highly
appreciated especially by the command-line-fearing windooze users.

So my idea is to provide some kind of "property sheet" -- a treeview with all
the sections and options with editable values with proper constraints (so
boolean and enum values could be entered with drop-down menus) and
descriptions. If a generic library read the list of options from some data
file and provided the values in a QAbstractItemModel, than any Qt gui could
simply design the widgets (table + info pane) and instantiate that and have
the feature. And since Gtk, Windows.Forms and other toolkits have similar
interfaces, it is possible to provide an interface, that is easily adapted to
any of them. If done right, that would simplify providing that feature and
when new option would be defined in git, there would be just one place that
would need to know about it to make it settable with all the guis.

> >  - Menu and action definitions for the common operations
> Already in. Plus customizable actions/macros.

I know that Qgit has it. Git Gui has it too -- done in an incompatible way,
so if you define it in Qgit, you won't have it in Git Gui and vice versa.
Common implementation would improve the user experience in this case.

> >  So what do you people think would be best? I see several options:
> >
> >  - QtCore
> >
> >   Qt seems to be the most popular library among Git GUI writers and since
> >   version 4.5 will be LGPL, so it will be allowed to link with anything.
> >   It is also probably the most portable one. On the downside, it's rather
> >   large and it's language bindings are a bit worse (the garbage collector
> >   integration was a bit bad last time I looked).
> 
> I never felt the need for a garbage collector at all. I strongly prefer to
> spend time to manually fix the (very few) memory leaks that slept in. Qt
> class model already does object housekeeping for you at deterministic and
> well known times (when parent object is deleted so are all corresponding
> children).

My complaint is not about Qt in C++ -- where the ownership model is
reasonable -- but about it's bindings for other languages. In python
programmer expects all objects he has access to to be valid, but Qt objects
will be destroyed with their parents and accessing a reference to them
afterwards will cause the python interpreter to segfault. The programmer can
avoid that by being careful not to leave such references around, but it's
a thing python programmer is not supposed to care about. That's why I say the
bindings are a bit worse (comparing to e.g. Glib/Gtk, which gets this part
right). It can be fixed by better bindings -- it is just that the bindings
when I last saw them didn't handle it.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
