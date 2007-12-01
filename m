From: Jeff King <peff@peff.net>
Subject: Re: [RFC] use typechange as rename source
Date: Sat, 1 Dec 2007 01:49:16 -0500
Message-ID: <20071201064916.GA7431@coredump.intra.peff.net>
References: <20071121171235.GA32233@sigill.intra.peff.net> <7vir3l2a1i.fsf@gitster.siamese.dyndns.org> <20071129141452.GA32670@coredump.intra.peff.net> <7vmyswsfl6.fsf@gitster.siamese.dyndns.org> <20071130015716.GA15224@coredump.intra.peff.net> <7vsl2n87jr.fsf@gitster.siamese.dyndns.org> <20071201043407.GD30725@coredump.intra.peff.net> <7vhcj36j6e.fsf@gitster.siamese.dyndns.org> <7v8x4f6iyu.fsf@gitster.siamese.dyndns.org> <7vy7ce6hyb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 07:49:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyMAW-0000fi-Aw
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 07:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbXLAGtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 01:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbXLAGtT
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 01:49:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1967 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbXLAGtT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 01:49:19 -0500
Received: (qmail 14377 invoked by uid 111); 1 Dec 2007 06:49:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Dec 2007 01:49:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2007 01:49:16 -0500
Content-Disposition: inline
In-Reply-To: <7vy7ce6hyb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66703>

On Fri, Nov 30, 2007 at 10:35:08PM -0800, Junio C Hamano wrote:

> Sorry for the earlier broken one.  Here is the correct one I wanted to
> send out.
>
> By the way, this breaks some tests in t4008 (break-rewrite test) because
> the test expects the behaviour you found counterintuitive (which was the
> reason we have this thread).

OK, this looks reasonable to me, and it produces diff results (with -B)
that make sense for typechanges. Looking at the failing test in t4008, I
like the new behavior better.

And maybe something like this on top for git-status?

diff --git a/wt-status.c b/wt-status.c
index 0e0439f..e77120d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -250,6 +250,7 @@ static void wt_status_print_updated(struct wt_status *s)
 	rev.diffopt.format_callback_data = s;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
+	rev.diffopt.break_opt = 0;
 	wt_read_cache(s);
 	run_diff_index(&rev, 1);
 }
