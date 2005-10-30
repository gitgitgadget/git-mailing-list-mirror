From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Sun, 30 Oct 2005 12:12:36 -0800
Message-ID: <43652934.8000308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 30 21:14:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWJXz-00011C-B3
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 21:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVJ3UMu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 15:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVJ3UMu
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 15:12:50 -0500
Received: from terminus.zytor.com ([192.83.249.54]:42449 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750735AbVJ3UMu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 15:12:50 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9UKCadJ011622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 30 Oct 2005 12:12:37 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>, rpm-list@redhat.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10827>

The Subversion importer Perl script breaks RPM generation.  First of 
all, it introduces new module dependencies which don't exist in for 
example RHEL4.  The easiest way to deal with that is probably to fork 
off the subversion exporter into a separate package, but the really bad 
one is:

git-svnimport.perl:require v5.8.0; # for shell-safe open("-|",LIST)

... which RPM thinks means that you need a Perl module called v5.8.0 
which doesn't, of course, exist.  This is arguably an rpmbuild bug, but 
it nevertheless breaks at the moment.

I'm afraid I cannot update any of the kernel.org machines to 0.99.9 
until these problems have been cleaned up.

	-hpa
