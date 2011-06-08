From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for /etc/gitweb.conf (WIP)
Date: Wed, 8 Jun 2011 18:35:47 +0200
Message-ID: <201106081835.48640.jnareb@gmail.com>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com> <1307382271-7677-5-git-send-email-jnareb@gmail.com> <20110606221236.GD30588@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>,
	Drew Northup <drew.northup@maine.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:36:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QULjl-0002AK-JJ
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 18:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912Ab1FHQgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 12:36:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53919 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab1FHQgA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 12:36:00 -0400
Received: by bwz15 with SMTP id 15so570277bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=TRofUgzvRxxPG9Vgj1qRmWHK0iK5Be8VatpEyqvhfsw=;
        b=njNmvDT2n9dg0MHB9ZkDfVhorm4Ve7MfQ67Hu4Do+2HYhn2mjL3RnFxbRSS457ozPF
         uoqh/MPsKaejeNG6s77+URh9ViclNwv2Slf8TCTZ6eaaCGRo6RhwZ3aDIFGQmAs+hJ/l
         6gbsS5WTJzcIzHifjqVXq2/kAq3y2UqXCa8uY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GZBvKR6S1Gijr1CTvMQxOKcj864Y/lesS9+2EN6l4yxIOy7PS1P89/FGsrkYBavbSR
         x4o1qXN9elXTzGJzuxONxY8FZfKpv5VQ75gC5gbrM5nqTKBB5vFGI7zRw+elAt5oP1Hd
         m/SykQf6LTca6MHyd5P6Zuda9x8YTc095mU10=
Received: by 10.204.144.194 with SMTP id a2mr953628bkv.93.1307550957579;
        Wed, 08 Jun 2011 09:35:57 -0700 (PDT)
Received: from [192.168.1.15] (abvu41.neoplus.adsl.tpnet.pl [83.8.218.41])
        by mx.google.com with ESMTPS id ek1sm720633bkb.21.2011.06.08.09.35.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 09:35:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110606221236.GD30588@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175397>

On Tue, 7 Jun 2011, Jonathan Nieder wrote:

Thank you for your review and comments, and for participating
in discussion!

> Jakub Narebski wrote:
> 
> > Some effort has
> > been made to de-duplicate any of this.
> 
> :)

Please excuse me, but I have noticed that I have "No effort has been made"
just before sending patches.  So this is unfortunate result of fixing it
"on the go".
 
> > * Much simpler "doc" target in gitweb/Makefile.  Now instead of
> >   duplicating internal knowledge how Documentation/Makefile works we
> >   simply delegate task to "gitweb-doc" target (a la "full-svn-test"
> >   in t/Makefile) in Documentation/Makefile.
> 
> Seems sensible as long as the main Makefile never learns
> 
> 	gitweb-doc:
> 		$(MAKE) -C gitweb doc
> 
> The toplevel Makefile could do "$(MAKE) -C Documentation gitweb-doc"
> and still avoid the usual pitfalls of recursive make stepping on its
> own toes.

What do you mean about recursive make troubles here?  There is no loop:
Makefile -> gitweb/Makefile -> Documentation/Makefile.

Do you means something like the following

  $ make -j 2 doc gitweb-doc
 
if main Makefile's "gitweb-doc" would delegate via gitweb/Makefile
instead of straight to Documentation/Makefile?

> Longer term, I would like to try making gitweb/Makefile include a
> build-helpers/Makefile.doc library and moving this documentation back
> to the gitweb/ directory, which would make the gitweb directory
> self-contained again (except for the build-helpers/Makefile.doc file).
> Not sure what to do about that "except for..." bit.  I don't think my
> half-baked long-term ideas should be allowed to slow this down. ;-)

First, this would move dependency from Documentation/Makefile to
build-helpers/Makefile-doc.inc
 
