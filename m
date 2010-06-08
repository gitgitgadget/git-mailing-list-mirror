From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Slaughtering the sacred cow
Date: Tue, 08 Jun 2010 11:34:16 +0200
Message-ID: <4C0E0E98.6080806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 11:34:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLvCr-000062-GU
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 11:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118Ab0FHJeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 05:34:44 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50147 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751961Ab0FHJen (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 05:34:43 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A5C01F7642
	for <git@vger.kernel.org>; Tue,  8 Jun 2010 05:34:42 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 08 Jun 2010 05:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=n8e8h5mfMMSXowZ1aWG+h8Kq1H0=; b=Crz8bA4Y++pPP+2Na6WkIdTViXcx4T2fP2WM8oDyGzk4s9dQKoetKMF+jqazrIOEQ17JRG7G0IW8tzRpJ+7YzrfRXGYM49QLwLb77T3Du1gLDjN8Xc1kHY9Y0dQ0HIB8QIT8yny66qwkPO/ERCn20x+ge95k3TWPh2qNTUgbz2s=
X-Sasl-enc: InrFyNwi0rN1TGM+7G4XvhEf+ZdQLTZtfoSHD9QwR7op 1275989682
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DFF5C5EDBB
	for <git@vger.kernel.org>; Tue,  8 Jun 2010 05:34:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148657>

Now that I got your attention, here are some observations and thoughts
about our development model for git.git. In fact I think we have a
successful model (and a great maintainer) but there is always room for
improvement.

The sacred cow from the subject line is backwards compatibility, and it
is sacred for a good reason. People can happily run git.git's master or
even next without too many surprises as long as they're on their watch
for some slightly larger changes in 1.x.0 releases. Distros choose to
follow maint or master.

Still, lately several discussions here have put me in a slaughterous
mood so to say. Our code base is "naturally grown", and as much as I
like that for a garden, it basically makes any attempts at providing a
consistent and smooth sur^Winterface impossible, because this always
requires some cuts. So, why not let the cow do the greenkeeping to get
the ball rolling smoothly again ;)

I think the technical reason behind this issue is the short-livedness of
our topic branches and pu. Who's looking at any 10+ patch series? I
mean, it was always easy to, say,

git merge $(git rev-parse ":/Merge branch
'mg/rev-parse-lrbranches-locals")^2

for stuff on pu and this is even easier now with the topic branches
pushed out by Junio to github. But large series simply get over-grown.

We don't have a place like kernel-next for large structural incompatible
changes. Our "next" is a very stable branch with what will be the next
small increments on master, and it serves a very good purpose.

Shortly before an upcoming 1.x.0 we often have "for-1.x.0"-topics but I
don't think that can house large developments like

- consistent interface for subcommands ("branch --setupstream" vs.
"remote add" etc.),

- consistent approach on DWImery (may require removing some, or making
it dependent on config),

- consistent treatment of porcelain/plumbing hermaphrodites (may require
breaking some assumptuous scripts).

Those are just a few examples of issues which are confusing for new
users, which are there just because they grew to be there (or because of
implementation details), and which don't go away because of that cow.

I don't pretend to have a perfect solution for this, but I'm wondering
whether a longer-lived for-1.x.0 branch (with or without an extra pu,
i.e. not rewinding itself [leaving that for the extra pu] or rewinding)
would be feasible which gets everything from next-master-maint and which
would also be a place to cook larger structural, backwards incompatible
changes. An alternative would be to have a branch like that for a
specific large topic (like one of the above) and focus on that for the
upcoming release.

The idea behind all this is that it would allow to work on a large topic
(breaking compatibility) early on, right after a 1.x.0 (which is
impossible right now), and hopefully have it exposed to more people,
maybe providing an integration branch if we go with the "long lived
large topic branch" approach rather then the first one described above.

As time goes by the cow can do her thing, and people can be aware of
upcoming changes much earlier. Then it should be alright to break a few
more scripts in a 1.x.0 release - we always broke a few, so people would
always have to check before switching anyways.

Cheers,
Michael
