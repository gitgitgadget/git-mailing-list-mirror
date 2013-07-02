From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] avoid quadratic behavior in fetch-pack
Date: Tue, 2 Jul 2013 02:11:49 -0400
Message-ID: <20130702061149.GB1206@sigill.intra.peff.net>
References: <201307012102.31384.mfick@codeaurora.org>
 <20130702040758.GA7068@sigill.intra.peff.net>
 <20130702044151.GB7068@sigill.intra.peff.net>
 <20130702050142.GA1206@sigill.intra.peff.net>
 <7vtxkd8rns.fsf@alter.siamese.dyndns.org>
 <20130702052827.GA10626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 08:11:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UttoY-0001Ke-Li
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 08:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab3GBGLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 02:11:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:54468 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab3GBGLm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 02:11:42 -0400
Received: (qmail 20381 invoked by uid 102); 2 Jul 2013 06:12:51 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Jul 2013 01:12:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jul 2013 02:11:49 -0400
Content-Disposition: inline
In-Reply-To: <20130702052827.GA10626@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229364>

Here are my patches to deal with Martin's pathological case, split out
for easy reading. I took a few timings to show that the results of the
3rd patch are noticeable even with 50,000 unique refs (which is still a
lot, but something that I could conceive of a busy repo accumulating
over time).

  [1/3]: fetch-pack: avoid quadratic list insertion in mark_complete
  [2/3]: commit.c: make compare_commits_by_commit_date global
  [3/3]: fetch-pack: avoid quadratic behavior in rev_list_push

And here's the diffstat to prove it is really not scary. :)

 commit.c     |  2 +-
 commit.h     |  2 ++
 fetch-pack.c | 16 ++++++++--------
 3 files changed, 11 insertions(+), 9 deletions(-)

-Peff
