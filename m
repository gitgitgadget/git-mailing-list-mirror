From: Drew Northup <drew.northup@maine.edu>
Subject: [PATCH/WIP] Starting work on a man page for /etc/gitweb.conf
Date: Wed, 11 May 2011 15:21:04 -0400
Message-ID: <1305141664.30104.11.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alan Chandler <alan@chandlerfamily.org.uk>,
	Ask =?ISO-8859-1?Q?Bj=F8rn?= Hansen <ask@develooper.com>,
	Bruno Ribas <ribas@c3sl.ufpr.br>,
	Christopher Wilson <cwilson@cdwilson.us>,
	Gerrit Pape <pape@smarden.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jim Meyering <jim@meyering.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin Waitz <tali@admingilde.org>,
	Matthias Lederhofer <matled@gmx.net>,
	Matt McCutchen <matt@mattmccutchen.net>,
	Mike Ralphson <mike@abacus.co.uk>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Sylvain Rabot <sylvain@abstraction.fr>,
	Alexander Gavrilov <angavrilov@gmail.com>,
	Mark Rada <marada@uwaterloo.ca>,
	Junio C Hamano <gitster@pobox.co
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 21:25:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKF27-0000dB-K6
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 21:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab1EKTZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 15:25:11 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:37548 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1EKTZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 15:25:09 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p4BJLA3R028559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 11 May 2011 15:21:15 -0400
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=23
	Fuz1=23 Fuz2=23
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p4BJLA3R028559
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1305746480.70702@T7ABTQvLOGflONBdAshdfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173422>

This is a work in progress. Much of what is in it has been pulled
directly from the README and INSTALL files of gitweb. No effort has yet
been made to de-duplicate any of this.

TODO:
  * Clean up README and INSTALL files
  * Add Makefile rules to build man / HTML pages.
  * Remove or rephrase redundant portions of original documentation
  * A lot more...
---

