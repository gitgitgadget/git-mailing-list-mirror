From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Deleting files
Date: Thu, 12 Jun 2008 14:11:25 +0200
Message-ID: <477B22F6-9F24-4CBE-98EE-58EF697E6320@ai.rug.nl>
References: <g2r19e$s6e$1@ger.gmane.org> <g2r1sb$tut$1@ger.gmane.org> <g2r36d$2ju$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shak" <sshaikh@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 14:12:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6lfG-0002QN-Nq
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 14:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759071AbYFLMLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 08:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759000AbYFLMLd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 08:11:33 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:46463 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389AbYFLMLc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 08:11:32 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6201.orange.nl (SMTP Server) with ESMTP id DDD401C0008D;
	Thu, 12 Jun 2008 14:11:30 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6201.orange.nl (SMTP Server) with ESMTP id 8C86B1C0008A;
	Thu, 12 Jun 2008 14:11:26 +0200 (CEST)
X-ME-UUID: 20080612121130575.8C86B1C0008A@mwinf6201.orange.nl
In-Reply-To: <g2r36d$2ju$1@ger.gmane.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84749>


On 12 jun 2008, at 14:01, Shak wrote:

> This is all becoming very counter-intuitive :(

It seems you are missing the concept of the index. Let's look
at an example:
Vienna:a pieter$ git init
Initialized empty Git repository in /Users/pieter/a/.git/
Vienna:a pieter$ touch a b
Vienna:a pieter$ git commit -m "Initial commit"
Created initial commit f0a0fe2: Initial commit
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 a
  create mode 100644 b
Vienna:a pieter$ rm a
Vienna:a pieter$ git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    a
#

This is the point where you were. Look at the line "Changed but no  
updated"
and also the hint "(use "git add/rm <file>..." to update what will be  
committed)".

Vienna:a pieter$ echo "text" >b && git add b && git commit -m "change"
Created commit e28a131: change
  1 files changed, 1 insertions(+), 0 deletions(-)

You changed b and commited it, but did nothing with a. now when you do  
git status:

Vienna:a pieter$ git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    a
#
no changes added to commit (use "git add" and/or "git commit -a")

It'll still show it as deleted. And still gives you a hint on what to do
(TWICE!). So, let's do that:

Vienna:a pieter$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    a
#


Notice that it now says "Changes to be committed"! If you commit now,  
your
status will be clean:

Vienna:a pieter$ git commit -m "deleted a"
Created commit 02bbe7b: deleted a
  0 files changed, 0 insertions(+), 0 deletions(-)
  delete mode 100644 a
Vienna:a pieter$ git status
# On branch master
nothing to commit (working directory clean)


In short, the point is that you never commited the deletions! Your  
whole history
until now will still show those deleted files. You can commit the  
actually deletions
now, as you should have done before (either by using "git rm <file>",  
"git add -u",
"git commit -a" or "git commit <file>".

- Pieter
