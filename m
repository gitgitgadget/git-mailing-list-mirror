From: Pete Harlan <pgit@pcharlan.com>
Subject: Unexpected "clean -Xd" behavior
Date: Sun, 15 Jan 2012 18:00:14 -0800
Message-ID: <4F1384AE.1050209@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 16 03:00:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmbsJ-0003tA-UW
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 03:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978Ab2APCAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 21:00:16 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:54092 "EHLO
	homiemail-a51.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752387Ab2APCAO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2012 21:00:14 -0500
Received: from homiemail-a51.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a51.g.dreamhost.com (Postfix) with ESMTP id 592322E807F
	for <git@vger.kernel.org>; Sun, 15 Jan 2012 18:00:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:subject:content-type:
	content-transfer-encoding; q=dns; s=pcharlan.com; b=CuowvGIOncf5
	MkfO1hCS1SZhg56mhhdvdalZ/IOlhOEEcA1OxSnrTEtIRxlevaimBwMJA8sBXY0a
	UFzWdq4mFRTl6nmJzFEn+KXnyfYpX1hR2wCBq9qjiP1CuK1Zpeh4LQXqXn7gFP5w
	akyVWuN5JnjMjJJyBIFJsB3/GKdVWGQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:subject:content-type:
	content-transfer-encoding; s=pcharlan.com; bh=wnlWyYFXdAOwdHT3aI
	wiYws2eGs=; b=ED9Rp8/eLFFzqTARzo7apLoZyxPnuCZZtCLUNgbvy2ZwmehXUT
	vJMKDbB8vVHtXIbqgfQyZ8pa7qDFMopWgbifgCxvTJWN+Rv2/wwzZcp9FObdJ0wo
	xOlI5bG9xCGTCRWVALTx38pqLnlSykI5x8L4FK9Kg5mzB5R2ofR+mZsEo=
Received: from [192.168.0.106] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pgit@pcharlan.com)
	by homiemail-a51.g.dreamhost.com (Postfix) with ESMTPSA id 4D3622E807D
	for <git@vger.kernel.org>; Sun, 15 Jan 2012 18:00:14 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111124 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188605>

Hi,

When a directory contains nothing but an ignored subdirectory, that
subdirectory does not get removed by "git clean -Xdf".

For example, in a new directory:

# git init
Initialized empty Git repository in /tmp/foo/.git/
# echo a/ >.gitignore
# git add .gitignore
# git commit -m "Initial commit"
[master (root-commit) c3af24c] Initial commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore
# mkdir -p foo/a
# touch foo/a/junk.o
# git status
# On branch master
nothing to commit (working directory clean)
# git clean -Xdn  # <--- DOES NOT MENTION foo/a
# touch foo/x.c
# git clean -Xdn  # <--- DITTO WITH UNTRACKED IN foo
# git add foo/x.c
# git clean -Xdn  # <--- WITH TRACKED IN foo, WILL REMOVE a/
Would remove foo/a/
#

Is this intentional?  It's interfering with my using "git clean" to
remove built objects, which happen to be in a dedicated temporary
subdirectory.

Thanks,

--Pete Harlan
  pgit@pcharlan.com
