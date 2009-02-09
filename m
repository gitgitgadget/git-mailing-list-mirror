From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] remote prune: warn dangling symrefs
Date: Mon, 9 Feb 2009 14:15:26 -0500
Message-ID: <20090209191526.GC27037@coredump.intra.peff.net>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com> <1234170565-6740-2-git-send-email-gitster@pobox.com> <1234170565-6740-3-git-send-email-gitster@pobox.com> <1234170565-6740-4-git-send-email-gitster@pobox.com> <1234170565-6740-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:16:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbcj-0007pE-Vn
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 20:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbZBITPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 14:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756029AbZBITPa
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 14:15:30 -0500
Received: from peff.net ([208.65.91.99]:36677 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861AbZBITP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 14:15:29 -0500
Received: (qmail 4501 invoked by uid 107); 9 Feb 2009 19:15:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 09 Feb 2009 14:15:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Feb 2009 14:15:26 -0500
Content-Disposition: inline
In-Reply-To: <1234170565-6740-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109108>

On Mon, Feb 09, 2009 at 01:09:23AM -0800, Junio C Hamano wrote:

> If you prune from the remote "frotz" that deleted the ref your tracking
> branch remotes/frotz/HEAD points at, the symbolic ref will become
> dangling.  We used to detect this as an error condition and issued a
> message every time refs are enumerated.
> 
> This stops the error message, but moves the warning to "remote prune".

Very nice. As a bonus, this fixes certain (admittedly unlikely) renames,
too (which don't need to pass the BROKEN flag, since ref_rename uses
get_loose_refs directly):

  # without this patch
  $ git symbolic-ref refs/heads/foo/bar refs/heads/nonexistant
  $ git branch -m master foo
  error: refs/heads/foo/bar points nowhere!
  error: there are still refs under 'refs/heads/foo'
  error: unable to lock refs/heads/foo for update
  fatal: Branch rename failed

  # with this patch
  $ git branch -m master foo
  error: 'refs/heads/foo/bar' exists; cannot create 'refs/heads/foo'
  fatal: Branch rename failed

-Peff
