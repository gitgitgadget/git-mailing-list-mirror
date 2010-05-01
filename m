From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: rev-parse vs. rev-list --no-walk
Date: Sat, 01 May 2010 20:35:29 +0200
Message-ID: <4BDC7471.9030107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 01 20:35:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8HXM-0008E4-EE
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 20:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838Ab0EASfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 14:35:30 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53394 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753779Ab0EASfa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 May 2010 14:35:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8D789EF9B5
	for <git@vger.kernel.org>; Sat,  1 May 2010 14:35:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 01 May 2010 14:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=WjjprCdw6dp3vQZ0xv94owNj7DQ=; b=URhVgARpkBSNLmPOAKK3RNTz/YPkZGzwmF7ntsawwtb8rRiRM7qqohNGBDI/TMiMohDCjMuy5G7KuGY3XuCYDpTdwiRqb16+EcR34L7Tr805uaSb42C+dsuP/UzR/mSfGOaMCDqjeFh7/Z82GskXNi67x7fpJfU3QSuWP9LcLvs=
X-Sasl-enc: bdyrtHJomVm1gtpc+FvrwydwwfSQoZdsd4epvR9NrqXB 1272738929
Received: from localhost.localdomain (p5DCC08EA.dip0.t-ipconnect.de [93.204.8.234])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 02993188BE
	for <git@vger.kernel.org>; Sat,  1 May 2010 14:35:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146106>

In connection with an upcoming RFD patch, I noticed that rev-parse and
rev-list --no-walk do very similar things (OK - I knew *that* already)
in different ways. In particular, rev-list uses the ordinary
setup_revision() which is used in many other places, whereas rev-parse
does it's own thing.

rev-parse does a couple more things, of course, but why doesn't it use
setup_revision() ? I just wanted to ask before trying to restructure
things....

As it is we have the maintenance burden of keeping both rev option
parsers in sync. And, in fact, they are not:

- setup_revision() (and thus rev-list) explicitly adds HEAD for "--all",
rev-parse does not

- setup_revision() outputs each sha1 only once, rev-parse possibly
multiple times (in case of coinciding heads/tags...)

Of course, rev-parse and rev-list --no-walk do actually very different
things, as one can see from the results of "--tags" on both (partially
answering my own question here). And that difference is intentional. So:

- Should setup_revision() really add HEAD on --all? (Probably yes.) In
this case I'd adjust the doc.

- Shouldn't rev-parse --all add HEAD as well?

- Is there any way to use setup_revision() without resolving tags to
commits etc. (and thus using it for rev-parse)?

Michael
