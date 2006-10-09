From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] gitweb wishlist and TODO list
Date: Mon, 09 Oct 2006 14:49:03 +0200
Organization: At home
Message-ID: <egdge3$t12$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Oct 09 15:10:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWuom-0008OC-SP
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 15:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbWJINFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 09:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbWJINFH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 09:05:07 -0400
Received: from main.gmane.org ([80.91.229.2]:55758 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932727AbWJINFF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Oct 2006 09:05:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWueF-0005W7-AS
	for git@vger.kernel.org; Mon, 09 Oct 2006 14:54:23 +0200
Received: from host-81-190-27-91.torun.mm.pl ([81.190.27.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Oct 2006 14:54:23 +0200
Received: from jnareb by host-81-190-27-91.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Oct 2006 14:54:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-91.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28570>

There is a new part of gitweb TODO list and wishlist; planned features and
features it would be nice to have. If you have new ideas, if you want some
features to be implemented first, if you use some web interface to some SCM
you like, please do contribute.

I've tried to divide this TODO/wishlist into categories.


1. Cleanups and refactoring

 * HTML and CSS cleanup. All (or almost all) styling should be done using
   CSS, and not embedded style or presentation elements. All HTML elements
   except perhaps a few should have either class attribute (if such
   element can be multiple times on page) or id attribute (if there can be
   only one such element). Perhaps some class attributes should be changed
   to id attributes. Gitweb has much improved from the incorporation in
   this area.

 * CSS refactoring. Try to avoid repeating the same styling, using
   combination of descendant and _child_ selectors, perhaps also
   adjacent sibling selector and attribute/attribute value selector.
   Perhaps large reorganization patch (moving contents within CSS and adding
   comments) is to be done...

 * Code refactoring. Separate/refactor common parts and put them into
   separate subrotines OR collapse similar subrotines into one subroutine
   with an argument selecting the case. For example git_blob and
   git_blob_plain could be collapsed; git_shortlog, git_tags/git_heads,
   git_log, git_history do similar work. When the new
   --grep/--author/--commiter options to git-rev-list hits released version,
   perhaps also git_search could be put together with the previous set.
   git_rss does similar work as a git_summary.

 * Refactor printing related links (like "blame | history | raw" for blob
   entries in tree view) into separate subroutine. The list depends both on
   the kind of object pointed, and on the current action/view.

 * Perhaps refactor reading and validation of parameters, except the ones
   used for dispatch i.e. project and action parameters, into separate
   subroutine
 
        my ($hash, $hash_base) = gitweb_params('hash', 'hash_base');    

   I'm not sure if it is/would be usefull.


2. Git.pm-ish (subroutines which in generalized version are/could be
   in Git.pm)
 
 * Refactor calling a git command and reading it's output into separate
   subroutine git_command/git_pipe, so for example if someone _has_ to use
   gitweb with ancient Perl version which does not understand list version
   of magic "-|" open could do it changing only one subroutine. Well, we can
   use Git.pm when it hits main release.

 * Add subroutine/subroutines, which given a full name of ref, returns
   either another ref if input ref was symlink/symref, or hash of the
   pointed object, and which work not only with ordinary loose refs, but
   also with symlinks, symrefs (up to some level of recursion) and packed
   refs. All without calling any git command. But I guess that currently
   it is not needed at all.

 * Add simplified git config file parser, which would _read_ only gitweb
   entries (and convert them to bool/int if necessary). With this we could
   move description, category, export_ok, .hide, cloneurl to config file,
   instead of cluttering $GIT_DIR. Or just make it an option (read file
   first, if it doesn't exist try config file).

 * Parsing of remotes/ files _and_ equivalent config entries, for adding
   information (tooltip?) about tracking branches in heads view, and for
   adding information about given subdirectory in refs/remotes/ (see below).


3. Optimizing gitweb

 * Use git-for-each-ref (when it hits released version) to speed up of
   generation of summary, heads and tags views. It would also enable the
   option of having most recent commit date in projects list view, and not
   most recent commit in current branch (in HEAD).
 
 * Add better support for mod_perl, e.g. $r->path_info(), via checking for
   MOD_PERL enviromental variable.

 * Better support for mod_perl/FastCGI, perhaps wrapping the changeable part
   into gitweb_handler subroutine, and calling it.


4. New features

 * Add support for other directories in $refs/ besides "heads" and
   "tags" directories, for example refs/remotes/ generated when cloning with
   --use-separate-remote option. On short TODO list.

 * Add categories support a la gitweb-xmms2 to the projects list view (and
   perhaps also OPML); perhaps with option to use first part of path to
   repository as category.

 * Code highlighting (or generic filter) support in blob view, perhaps as
   a feature. Proposed tools for generating syntax highlighting include
   Highlight (http://www.andre-simon.de) and GNU Source Highlight
   (http://www.gnu.org/software/src-highlite) a la gitweb-xmms2.
   Gitweb-xmms2 uses Highlight, and due to the tags support uses temporary
   files. I think that CSS for code highlighting should be in separate file,
   and that selecting syntax to use should be done using mime.types like
   file rather than gitweb-xmms2 internal configuration (hash of
   extensions).

 * Committags support from gitweb-xmms2 in commit, commitdiff, log views and
   in the top commit summary/title link on most pages. There was preliminary
   patch on git mailing list for committags support (more general than
   the support in gitweb-xmms2), with current commitsha link (now in
   format_log_line_html) implemented as committag. Junio had quite
   a good idea how to avoid having to do committags _after_ HTML escaping,
   and how to stack committags. I'm not sure if it wouldn't be better to try
   to do all committags in one go, instead of stacking. Perhaps also commit
   message "syntax highlighting" (i.e. highlighting signoff lines) and empty
   lines simplification should be done using committags.

 * Crossreferencing in blob view. Gitweb-xmms2 uses if I remember correctly
   etags to generate anchors and to generate hyperlinks to definition of
   function. GNU Highlight can use encumberant-tags IIRC. Both need I think
   temporary files for index. Perhaps this should be done rather as a part
   of gitweb/git integration with LXR Cross Referencer. 

   Do you know other projects that could be used instead of etags here?

   I'm not sure if it is worth to pursue implementing it now.

 * Improve blame view, making use of --porcelain option to git-blame (for
   later). Perhaps change blame view from table based one to div based one.
   Use different colors for different commits (graph coloring problem).

 * Perhaps add some kind of finding closest preceding/following tag. and on
   which branch we are on. Tempered of course by the concerns of
   performance. What is possible for locally run history browser like gitk
   or qgit, might be not feasible on server run web interface.

 * Add information from remotes/ to heads view, for example the following
     tracks branch 'master' of git://git.kernel.org/pub/scm/git/git (origin)
   as a tooltip for 'origin' branch. But what if one branch tracks more than
   one remote? Needs to use also config file.

 * Support for tracking renames in history view. Simple rename tracking
   I think could be done directly in gitweb; more advanced would need
   --follow option (i.e. core git improvement).

 * log/shortlog should be a format, so we could have log-like history, tags,
   heads views.

 * add summary of number of lines changed for each file (a la darcsview)
   in the difftree part of commit and *diff* views, e.g.

        blame.c   +1 -0  diff | history | blame

   or something like that.

 * add extended header to the commitdiff and perhaps blobdiff views,
   hyperlinked. _This_ would add some patches to commitdiff view, which are
   now IIRC visible only in difftree part now.

 * enable sorting tags/heads view by name instead of sorting it by date.


5. New views

 * Reflog view (most probably limited to heads only). I'm not sure if it is
   worth time spend on calling git commands to mark unreachable commits for
   example using strikethrough, and hyperlink reachable. Any ideas how such
   a view should look like?

 * ViewVC-like tree-blame view. There was RFC patch adding tree_blame view
   some time ago here, on git mailing list. The main problem of course is
   performance. We could implement tree_blame purely in gitweb as it was
   done in mentioned patch (having --stdin option to git-ls-tree would
   help), or add new core command/extend git-blame for directories. There is
   also a question if we want to find blame for tree entries, or not.

 * "List of the files in given directory, touched by given commit"

 * Perhaps ad Atom feed support as an alternative to RSS, and XOXO as an
   alternative to OPML.

 * Graph of number of changed files in given branch; probably should be
   cached.


X. Proposed improvements to core git commands
 * add --stdin option to git-ls-tree, a la --stdin option to git-diff-tree.
 * add --follow option to git-rev-list, allow to provide path limiter via
   stdin (with --stdin option) in git-diff-tree
 * add --numstat option to git-diff; currently only git-apply has it.


Thoughts? Comments?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
