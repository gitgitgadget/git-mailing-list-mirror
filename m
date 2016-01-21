From: Andrew Stewart <boss@airbladesoftware.com>
Subject: git-diff: unable to turn off diff.autorefreshindex with command line switch
Date: Thu, 21 Jan 2016 10:29:49 +0000
Message-ID: <4432B7DA-921D-4D1C-8DC5-55A4E3722F73@airbladesoftware.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 11:30:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMCVB-0001Re-Q7
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 11:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759202AbcAUKaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 05:30:00 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55257 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935132AbcAUK3w convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 05:29:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 61CEE207E1
	for <git@vger.kernel.org>; Thu, 21 Jan 2016 05:29:51 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 21 Jan 2016 05:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	airbladesoftware.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=gxO2Bw3zsvVEW9JW4ddtkSkA19c=; b=tXLlix
	LaivRa5yZjvm3JXK9BP4FLmQpkH6dPh60sClQv4HOuqaadfxPhoRZZv35gLV+hX0
	EiLMY2iW9bznJZ3hR5onj4jv0ePPUWADbaFhVCgMhQ1qMupxZJN/pG0Oc098Nudu
	EsNkOURwCvmPaoK+izSmp50tYyJ0mdNMNUbxs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=gxO2Bw3zsvVEW9JW4ddtkSkA19c=; b=ixSZ8
	wT58dZY+TdxuyY3gBYY9gZZZPKru2fo5eXkPiNN4DZ6sAIwhCoJF+raAYQmU/UnC
	1lB4Gx0S2LOH2FUTlI6yzy1Mil1CW5pTC45Si5yFioQLeNFlS+23iT2BiANumflq
	o3FAEj5fUd3BZ73cB+NtXZWfPWEntFPESogk+w=
X-Sasl-enc: d67rqoJn++Y6ukyfswDFp30nEfaxhLwc8WJs2To9iA6Y 1453372191
Received: from andrews-mbp.home (host81-153-212-242.range81-153.btcentralplus.com [81.153.212.242])
	by mail.messagingengine.com (Postfix) with ESMTPA id DFF76C01714;
	Thu, 21 Jan 2016 05:29:50 -0500 (EST)
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284511>

Hello,

I am seeing unexpected behaviour on my system with git-diff and stat-only changes: diff.autorefreshindex=0 only works when in a repo's config (./.git/config); it doesn't work via a -c switch.  Conversely -c diff.autorefreshindex=1 does indeed override a 0 setting in the repo's config.

# First I remove all my normal configs.
$ mv ~/.git* ~/stuff/

# Now some setup.
$ mkdir foo && cd foo
$ git init
$ echo 123 > README
$ git commit -am 'initial'
[master (root-commit) 92e793c] initial
 ...[stuff about name and email address being auto-configured]...
 1 file changed, 1 insertion(+)
 create mode 100644 README
$ touch README

# Now the strange behaviour: no output from the next command
$ git -c diff.autorefreshindex=0 diff --raw -- README

$ cat .git/config
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
	ignorecase = true
	precomposeunicode = true

$ echo -e "[diff]\n  autorefreshindex = 0" >> .git/config
$ touch README

# Next command works as expected.
$ git diff --raw -- README
:100644 100644 190a180... 0000000... M  README

# Next command produces no output as expected
$ git -c diff.autorefreshindex=1 diff --raw -- README

I get this with both git v2.6.4 and v2.7.0 on my OS X 10.11.2.  I tried it on another system (Ubuntu 12.04 LTS, git 1.7.9.5) and everything worked as expected.  Somebody else tried it on their OS X 10.11.2 (as well as 10.10.something) with git 2.5.4 and everything worked as expected.

Any help would be much appreciated.  Thanks in advance!

Yours,
Andrew Stewart