Notes:
There ARE INTENTIONAL WHITESPACE ERRORS (Yuck!) to make asciidoc happy. :-(

I have been compiling this with a hand-made test-script into both manpage and
HTML formats during my testing. It was made by observing what make was doing
on my platform @home (Slackware 13.0 currently).

This is not quite ready for the big time, so I expect (and hope for) lots of
criticism (of the constructive kind?).

If you don't really need (or want) to be on the CC list let me know. You were
in the output of 'git blame'....

 gitweb/gitweb.conf.txt |  294 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 294 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/gitweb.conf.txt

diff --git a/gitweb/gitweb.conf.txt b/gitweb/gitweb.conf.txt
new file mode 100644
index 0000000..c14847a
--- /dev/null
+++ b/gitweb/gitweb.conf.txt
@@ -0,0 +1,294 @@
+gitweb.conf(5)
+==============
+
+NAME
+----
+gitweb.conf - Gitweb configuration file
+
+SYNOPSIS
+--------
+/etc/gitweb.conf
+
+DESCRIPTION
+-----------
+'Gitweb' is a CGI application for viewing Git repositories over the web. The
+configuration file is used to override the default settings that were built
+into gitweb at the time Git itself was compiled. While one could just alter
+the configuration settings in the gitweb CGI itself, those changes would be
+lost upon upgrade. Configuration settings my also be placed into a file in
+the same directory as the CGI script with the default name
+`gitweb_config.perl` &#8211; allowing one to have multiple gitweb instances
+with different configurations by the use of symlinks.
+
+
+DISCUSSION
+----------
+
+The location of `gitweb.conf` is defined at compile time using the
+configuration value `GITWEB_CONFIG_SYSTEM` and defaults to /etc/gitweb.conf.
+The name of the per-instance configuration file is defined in gitweb by
+`GITWEB_CONFIG`.
+
+*NOTE:* Values defined in the per-instance configuration file override both
+values found in the gitweb CGI as well as values found in the sytem-wide
+gitweb.conf file.
+
+The syntax of the configuration files is that of PERL, as these files are
+indeed handled as fragments of PERL code (the language that gitweb itself is
+written in). Variables may be set using "'our $variable = value'"; text from
+"#" character until the end of a line is ignored. See the perlsyn(1) man page
+for more information.
+
+One good reason to take advatage of the system-wide and local gitweb
+configuration files is that not all settings may be set up directly in the CGI
+itself. Optional features &#8211; defined using the '%features' variable
+&#8211; must be set in one of the two configuration files.
+
+CONFIGURATION SETTINGS
+----------------------
+Standard Options
+~~~~~~~~~~~~~~~~~
+The following are not typically set or overridden at build time:
+
+$GIT::
+	Core git executable to use.  By default set to `$GIT_BINDIR/git`, which
+	in turn is by default set to `$(bindir)/git`.  If you use git from binary
+	package, set this to "/usr/bin/git".  This can just be "git" if your
+	webserver has a sensible PATH.  If you have multiple git versions installed
+	it can be used to choose which one to use.
+$version::
+	Gitweb version, set automatically when creating gitweb.cgi from
+	gitweb.perl. You might want to modify it if you are running modified
+	gitweb.
+$projectroot::
+	Absolute filesystem path which will be prepended to project path;
+	the path to repository is `$projectroot/$project`.  Set to
+	`$GITWEB_PROJECTROOT` during installation.  This variable has to be
+	set correctly for gitweb to find repositories.
+$projects_list::
+	Source of projects list, either directory to scan, or text file
+	with list of repositories (in the "`<URI-encoded repository path> SP
+	<URI-encoded repository owner>`" line format; actually there can be
+	any sequence of whitespace in place of space (SP)).  Set to
+	`$GITWEB_LIST` during installation.  If empty, `$projectroot` is used
+	to scan for repositories.
+$my_url, $my_uri::
+	Full URL and absolute URL of gitweb script;
+	in earlier versions of gitweb you might have need to set those
+	variables, now there should be no need to do it.  See
+	`$per_request_config` if you need to set them still.
+$base_url::
+	Base URL for relative URLs in pages generated by gitweb,
+	(e.g. `$logo`, `$favicon`, `@stylesheets` if they are relative URLs),
+	needed and used only for URLs with nonempty PATH_INFO via
+	'<base href="$base_url">'.  Usually gitweb sets its value correctly,
+	and there is no need to set this variable, e.g. to $my_uri or "/".
+	See `$per_request_config` if you need to set it anyway.
+$home_link::
+	Target of the home link on top of all pages (the first part of view
+	"breadcrumbs").  By default set to absolute URI of a page ($my_uri).
+@stylesheets::
+	List of URIs of stylesheets (relative to base URI of a page). You
+	might specify more than one stylesheet, for example use gitweb.css
+	as base, with site specific modifications in separate stylesheet
+	to make it easier to upgrade gitweb. You can add a `site` stylesheet
+	for example by using +
+		`push @stylesheets, "gitweb-site.css";`  + 
+	in the gitweb config file.
+$logo_url, $logo_label::
+	URI and label (title) of GIT logo link (or your site logo, if you choose
+	to use different logo image). By default they point to git homepage;
+	in the past they pointed to git documentation at www.kernel.org.
+$projects_list_description_width::
+	The width (in characters) of the projects list "Description" column.
+	Longer descriptions will be cut (trying to cut at word boundary);
+	full description is available as 'title' attribute (usually shown on
+	mouseover).  By default set to 25, which might be too small if you
+	use long project descriptions.
+@git_base_url_list::
+	List of git base URLs used for URL to where fetch project from, shown
+	in project summary page.  Full URL is "`$git_base_url/$project`".
+	You can setup multiple base URLs (for example one for  git:// protocol
+	access, and one for http:// "dumb" protocol access).  Note that per
+	repository configuration in 'cloneurl' file, or as values of gitweb.url
+	project config.
+$default_blob_plain_mimetype::
+	Default mimetype for blob_plain (raw) view, if mimetype checking
+	doesn't result in some other type; by default 'text/plain'.
+$default_text_plain_charset::
+	Default charset for text files. If not set, web server configuration
+	would be used.
+$mimetypes_file::
+	File to use for (filename extension based) guessing of MIME types before
+	trying /etc/mime.types. Path, if relative, is taken currently as
+	relative to the current git repository.
+$fallback_encoding::
+	Gitweb assumes this charset if line contains non-UTF-8 characters.
+	Fallback decoding is used without error checking, so it can be even
+	'utf-8'. Value must be valid encoding; see Encoding::Supported(3pm) man
+	page for a list.   By default 'latin1', aka. 'iso-8859-1'.
+@diff_opts::
+	Rename detection options for git-diff and git-diff-tree. By default
+	(\'-M'); set it to (\'-C') or (\'-C', \'-C') to also detect copies, or
+	set it to () if you don't want to have renames detection.
+$prevent_xss::
+	If true, some gitweb features are disabled to prevent content in
+	repositories from launching cross-site scripting (XSS) attacks.  Set this
+	to true if you don't trust the content of your repositories.
+[Default: false].
+$maxload::
+	Used to set the maximum load that we will still respond to gitweb queries.
+	If server load exceed this value then return "503 Service Unavailable"
+	error. Server load is taken to be 0 if gitweb cannot determine its value.
+	Set it to undefined value to turn it off. [Default: 300]
+$highlight_bin::
+	Path to the highlight executable to use (must be the one from
+	http://www.andre-simon.de due to assumptions about parameters and output).
+	Useful if highlight is not installed on your webserver's PATH.
+	[Default: highlight]
+$per_request_config::
+	If set to code reference, it would be run once per each request.  You can
+	set parts of configuration that change per session, e.g. by setting it to +
+		`sub { $ENV{GL_USER} = $cgi->remote_user || "gitweb"; }`  + 
+	Otherwise it is treated as boolean value: if true gitweb would process
+	config file once per request, if false it would process config file only
+	once.  Note: $my_url, $my_uri, and $base_url are overwritten with
+	their default values before every request, so if you want to change
+	them, be sure to set this variable to true or a code reference effecting
+	the desired changes.  [Default: true]
+
+Configuration Options Often Set at Compile Time
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+These configuration variables are often specified at compile time and are
+defined by default in the gitweb CGI itself:
+
+GIT_BINDIR::
+	Points where to find the git executable.  You should set it up to
+	the place where the git binary was installed (usually /usr/bin) if you
+	don't install git from sources together with gitweb.  [Default: $(bindir)]
+GITWEB_SITENAME::
+	Shown in the title of all generated pages, defaults to the server name
+	(SERVER_NAME CGI environment variable) if not set. [No default]
+GITWEB_PROJECTROOT::
+	The root directory for all projects shown by gitweb. Must be set
+	correctly for gitweb to find repositories to display.  See also
+	"Gitweb repositories" in the INSTALL file for gitweb.  [Default: /pub/git]
+GITWEB_PROJECT_MAXDEPTH::
+	The filesystem traversing limit for getting the project list; the number
+	is taken as depth relative to the projectroot.  It is used when
+	GITWEB_LIST is a directory (or is not set; then project root is used).
+	Is is meant to speed up project listing on large work trees by limiting
+	search depth.  [Default: 2007]
+GITWEB_LIST::
+	Points to a directory to scan for projects (defaults to project root
+	if not set / if empty) or to a file with explicit listing of projects
+	(together with projects' ownership). See "Generating projects list
+	using gitweb" in INSTALL file for gitweb to find out how to generate
+	such file from scan of a directory. [No default, which means use root
+	directory for projects]
+GITWEB_EXPORT_OK::
+	Show repository only if this file exists (in repository).  Only
+	effective if this variable evaluates to true.  [No default / Not set]
+GITWEB_STRICT_EXPORT::
+	Only allow viewing of repositories also shown on the overview page.
+	This for example makes GITWEB_EXPORT_OK to decide if repository is
+	available and not only if it is shown.  If GITWEB_LIST points to
+	file with list of project, only those repositories listed would be
+	available for gitweb.  [No default]
+GITWEB_HOMETEXT::
+	Points to an .html file which is included on the gitweb project
+	overview page ('projects_list' view), if it exists.  Relative to
+	gitweb.cgi script.  [Default: indextext.html]
+GITWEB_SITE_HEADER::
+	Filename of html text to include at top of each page.  Relative to
+	gitweb.cgi script.  [No default]
+GITWEB_SITE_FOOTER::
+	Filename of html text to include at bottom of each page.  Relative to
+	gitweb.cgi script.  [No default]
+GITWEB_HOME_LINK_STR::
+	String of the home link on top of all pages, leading to $home_link
+	(usually main gitweb page, which means projects list).  Used as first
+	part of gitweb view "breadcrumb trail": <home> / <project> / <view>.
+	[Default: projects]
+GITWEB_SITENAME::
+	Name of your site or organization to appear in page titles.  Set it
+	to something descriptive for clearer bookmarks etc.  If not set
+	(if empty) gitweb uses "$SERVER_NAME Git", or "Untitled Git" if
+	SERVER_NAME CGI environment variable is not set (e.g. if running
+	gitweb as standalone script).  [No default]
+GITWEB_BASE_URL::
+	Git base URLs used for URL to where fetch project from, i.e. full
+	URL is "$git_base_url/$project".  Shown on projects summary page.
+	Repository URL for project can be also configured per repository; this
+	takes precedence over URLs composed from base URL and a project name.
+	Note that you can setup multiple base URLs (for example one for
+	git:// protocol access, another for http:// access) from the gitweb
+	config file.  [No default]
+GITWEB_CSS::
+	Points to the location where you put gitweb.css on your web server
+	(or to be more generic, the URI of gitweb stylesheet).  Relative to the
+	base URI of gitweb.  Note that you can setup multiple stylesheets from
+	the gitweb config file.  [Default: static/gitweb.css (or
+	static/gitweb.min.css if the CSSMIN variable is defined / CSS minifier
+	is used)]
+GITWEB_LOGO::
+	Points to the location where you put git-logo.png on your web server
+	(or to be more generic URI of logo, 72x27 size, displayed in top right
+	corner of each gitweb page, and used as logo for Atom feed).  Relative
+	to base URI of gitweb.  [Default: static/git-logo.png]
+GITWEB_FAVICON::
+	Points to the location where you put git-favicon.png on your web server
+	(or to be more generic URI of favicon, assumed to be image/png type;
+	web browsers that support favicons (website icons) may display them
+	in the browser's URL bar and next to site name in bookmarks).  Relative
+	to base URI of gitweb.  [Default: static/git-favicon.png]
+GITWEB_JS::
+	Points to the location where you put gitweb.js on your web server
+	(or to be more generic URI of JavaScript code used by gitweb).
+	Relative to base URI of gitweb.  [Default: static/gitweb.js (or
+	static/gitweb.min.js if JSMIN build variable is defined / JavaScript
+	minifier is used)]
+HIGHLIGHT_BIN::
+	Path to the highlight executable to use (must be the one from
+	http://www.andre-simon.de due to assumptions about parameters and output).
+	Useful if highlight is not installed on your webserver's PATH.
+	[Default: highlight]
+
+
+Configuration File Example
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To enable blame, pickaxe search, and snapshot support, while allowing
+individual projects to turn them off, put the following in your
+GITWEB_CONFIG file:
+
+        $feature{'blame'}{'default'} = [1];
+        $feature{'blame'}{'override'} = 1;
+
+        $feature{'pickaxe'}{'default'} = [1];
+        $feature{'pickaxe'}{'override'} = 1;
+
+        $feature{'snapshot'}{'default'} = ['zip', 'tgz'];
+        $feature{'snapshot'}{'override'} = 1;
+
+If you allow overriding for the snapshot feature, you can specify which
+snapshot formats are globally disabled. You can also add any command line
+options you want (such as setting the compression level). For instance,
+you can disable Zip compressed snapshots and set GZip to run at level 6 by
+adding the following lines to your $GITWEB_CONFIG:
+
+        $known_snapshot_formats{'zip'}{'disabled'} = 1;
+        $known_snapshot_formats{'tgz'}{'compressor'} = ['gzip','-6'];
+
+FILES
+-----
+/etc/gitweb.conf, gitweb_config.perl
+
+
+SEE ALSO
+--------
+In Progress
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.7.4.1
