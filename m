From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for
 /etc/gitweb.conf (WIP)
Date: Mon, 6 Jun 2011 17:12:36 -0500
Message-ID: <20110606221236.GD30588@elie>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
 <1307382271-7677-5-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>,
	Drew Northup <drew.northup@maine.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 00:12:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTi2R-0003bK-Dh
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 00:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929Ab1FFWMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 18:12:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46850 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590Ab1FFWMl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 18:12:41 -0400
Received: by iwn34 with SMTP id 34so3492536iwn.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WoiUaYbdtNzT/H4j9vsUj4NwEBBWA6rgGlvLw/+Wysw=;
        b=fHShPMSbjHy+LMCYEHjBg6UPb0td5SCOnoZNzF5HNrN8PsbNsa+D6whzghNqpFzJ2r
         PdU3+8aKl/vmVmuNPE07J2QPk1YMiWJkw1Ya9lVh1g8uYYKycFFEIsraYifSsceAVtOo
         q2elVH8iQlud2Su/pce5YCFxTcaEpz9Z93yeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Mu9PEFeniI7WtSUBcTvIxqAXec6AHS+arTPdEscUrvInQ+wZ3nKDhA2MKOI1uUsFFT
         zGQDVM5u3mfI3uzf7jU01FB/zD4ikqIbFtScy/+I+hTEs499OnkiG0U8CWckBz5ywcop
         NrV/Y0sxMcMV8npYKcObnpFHlHu0fU0q+7zZw=
Received: by 10.231.63.82 with SMTP id a18mr8585348ibi.130.1307398361072;
        Mon, 06 Jun 2011 15:12:41 -0700 (PDT)
Received: from elie (adsl-68-255-97-40.dsl.chcgil.ameritech.net [68.255.97.40])
        by mx.google.com with ESMTPS id d10sm1829550ibb.49.2011.06.06.15.12.38
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 15:12:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307382271-7677-5-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175176>

Jakub Narebski wrote:

> Some effort has
> been made to de-duplicate any of this.

:)

> * Much simpler "doc" target in gitweb/Makefile.  Now instead of
>   duplicating internal knowledge how Documentation/Makefile works we
>   simply delegate task to "gitweb-doc" target (a la "full-svn-test"
>   in t/Makefile) in Documentation/Makefile.

Seems sensible as long as the main Makefile never learns

	gitweb-doc:
		$(MAKE) -C gitweb doc

The toplevel Makefile could do "$(MAKE) -C Documentation gitweb-doc"
and still avoid the usual pitfalls of recursive make stepping on its
own toes.

Longer term, I would like to try making gitweb/Makefile include a
build-helpers/Makefile.doc library and moving this documentation back
to the gitweb/ directory, which would make the gitweb directory
self-contained again (except for the build-helpers/Makefile.doc file).
Not sure what to do about that "except for..." bit.  I don't think my
half-baked long-term ideas should be allowed to slow this down. ;-)

> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -3,7 +3,7 @@ MAN1_TXT= \
>  		$(wildcard git-*.txt)) \
>  	gitk.txt git.txt
>  MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
> -	gitrepository-layout.txt
> +	gitrepository-layout.txt gitweb.conf.txt
>  MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
>  	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
>  	gitdiffcore.txt gitrevisions.txt gitworkflows.txt
> @@ -170,6 +170,9 @@ info: git.info gitman.info
>  
>  pdf: user-manual.pdf
>  
> +GITWEB_DOC = $(filter gitweb.%,$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7))
> +gitweb-doc: $(GITWEB_DOC)

Nice.

> @@ -334,4 +337,4 @@ quick-install-man:
>  quick-install-html:
>  	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htmldir)
>  
> -.PHONY: FORCE
> +.PHONY: FORCE gitweb-doc

Is there any reason other phony targets (like "install" and "pdf")
aren't listed here?

> --- /dev/null
> +++ b/Documentation/gitweb.conf.txt
> @@ -0,0 +1,716 @@
> +gitweb.conf(5)
> +==============
> +
> +NAME
> +----
> +gitweb.conf - Gitweb configuration file

I suppose the novice can look to the DESCRIPTION or SEE ALSO section
to learn what gitweb is.

> +SYNOPSIS
> +--------
> +[verse]
> +'/etc/gitweb.conf'
> +'$GITWEBDIR/gitweb_config.perl'

Micronit: a single line like

	SYNOPSIS
	--------
	$GITWEBDIR/gitweb_config.perl, /etc/gitweb.conf

might fit better with the pattern established by gitattributes(5) and
its kin.

