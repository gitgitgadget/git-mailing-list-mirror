From: Jeff King <peff@peff.net>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 01:54:00 -0500
Message-ID: <20071211065400.GA25985@coredump.intra.peff.net>
References: <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org> <20071210234941.GE22254@coredump.intra.peff.net> <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org> <7vzlwhhli5.fsf@gitster.siamese.dyndns.org> <20071211063941.GB21718@coredump.intra.peff.net> <7vd4tdhgnd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:54:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1z0j-0005Dg-Pa
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbXLKGyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbXLKGyF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:54:05 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2456 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbXLKGyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:54:05 -0500
Received: (qmail 6829 invoked by uid 111); 11 Dec 2007 06:54:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 11 Dec 2007 01:54:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 01:54:00 -0500
Content-Disposition: inline
In-Reply-To: <7vd4tdhgnd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67807>

On Mon, Dec 10, 2007 at 10:47:18PM -0800, Junio C Hamano wrote:

> > We are duplicating the "!shown && ..." conditional branch from
> > log_tree_commit, which calls show_log. Why are we not calling show_log
> > instead of pretty_print_commit (I understand that show_log should end up
> > calling pretty_print_commit, but it is not immediately obvious that all
> > of the extra code in show_log is going to be ignored).
> 
> Exactly.  I think show_log() has become too complex, and when we want a
> oneline userformat, pretty-print-commit is more appropriate to use.
> Actually, when I re-review the code, I think the part should use
> format_commit_message() which is more to the point without any of the
> other "more generic" parameter pretty-print-commit takes.

Perhaps it would be even more readable to simply split the printing of
the commit message and the diff. Tracking this bug was a bit confusing.
Ideally, print_summary would just say:

  print_commit_message(commit);
  print_diff(commit, "^commit");

where obviously each of those takes a few lines to say properly. But the
use of a combination "show the log and maybe the diff" function seems
like a shell holdover, trying to avoid spawning too many processes.

-Peff
