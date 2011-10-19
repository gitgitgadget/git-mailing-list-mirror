From: Johannes Sixt <j.sixt@viscovery.net>
Subject: How to verify that lines were only moved, not edited?
Date: Wed, 19 Oct 2011 16:34:20 +0200
Message-ID: <4E9EDFEC.3040009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 16:34:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGXDz-00081B-SA
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 16:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab1JSOeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 10:34:25 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19988 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752415Ab1JSOeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 10:34:25 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RGXDp-0001Fm-Gb
	for git@vger.kernel.org; Wed, 19 Oct 2011 16:34:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2E4831660F
	for <git@vger.kernel.org>; Wed, 19 Oct 2011 16:34:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183930>

I thought there was a way to use git-blame to find out whether a change
only shuffled lines, but otherwise did not modify them. I tried "git blame
-M -- the/file", but it does not work as expected, neither with a toy file
nor with a 5000+ lines file (with 55 lines moved).

git init
echo A > foo
echo B >> foo
git add foo
git commit -m initial
echo B > foo
echo A >> foo
git commit -a -m swapped

The results are:
$ git blame -M -s -- foo
^e3abca2 1) B
6189cb46 2) A

I would have expected:
^e3abca2 1) B
^e3abca2 2) A

Oh, look! This produces the expected result:
$ git blame -M1 -s -- foo

while this produces the same as with just -M:
$ git blame -M2 -s -- foo

But neither helps with my 5000+ lines file. Does it mean that the lines
were changed? But I'm sure they were just moved! Please help!

-- Hannes
