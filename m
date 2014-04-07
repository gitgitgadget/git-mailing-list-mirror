From: Kevin Ballard <kevin@sb.org>
Subject: notes.rewriteRef doesn't apply to rebases that skip the commit
Date: Mon, 7 Apr 2014 13:26:47 -0700
Message-ID: <99F95780-059D-4F62-A851-C43729BB9893@sb.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: gitList list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 07 22:26:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXG87-0007zU-SG
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 22:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbaDGU0v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2014 16:26:51 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56700 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754671AbaDGU0t convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 16:26:49 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 241F920A95
	for <git@vger.kernel.org>; Mon,  7 Apr 2014 16:26:49 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 07 Apr 2014 16:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:content-type
	:content-transfer-encoding:subject:message-id:date:to
	:mime-version; s=smtpout; bh=bWTDQFkBHLk1t5/mtH7YuCtZp1A=; b=pQt
	tNdzpRDD+wki5dROhpnBkowuN6dxxerkuxgXfaENwp7c0PQ3D+YP6y5xmuH8RHCS
	7UW0w+h281dH6V4e5mvrisbm/xTXl10Hv1WDIIFxetY1d/dJXyOxUM/KqnDT5qck
	eg9ezLdz+xSJhMBxELm9rIfsWwTGSBZlOhPy7kXw=
X-Sasl-enc: XDgi+OmW4G547Yyc3tXl2xBqHnF2pjFrfkwRQfnU3IwS 1396902408
Received: from [10.1.30.11] (unknown [199.27.109.101])
	by mail.messagingengine.com (Postfix) with ESMTPA id 99E5AC00005
	for <git@vger.kernel.org>; Mon,  7 Apr 2014 16:26:48 -0400 (EDT)
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245904>


I=92ve started using notes recently, and I have notes.rewriteRef set so=
 that
when I rebase, my notes will be kept. Unfortunately, it turns out that =
if a
rebase deletes my local commit because it already exists in upstream, i=
t
doesn=92t copy the note to the upstream commit. It seems perfectly reas=
onable to
me to expect the note to be copied to the upstream commit, as it repres=
ents
the same change.

One complication I can see is when my local commit is deleted not becau=
se it
exists upstream, but because it ends up being an empty commit due to th=
e
changes existing across multiple upstream commits. In this case I see n=
o
alternative but to have the note disappear. But I think that's acceptab=
le.

Another potential issues is if the commit exists upstream, but the surr=
ounding
context has changed enough that it contains a different patch-id. In th=
is
case, I would want Git to take the extra effort to correlate the upstre=
am
commit with my local one (it has the same message, modulo any Signed-Of=
f-By
lines, the same authorship info, and all the - and + lines in the diff =
are
identical). That said, I'd still understand if it didn't do that and lo=
st my
note. It would be unfortunate, but it would match today's behavior. I'm=
 ok
with copying over my notes when necessary, I just want Git to handle it=
 when
it's obviously correct (e.g. when the patch-id matches).

---

On a semi-related note, I don't see why Git should be warning about
notes.displayRef evaluating to a reference that doesn't exist. It doesn=
't
exist because I haven't created any notes for that ref in this reposito=
ry yet.
But that doesn't mean I won't be creating them eventually, and when I d=
o I
want them to be displayed.

=46or reference, I've been using git v1.9.0. The v1.9.1 release notes d=
on't
mention anything notes-related so I assume these issues still exist.

-Kevin Ballard
