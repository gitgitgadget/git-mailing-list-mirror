From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] commit.c: add clear_commit_marks_many()
Date: Wed, 6 Mar 2013 03:30:38 -0500
Message-ID: <20130306083037.GA2018@sigill.intra.peff.net>
References: <1362523639-30566-1-git-send-email-gitster@pobox.com>
 <1362523639-30566-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 09:31:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD9kg-0004oy-KR
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 09:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab3CFIal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 03:30:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37878 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753403Ab3CFIak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 03:30:40 -0500
Received: (qmail 23503 invoked by uid 107); 6 Mar 2013 08:32:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 03:32:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 03:30:38 -0500
Content-Disposition: inline
In-Reply-To: <1362523639-30566-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217506>

On Tue, Mar 05, 2013 at 02:47:16PM -0800, Junio C Hamano wrote:

> clear_commit_marks(struct commit *, unsigned) only can clear flag
> bits starting from a single commit; introduce an API to allow
> feeding an array of commits, so that flag bits can be cleared from
> commits reachable from any of them with a single traversal.

Out of curiosity, is that actually measurably more efficient?

Since we stop traversing a commit's parents when we see it does not have
any of the flags we are clearing, we should visit most commits once. The
exception is ones that we hit by multiple paths. But that should
be the same whether it is done as part of a single traversal or
multiple; in each case, we hit the commit and say "Oh, already cleared;
do not add it to the parents list".

So I would expect it to have little to no impact on performance.  I
still think it is a sane interface change; I was just curious from the
commit message whether there could be a performance impact.

-Peff
