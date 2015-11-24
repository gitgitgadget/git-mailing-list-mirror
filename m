From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] sh-setup: make require_clean_work_tree() work on
 orphan branches
Date: Tue, 24 Nov 2015 15:50:37 -0500
Message-ID: <20151124205036.GF7174@sigill.intra.peff.net>
References: <1448376345-27339-1-git-send-email-szeder@ira.uka.de>
 <1448376345-27339-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 24 21:50:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1KY1-0001Zo-Ie
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 21:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbbKXUum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2015 15:50:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:33408 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754979AbbKXUuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 15:50:39 -0500
Received: (qmail 21848 invoked by uid 102); 24 Nov 2015 20:50:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 14:50:38 -0600
Received: (qmail 18113 invoked by uid 107); 24 Nov 2015 20:50:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 15:50:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 15:50:37 -0500
Content-Disposition: inline
In-Reply-To: <1448376345-27339-2-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281629>

On Tue, Nov 24, 2015 at 03:45:45PM +0100, SZEDER G=C3=A1bor wrote:

> git-sh-setup's require_clean_work_tree() always exits with error on a=
n
> orphan branch, even when the index and worktree are both clean.  The
> reason is that require_clean_work_tree() starts off with verifying
> HEAD, to make sure that it can safely pass HEAD to 'git diff-index'
> later when it comes to checking the cleanness of the index, and error=
s
> out finding the invalid HEAD of the orphan branch.
>=20
> There are scripts requiring a clean worktree that should work on an
> orphan branch as well, and those should be able to use this function
> instead of duplicating its functionality and nice error reporting in =
a
> way that handles orphan branches.
>=20
> Fixing this is easy: the index should be compared to the empty tree
> while on an orphan branch, and to HEAD otherwise.
>=20
> However, just fixing require_clean_work_tree() this way is also
> dangerous, because scripts must take care to work properly on orphan
> branches.  Currently a script calling require_clean_work_tree() would
> exit on a clean orphan branch, but with the simple fix it would
> continue executing and who knows what the consequences might be if
> the script is not prepared for orphan branches.

Hmm. I suspect this is not a big deal in practice. Lots of scripts
(including some of our own, through history) get the orphan case wrong.
I'm not sure that require_clean_work_tree is necessarily the place to b=
e
enforcing it, even though it happened to have done so historically.

Still, it may be prudent to err on the side of caution. I'm on the
fence.

-Peff
