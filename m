From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [BUG] git add -u ignores --dry-run flag
Date: Thu, 15 May 2008 18:08:24 +0200
Message-ID: <482C5FF8.1060200@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 15 18:15:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwg1Q-00054I-1Z
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 18:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759112AbYEOQI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 12:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760154AbYEOQI2
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 12:08:28 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:33847 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759000AbYEOQI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 12:08:27 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id D8C5525A3D
	for <git@vger.kernel.org>; Thu, 15 May 2008 18:08:25 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 15438-09 for <git@vger.kernel.org>;
 Thu,  8 May 2008 07:37:09 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 47CFB25A3B
	for <git@vger.kernel.org>; Thu, 15 May 2008 18:08:25 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82208>

Hi!

I think this is a bug in the built in implementation of git add -u

$ git --version
git version 1.5.5.1.373.ga3200
$ git init
Initialized empty Git repository in /home/hendeby/bar/.git/
$ echo foo > foo
$ git add foo && git commit -m "Test"
Created initial commit 7477e8b: Test
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 foo
$ echo foo >> foo
$ git add -u --dry-run
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   foo
#

I was expecting to get foo listed, and not actually added to the index.

I've had a quick look in builtin-add.c, and the -u option is tested for 
before the --dry-run option, and in the process of handling the -u 
option the code makes a jump that bypasses the --dry-run handling. 
Unfortunately, I'm not familiar enough with the code to see how to best 
fix it.

/Gustaf
