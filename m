From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Tue, 10 Oct 2006 22:52:57 -0700
Message-ID: <7v1wpfwg92.fsf@assigned-by-dhcp.cox.net>
References: <egdge3$t12$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 07:53:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXX1o-0007ip-8T
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 07:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWJKFw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 01:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWJKFw7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 01:52:59 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39067 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030287AbWJKFw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 01:52:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011055258.DANT6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Oct 2006 01:52:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ytt01V00h1kojtg0000000
	Wed, 11 Oct 2006 01:53:01 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <egdge3$t12$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	09 Oct 2006 14:49:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28694>

Jakub Narebski <jnareb@gmail.com> writes:

> 1. Cleanups and refactoring
>
>  * HTML and CSS cleanup. All (or almost all) styling should be done using
>    CSS, and not embedded style or presentation elements. All HTML elements
>    except perhaps a few should have either class attribute (if such
>    element can be multiple times on page) or id attribute (if there can be
>    only one such element). Perhaps some class attributes should be changed
>    to id attributes. Gitweb has much improved from the incorporation in
>    this area.

It scares me when somebody says "all X should do Y".  Aiming for
consistency and cleanliness is good but taking it to extreme and
becoming dogmatic about it isn't.  Let's not repeat the crusade
against redundant links.

>    ... When the new
>    --grep/--author/--commiter options to git-rev-list hits released version,
>    perhaps also git_search could be put together with the previous set.

Sounds like a good idea, but I think people can (and should)
start preparing for it in "next"; after all that is what "next"
is for.

>  * Refactor calling a git command and reading it's output into separate
>    subroutine git_command/git_pipe, so for example if someone _has_ to use
>    gitweb with ancient Perl version which does not understand list version
>    of magic "-|" open could do it changing only one subroutine. Well, we can
>    use Git.pm when it hits main release.

I agree this is a good thing to do while refactoring.  There are
too many similar looking code sprinkled all over.  Git.pm is
already in the "master" and there is nothing cooking in "next".

>  * Add simplified git config file parser, which would _read_ only gitweb
>    entries (and convert them to bool/int if necessary). With this we could
>    move description, category, export_ok, .hide, cloneurl to config file,
>    instead of cluttering $GIT_DIR. Or just make it an option (read file
>    first, if it doesn't exist try config file).

I do not see why you would need anything "simplified"; I think
writing a .git/config parser purely in Perl is much easier than
waiting for libified interface that talks .xs and would run just
as efficient -- after all Perl is the ideal tool for text file
processing like this.  And I do not particularly worry about
issues that could arise from two different configuration parsers
having different set of bugs.  The file format is simple enough.
It would be a very good addition to Git.pm suite.

>  * Add categories support a la gitweb-xmms2 to the projects list view (and
>    perhaps also OPML); perhaps with option to use first part of path to
>    repository as category.

Perhaps; hosting site would want this.

>  * Code highlighting (or generic filter) support in blob view, perhaps as
>    a feature.

Not particularly interested myself but as long as it would not
add huge load on the server I would not much object either.

>  * Crossreferencing in blob view.

Lxr is certainly interesting, but I would rather use local "git grep".

>  * add summary of number of lines changed for each file (a la darcsview)
>    in the difftree part of commit and *diff* views, e.g.
>
>         blame.c   +1 -0  diff | history | blame
>
>    or something like that.

I'll place "diff --numstat" to the stack of "things to do on the
core side".  Should be trivial.

>  * Reflog view (most probably limited to heads only). I'm not sure if it is
>    worth time spend on calling git commands to mark unreachable commits for
>    example using strikethrough, and hyperlink reachable. Any ideas how such
>    a view should look like?

If the feature is useful, do not be afraid to add core side
support for it.  As long as the proposed core side support is
reasonable and not too specific to a niche task, that is.

>  * "List of the files in given directory, touched by given commit"

Have no idea what you mean.  "diff-tree -r --name-only $commit"?

> X. Proposed improvements to core git commands
>  * add --stdin option to git-ls-tree, a la --stdin option to git-diff-tree.

Not particularly interested, as it is unclear how the output
boundary should be marked, but should be trivial to add once we
know what the output should look like.

>  * add --follow option to git-rev-list, allow to provide path limiter via
>    stdin (with --stdin option) in git-diff-tree

The "path limiter via stdin" part is murky.  I would not object
to "rev-list --follow=$this_path_at_the_tip $start_at_this_commit"
which I can see clear semantics for. 
