From: Jeff King <peff@peff.net>
Subject: Re: Host refs to push are chosen (documentation error)?
Date: Wed, 17 Feb 2010 21:10:10 -0500
Message-ID: <20100218021010.GA21693@coredump.intra.peff.net>
References: <201002171627.57599.arvidjaar@mail.ru>
 <be6fef0d1002170539v4384b355lb6be3e2f19b7b87b@mail.gmail.com>
 <32541b131002170939l261f396cpbee45f652fd96c77@mail.gmail.com>
 <20100218011620.GA15870@coredump.intra.peff.net>
 <32541b131002171751n454081a9w90f2957d7a40d87@mail.gmail.com>
 <7vaav7wb8v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 03:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhvqN-0005rD-6K
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 03:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267Ab0BRCKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 21:10:13 -0500
Received: from peff.net ([208.65.91.99]:55645 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab0BRCKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 21:10:11 -0500
Received: (qmail 24052 invoked by uid 107); 18 Feb 2010 02:10:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 17 Feb 2010 21:10:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Feb 2010 21:10:10 -0500
Content-Disposition: inline
In-Reply-To: <7vaav7wb8v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140286>

On Wed, Feb 17, 2010 at 06:04:00PM -0800, Junio C Hamano wrote:

> This is not about "I have packed refs/heads/master and then a loose
> refs/heads/master also exists" case.  After packing, update ref simply
> creates a new loose ref, and we read loose ones and give precedence to it
> over packed one.  This is so that you once gc and most of the unchanging
> refs will stay in packed file, but some active branches can be quickly
> flipped without having to rewrite the whole packed refs file (or removing
> the ref from that file).
> 
> But the statement is not about that.  The statement is about this:
> 
>     "refs/tags/master" gets higher precedence over "refs/heads/master",
>     and this order is indifferent to where these two refs come from,
>     either packed refs or loose in the filesystem.

Exactly what I meant, but if somebody as clueful as Avery gets confused,
then probably I need to be a bit more clear in my note.

Maybe just this squashed into my previous patch?

---
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 9ee006b..1a613aa 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -197,15 +197,15 @@ blobs contained in a commit.
   . if `$GIT_DIR/<name>` exists, that is what you mean (this is usually
     useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD` and `MERGE_HEAD`);
 
-  . otherwise, `$GIT_DIR/refs/<name>` if exists;
+  . otherwise, `refs/<name>` if exists;
 
-  . otherwise, `$GIT_DIR/refs/tags/<name>` if exists;
+  . otherwise, `refs/tags/<name>` if exists;
 
-  . otherwise, `$GIT_DIR/refs/heads/<name>` if exists;
+  . otherwise, `refs/heads/<name>` if exists;
 
-  . otherwise, `$GIT_DIR/refs/remotes/<name>` if exists;
+  . otherwise, `refs/remotes/<name>` if exists;
 
-  . otherwise, `$GIT_DIR/refs/remotes/<name>/HEAD` if exists.
+  . otherwise, `refs/remotes/<name>/HEAD` if exists.
 +
 HEAD names the commit your changes in the working tree is based on.
 FETCH_HEAD records the branch you fetched from a remote repository
@@ -217,10 +217,8 @@ them easily.
 MERGE_HEAD records the commit(s) you are merging into your branch
 when you run 'git merge'.
 +
-For any of the `$GIT_DIR/refs` cases above, packed refs from
-`$GIT_DIR/packed-refs` may be substituted (e.g., a line with
-`refs/heads/master` in the packed-refs file would have the same
-precedence as the file `$GIT_DIR/refs/heads/master`).
+Note that any of the `refs/*` cases above may come either from
+the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
 
 * A ref followed by the suffix '@' with a date specification
   enclosed in a brace
