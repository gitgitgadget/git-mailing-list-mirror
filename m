From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] merge-one-file: fix broken merges with GIT_WORK_TREE
Date: Fri, 29 Apr 2011 14:52:28 -0400
Message-ID: <20110429185228.GA27268@sigill.intra.peff.net>
References: <BANLkTimoehqY9ViF7AkQC3YU8e4Sq-OT_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Aman Gupta <themastermind1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:52:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFso5-0005go-Qs
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 20:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759166Ab1D2Swc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 14:52:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45209
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979Ab1D2Swb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 14:52:31 -0400
Received: (qmail 15455 invoked by uid 107); 29 Apr 2011 18:54:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Apr 2011 14:54:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2011 14:52:28 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimoehqY9ViF7AkQC3YU8e4Sq-OT_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172490>

On Fri, Apr 29, 2011 at 07:19:09PM +0200, Martin von Zweigbergk wrote:

> On Apr 29, 2011 12:41 AM, "Jeff King" <peff@peff.net> wrote:
> >
> > -       git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4"
> > +       git checkout-index -f --stage=2 -- "$4" &&
> > +               cat "$src1" >"${GIT_WORK_TREE:+$GIT_WORK_TREE/}$4" ||
> > +               exit 1
> 
> Would "git rev-parse --show-toplevel" be better here? Does it work with
> core.worktree etc otherwise? (Maybe git-sh-setup sets the env var?)

Good catch. I believe the git wrapper will convert "git --work-tree"
into an environment variable, but the config seems to be handled
separately.  and either way, I think we technically still support
calling "git-merge-one-file" directly without the git wrapper.

Thinking on it more, it probably makes more sense to "cd_to_toplevel"
via git-sh-setup. It seems pretty clear to me the original script was
written with the expectation of being at the top of the working tree
(and that is certainly where it ends up when called via
git-merge-octopus and git-merge-resolve).

Let me extend the tests a bit and roll a new series.

-Peff
