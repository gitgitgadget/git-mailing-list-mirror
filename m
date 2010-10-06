From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH] Improve the "diff --git" format documentation
Date: Thu, 7 Oct 2010 01:03:17 +0200
Organization: SUSE Labs, Novell Inc.
Message-ID: <201010070103.17689.agruen@suse.de>
References: <201010061823.47475.agruen@suse.de> <7vk4lv44os.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:04:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3d1s-0007kj-Om
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268Ab0JFXDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 19:03:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:45611 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757966Ab0JFXDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 19:03:51 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 55C3A93717;
	Thu,  7 Oct 2010 01:03:50 +0200 (CEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <7vk4lv44os.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158347>

On Wednesday 06 October 2010 19:22:11 Junio C Hamano wrote:
> [...] Could you objectively describe in what way is it an "improvement" on
> the subject line?

Okay.

> >  Documentation/diff-generate-patch.txt |   23 ++++++++++++++++++++++-
> >  1 files changed, 22 insertions(+), 1 deletions(-)
> > 
> > diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-
> > generate-patch.txt
> > index 8f9a241..05f2164 100644
> > --- a/Documentation/diff-generate-patch.txt
> > +++ b/Documentation/diff-generate-patch.txt
> > @@ -18,7 +18,8 @@ diff format.
> > 
> >  +
> >  The `a/` and `b/` filenames are the same unless rename/copy is
> >  involved.  Especially, even for a creation or a deletion,
> > 
> > -`/dev/null` is _not_ used in place of `a/` or `b/` filenames.
> > +`/dev/null` is _not_ used in place of `a/` or `b/` filenames in the
> > +`diff --git` line.
> 
> With a bit more context, the original reads like this:
> 
>     What the -p option produces is slightly different from the traditional
>     diff format.
> 
>     1.   It is preceded with a "git diff" header, that looks like
>          this:
> 
>            diff --git a/file1 b/file2
>     +
>     The `a/` and `b/` filenames are the same unless rename/copy is
>     involved.  Especially, even for a creation or a deletion,
>     `/dev/null` is _not_ used in place of `a/` or `b/` filenames.
> 
> I think the first sentence makes it clear that this section is about '"git
> diff" header', without repeating it like your patch does.

The text made me wonder how git handles file names in the unified diff
headers, which is not mentioned in this section.  Also, the way how /dev/null
is used in unified diff headers may not be known to some users.  I have tried
to clarify both in the attached version.

> > @@ -38,11 +39,31 @@ the file that rename/copy produces, respectively.
> > 
> >         dissimilarity index <number>
> >         index <hash>..<hash> <mode>
> > 
> > +    Path names in extended header lines do not include the `a/` and `b/`
> > +    prefixes.  The index header includes the <mode> only if the file
> > +    mode does not change; otherwise, explicit mode headers are included.
> > +
> 
> Have you looked at generated output in man and html formats?  I suspect
> that it needs some asciidoc formatting magic, similar to what we already
> have for the first section (namely, no indent, but the new block is marked
> as a continuation with a lone plus sign at the beginning, instead of being
> separated by a blank line).

Fixed, thanks.

> >  3.  TAB, LF, double quote and backslash characters in pathnames
> >  
> >      are represented as `\t`, `\n`, `\"` and `\\`, respectively.
> >      If there is need for such substitution then the whole
> >      pathname is put in double quotes.
> > 
> > +    Space characters are not quoted and so when files are copied or
> > +    renamed, the file names in the "diff --git" line can be
> > +    ambiguous.
> 
> Why do you even need to say that, especially after you made it clear that
> rename information is available in the extended header section in an
> unambiguous form?

This fact was *extremely* surprising to me (and I still think it is a
mistake; spaces should at least be quoted in the "git diff" line). 
But documenting it may at least save others this surprise.

I have tried to reword this; could you please check?

> > +4.  All the `a/` files refer to files before the commit, and all the
> > `b/` +    files refer to files after the commit; it is incorrect to
> > apply the +    changes to each file sequentially.  For example, this
> > patch will +    swap a and b:
> > +
> > +      diff --git a/a b/b
> > +      rename from a
> > +      rename to b
> > +      diff --git a/b b/a
> > +      rename from b
> > +      rename to a
> > +
> > 
> >  The similarity index is the percentage of unchanged lines, and
> >  the dissimilarity index is the percentage of changed lines.  It
> >  is a rounded down integer, followed by a percent sign.  The
> 
> The new section is a worthwhile addition; I however think this addition
> makes the description of the similarity/dissimilarity indices further from
> the section it relates to (it logically is part of section 2), so perhaps
> it should move 3. down and add 4. while at it.

Done.

Thanks,
Andreas

--

[PATCH] Clarify and extend the "git diff" format documentation

Make it more clear that the unified diff header lines *do* use /dev/null
for nonexisting files.

Move the similarity and dissimilarity index header description closer to
where those extended headers are described.

Describe and/or clarify the format used for file modes, pathnames, and
the index header.  Make it clear that spaces in pathnames are not
quoted.

Document that all "old" files refer to the state before applying the
*entire* output, and all "new" files refer to the state thereafter.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 Documentation/diff-generate-patch.txt |   44 +++++++++++++++++++++++++-------
 1 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 8f9a241..e5beef1 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -9,16 +9,16 @@ patch file.  You can customize the creation of such patches via the
 GIT_EXTERNAL_DIFF and the GIT_DIFF_OPTS environment variables.
 
 What the -p option produces is slightly different from the traditional
-diff format.
+diff format:
 
-1.   It is preceded with a "git diff" header, that looks like
-     this:
+1.   It is preceded with a "git diff" header that looks like this:
 
        diff --git a/file1 b/file2
 +
 The `a/` and `b/` filenames are the same unless rename/copy is
 involved.  Especially, even for a creation or a deletion,
-`/dev/null` is _not_ used in place of `a/` or `b/` filenames.
+`/dev/null` is _not_ used in place of the `a/` or `b/` filenames
+for nonexisting files (unlike in the unified diff headers).
 +
 When rename/copy is involved, `file1` and `file2` show the
 name of the source file of the rename/copy and the name of
@@ -37,18 +37,42 @@ the file that rename/copy produces, respectively.
        similarity index <number>
        dissimilarity index <number>
        index <hash>..<hash> <mode>
-
-3.  TAB, LF, double quote and backslash characters in pathnames
-    are represented as `\t`, `\n`, `\"` and `\\`, respectively.
-    If there is need for such substitution then the whole
-    pathname is put in double quotes.
-
++
+File modes are printed as 6-digit octal numbers including the file type
+and file permission bits.
++
+Path names in extended headers do not include the `a/` and `b/` prefixes.
++
 The similarity index is the percentage of unchanged lines, and
 the dissimilarity index is the percentage of changed lines.  It
 is a rounded down integer, followed by a percent sign.  The
 similarity index value of 100% is thus reserved for two equal
 files, while 100% dissimilarity means that no line from the old
 file made it into the new one.
++
+The index line includes the SHA-1 checksum before and after the change.
+The <mode> is included if the file mode does not change; otherwise,
+separate lines indicate the old and the new mode.
+
+3.  TAB, LF, double quote and backslash characters in pathnames
+    are represented as `\t`, `\n`, `\"` and `\\`, respectively.
+    If there is need for such substitution then the whole
+    pathname is put in double quotes.
++
+Space characters in pathnames are _not_ quoted, neither in the "git
+diff" header nor in extended header lines.
+
+4.  All the `file1` files in the output refer to files before the
+    commit, and all the `file2` files refer to files after the commit.
+    It is incorrect to apply each change to each file sequentially.  For
+    example, this patch will swap a and b:
+
+      diff --git a/a b/b
+      rename from a
+      rename to b
+      diff --git a/b b/a
+      rename from b
+      rename to a
 
 
 combined diff format
-- 
1.7.3.1.50.g1e633.dirty
