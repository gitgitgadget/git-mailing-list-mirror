From: Jeff King <peff@peff.net>
Subject: Re: suppress fatal pathspec errors from "git add"?
Date: Sun, 3 Jan 2010 02:40:59 -0500
Message-ID: <20100103074058.GB23031@sigill.intra.peff.net>
References: <d7ac1a680912311324i85b7a5anadaf2ac13f215873@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: aaron smith <beingthexemplarylists@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 03 08:41:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRL61-0004TW-AV
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 08:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab0ACHlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 02:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269Ab0ACHlD
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 02:41:03 -0500
Received: from peff.net ([208.65.91.99]:58934 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096Ab0ACHlB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 02:41:01 -0500
Received: (qmail 31788 invoked by uid 107); 3 Jan 2010 07:45:45 -0000
Received: from 97-81-72-200.dhcp.athn.ga.charter.com (HELO sigill.intra.peff.net) (97.81.72.200)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 03 Jan 2010 02:45:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Jan 2010 02:40:59 -0500
Content-Disposition: inline
In-Reply-To: <d7ac1a680912311324i85b7a5anadaf2ac13f215873@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136068>

On Thu, Dec 31, 2009 at 01:24:59PM -0800, aaron smith wrote:

> I'm looking through the add documentation, I don't see a way to
> suppress fatal pathspec errors? For example, if I'm adding 5 files,
> but one of them is mis-spelled, can I have git just supress the errors
> and add the other four?

Hmm. I would have thought "git add --ignore-errors" would do what you
want, but it only ignores errors in reading the file. If we can't stat
it, we will always die. IMHO that is an oversight in how
"--ignore-errors" works (why should this one particular error be treated
as fatal, when others are not?).

However, I have to wonder what your workflow is to really want this. If
you do:

  $ ls
  foo bar baz
  $ git add foo bar bz
  fatal: pathspec 'bz' did not match any files

Then presumably your next command would be:

  $ git add foo bar baz

Using ignore-errors (if it worked), you would probably do:

  $ git add baz

Less typing, I suppose, but presumably you are using a shell that
lets you just go back and edit the previous command line. I could see it
if your workflow were something like "in a script, add these N files if
they exist, but it is not an error if they don't". But I still don't
think you would want to ignore all errors; you would want to do
something like:

  $ git add $(for i in foo bar baz; do test -e $i && echo $i; done)

instead. Am I missing something?

-Peff
