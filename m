From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Fri, 02 Nov 2012 15:43:24 +0100
Message-ID: <5093DC0C.5000603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 15:43:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUITD-0000GW-Gj
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 15:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab2KBOn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 10:43:27 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54705 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876Ab2KBOn0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2012 10:43:26 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8B26D20F59
	for <git@vger.kernel.org>; Fri,  2 Nov 2012 10:43:25 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 02 Nov 2012 10:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:content-type:content-transfer-encoding; s=smtpout; bh=d
	bMl341JA2kUh/mIDbXiIeAU6Io=; b=kM5OwHmSSQtY0QJUHnHFDrG9+c/M9xq2H
	gTOpIP9mca8gseb6Y7z3VQT4HSgsezhTm7Cxx7V3CZ1nS+cDyyM9DvMRk4o07lco
	ngRO4CHFADzyq817RGw9OEDTnZlNhO44R99diV5PTJVwJ3NnR0R4x9SyZkeD/Hrv
	fhvl2oi80s=
X-Sasl-enc: cdRsibPOe4wR161jdyqo19nFk79RNavLoen8Kmjx44tq 1351867405
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2EB6E8E00A2
	for <git@vger.kernel.org>; Fri,  2 Nov 2012 10:43:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208937>

It seems that our fast-import is super picky with regards to author
names. I've encountered author names like

Foo Bar<foo.bar@dev.null>
Foo Bar <foo.bar@dev.null
foo.bar@dev.null

in the self-hosting repo of some other dvcs, and the question is how to
translate them faithfully into a git author name. In general, we try to do

fullotherdvcsname <none@none>

if the other system's entry does not parse as a git author name, but
fast-import does not accept either of

Foo Bar<foo.bar@dev.null> <none@none>
"Foo Bar<foo.bar@dev.null>" <none@none>

because of the way it parses for <>. While the above could be easily
turned into

Foo Bar <foo.bar@dev.null>

it would not be a faithful representation of the original commit in the
other dvcs.

So the question is:

- How should we represent botched author entries faithfully?

As a cororollary, fast-import may need to change or not.

Michael

P.S.: Yes, dvcs=hg, and the "earlier" remote-hg helper chokes on these.
garbage in crash out :(
