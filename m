From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/6] attribute regression fix for maint-1.8.1 and upward
Date: Thu, 28 Mar 2013 17:43:58 -0400
Message-ID: <20130328214358.GA10685@sigill.intra.peff.net>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 22:44:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULKcd-0003Am-8F
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 22:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab3C1VoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 17:44:06 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44038 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320Ab3C1VoF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 17:44:05 -0400
Received: (qmail 30650 invoked by uid 107); 28 Mar 2013 21:45:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 17:45:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 17:43:58 -0400
Content-Disposition: inline
In-Reply-To: <1364323171-20299-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219462>

On Tue, Mar 26, 2013 at 11:39:27AM -0700, Junio C Hamano wrote:

> So here is an attempt to fix the unintended regression, on top of
> 9db9eecfe5c2 (attr: avoid calling find_basename() twice per path,
> 2013-01-16).  It consists of four patches.

Here's my update to the series. I think this should fix all of the
issues. And it should be very easy to drop in Duy's nwildmatch later on;
it can just replace the fnmatch_icase_mem function added in patch 2
below.

The main fix in this iteration is that match_pathname receives the same
treatment as match_basename, which is done in patches 3 and 4 (the
issues were subtly different enough that I didn't want to squash it all
together; plus, gotta keep that commit count up).

  [1/6]: attr.c::path_matches(): the basename is part of the pathname
  [2/6]: dir.c::match_basename(): pay attention to the length of string parameters
  [3/6]: dir.c::match_pathname(): adjust patternlen when shifting pattern
  [4/6]: dir.c::match_pathname(): pay attention to the length of string parameters
  [5/6]: attr.c::path_matches(): special case paths that end with a slash
  [6/6]: t: check that a pattern without trailing slash matches a directory

-Peff

PS I followed your subject-naming convention since I was adding into
   your series, but it seems quite long to me. I would have just said:
   "match_basename: pay attention...".