Second such helper would need to solve the ussue that currently in
Documentation/Makefile one must specify explicitely to which man section
given manpage belongs.  You would have to come with some efficient way
to get that information from AsciiDoc source and/or file position in
hierarchy.

Third, we would still depend on t/Makefile for tests...


BTW. does anyone know any converter from AsciiDoc to POD, or POD
formatter formatting to AsciiDoc?

> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
[...]
> > @@ -170,6 +170,9 @@ info: git.info gitman.info
> >  
> >  pdf: user-manual.pdf
> >  
> > +GITWEB_DOC = $(filter gitweb.%,$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7))
> > +gitweb-doc: $(GITWEB_DOC)
> 
> Nice.

I try... :-)

> > @@ -334,4 +337,4 @@ quick-install-man:
> >  quick-install-html:
> >  	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htmldir)
> >  
> > -.PHONY: FORCE
> > +.PHONY: FORCE gitweb-doc
> 
> Is there any reason other phony targets (like "install" and "pdf")
> aren't listed here?

I don't know; they weren't there.
 
> > --- /dev/null
> > +++ b/Documentation/gitweb.conf.txt
> > @@ -0,0 +1,716 @@
> > +gitweb.conf(5)
> > +==============
> > +
> > +NAME
> > +----
> > +gitweb.conf - Gitweb configuration file
> 
> I suppose the novice can look to the DESCRIPTION or SEE ALSO section
> to learn what gitweb is.

Well, we could write "Configuration file for git web interface"... but
there are [much] more web interfaces for git than gitweb.
 
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'/etc/gitweb.conf'
> > +'$GITWEBDIR/gitweb_config.perl'
> 
> Micronit: a single line like
> 
> 	SYNOPSIS
> 	--------
> 	$GITWEBDIR/gitweb_config.perl, /etc/gitweb.conf
> 
> might fit better with the pattern established by gitattributes(5) and
> its kin.

I'm sorry, that is my fault and not Drew's.

While Drew was styling gitweb.conf manpage after resolv.conf(5), I took
ssh_config(5) as an example.  But of course consistency within section 5
git manpages are more important.

Will fix.

> > +DESCRIPTION
> > +-----------

[...]
> > +The configuration file is used to override the default settings that
> > +were built into gitweb at the time 'gitweb.cgi' script was generated.
> > +
> > +While one could just alter the configuration settings in the gitweb
> > +CGI itself, those changes would be lost upon upgrade.
> 
> What if I upgrade using RCS "merge"? :)  So maybe:
> 
> 	s/one could just alter/one can alter/
> 	s/would be lost/could be lost/
> 
> to clarify that (1) editing the CGI script is allowed and fine but (2)
> it might be a pain to keep those changes.

I can agree with 2nd change, but not the first.  Besides who use rcsmerge
for upgrading (and not something that looks like config file)?

> > +[...] Configuration
> > +settings might also be placed into a file in the same directory as the
> > +CGI script with the default name 'gitweb_config.perl' -- allowing
> > +one to have multiple gitweb instances with different configurations by
> > +the use of symlinks.
> 
> Might also in addition to what?  Continuing the thought from before:
> 
> 	So gitweb allows settings to be placed in a separate file named
> 	'gitweb_config.perl' in the same directory as the CGI script.
> 	This also allows one to set up multiple gitweb instances with
> 	different configurations by using symlinks to a common gitweb.cgi
> 	script.

I think your 2nd paragraph would better be put in notes, or in other
separate (sub)section.
 
> > +DISCUSSION
> > +----------
> 
> First, as a general thought, by the time I get this far I start
> thinking, "so where's the list of possible settings?".  But there are
> certainly some more basic pieces of information to cover before then
> (like the global configuration file), so I think this part is in the
> right place.  It just could benefit from being a little shorter.

Right.

