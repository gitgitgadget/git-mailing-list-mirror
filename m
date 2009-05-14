From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Cross-Platform Version Control
Date: Thu, 14 May 2009 14:48:40 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0905141441200.20117@perkele.intern.softwolves.pp.se>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 16:52:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4cIk-0004VJ-Gg
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 16:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbZENOwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 10:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbZENOwm
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 10:52:42 -0400
Received: from mx.getmail.no ([84.208.15.66]:56203 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751010AbZENOwl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 10:52:41 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2009 10:52:41 EDT
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJM003X4ZVOM910@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 14 May 2009 15:52:36 +0200 (MEST)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJM00707ZQ7BN00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 14 May 2009 15:52:35 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.14.133150
Received: by perkele (Postfix, from userid 501)	id D6870189AE1; Thu,
 14 May 2009 15:48:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id D32C81A97ED; Thu, 14 May 2009 14:48:40 +0100 (CET)
In-reply-to: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119199>

Esko Luontola:

> A good start for making Git cross-platform, would be storing the text 
> encoding of every file name and commit message together with the commit.

Is it really necessary to store the encoding for every single file name, 
should it not be enough to just store encoding information for all file 
names at once (i.e., for the object that contains the list of file names and 
their associated blobs)?

I did publish, as a request for comments, the beginnings of a patch that 
would change the Windows version of Git to expect file names to be UTF-8 
encoded. There were some comments about it, especially that I could not just 
assume that UTF-8 was the right thing to assume.

Perhaps if we added some meta-data, maybe using the same fall-back mechanism 
as for commit messages (i.e., assume UTF-8 unless otherwise specified), it 
would be easier to do.

On Windows, the file APIs allow you to use Unicode (UTF-16) to specify file 
names, and the file systems will handle any necessary conversion to whatever 
byte sequences are used to store the file names. UTF-16 and UTF-8 are 
trivial to convert between, and Windows does contain APIs to convert between 
other character encodings and UTF-16.

On Mac OS X, I believe the file system APIs assume you use some kind of 
normalized UTF-8. That should also be possible to create, possibly 
converting back and forth between different normalization forms, if necessary.

On Linux and other Unixes we could just use iconv() to convert from the 
repository file name encoding to whatever the current locale has set up. The 
trick here is to handle file names outside the current encoding. Some kind 
of escaping mechanism will probably need to be introduced.

The best way would be to define this in the Git core once and for all, and 
add support to it for all the platforms in the same go, instead of trying to 
hack around the issue whenever it pops up on the various platforms.

My main use-case for Git on Windows has disappeared as my $dayjob went 
bankrupt, but I am happy to assist with whatever insight I may be able to 
bring.

-- 
\\// Peter - http://www.softwolves.pp.se/
