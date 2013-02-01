From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Fri, 1 Feb 2013 02:33:52 -0500
Message-ID: <20130201073352.GB970@sigill.intra.peff.net>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <20130131223305.GB21729@sigill.intra.peff.net>
 <20130131230455.GN27340@google.com>
 <20130201050343.GA29973@sigill.intra.peff.net>
 <7v7gmsd26o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 08:34:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1B8b-0000d8-RR
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 08:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab3BAHd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 02:33:56 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55247 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab3BAHdz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 02:33:55 -0500
Received: (qmail 18909 invoked by uid 107); 1 Feb 2013 07:35:19 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 02:35:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 02:33:52 -0500
Content-Disposition: inline
In-Reply-To: <7v7gmsd26o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215214>

On Thu, Jan 31, 2013 at 09:37:51PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > What was the original rationale for the "gitfoo" form? Was it just to
> > visually distinguish command manpages from non-command manpages? I can't
> > remember the origins now.
> 
> b27a23e (Documentation: convert tutorials to man pages, 2008-05-24)
> turns "tutorial.txt" into "gittutorial.txt".  Before that, there
> were git{attributes,cli,ignore,hooks,modules}.txt.  They were added
> in this order, which reveals the true reason:
> 
>     hooks.txt
>     gitignore.txt
>     gitmodules.txt
>     gitcli.txt
>     hooks.txt => githooks.txt
>     gitatributes.txt
> 
> Originally, we did not intend to name them as "git$concept.txt";
> instead, we just said "$concept.txt".  Hooks are "hooks", and we
> know we are discussing hooks in the context of Git, there was no
> reason to say "githooks".

Yes, but if we are going to install a manpage, we must include "git"
somewhere in the name since that context is lost in the global manpage
database. So we need "githooks.txt" or "git-hooks.txt".

> "gitignore" was about the file format,
> and it would have been insane to call it "ignore.txt".  The same
> applies to "gitmodules.txt".

Right. So we have some that must be "gitfoo", and others that do not
care. If we turned "githooks" into "git-hooks" and removed the "is it a
command?" magic from "git help", then "git help hooks" would still find
hooks. And likewise, "git help gitignore" would still find "gitignore".
But you could no longer say "git help ignore" to find "gitignore".

Which personally I am OK with. It is not a sensible thing to ask for;
the concept is not "ignore", but rather "the gitignore file".

> In other way, I think this wasn't designed, but organically grown.

Like many parts of git. :) I am starting to think it has grown in an
unnecessarily complex direction, and we would be much happier just
calling all of the "concept" documentation "git-".

The steps I see are:

  1. Modify builtin/help.c, like:

diff --git a/builtin/help.c b/builtin/help.c
index 6067a61..1eca4ea 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -308,10 +308,8 @@ static const char *cmd_to_page(const char *git_cmd)
 		return "git";
 	else if (!prefixcmp(git_cmd, "git"))
 		return git_cmd;
-	else if (is_git_command(git_cmd))
-		return prepend("git-", git_cmd);
 	else
-		return prepend("git", git_cmd);
+		return prepend("git-", git_cmd);
 }
 
 static void setup_man_path(void)


  2. Rename the "concept" files like:

 Documentation/{gitcli.txt => git-cli.txt}                             | 0
 Documentation/{gitcore-tutorial.txt => git-core-tutorial.txt}         | 0
 Documentation/{gitcredentials.txt => git-credentials.txt}             | 0
 Documentation/{gitcvs-migration.txt => git-cvs-migration.txt}         | 0
 Documentation/{gitdiffcore.txt => git-diffcore.txt}                   | 0
 Documentation/{gitglossary.txt => git-glossary.txt}                   | 0
 Documentation/{githooks.txt => git-hooks.txt}                         | 0
 Documentation/{gitnamespaces.txt => git-namespaces.txt}               | 0
 Documentation/{gitrepository-layout.txt => git-repository-layout.txt} | 0
 Documentation/{gitrevisions.txt => git-revisions.txt}                 | 0
 Documentation/{gittutorial-2.txt => git-tutorial-2.txt}               | 0
 Documentation/{gittutorial.txt => git-tutorial.txt}                   | 0
 Documentation/{gitworkflows.txt => git-workflows.txt}                 | 0


  3. Teach Documentation/Makefile about the new filenames. MAN1_TXT
     includes git-*.txt, which is no longer right. I think we'd need to
     just filter out what is in MAN5_TXT and MAN7_TXT.

  4. Replace the rename "gitfoo" above with a "see git-foo..." pointer.
     Users of "git help foo" would not ever see this, but people who
     have trained their fingers to type "man gitfoo" would, along with
     anybody following an outdated HTML link.

  5. Update internal references to "linkgit:gitfoo" to point to
     "git-foo".

Hmm. That really does not seem so bad. The biggest downside is the
people who have to see the redirect made in step 4.

But I have not thought about it too hard, so maybe there is something
else I'm not seeing.

-Peff
