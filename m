From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: git replace woes: dirty stat with clean workdir
Date: Tue, 10 Nov 2009 17:21:12 +0100
Message-ID: <4AF992F8.8010309@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 17:21:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7tTK-0001e6-8Y
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 17:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876AbZKJQVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 11:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756858AbZKJQVR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 11:21:17 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46800 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756835AbZKJQVQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 11:21:16 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DD047BED24;
	Tue, 10 Nov 2009 11:21:21 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 10 Nov 2009 11:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:content-type:content-transfer-encoding; s=smtpout; bh=MF58EehFmEPWAFjx0KT93duszVQ=; b=YW0A97shuzmUD46RJskvGsTLFA/3uBylxzsMKDD76o4Wk2OKJf4xeAY+r5qTIDgOfBP4+rAO+8VIosMUaIAg9Q3OeLZiUKm5FywYPSnntR8V5WEUIGSiZExQTBXPqJQCXZOHlcr24eoGxR51snkjzSsuupPYYe8DhR4zlp22B5A=
X-Sasl-enc: NEvU+OHoGNk3mPhi5q7wJhJb6YIPTajdb9xooIp6Oziv 1257870080
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5011F4AAF95;
	Tue, 10 Nov 2009 11:21:20 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091110 Lightning/1.0pre Shredder/3.0pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132576>

Hi there,

when cooking up a "warning example" for git replace (don't draw
premature conclusions when there are replaced objects) I came across the
following problem: git status seems to compare the work dir with the
tree of HEAD, not the replacing tree. Even deleting the index does not help.

[ The example also shows that we need a way to specify
--no-replace-objects for gitk. Would easier if gitk really where git
something. ]

Michael

#!/bin/sh
rm -Rf rtest &&
mkdir rtest &&
cd rtest &&
git init &&
echo > comment &&
git add comment &&
git commit -m "empty comment" &&
echo nice > "comment" &&
git commit -am "nice comment" &&
echo ugly > "comment" &&
git commit -am "to be discarded" &&
git replace HEAD^^{tree} HEAD^{tree} &&
git reset --hard HEAD^ &&
git log -p &&
git st
