From: Jeff King <peff@peff.net>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Mon, 12 Nov 2012 15:27:01 -0500
Message-ID: <20121112202701.GE4623@sigill.intra.peff.net>
References: <20121111232820.284510@gmx.net>
 <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
 <20121112202413.GD4623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: glpk xypron <xypron.glpk@gmx.de>, git@vger.kernel.org,
	jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:27:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY0bL-0002Jb-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038Ab2KLU1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:27:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44968 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803Ab2KLU1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:27:05 -0500
Received: (qmail 13548 invoked by uid 107); 12 Nov 2012 20:27:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 15:27:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 15:27:01 -0500
Content-Disposition: inline
In-Reply-To: <20121112202413.GD4623@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209519>

On Mon, Nov 12, 2012 at 03:24:13PM -0500, Jeff King wrote:

> I think the right answer is going to be a well-placed call to esc_html.

I'm guessing the right answer is this:

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 10ed9e5..a51a8ba 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8055,6 +8055,7 @@ sub git_feed {
 		$feed_type = 'history';
 	}
 	$title .= " $feed_type";
+	$title = esc_html($title);
 	my $descr = git_get_project_description($project);
 	if (defined $descr) {
 		$descr = esc_html($descr);

but I did not test it (and I am not that familiar with gitweb, so it is
a slight guess from spending 5 minutes grepping and reading).

-Peff
