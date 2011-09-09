From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Fri, 9 Sep 2011 15:12:40 -0400
Message-ID: <20110909191240.GA30019@sigill.intra.peff.net>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <robbat2-20110907T234637-463765607Z@orbis-terrarum.net>
 <20110908200343.GD16064@sigill.intra.peff.net>
 <robbat2-20110909T004300-810527870Z@orbis-terrarum.net>
 <20110909160301.GA9707@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 21:12:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R26VL-0002gS-Qg
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759833Ab1IITMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:12:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59048
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759828Ab1IITMm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 15:12:42 -0400
Received: (qmail 880 invoked by uid 107); 9 Sep 2011 19:13:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 15:13:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 15:12:40 -0400
Content-Disposition: inline
In-Reply-To: <20110909160301.GA9707@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181108>

On Fri, Sep 09, 2011 at 12:03:01PM -0400, Joey Hess wrote:

> The most credible attack I have so far does not involve binary files in
> tree. Someone pointed out that git log, git show, etc stop printing
> commit messages at NULL.

It was me.

> It might be worth ameloriating that attack by making git log always
> show the full buffer. Or it would be easy to write a tool that finds
> any commits that have a NULL in their message.

Unfortunately, that is going to involve a pretty huge code audit of git,
as the "tack a \0 to the end of an object just in case" code dates back
quite a while (e871b64, unpack_sha1_file: zero-pad the unpacked
object, 2005-05-25). So I suspect there is a lot of code built on
top of the assumption that commit messages are NUL-terminated strings.

Besides which, that is only one form of hiding. If collision attacks
against sha1 become a possibility, I think we are better to talk about
moving to a new hash. Even sha-256 truncated to 160 bits would be better
than sha-1 (AFAIK, that family of SHA does not suffer from the same
attacks, so we would still be in the 2^80 range for collision attacks).

-Peff
