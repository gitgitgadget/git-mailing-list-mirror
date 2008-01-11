From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 13:18:10 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801111313220.3148@woody.linux-foundation.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 22:19:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDRHX-0004WX-F3
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 22:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759971AbYAKVSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 16:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760112AbYAKVSp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 16:18:45 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43300 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759853AbYAKVSo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 16:18:44 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BLIAO2012119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jan 2008 13:18:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BLIA60023091;
	Fri, 11 Jan 2008 13:18:10 -0800
In-Reply-To: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70203>



On Fri, 11 Jan 2008, Kevin Ballard wrote:
>
> Anyway, here's the state of my directory:
> 
> kevin@KBALLARD:~/Documents/School/C07> git ls-tree HEAD
> 040000 tree b47c8103e2e01fcf145bdc237c0e56ffc61f1c47	CS4536
> 040000 tree dbf7fc51ef3effebdf9b4e9172e4c86cae52b163	cs4536
> 040000 tree 15834a7b6534a285bf6930be4e5404b37e1dc718	ece3601
> 040000 tree 62d229b8c4a389b550df20a3752d666c48c767a4	ma2071

Hmm. You can do something like

	git ls-files CS4536 | xargs git update-index --force-remove

which will remove gits knowledge of that directory even though "lstat()" 
will still claim that all the files still exists.

Case-insensitive filesystems are a pain.

I wish we had some way to handle it sanely, but I don't think a sane 
solution to case-insensitivity exists. If you limit it to strictly just 
7bit ascii names (like in your example), then some of the problems do go 
away, but it would still be probably fairly major surgery to try to teach 
git about the whole insanity of a case-independent working tree.

		Linus
