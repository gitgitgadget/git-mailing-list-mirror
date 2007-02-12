From: Pavel Roskin <proski@gnu.org>
Subject: StGIT discards local commits on "stg pull"
Date: Mon, 12 Feb 2007 02:26:25 -0500
Message-ID: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 08:26:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGVa5-0000GB-0N
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 08:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061AbXBLH01 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 02:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933062AbXBLH00
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 02:26:26 -0500
Received: from mailgate.cesmail.net ([216.154.195.36]:51358 "HELO
	mailgate.cesmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933061AbXBLH00 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 02:26:26 -0500
Received: (qmail 18588 invoked from network); 12 Feb 2007 07:26:25 -0000
Received: from unknown (HELO delta.cesmail.net) (192.168.1.30)
  by mailgate.cesmail.net with SMTP; 12 Feb 2007 07:26:25 -0000
Received: (qmail 30597 invoked by uid 99); 12 Feb 2007 07:26:25 -0000
Received: from c-71-230-131-166.hsd1.pa.comcast.net
	(c-71-230-131-166.hsd1.pa.comcast.net [71.230.131.166]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Mon, 12 Feb 2007 02:26:25 -0500
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39382>

Hello!

I have been bitten by a strange bug/feature of StGIT, and it looks like it's not
only counterintuitive, but also inconsistent with git.

I have a repository available over ssh and I push to it from several places.  
Sometimes I make a commit and forget to push it.  Then I run "stg pull" to make
sure my repository is up to date.

The result is that the repository is rebased back to the last remote commit. 
It's very easy to miss.  There is no warning.  Everything looks just like an
update from the remote.

The example below shows that git-pull keeps my commit, but "stg pull" discards
it by rebasing back to the remote ID.

My .gitconfig doesn't override "stg pull" behavior; it merely sets my name and
mail aliases.

[proski@dl stgit-test]$ stg id
ebc429e7b7e596a12e8255fadc397123893cec73
[proski@dl stgit-test]$ echo "test change" >README
[proski@dl stgit-test]$ git-commit -m "test commit" README
Created commit 468861a2a1530f3bf98108e69632b3059e4ca0ce
 1 files changed, 1 insertions(+), 14 deletions(-)
[proski@dl stgit-test]$ git-pull
Fetching refs/heads/master from http://homepage.ntlworld.com/cmarinas/stgit.git
using http
Fetching refs/heads/stable from http://homepage.ntlworld.com/cmarinas/stgit.git
using http
Already up-to-date.
[proski@dl stgit-test]$ stg id
468861a2a1530f3bf98108e69632b3059e4ca0ce
[proski@dl stgit-test]$ stg pull
Checking for changes in the working directory... done
Pulling from "origin"...
Fetching refs/heads/master from http://homepage.ntlworld.com/cmarinas/stgit.git
using http
Fetching refs/heads/stable from http://homepage.ntlworld.com/cmarinas/stgit.git
using http
rebasing to "ebc429e7b7e596a12e8255fadc397123893cec73"...
done
No patches applied
[proski@dl stgit-test]$ stg id
ebc429e7b7e596a12e8255fadc397123893cec73
[proski@dl stgit-test]$

--
Regards,
Pavel Roskin