> +DESCRIPTION
> +-----------
> +The gitweb CGI script for viewing Git repositories over the web uses a
> +perl script fragment as its configuration file.  You can set variables
> +using "`our $variable = value`"; text from a "#" character until the
> +end of a line is ignored.  See *perlsyn*(1) for details.
> +
> +An example:
> +
> +    # gitweb configuration file for http://git.example.org
> +    #
> +    our $projectroot = "/srv/git"; # FHS recommendation
> +    our $site_name = 'Example.org >> Repos';

Nice.

> +The configuration file is used to override the default settings that
> +were built into gitweb at the time 'gitweb.cgi' script was generated.
> +
> +While one could just alter the configuration settings in the gitweb
> +CGI itself, those changes would be lost upon upgrade.

What if I upgrade using RCS "merge"? :)  So maybe:

	s/one could just alter/one can alter/
	s/would be lost/could be lost/

to clarify that (1) editing the CGI script is allowed and fine but (2)
it might be a pain to keep those changes.

> Configuration
> +settings might also be placed into a file in the same directory as the
> +CGI script with the default name 'gitweb_config.perl' -- allowing
> +one to have multiple gitweb instances with different configurations by
> +the use of symlinks.

Might also in addition to what?  Continuing the thought from before:

	So gitweb allows settings to be placed in a separate file named
	'gitweb_config.perl' in the same directory as the CGI script.
	This also allows one to set up multiple gitweb instances with
	different configurations by using symlinks to a common gitweb.cgi
	script.

> +DISCUSSION
> +----------

First, as a general thought, by the time I get this far I start
thinking, "so where's the list of possible settings?".  But there are
certainly some more basic pieces of information to cover before then
(like the global configuration file), so I think this part is in the
right place.  It just could benefit from being a little shorter.

> +The location of system-wide gitweb configuration file is defined at compile
> +time using the configuration value `GITWEB_CONFIG_SYSTEM` and defaults to
> +'/etc/gitweb.conf'.  The name of the per-instance configuration file is
> +defined in gitweb by `GITWEB_CONFIG`, and defaults to 'gitweb_config.perl'
> +(relative path means located in the same directory gitweb is installed).

Maybe:

	In addition to the per-instance configuration file, there can
	be a system-wide configuration file to act as a fallback when
	the per-instance configuration file does not exist.

	The system-wide configuration file is named /etc/gitweb.conf
	by default.  Filenames for the system-wide and per-instance
	configuration variables can be overridden at compile time and
	run time; see the FILES section for details.

[...]
> +Values defined in configuration files override built-in values found in the
> +gitweb CGI.

Reasonable.

> +*NOTE:* If per-instance configuration file ('gitweb_config.perl') exists,
> +then system-wide configuration file ('/etc/gitweb.conf') is _not used at
> +all_!!!

Over the top. :)  I think the best way to document this is to contrast
it with /etc/gitweb-common.conf once the latter exists.

> +The syntax of the configuration files is that of Perl, as these files are
> +indeed handled as fragments of Perl code (the language that gitweb itself is
> +written in). Variables may be set using "`our $variable = value`"; text from
> +"#" character until the end of a line is ignored. See the *perlsyn*(1) man
> +page for more information.

Duplicates DESCRIPTION.

> +
> +Actually using `our` qualifier in `our $variable = <value>;` is a safety
> +check: if newer gitweb does no longer use given variable, by using `our` we
> +won't get syntax errors.

Maybe this could move to a later NOTES section?

