From: =?UTF-8?B?IlBldGVyIFZhbGRlbWFyIE3DuHJjaCAoTGlzdHMpIg==?= 
	<4ux6as402@sneakemail.com>
Subject: Re: [PATCH] Teach git log --check to return an appropriate error
 code
Date: Sun, 10 Aug 2008 19:05:40 +0200
Message-ID: <489F1FE4.6090400@sneakemail.com>
References: <alpine.DEB.1.00.0808081315060.9611@pacific.mpi-cbg.de.mpi-cbg.de> <1218265054-19220-1-git-send-email-4ux6as402@sneakemail.com> <alpine.DEB.1.00.0808091404230.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7v8wv66l8d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 19:06:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSENU-0004bi-G6
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 19:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbYHJRFo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2008 13:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbYHJRFo
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 13:05:44 -0400
Received: from morch.com ([193.58.255.207]:40754 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbYHJRFn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 13:05:43 -0400
Received: from [192.168.1.214] (ANice-157-1-71-161.w90-36.abo.wanadoo.fr [90.36.206.161])
	by morch.com (Postfix) with ESMTP id C3808274A
	for <git@vger.kernel.org>; Sun, 10 Aug 2008 19:08:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7v8wv66l8d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91858>

Junio C Hamano gitster-at-pobox.com |Lists| wrote:
> Future versions of log_tree_diff() may want to tweak opt->diffopt per
> commit, when we have options for "use larger -U<lines> value after hi=
tting
> this commit", or "use this pathspec to limit the diff output after hi=
tting
> this commit", for example.  But even in these cases, I think it is
> implausible to start from a freshly initialized diff_options structur=
e.
> The code most likely would start from the copy of what was in use and
> update only the necessary fields, without disturbing the state variab=
les.
>=20
> So I think you are worried a bit too much in this case, even though i=
t is
> a valid concern in principle.  It might warrant a comment somewhere i=
nside
> log_tree_diff() to tell people not to re-initialize opt->diffopt per
> commit without thinking, though.

Hmm... I've looked at the code... The while loop that iterates through=20
the revisions is in cmd_log_walk(), which calls log_tree_commit(), whic=
h=20
in turn calls log_tree_diff().

I'm thinking that cmd_log_walk() is where one "would want" to change=20
rev->diffopt / opt->diffopt in the future, and hence I suggest to put=20
the comment there - given my limited understanding of connecting tissue=
=2E=20
Something like:

/* For --check, the exit code is based on CHECK_FAILED
    being accumulated in rev->diffopt, so be careful to retain
    that state information if replacing rev->diffopt in this
    loop */

That would also be 10-15 lines above the patch I posted earlier, so the=
=20
connection with retrieving the error code would be visible 15 lines bel=
ow.

Would such a comment in that place constiture and acceptable patch? I'v=
e=20
tried to follow Dscho's write up and contribute a patch, even though=20
git-log's exit code was never my itch to begin with, because I'm exited=
=20
to contribute.

> One interesting option that might be interesting to add to the log fa=
mily
> would be to show only commits that fail the checkdiff tests.  I suspe=
ct
> necessary change for doing so would go to log_tree_diff() codepath.

I'm hoping that this is meant as "aside from this current patch, one=20
interesting option..." or do you mean "in order for this patch to be=20
accepted, I suggest this to be added ..." ?

This is growing. I originally suggested a patch to documentation to mak=
e=20
it match the code, but took on Dscho's invitation to contribute a code=20
patch instead. But given that this patch, although working, still isn't=
=20
good enough and the new proposals : the new option above and --exit-cod=
e=20
proposal elsewhere in this thread, I'm getting a little discouraged. I'=
m=20
not saying you meant it that way.

Peter
--=20
Peter Valdemar M=C3=B8rch
http://www.morch.com