> > +The location of system-wide gitweb configuration file is defined at compile
> > +time using the configuration value `GITWEB_CONFIG_SYSTEM` and defaults to
> > +'/etc/gitweb.conf'.  The name of the per-instance configuration file is
> > +defined in gitweb by `GITWEB_CONFIG`, and defaults to 'gitweb_config.perl'
> > +(relative path means located in the same directory gitweb is installed).
> 
> Maybe:
> 
> 	In addition to the per-instance configuration file, there can
> 	be a system-wide configuration file to act as a fallback when
> 	the per-instance configuration file does not exist.
> 
> 	The system-wide configuration file is named /etc/gitweb.conf
> 	by default.  Filenames for the system-wide and per-instance
> 	configuration variables can be overridden at compile time and
> 	run time; see the FILES section for details.

O.K.  Looks better.
 
> [...]

> > +*NOTE:* If per-instance configuration file ('gitweb_config.perl') exists,
> > +then system-wide configuration file ('/etc/gitweb.conf') is _not used at
> > +all_!!!
> 
> Over the top. :)  I think the best way to document this is to contrast
> it with /etc/gitweb-common.conf once the latter exists.

Well, perhaps it is to be reworded, and use ALL CAPS somewhere, but for
the time being I'd rather have this information there.

Though the point might become moot, if (as you noticed) the patch
introducing /etc/gitweb-common.conf is merged in before this series.
Then this part would have to be reworded.
 
> > +The syntax of the configuration files is that of Perl, as these files are
> > +indeed handled as fragments of Perl code (the language that gitweb itself is
> > +written in). Variables may be set using "`our $variable = value`"; text from
> > +"#" character until the end of a line is ignored. See the *perlsyn*(1) man
> > +page for more information.
> 
> Duplicates DESCRIPTION.

Thanks for notocing this.  I'd try to come up with shorter explanation in
"Description", and longer and more detailed here.
 
> > +
> > +Actually using `our` qualifier in `our $variable = <value>;` is a safety
> > +check: if newer gitweb does no longer use given variable, by using `our` we
> > +won't get syntax errors.
> 
> Maybe this could move to a later NOTES section?

Good idea.

