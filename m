From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: weird behaviour in git
Date: Thu, 26 Feb 2015 15:45:13 +0100
Message-ID: <54EF3179.8030104@drmicha.warpmail.net>
References: <20150226141234.GP19896@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Thomas Klausner <tk@giga.or.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 15:45:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQzgs-0005fE-DB
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 15:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbbBZOpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 09:45:18 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59670 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753742AbbBZOpP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2015 09:45:15 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 054BA20A5D
	for <git@vger.kernel.org>; Thu, 26 Feb 2015 09:45:13 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 26 Feb 2015 09:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=CDYPb8qQfmDsLzrT9ghFt7
	H2BP4=; b=a5P93GdVIPKLiSCLl8orIldXyxgG/SH2A4p6DARa12sZbtQZ/7lIc8
	FpcSUniluGlpgw5m8CGnuAWvHE1wB0QhV6y0FynCRhXZ0w8Ob1HirqQ995YVCa6j
	dl3s8Rb5Zti9WjG9eyjOe7E8QRN+3J+vZxBc1gSjLMlguBJdB+90E=
X-Sasl-enc: jdz2Y2tT1sEjsP9tS+MLHGVDSqnZoedk3KTItuT/qPRS 1424961914
Received: from localhost.localdomain (unknown [188.96.114.76])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4C329680171;
	Thu, 26 Feb 2015 09:45:14 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150226141234.GP19896@danbala.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264445>

Thomas Klausner venit, vidit, dixit 26.02.2015 15:12:
> Hi!
> 
> I've played around with git and found that 'git mv' does not honor
> what I tell it to do:
> 
> wiz@yt:~> mkdir a
> wiz@yt:~> cd a
> wiz@yt:~/a> git init .
> Initialized empty Git repository in /home/wiz/a/.git/
> wiz@yt:~/a> touch a
> wiz@yt:~/a> git add a
> wiz@yt:~/a> git commit -m 'add a'
> [master (root-commit) 99d0ee7] add a
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 a
> wiz@yt:~/a> git mv a b
> wiz@yt:~/a> touch Makefile
> wiz@yt:~/a> git add Makefile
> wiz@yt:~/a> git commit
> 
> 
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
> # On branch master
> # Changes to be committed:
> #       renamed:    a -> Makefile
> #       new file:   b
> #
> 
> This is reproducible for me with "git version 2.3.0" on
> NetBSD-7.99.5/amd64.
> 
> I guess this happens because the checksums of the files are the same
> and 'Makefile' is earlier when sorting, but since I explicitly told
> "git mv" old and new name, I think that's a bug nevertheless.
>  Thomas
> 

git tracks content, not paths.

It does record the path at which the tracked content is, of course. But
it tracks the history of content, not that of paths.

What you see in the diff above is merely one way to interpret the
history of the content. Saying

renamed:  a -> b
new file: Makefile

leads to the same content at the same paths (with the proper new file
content).

By default, diff tries to interpret content history in terms of renames
and copies when possible, in order to help users. Sometimes this fails -
while still being correct, it confuses them ;)

Michael
