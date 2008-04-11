From: Eric Blake <ebb9@byu.net>
Subject: url.<base>.insteadOf bugs
Date: Fri, 11 Apr 2008 13:59:04 +0000 (UTC)
Message-ID: <loom.20080411T134849-798@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 21:06:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkOZM-0002dP-6E
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 21:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760122AbYDKTFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 15:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760157AbYDKTFI
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 15:05:08 -0400
Received: from main.gmane.org ([80.91.229.2]:40711 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759030AbYDKTFH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 15:05:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JkOYY-0000pG-QJ
	for git@vger.kernel.org; Fri, 11 Apr 2008 19:05:02 +0000
Received: from eblake.csw.l-3com.com ([128.170.36.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 19:05:02 +0000
Received: from ebb9 by eblake.csw.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 19:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.124 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79286>

I just upgraded to git 1.5.5, and decided to try out the new 
url.<base>.insteadOf config option, to save me typing when pulling from 
git.sv.gnu.org (and so that I can type the same url whether I'm at home and can 
use git://, or when I'm at work and behind a stupid firewall where I must use 
http://).  It has a couple of bugs:

First, it appears to have an off-by-one bug.

$ git --version
git version 1.5.5
$ mkdir bison
$ cd bison
$ git init
Initialized empty Git repository in .git/
$ git config url.http://git.sv.gnu.org/r/.insteadOf gnu:
$ git fetch gnu:bison.git master
fatal: I don't handle protocol 'ttp'
$ git config --unset url.http://git.sv.gnu.org/r/.insteadOf     
$ git config --global 'url. http://git.sv.gnu.org/r/.insteadOf' gnu:
$ git fetch gnu:bison.git master
Getting alternates list for http://git.sv.gnu.org/r/bison.git
...

Second, 'git clone --help' documents that it uses this config option, but it 
doesn't:

$ cd ..
$ rm -Rf bison
$ git clone gnu:bison.git
Initialized empty Git repository in /home/eblake/bison/.git/
ssh: Could not resolve hostname gnu: no address associated with name
fatal: The remote end hung up unexpectedly
fetch-pack from 'gnu:bison.git' failed.

-- 
Eric Blake