> > +
> > +The default configuration with no configuration file at all may work
> > +perfectly well for some installations.  Still, a configuration file is
> > +useful for customizing or tweaking the behavior of gitweb in many ways, and
> > +some optional features will not be present unless explicitly enabled using
> > +the configurable `%features` variable (see also "Configuring gitweb
> > +features" section below).
> 
> I suppose this is based on the text
> 
> 	The most notable thing that is not configurable at compile time are the
> 	optional features, stored in the '%features' variable.
> 
> I'd suggest removing the paragraph.

O.K., as this is in section that needs to be kept short, perhaps
simplification is in order.  Still, I'd like to mention `%feature`
variable, and refer to later section describing it (which I forgot
to add in this version).
 
> > +CONFIGURATION VARIABLES
> > +-----------------------
> > +Some of configuration variables have their default values (embedded in CGI
> > +file) set during building gitweb -- if that is the case, it is put in their
> > +description.  See gitweb's 'INSTALL' file for instructions on building and
> > +installing gitweb.
> 
> Reasonable.  Nit: s/put/mentioned/

"Mentioned" is certainly better word here.
 
> > +
> > +Location of repositories
> > +~~~~~~~~~~~~~~~~~~~~~~~~
> > +Configuration variables described below control finding git repositories by
> > +gitweb, and control display and access to repositories.
> 
> 	The configuration variables described below determine where gitweb looks
> 	for repositories and which will be displayed.
> 
> (missing "The", elaboring on what it means to control repository search.)

Thanks.

I am not a native English speaker, and I seem to be missing "the" from
time to time.
 
> > +$project_maxdepth::
> > +	Filesystem traversing depth limit for recursively scanning for git
> > +	repositories, used if `$projects_list` (below) is unset.  The default
> > +	value of this variable is determined by build-time configuration
> > +	variable `GITWEB_PROJECT_MAXDEPTH`, which defaults to 2007.
> 
> gitweb/INSTALL says:
> 
> 	The filesystem traversing limit for getting the project list; the number
> 	is taken as depth relative to the projectroot.  It is used when
> 	GITWEB_LIST is a directory (or is not set; then project root is used).
> 	This is meant to speed up project listing on large work trees by limiting
> 	search depth.  [Default: 2007]
> 
> I'm still not clear on what it actually means.  Is it used when
> $projects_list points to a directory or not?  What if $projects_list
> points to a file with lines that name directories?  What happens
> when listing forks of a repository?

All right, I'd try to come up with clearer description.

The `$project_maxdepth` is used _only_ when recursively searching for git
repositories, and it always counts depth relative to $projectroot (since
the fix to "forks" that made it into git.git repository).
 
BTW. I don't know why 2007... ;-P

> > +
> > +$projects_list::
> > +	Plain text file listing projects or name of directory
> > +	to be scanned for projects.
> > +
> > +	Project list files should list one project per line, with each line
> > +	having the following format
> > +-----------------------------------------------------------------------------
> > +<URI-encoded filesystem path to repository> SP <URI-encoded repository owner>
> > +-----------------------------------------------------------------------------
> > +
> > +The default value of this variable is determined by the `GITWEB_LIST`
> > +makefile variable at installation time.  If this variable is empty, gitweb
> > +will fall back to scanning the `$projectroot` directory for repositories.
> 
> This gets formatted with the second and later paragraphs being
> unindented; presumably it needs a "+", like so:
> 
> 		... paragraph 1 ...
> 	+
> 	--
> 	... remaining paragraphs ...
> 	--

It looked all right when I was looking at asciidoc 7.1.3 formatted manpage.
I'd have to check how other manpages solve the problem of literal blocks
inside description list, and multi-paragraph description lists, and follow
their examples.

> Can't this point to a directory, too?

*IMPORTANT ISSUE*

I am trying to _evade_ this issue, because of what I see is MISDESIGN
of gitweb.  

When $projects_list is a file, everything is clear -- pathnames
in this file are relative to $projectroot.

But when $projects_list is a directory, it will be recursively scanned for
git repositories, and gitweb would show in projects list page their
pathnames retalive to $projects_list.  But when viewing single repository
it would compose full path out of _$projectroot_ and project "name".

Therefore what makes sense is either $projects_list set to file listing
repositories, or $projects_list unset; then gitweb would use $projectroot
for $projects_list, and scan $projectsroot.

Perhaps there are some rare changes where having $projects_list be set to
a directory different from $projectroot has sense, but they are very, very
rare (directory populated with symlinks to repositories comes to mind).

So that is why I am always taking here about either $projects_list set to
path of plain text file listing repositories, or $projects_list unset.
Though perhaps I should explain gitweb behavior in some "notes"
(sub)section.
 
> > +
> > +$export_ok::
> > +	Show repository only if this file exists (in repository).  Only
> > +	effective if this variable evaluates to true.  Can be set during
> > +	building gitweb via `GITWEB_EXPORT_OK`.  [No default / Not set]
> 
> Am I supposed to show a repository?  Ah, no, this is about what gitweb
> does.  Maybe
> 
> 	Filename to look for in repositories to determine whether to
> 	show them.  If this variable evaluates to true, gitweb will
> 	only show repositories that contain a magic file with that
> 	name; otherwise, which repositories gitweb shows is controlled
> 	by the $strict_export option.  Can be set when building gitweb
> 	using the `GITWEB_EXPORT_OK` variable.  [No default]

That is better way of stating this, thanks.
 
Perhaps s/evaluates to true/is set/ after fixing gitweb to use

  if (defined $export_ok) {

instead of

  if ($export_ok) {

> Might be simpler to put the documentation of $strict_export first.

I'd consider this.

> gitweb/INSTALL says:
> 
> 	gitweb
> 	shows repositories only if this file exists in its object database
> 	(if directory has the magic file named $export_ok)
> 
> but I assume what was meant is the git dir, not .git/objects.

Yes, I meant $GIT_DIR here.  I need to somehow explain that this file
is not searched for in projects working area.  I'd take a look on how
git-daemon(1) documents this...

> Incidentally, wouldn't it be more intuitive to treat all values of
> $export_ok as true (i.e., check "if (defined($export_ok))" instead of
> "if ($export_ok)") so the user doesn't need to know what values perl
> considers to be true?

You are right.

Though this would need a separate commit, for easier review.
 

> [...]
> > +$strict_export::
> > +	Only allow viewing of repositories also shown on the overview page.
> > +	This for example makes `$gitweb_export_ok` file decide if repository is
> > +	available and not only if it is shown.  If `$gitweb_list` points to
> > +	file with list of project, only those repositories listed would be
> > +	available for gitweb.  Can be set during building gitweb via
> > +	`GITWEB_STRICT_EXPORT`.  [No default / Not set]
> 
> I think I'd put this before $export_ok (because simpler) and steal
> text from INSTALL.
> 
> 	By default, even if a project is not visible on the projects list
> 	page, you can view it by hand-crafting a gitweb URL.  Set the
> 	$strict_export variable to true if you want to only allow
> 	repositories shown on the overview page to be viewed.  Can be
> 	set during ...

All right.
 
> > +Finding files
> > +~~~~~~~~~~~~~
> > +Those configuration variables tell gitweb where to find files.  Values of
> > +those variables are paths on filesystem.  Of those only `$GIT` is required
> > +to be (correctly) set for gitweb to be able to work; all the rest are
> > +required only for extra configuration or extra features.
> 
> Perhaps:
> 
> 	System paths
> 	~~~~~~~~~~~~
> 	These configuration variables tell gitweb where to find commands and 
> 	system files.  The values of these variables are commands or
> 	paths on the filesystem.  Of these, only ...
> 
> (s/those/these/; add some wiggle room since $GIT = "git" is allowed;
> change the title to contrast with the repository location variables;
> add a comma.)

Thanks.  I couldn't come with a good name for this section, and a good
introductory paragraph.
 
> > +
> > +$GIT::
> > +	Core git executable to use.  By default set to `$GIT_BINDIR/git`, which
> > +	in turn is by default set to `$(bindir)/git`.  If you use git from binary
> > +	package, set this to "/usr/bin/git".  This can just be "git" if your
> > +	webserver has a sensible PATH.  If you have multiple git versions installed
> > +	it can be used to choose which one to use.
> 
> A setting like $GIT = "git --exec-path=elsewhere" would not work
> because the entire string is used as the first argument to execvp.
> Not sure how to say it: maybe just
> 
> 	Command name to use when running git commands.  By default
> 	this is set to ...
> 
> ("command name" being a phrase I made up on the spot for "path or
> bare command name, suitable for passing to execvp".)

I thought that "executable" impled name of a _file_, isn't it?
But I'd consider your wording.  Thanks.

> I think a better default would be "git", so if a newer git gets
> installed in /usr/local/bin then gitweb would notice automatically.

I'd rather not we pick first "git" that happens to be in web server PATH.
Though nowadays it should be much more rare to encounter "git" binary
that is not our git (there was section named "other programs named git"
somewhere, but I couldn't find it).

> > +$mimetypes_file::
> > +	File to use for (filename extension based) guessing of MIME types before
> > +	trying '/etc/mime.types'.  Path, if relative, is taken currently as
> > +	relative to the current git repository.  [Unset by default]
> 
> What makes $mimetypes_file fit in this section but not $export_ok?  (I
> have no good answer.  Maybe a separate section for MIME type guessing
> would be more discoverable?)

Because it is name of file to be found on filesystem, and not inside
git repository.  Perhaps I should have made it more clear that this
section is not about files inside git repository that control gitweb
look and behavior.

But perhaps separate section about MIME type handling, containing a three
variables (IIRC) would be a better solution.
 
> > +Links and their targets
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +Configuration variables described below configure some of gitweb links:
> > +their target and their look (text or image), and where to find page
> > +prerequisites (stylesheet, favicon, images, scripts).  Usually they are left
> > +at their default values, with the possible exception of `@stylesheets`
> > +variable.
> 
> Does "Usually they are left at" mean "Usually there is no reason to change
> them from"?  Aside from that, makes sense.

Yes, it does.  Will fix.
 
> > +
> > +@stylesheets::
> > +	List of URIs of stylesheets (relative to base URI of a page). You
> > +	might specify more than one stylesheet, for example use gitweb.css
> > +	as base, with site specific modifications in separate stylesheet
> > +	to make it easier to upgrade gitweb. You can add a `site` stylesheet
> > +	for example by putting
> > +----------------------------------------------------------------------------
> > +push @stylesheets, "gitweb-site.css";
> > +----------------------------------------------------------------------------
> > +in the gitweb config file.  Those values that are relative paths, are
> > +relative to base URI of gitweb.
> > +
> > +This list should contain URI of gitweb's stylesheet.  The URI of gitweb
> > +stylesheet is set during build time via `GITWEB_CSS` variable.  It's default
> > +value is 'static/gitweb.css' (or 'static/gitweb.min.css' if the `CSSMIN`
> > +variable is defined, i.e. if CSS minifier is used during build.
> > +
> > +*Note*: there is also legacy `$stylesheet` configuration variable, which was
> > +used by older gitweb.
> 
> s/gitweb$/gitweb's/; s/It's/Its/.  Missing closing paren, I think.

O.K.
 
> s/legacy/the legacy/.  How does this interact with the legacy setting (e.g.,
> if I am new on my job as gitweb administrator and encounter such a line,
> what does it mean and what would I want to change it to)?
 
Badly.

If $stylesheet variable is defined, it is used as gitweb's stylesheet, and
@stylesheets variable is ignored.

If you as administrator encounter old gitweb config file with such a line,
you should examine said file to check what was added to stock gitweb CSS,
and put additions / changes in a separate file, which would be then
separate entry in @stylesheets besides stock gitweb CSS

  push @stylesheets, "gitweb-changes.css";

This way upgrading gitweb would upgrade stock part of CSS file.


I think on 1.8.0 boundary, or some other such, we could get rid of legacy
$stylesheet variable, perhaps leaving comment here about how to update
config file.

> > +
> > +$logo::
> > +	Points to the location where you put 'git-logo.png' on your web
> > +	server, or to be more generic URI of logo, 72x27 size).  This image
> > +	is displayed in top right corner of each gitweb page, and used as
> > +	logo for Atom feed.  Relative to base URI of gitweb (as a path).
> > +	Can be adjusted during building gitweb using `GITWEB_LOGO` variable
> > ++
> > +	[Default: 'static/git-logo.png']
> 
> Re "as a path": can this be a URI pointing to another server if I want
> it to?

Yes it can.  This way you can serve static content (images, CSS, scripts)
from some CDN (Content Delivery Network) on different host for a bit better
performance.

Though you would have to install and upgrade such files yourself.
 

Note: URL can be 'path/to/file', or '/path/to/file', or even 
'http://server/path/to/file'.  Only last is absolute _URL_, IIRC.

> [...]
> > +$home_link::
> > +	Target of the home link on top of all pages (the first part of view
> > +	"breadcrumbs").  By default set to absolute URI of a page ($my_uri).
> 
> s/By default set to absolute URI of a page/The default is the absolute
> URI for the gitweb script/
> 
> Stopping here.  Will resume later but since having something is better
> than nothing, I am tempted to say this should be applied e.g. to
> "next" so people can start using it right away and finding/fixing
> documentation bugs.

Thanks.

-- 
Jakub Narebski
Poland
