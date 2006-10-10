From: Pazu <pazu@pazu.com.br>
Subject: Re: git-svn fetch fails when a file is renamed changing only case
Date: Mon, 09 Oct 2006 23:11:30 -0300
Message-ID: <egevhe$d15$1@sea.gmane.org>
References: <ege016$vrb$1@sea.gmane.org> <m2psd1rwb0.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 10 04:13:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX77C-0005kC-Fq
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 04:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWJJCNB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 22:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWJJCNB
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 22:13:01 -0400
Received: from main.gmane.org ([80.91.229.2]:13487 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750763AbWJJCNA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Oct 2006 22:13:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GX76u-0005f8-6Q
	for git@vger.kernel.org; Tue, 10 Oct 2006 04:12:48 +0200
Received: from 200.213.42.52 ([200.213.42.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 04:12:48 +0200
Received: from pazu by 200.213.42.52 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 04:12:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.213.42.52
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
In-Reply-To: <m2psd1rwb0.fsf@ziti.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28593>

Seth Falcon wrote:

> IOW, are you sure this is an issue in git-svn and not an issue in
> filesystem + svn?  For example, I think you will also have problems
> with a repository that contains in the same dir TESTFILE and TestFile
> :-\

If I try something like:

mini:~$ svn mv TESTFILE TestFile

It will fail with a message saying that TestFile already exists, since 
HFS+ is case insensitive by default:

svn: File 'TestFile' already exists

But keep in mind this is a shared repository, and people working on 
case-sensitive file systems may rename the file. I can do it too, if I 
use full URL's (all examples here use the same test repository provided 
in my first message):

mini:~$ svn mv file:///tmp/git-svn-rename-test/TESTFILE 
file:///tmp/git-svn-rename-test/TestFile
Commited revision 5.

Anyway, when I'm updating a working copy, svn will do the right thing:

mini:~$ svn co -r1 file:///tmp/git-svn-rename-test
D    git-svn-rename-test/TESTFILE
A    git-svn-rename-test/TestFile
Checked out revision 1.

mini:~$ cd git-svn-rename-test
mini:git-svn-rename-test$ svn up -r3
D    TestFile
A    TESTFILE
Updated to revision 3.

A rename for svn is just a copy followed by delete, so when updating, 
TestFile is removed and then recreated as TESTFILE, correctly.

So, to finally answer your question, no, unfortunately I don't think 
this is purely an svn problem. Yes, I would have problems with two files 
named TestFile and TESTFILE in the same dir, but that's not what happens 
in this test case.

Well, I'll keep browsing the git-svn source code, and try to make some 
sense out of it...

-- Marcus