> +
> +The default configuration with no configuration file at all may work
> +perfectly well for some installations.  Still, a configuration file is
> +useful for customizing or tweaking the behavior of gitweb in many ways, and
> +some optional features will not be present unless explicitly enabled using
> +the configurable `%features` variable (see also "Configuring gitweb
> +features" section below).

I suppose this is based on the text

	The most notable thing that is not configurable at compile time are the
	optional features, stored in the '%features' variable.

I'd suggest removing the paragraph.

> +CONFIGURATION VARIABLES
> +-----------------------
> +Some of configuration variables have their default values (embedded in CGI
> +file) set during building gitweb -- if that is the case, it is put in their
> +description.  See gitweb's 'INSTALL' file for instructions on building and
> +installing gitweb.

Reasonable.  Nit: s/put/mentioned/

> +
> +Location of repositories
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +Configuration variables described below control finding git repositories by
> +gitweb, and control display and access to repositories.

	The configuration variables described below determine where gitweb looks
	for repositories and which will be displayed.

(missing "The", elaboring on what it means to control repository search.)

> +
> +$projectroot::
> +	Absolute filesystem path which will be prepended to project path;
> +	the path to repository is `$projectroot/$project`.  Set to
> +	`$GITWEB_PROJECTROOT` during installation.  This variable has to be
> +	set correctly for gitweb to find repositories.
> ++
> +For example if `$projectroot` is set to "/srv/git" by putting the following
> +in gitweb config file:
> +----------------------------------------------------------------------------
> +our $projectroot = "/srv/git";
> +----------------------------------------------------------------------------
> +then
> +------------------------------------------------
> +http://git.example.com/gitweb.cgi?p=foo/bar.git
> +------------------------------------------------
> +or its path_info based equivalent
> +------------------------------------------------
> +http://git.example.com/gitweb.cgi/foo/bar.git
> +------------------------------------------------
> +will map to path '/srv/git/foo/bar.git' on filesystem.

Nice.  s/(path|filesystem)/the &/

> +
> +$project_maxdepth::
> +	Filesystem traversing depth limit for recursively scanning for git
> +	repositories, used if `$projects_list` (below) is unset.  The default
> +	value of this variable is determined by build-time configuration
> +	variable `GITWEB_PROJECT_MAXDEPTH`, which defaults to 2007.

gitweb/INSTALL says:

	The filesystem traversing limit for getting the project list; the number
	is taken as depth relative to the projectroot.  It is used when
	GITWEB_LIST is a directory (or is not set; then project root is used).
	This is meant to speed up project listing on large work trees by limiting
	search depth.  [Default: 2007]

I'm still not clear on what it actually means.  Is it used when
$projects_list points to a directory or not?  What if $projects_list
points to a file with lines that name directories?  What happens
when listing forks of a repository?

> +
> +$projects_list::
> +	Plain text file listing projects or name of directory
> +	to be scanned for projects.
> +
> +	Project list files should list one project per line, with each line
> +	having the following format
> +-----------------------------------------------------------------------------
> +<URI-encoded filesystem path to repository> SP <URI-encoded repository owner>
> +-----------------------------------------------------------------------------
> +
> +The default value of this variable is determined by the `GITWEB_LIST`
> +makefile variable at installation time.  If this variable is empty, gitweb
> +will fall back to scanning the `$projectroot` directory for repositories.

This gets formatted with the second and later paragraphs being
unindented; presumably it needs a "+", like so:

		... paragraph 1 ...
	+
	--
	... remaining paragraphs ...
	--

Can't this point to a directory, too?

> +
> +$export_ok::
> +	Show repository only if this file exists (in repository).  Only
> +	effective if this variable evaluates to true.  Can be set during
> +	building gitweb via `GITWEB_EXPORT_OK`.  [No default / Not set]

Am I supposed to show a repository?  Ah, no, this is about what gitweb
does.  Maybe

	Filename to look for in repositories to determine whether to
	show them.  If this variable evaluates to true, gitweb will
	only show repositories that contain a magic file with that
	name; otherwise, which repositories gitweb shows is controlled
	by the $strict_export option.  Can be set when building gitweb
	using the `GITWEB_EXPORT_OK` variable.  [No default]

Might be simpler to put the documentation of $strict_export first.
gitweb/INSTALL says:

	gitweb
	shows repositories only if this file exists in its object database
	(if directory has the magic file named $export_ok)

but I assume what was meant is the git dir, not .git/objects.

Incidentally, wouldn't it be more intuitive to treat all values of
$export_ok as true (i.e., check "if (defined($export_ok))" instead of
"if ($export_ok)") so the user doesn't need to know what values perl
considers to be true?

> +$export_auth_hook::
> +	Show repository only if this subroutine returns true, when given as
> +	the only parameter the full path to the project.

		Subroutine to decide whether to show a project.  Its only
		parameter is the full filesystem path to the repository.
	+
	Example:

[...]
> +$strict_export::
> +	Only allow viewing of repositories also shown on the overview page.
> +	This for example makes `$gitweb_export_ok` file decide if repository is
> +	available and not only if it is shown.  If `$gitweb_list` points to
> +	file with list of project, only those repositories listed would be
> +	available for gitweb.  Can be set during building gitweb via
> +	`GITWEB_STRICT_EXPORT`.  [No default / Not set]

I think I'd put this before $export_ok (because simpler) and steal
text from INSTALL.

	By default, even if a project is not visible on the projects list
	page, you can view it by hand-crafting a gitweb URL.  Set the
	$strict_export variable to true if you want to only allow
	repositories shown on the overview page to be viewed.  Can be
	set during ...

> +Finding files
> +~~~~~~~~~~~~~
> +Those configuration variables tell gitweb where to find files.  Values of
> +those variables are paths on filesystem.  Of those only `$GIT` is required
> +to be (correctly) set for gitweb to be able to work; all the rest are
> +required only for extra configuration or extra features.

Perhaps:

	System paths
	~~~~~~~~~~~~
	These configuration variables tell gitweb where to find commands and 
	system files.  The values of these variables are commands or
	paths on the filesystem.  Of these, only ...

(s/those/these/; add some wiggle room since $GIT = "git" is allowed;
change the title to contrast with the repository location variables;
add a comma.)

> +
> +$GIT::
> +	Core git executable to use.  By default set to `$GIT_BINDIR/git`, which
> +	in turn is by default set to `$(bindir)/git`.  If you use git from binary
> +	package, set this to "/usr/bin/git".  This can just be "git" if your
> +	webserver has a sensible PATH.  If you have multiple git versions installed
> +	it can be used to choose which one to use.

A setting like $GIT = "git --exec-path=elsewhere" would not work
because the entire string is used as the first argument to execvp.
Not sure how to say it: maybe just

	Command name to use when running git commands.  By default
	this is set to ...

("command name" being a phrase I made up on the spot for "path or
bare command name, suitable for passing to execvp".)

I think a better default would be "git", so if a newer git gets
installed in /usr/local/bin then gitweb would notice automatically.

> +$mimetypes_file::
> +	File to use for (filename extension based) guessing of MIME types before
> +	trying '/etc/mime.types'.  Path, if relative, is taken currently as
> +	relative to the current git repository.  [Unset by default]

What makes $mimetypes_file fit in this section but not $export_ok?  (I
have no good answer.  Maybe a separate section for MIME type guessing
would be more discoverable?)

> +
> +$highlight_bin::
> +	Path to the highlight executable to use (must be the one from
> +	http://www.andre-simon.de due to assumptions about parameters and output).
> +	Useful if 'highlight' is not installed on your webserver's PATH.
> +
> +	*Note* that if you want to add support for new syntax (supported by
> +	"highlight" but not used by gitweb), you need to modify `%highlight_ext`
> +	or `%highlight_basename`, depending on whether you detect type of file
> +	based on extension (for example "*.sh") or on its basename (for example
> +	"Makefile").  Keys of those hashes are extension or basename,
> +	respectively, and value for given key is name of syntax to be passed via
> +	`--syntax <syntax>` to highlighter.
> +
> +	[Default: 'highlight']

Needs "+" continuation lines, presumably.

> +Links and their targets
> +~~~~~~~~~~~~~~~~~~~~~~~
> +Configuration variables described below configure some of gitweb links:
> +their target and their look (text or image), and where to find page
> +prerequisites (stylesheet, favicon, images, scripts).  Usually they are left
> +at their default values, with the possible exception of `@stylesheets`
> +variable.

Does "Usually they are left at" mean "Usually there is no reason to change
them from"?  Aside from that, makes sense.

> +
> +@stylesheets::
> +	List of URIs of stylesheets (relative to base URI of a page). You
> +	might specify more than one stylesheet, for example use gitweb.css
> +	as base, with site specific modifications in separate stylesheet
> +	to make it easier to upgrade gitweb. You can add a `site` stylesheet
> +	for example by putting
> +----------------------------------------------------------------------------
> +push @stylesheets, "gitweb-site.css";
> +----------------------------------------------------------------------------
> +in the gitweb config file.  Those values that are relative paths, are
> +relative to base URI of gitweb.
> +
> +This list should contain URI of gitweb's stylesheet.  The URI of gitweb
> +stylesheet is set during build time via `GITWEB_CSS` variable.  It's default
> +value is 'static/gitweb.css' (or 'static/gitweb.min.css' if the `CSSMIN`
> +variable is defined, i.e. if CSS minifier is used during build.
> +
> +*Note*: there is also legacy `$stylesheet` configuration variable, which was
> +used by older gitweb.

s/gitweb$/gitweb's/; s/It's/Its/.  Missing closing paren, I think.

s/legacy/the legacy/.  How does this interact with the legacy setting (e.g.,
if I am new on my job as gitweb administrator and encounter such a line,
what does it mean and what would I want to change it to)?

Missing "+" continuation lines.

> +
> +$logo::
> +	Points to the location where you put 'git-logo.png' on your web
> +	server, or to be more generic URI of logo, 72x27 size).  This image
> +	is displayed in top right corner of each gitweb page, and used as
> +	logo for Atom feed.  Relative to base URI of gitweb (as a path).
> +	Can be adjusted during building gitweb using `GITWEB_LOGO` variable
> ++
> +	[Default: 'static/git-logo.png']

Re "as a path": can this be a URI pointing to another server if I want
it to?

[...]
> +$home_link::
> +	Target of the home link on top of all pages (the first part of view
> +	"breadcrumbs").  By default set to absolute URI of a page ($my_uri).

s/By default set to absolute URI of a page/The default is the absolute
URI for the gitweb script/

Stopping here.  Will resume later but since having something is better
than nothing, I am tempted to say this should be applied e.g. to
"next" so people can start using it right away and finding/fixing
documentation bugs.
