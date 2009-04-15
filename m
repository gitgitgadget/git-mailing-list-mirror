From: Jeff King <peff@peff.net>
Subject: Re: "git cat-file <sha1>" shows usage but should not?
Date: Wed, 15 Apr 2009 13:04:44 -0400
Message-ID: <20090415170444.GA24717@coredump.intra.peff.net>
References: <49E61067.6060802@hartwork.org> <20090415165420.GB24528@coredump.intra.peff.net> <49E611A5.8090602@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8Zd-0006CN-BK
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 19:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbZDOREw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 13:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755119AbZDOREv
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 13:04:51 -0400
Received: from peff.net ([208.65.91.99]:59318 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754069AbZDOREu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 13:04:50 -0400
Received: (qmail 27369 invoked by uid 107); 15 Apr 2009 17:04:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Apr 2009 13:04:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2009 13:04:44 -0400
Content-Disposition: inline
In-Reply-To: <49E611A5.8090602@hartwork.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116630>

On Wed, Apr 15, 2009 at 06:56:05PM +0200, Sebastian Pipping wrote:

> Jeff King wrote:
> > That usage message is misleading. You need to use one of -t, -s, -e, -p,
> > or <type>. So it should perhaps just be:
> > 
> >   git cat-file -t|-s|-e|-p|<type> <sha1>
> > 
> > though that looks terribly ugly. Suggestions welcome.
> 
> Thanks for making that clear.  How about round or curly brackets?

I think curly makes the most sense for grouping, though I still think it
is a bit ugly. Patch is below.

-- >8 --
Subject: [PATCH] fix cat-file usage message and documentation

cat-file with an object on the command line requires an
option to tell it what to output (type, size, pretty-print,
etc). However, the square brackets in the usage imply that
those options are not required. This patch switches them to
curly braces to indicate "required but grouped-OR".

While we're at it, let's change the <sha1> specifier in the
usage to <object>. That's what the documentation uses, and
it does actually use the regular object lookup.
---
The curly braces seem to render fine via asciidoc (presumably because
there is no entity with that name), but I'm not sure if that will work
with all asciidoc versions.

 Documentation/git-cat-file.txt |    2 +-
 builtin-cat-file.c             |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index b191276..0856568 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,7 +9,7 @@ git-cat-file - Provide content or type and size information for repository objec
 SYNOPSIS
 --------
 [verse]
-'git cat-file' [-t | -s | -e | -p | <type>] <object>
+'git cat-file' {-t | -s | -e | -p | <type>} <object>
 'git cat-file' [--batch | --batch-check] < <list-of-objects>
 
 DESCRIPTION
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 8fad19d..4e6ad73 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -201,8 +201,8 @@ static int batch_objects(int print_contents)
 }
 
 static const char * const cat_file_usage[] = {
-	"git cat-file [-t|-s|-e|-p|<type>] <sha1>",
-	"git cat-file [--batch|--batch-check] < <list_of_sha1s>",
+	"git cat-file {-t|-s|-e|-p|<type>} <object>",
+	"git cat-file [--batch|--batch-check] < <list_of_objects>",
 	NULL
 };
 
-- 
1.6.3.rc0.156.g19ef8
