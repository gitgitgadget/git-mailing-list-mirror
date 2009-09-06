From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/4] make helpful messages optional
Date: Sun, 6 Sep 2009 02:44:54 -0400
Message-ID: <20090906064454.GA1643@coredump.intra.peff.net>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
 <1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
 <87prb6r9d1.fsf@iki.fi>
 <vpqab2aqqia.fsf@bauges.imag.fr>
 <7vy6pujmsc.fsf@alter.siamese.dyndns.org>
 <20090811120313.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 08:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkBUp-00062x-9Z
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 08:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbZIFGo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 02:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbZIFGo5
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 02:44:57 -0400
Received: from peff.net ([208.65.91.99]:57223 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbZIFGo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 02:44:56 -0400
Received: (qmail 9353 invoked by uid 107); 6 Sep 2009 06:45:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Sep 2009 02:45:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Sep 2009 02:44:54 -0400
Content-Disposition: inline
In-Reply-To: <20090811120313.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127835>

On Tue, Aug 11, 2009 at 12:03:13PM +0900, Nanako Shiraishi wrote:

>  		error("failed to push some refs to '%s'", url[i]);
> +		if (nonfastforward) {
> +			printf("To prevent you from losing history, non-fast-forward updates were rejected.\n"
> +			       "Merge the remote changes before pushing again.\n"
> +			       "See 'non-fast forward' section of 'git push --help' for details.\n");
> +		}

I saw this message in regular use for the first time today, and I
thought it was terribly ugly. The sheer number of lines, coupled with
the extremely ragged right edge made it much harder to pick out the
nicely formatted status table. And of course the information in the
message was totally worthless to me, as an experienced git user.

So rather than re-open the debate on whether this message should exist
or not, here is a patch series which tries to address the issue:

  [1/4]: push: fix english in non-fast-forward message

    Hopefully non-controversial.

  [2/4]: push: re-flow non-fast-forward message

    This makes it prettier, IMHO.  I suspect the message was flowed as
    it was originally on purpose so that each sentence began on its own
    line. I think making it easier on the eyes is more important,
    though.

  [3/4]: push: make non-fast-forward help message configurable

    I feel like we have had this exact sort of tension before: we want
    one thing to help new users and experienced users want another
    thing. We have resisted an "expert user" config variable in the past
    because proposals usually involved a change of behavior, which could
    lead to quite confusing results. However, I think the case of
    "helpful messages" is much simpler. The message is meant purely for
    human consumption and is redundant with information already given,
    so an expert sitting at a novice's terminal (or vice versa) will not
    encounter any surprises.

    This actually introduces infrastructure for other, similar messages,
    so that we can make existing ones optional, or build new ones as
    appropriate.

  [4/4]: status: make "how to stage" messages optional

    This uses the infrastructure in 3/4 to lose the "use git add to add
    untracked files" advice.

I think (1) and (2) are pretty straightforward. (3) and (4) are more
questionable, and I am undecided whether I am over-reacting to being
annoyed by the message. I do know this is not the first time I have had
the urge to write such a patch, so maybe others feel the same.

-Peff
