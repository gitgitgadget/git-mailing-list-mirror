Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350DD203BD
	for <e@80x24.org>; Fri, 12 Aug 2016 07:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbcHLHJa (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:09:30 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:24753 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbcHLHIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:08:49 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y6ZUbGDs4xR4bY6ZWbadhL; Fri, 12 Aug 2016 08:08:03 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=8q6LdnVOAAAA:8
 a=PKzvZo6CAAAA:8 a=CQMmv4Y0rQEm21PX9QMA:9 a=xts0dhWdiJbonKbuqhAr:22
 a=jNYSTCpFY2gkngftge3H:22 a=q92HNjYiIAC_jH7JDaYf:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:	Marc Branchaud <marcnarc@xiplink.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 04/12] doc: revisions: give headings for the two and three dot notations
Date:	Fri, 12 Aug 2016 08:07:41 +0100
Message-Id: <20160812070749.2920-5-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812070749.2920-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfIX5JytRkiay/4wwBbHcaFB7QVV3M+lk7t9UteUa0IDNAkg8LX4WgIdyE11nAyE2H6OrzYncaZW+LERCWTVKulk8X3kP9qobQI3zqyP666jE1uFMteDW
 RnbYFoRTcGbarMtl3s/J7tBnDz2SG6qNL2IPO9V+D8sQRmPo4F7giBk8Xf5ZtsTKz8DfSNhw8Luaev/VsAFqnBHXIFj/phmb8bTugpgWgWi+KNd2+/GhcsYD
 IMYwEUrMlW5mYV3vJ5EY/w==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

While there, also break out the other shorthand notations and
add a title for the revision range summary (which also appears
in git-rev-parse, so keep it mixed case).

We do not quote the notation within the headings as the asciidoc ->
docbook -> groff man viewer toolchain, particularly the docbook-groff
step, does not cope with two font changes, failing to return the heading
font to bold after the quotation of the notation.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
Cc: Marc Branchaud <marcnarc@xiplink.com>
Cc: Jeff King <peff@peff.net>

ref email

Jeff King wrote on 12 July 2016 23:12
> On Tue, Jul 12, 2016 at 10:41:35PM +0100, Philip Oakley wrote:
> > Marc Branchaud <marcnarc@xiplink.com> 12 July 2016 14:44 noted
> > > +The '{caret}' (caret) notation
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >   To exclude commits reachable from a commit, a prefix '{caret}'
> > >   notation is used.  E.g. '{caret}r1 r2' means commits reachable
> > >   from 'r2' but exclude the ones reachable from 'r1'.
> >
> > All of these headings render poorly in the manpage, at least for me
> > (Ubuntu 16.04).  Only the first word appears in bold; the '-quoted text
> > is not bold but underlined, and the rest of the header is plain.
>
> Which doc package is that with? It had formatted OK for the html web pages.

I get the same with:

  make gitrevisions.7
  man -l gitrevisions.7

Asciidoc 8.6.9, docbook-xsl 4.5 if it matters.

Rendering single-quotes as underline is normal in this case (though it's
not great for punctuation like this, as it kind of blends with the dots;
I know we use it elsewhere in this document, though).  The failure to
continue the bold through the end of line looks like a bug, though.

The generated XML (from asciidoc) looks reasonable:

  <title>The <emphasis>..</emphasis> (two-dot) range notation</title>

The roff looks like:

  .SS "The \fI\&.\&.\fR (two\-dot) range notation"

The "\fR" switches us back to "Roman" from italics, which is presumably
the problem. We really want to say "switch back what we were using
before \fI".

Switching it to "\fP" fixes it, but it's not clear to me if that's
actually portable, or a groff-ism. I don't know roff very well and
documentation seems to be quite hard to find. So it's either a bug in
docbook, or an intentional decision they've made because roff can't
portably do better. I'm not sure which.

-Peff

The docbook folks have confirmed that \fP would only work across one
level, so they cannot use it for their XSLT conversion which must be
multi-level, so they always return to the default font.
-Philip
---
 Documentation/revisions.txt | 58 ++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 6e9cd41..3da0083 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -242,35 +242,49 @@ specifying a single revision with the notation described in the
 previous section means the set of commits reachable from that
 commit, following the commit ancestry chain.
 
-To exclude commits reachable from a commit, a prefix '{caret}'
-notation is used.  E.g. '{caret}r1 r2' means commits reachable
-from 'r2' but exclude the ones reachable from 'r1'.
-
-This set operation appears so often that there is a shorthand
-for it.  When you have two commits 'r1' and 'r2' (named according
-to the syntax explained in SPECIFYING REVISIONS above), you can ask
-for commits that are reachable from r2 excluding those that are reachable
-from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
-
-A similar notation 'r1\...r2' is called symmetric difference
-of 'r1' and 'r2' and is defined as
-'r1 r2 --not $(git merge-base --all r1 r2)'.
-It is the set of commits that are reachable from either one of
-'r1' (left side) or 'r2' (right side) but not from both.
-
-In these two shorthands, you can omit one end and let it default to HEAD.
+Commit Exclusions
+~~~~~~~~~~~~~~~~~
+
+'{caret}<rev>' (caret) Notation::
+ To exclude commits reachable from a commit, a prefix '{caret}'
+ notation is used.  E.g. '{caret}r1 r2' means commits reachable
+ from 'r2' but exclude the ones reachable from 'r1'.
+
+Dotted Range Notations
+~~~~~~~~~~~~~~~~~~~~~~
+
+The '..' (two-dot) Range Notation::
+ The '{caret}r1 r2' set operation appears so often that there is a shorthand
+ for it.  When you have two commits 'r1' and 'r2' (named according
+ to the syntax explained in SPECIFYING REVISIONS above), you can ask
+ for commits that are reachable from r2 excluding those that are reachable
+ from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
+
+The '...' (three dot) Symmetric Difference Notation::
+ A similar notation 'r1\...r2' is called symmetric difference
+ of 'r1' and 'r2' and is defined as
+ 'r1 r2 --not $(git merge-base --all r1 r2)'.
+ It is the set of commits that are reachable from either one of
+ 'r1' (left side) or 'r2' (right side) but not from both.
+
+In these two shorthand notations, you can omit one end and let it default to HEAD.
 For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
 did I do since I forked from the origin branch?"  Similarly, '..origin'
 is a shorthand for 'HEAD..origin' and asks "What did the origin do since
 I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
 empty range that is both reachable and unreachable from HEAD.
 
-Two other shorthands for naming a set that is formed by a commit
-and its parent commits exist.  The 'r1{caret}@' notation means all
-parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
-all of its parents.
+Other <rev>{caret} Parent Shorthand Notations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Two other shorthands exist, particularly useful for merge commits,
+for naming a set that is formed by a commit and its parent commits.
 
-To summarize:
+The 'r1{caret}@' notation means all parents of 'r1'.
+
+'r1{caret}!' includes commit 'r1' but excludes all of its parents.
+
+Revision Range Summary
+----------------------
 
 '<rev>'::
 	Include commits that are reachable from (i.e. ancestors of)
-- 
2.9.0.windows.1

