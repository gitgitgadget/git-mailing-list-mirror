From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] gitweb: add a setting to control the tabstop width
Date: Tue, 4 Mar 2008 08:36:02 +0000
Message-ID: <20080304083602.GA13585@hashpling.org>
References: <20080303221159.GA6875@hashpling.org> <7vhcfnfljw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 09:37:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWSe5-0007c5-96
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 09:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759237AbYCDIgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 03:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761149AbYCDIgN
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 03:36:13 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:51296 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760295AbYCDIgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 03:36:10 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1JWSd6-00054P-OS; Tue, 04 Mar 2008 08:36:08 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m248a2RQ014269;
	Tue, 4 Mar 2008 08:36:02 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m248a2ST014268;
	Tue, 4 Mar 2008 08:36:02 GMT
Content-Disposition: inline
In-Reply-To: <7vhcfnfljw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: 286ee74a803c04f16dde94d2b74a8098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76051>

On Mon, Mar 03, 2008 at 03:13:39PM -0800, Junio C Hamano wrote:
> Some people say "Tabs are 8 characters, and thus indentations are also 8
> characters.  There are heretic movements that try to make indentations 4
> (or even 2!)  characters deep, and that is akin to trying to define the
> value of PI to be 3."  Some people disagree.
> 
> But while viewing what is etched in the history, it does not hurt anybody
> else if the viewer uses different tab width.  Choice is good.
> 
> However, a choice made by the hosting service that runs gitweb would not
> help individual viewers with different tab-width taste.  Neither does
> configuration that is per-repository.  Participants of the same project
> would want to view contents with different tab-width.

I don not want to, nor shall I, argue about what interpretation of
ASCII HT is correct. I do want to argue that choice is good, and
furthermore that choice at the project level is appropriate.

Personally, I do not agree that participants of the same project would
want to view contents with different tab-width - or if they do, that
they shouldn't ;-) .

I work on, or contribute to, a number of projects. I have a preference
for indentation level of source, but I try to match the conventions of
the project to which I am contributing. If tabs are used, and if so
how wide they are, are important project conventions.

For some projects they are mandatory standards.

For some sets of conventions the width of a tab is not important, but
for many they are.

You can have the convention that tabs shall not be used, but you
cannot have a convention that tabs shall or can be used in conjunction
with a convention about maximum line length without and agreement on
tab-width.

git-mergetool.sh exhibits an example. If you look at the file with
tabs set to 4 then the gvimdiff 'case' in the merge_file shell
function *looks* correctly indented, but in other cases, the contents
of the if statements do not look indented when they should be.

If you look at git-mergetool.sh with tabs set to 8, then the other
cases look correctly indented, but the gvimdiff case is over-indented.

Clearly, what happened is that a user edited a file that should have
been viewed with ts=8 as ts=4 and the result is now 'wrong' in
different ways in different places.

[ Aside: this particular inconsistency is fixed in pu :-) ]

> On the other hand, maybe the tab-width customization is not about user
> preference but what tab-width was used when the contents were created.  In
> such a case, probably the right thing to do would be to look at the
> tab-width hints embedded in the file.  In such a case, probably the tab
> width setting need to be per-path (e.g. *.c files may use standard 8,
> while *.py may use heretic 4).  Again, site-wide or repository-wide
> configuration would not help.

This, I certainly agree with more. Tab width is about choice at
content creation. My argument is that choice at content creation
should follow project-wide conventions. I agree that my patch doesn't
provide a totally flexible solution but I do believe that there are
projects that either use one type of source file - or at least only one
tab width - which would benefit from the patch.

I run a gitweb.cgi which has a handful of projects, one of which uses
a popular IDE on a popular proprietary OS and uses a ts=4 convention
and another which uses ts=8 convention. The patch was driven by this
requirement and a (possibly erroneous) feeling that I probably wasn't
alone.

> In short, I do not like the patch, not because I do not like customizable
> tab-width, but because I think the customizability the patch offers is of
> the wrong kind and too limited to be useful.

Whereas I believe it provides some useful customization, the
customization is appropriate in many situations and the costs
(performance and code complexity) are minimal. Obviously, integration
is your call, but the patch will certainly stay on my own http server.

> P.S.
> 
> It might be interesting to come up with a heuristics to _guess_ the tab
> width used by the content creator by looking at the contents, by the way.
> There obviously are Emacs "Local Variables" and "-*-" lines and equivalent
> clues vim would leave, but you could probably also use indentation levels
> as a cue.

Perhaps. I don't really care for -*- style fluff but that's just
personal. The heuristics could be tricky to get right, probably
impossible in the case of users with tab conventions mangling the same
file :-) .

> And perhaps teach the underlying git commands a special flag to expand
> tabs on the output.
> 
> 	"git cat-file --expand=auto blob Makefile"
> 	"git diff --expand=8 HEAD^..HEAD frotz.c"
> 
> ;-)
> 

And I'd argue that expanding tabs was the job of the terminal and not
core git, but hey :-) !

Charles.
