From: Pazu <pazu@pazu.com.br>
Subject: git-svn fetch fails when a file is renamed changing only case
Date: Mon, 09 Oct 2006 14:13:51 -0300
Message-ID: <ege016$vrb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010803090902090205070104"
X-From: git-owner@vger.kernel.org Mon Oct 09 19:36:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWz2d-0001fB-UB
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 19:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWJIRfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 13:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWJIRfJ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 13:35:09 -0400
Received: from main.gmane.org ([80.91.229.2]:25262 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964773AbWJIRfF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Oct 2006 13:35:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GWz1p-0001Pv-WF
	for git@vger.kernel.org; Mon, 09 Oct 2006 19:35:02 +0200
Received: from 201.37.98.50 ([201.37.98.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Oct 2006 19:35:01 +0200
Received: from pazu by 201.37.98.50 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Oct 2006 19:35:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 201.37.98.50
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28575>

This is a multi-part message in MIME format.
--------------010803090902090205070104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

For example, if you had a file named TestFile and it's renamed to 
TESTFILE, git-svn fails to fetch revisions after the rename.

My perl skills are close to non-existant, so I'm afraid I don't know how 
to fix this. Attached to this message, however, is a sample svn 
repository that can reproduce this bug. Just unpack it somewhere (let's 
say, in /tmp) and try the following:

tar -C /tmp -xzf git-svn-rename-test.tar.gz
mkdir test-wc
cd test-wc
git-svn init file:///tmp/git-svn-rename-test
git-svn fetch

The last command will fail after fetching revision #3, where a file 
named TestFile was renamed to TESTFILE. Here's the stack trace:

svn: 'TestFile' is not under version control
256 at /Users/pazu/bin/git-svn line 2015
         main::safe_qx('svn', 'propget', 'svn:keywords', 
'TestFile@BASE') called at /Users/pazu/bin/git-svn line 2154
         main::svn_propget_base('svn:keywords', 'TestFile') called at 
/Users/pazu/bin/git-svn line 1773
         main::do_update_index('ARRAY(0x180bd68)', 'remove', 'undef') 
called at /Users/pazu/bin/git-svn line 1805
         main::index_changes() called at /Users/pazu/bin/git-svn line 1875
         main::git_commit('HASH(0x180bd98)', 
'c77db38dc752305ba19ebe19b22306551d0f8d52') called at 
/Users/pazu/bin/git-svn line 346
         main::fetch_cmd() called at /Users/pazu/bin/git-svn line 290
         main::fetch() called at /Users/pazu/bin/git-svn line 149

I'm on Mac OS X (Intel) 10.4.8

mini:~ pazu$ uname -a
Darwin mini.intranet.ecore.com.br 8.8.1 Darwin Kernel Version 8.8.1: Mon 
Sep 25 19:42:00 PDT 2006; root:xnu-792.13.8.obj~1/RELEASE_I386 i386 i386

Git was compiled from the released 1.4.2.3 sources, without any 
modifications:

mini:~ pazu$ git-svn --version
git-svn version 1.4.2.3

If you need more information, you can contact me directly, or just use 
the list -- I'll be here listening :)

-- Marcus Brito

--------------010803090902090205070104
Content-Type: application/x-gzip; x-mac-type="0"; x-mac-creator="0";
 name="git-svn-rename-test.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-svn-rename-test.tar.gz"

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
--------------010803090902090205070104--
