From: Jeff King <peff@peff.net>
Subject: Re: git diff bug?
Date: Fri, 3 Apr 2009 21:45:27 -0400
Message-ID: <20090404014527.GA13350@coredump.intra.peff.net>
References: <m2ocvdkyul.fsf@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 03:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpuyh-0003SV-VQ
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 03:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758474AbZDDBpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 21:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758135AbZDDBpq
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 21:45:46 -0400
Received: from peff.net ([208.65.91.99]:53835 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668AbZDDBpp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 21:45:45 -0400
Received: (qmail 2595 invoked by uid 107); 4 Apr 2009 01:46:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 21:46:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 21:45:27 -0400
Content-Disposition: inline
In-Reply-To: <m2ocvdkyul.fsf@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115568>

On Fri, Apr 03, 2009 at 09:10:42PM -0400, David Abrahams wrote:

> Please see
> http://github.com/techarcana/elisp/commit/63d672c296316c85690085930b05c642b88a9978#diff-2
> 
> Note how the @@ ... @@ clauses are followed by text from the previous
> line's comment.  Not sure, but this strikes me as a line-ending issue.
> custom.el was originally built on a linux machine; now I'm using a Mac.

This is as designed. The original file ("git show e7dd7db") contains (my
numbering seems different than what git produces; it is produced by "nl"
which is maybe treating some line endings differently earlier in the
file):

   102   '(mm-attachment-override-types (quote ("text/x-vcard" "application/pkcs7-mime" "application/x-pkcs7-mime" "application/pkcs7-signature" "application/x-pkcs7-signature" "image/*")) nil nil "
   103  Added image/* to display attached images inline")
   104   '(mm-discouraged-alternatives (quote ("text/html" "text/richtext" "image/.*")) nil nil "
   105  The documentation for this variable says it all")
   106   '(mm-inline-text-html-with-images t)
   107   '(muse-project-alist (quote (("WikiPlanner" ("~/plans" :default "index" :major-mode planner-mode :visit-link planner-visit-link)))))
   108   '(org-agenda-files (quote ("~/organizer.org")))

The changed text in your diff starts on 108. So we show 105-107 as
context lines. The text after the @@ clause is the "function header";
this is equivalent to "-p" in GNU diff. It's basically a guess about the
most interesting context to show, and looks alphabetic characters that
are left-aligned. In the case of lisp, it really isn't all that
interesting (and what looks so weird is that your file contains
a lot of

  "\nSome text"

so the text strings are all left-aligned. You can customize the regex
used to guess at the function header. See "defining a custom
hunk-header" in "git help attributes".

-Peff
