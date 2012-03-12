From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: pass author/committer info to hooks
Date: Mon, 12 Mar 2012 07:29:21 -0400
Message-ID: <20120312112921.GB12921@sigill.intra.peff.net>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
 <4F5BAE5E.5030407@gmail.com>
 <7vboo415rn.fsf@alter.siamese.dyndns.org>
 <4F5BDDAC.4050700@gmail.com>
 <7v62ebz9c0.fsf@alter.siamese.dyndns.org>
 <7vwr6rxul6.fsf_-_@alter.siamese.dyndns.org>
 <7vsjhfxuhh.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Neal Kreitzinger <nkreitzinger@gmail.com>,
	Adrian Cornish <git@bluedreamer.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 12:29:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S73RY-0007sa-P6
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 12:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab2CLL3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 07:29:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47611
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067Ab2CLL3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 07:29:24 -0400
Received: (qmail 15070 invoked by uid 107); 12 Mar 2012 11:29:34 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Mar 2012 07:29:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2012 07:29:21 -0400
Content-Disposition: inline
In-Reply-To: <7vsjhfxuhh.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192854>

On Sun, Mar 11, 2012 at 04:11:38AM -0700, Junio C Hamano wrote:

> However, when the command was reimplemented in C, the rewritten code
> was not very faithful to the original, and hooks stopped getting the
> authorship information given with "--author".  Fix this by exporting
> the necessary environment variables.
> [...]
>  * This is the last patch of the simpler of the two approaches, that
>    builds on top of the two common preparatory patches.  It uses setenv()
>    to directly affect the execution environment of "git commit" process,
>    which is closer to the original scripted Porcelain implementation.

FWIW, I like this approach better. It's simpler, and I think it is
perfectly sane to define "--author" as "act as if the contents were in
GIT_AUTHOR_*"[1]. We do the same thing already with "git --git-dir",
"git --work-tree", and other variables, and it keeps the code simple by
making the environment variable the definitive source.

-Peff

[1] Your approach is slightly more complex, in that it handles "-c"
    (which is a good thing). But I think the principle is the same.
