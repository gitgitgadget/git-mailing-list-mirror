From: Frans Englich <fenglich@fastmail.fm>
Subject: Bug report: .gitattributes: -diff Unset causes files to be reported as binaries
Date: Wed, 1 Jul 2009 12:08:35 +0200
Message-ID: <200907011208.35397.fenglich@fastmail.fm>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jWzSKUjS5sEv03v"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 12:05:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLwh6-00006p-5O
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 12:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbZGAKFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 06:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZGAKFU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 06:05:20 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40098 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752681AbZGAKFT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jul 2009 06:05:19 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 924F63825A4
	for <git@vger.kernel.org>; Wed,  1 Jul 2009 06:05:21 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 01 Jul 2009 06:05:21 -0400
X-Sasl-enc: gmDhvPzP4PPFaC4JEj3FWbI2FHUbLX2t9mJoBMsVr0Rq 1246442721
Received: from localhost (unknown [62.70.27.104])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 294092D580
	for <git@vger.kernel.org>; Wed,  1 Jul 2009 06:05:21 -0400 (EDT)
User-Agent: KMail/1.9.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122579>

--Boundary-00=_jWzSKUjS5sEv03v
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi,

Applying -diff Unset to a file using .gittattributes causes "git diff" to 
state that the file is a binary even though it isn't, or have been instructed 
to be treated as one. See attached script for reproducing.

This causes confusion since the file isn't a binary, it's only the diff output 
that has been suppressed. For instance, an auto generated cpp file has -diff 
Unset applied to it to suppress the meaningless output, but people contact 
you to point out the file is binary.

Perhaps this is easy to fix, a question of changing message strings.


Cheers,

		Frans

--Boundary-00=_jWzSKUjS5sEv03v
Content-Type: application/x-shellscript;
  name="reproduceDiffBinary.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="reproduceDiffBinary.sh"

#!/bin/bash

rm -rf diffbinary
mkdir diffbinary
cd diffbinary

git init
echo "the content" > file.txt
echo "file.txt -diff Unset" > .gitattributes
git add file.txt .gitattributes
git commit -m "Add files."
echo "new content"> file.txt

# This command:
git diff
# will now output "Binary files a/file.txt and b/file.txt differ", even though the file isn't a binary.

--Boundary-00=_jWzSKUjS5sEv03v--
