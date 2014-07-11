From: Duane Murphy <duanemurphy@mac.com>
Subject: git-fast-import bug?
Date: Fri, 11 Jul 2014 14:58:32 -0700
Message-ID: <424DC50C-DF9D-423E-93DC-E9E224B871D0@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 23:58:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5iq0-0000lm-U2
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 23:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbaGKV6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 17:58:37 -0400
Received: from st11p02mm-asmtp001.mac.com ([17.172.220.236]:36995 "EHLO
	st11p02mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753495AbaGKV6g (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jul 2014 17:58:36 -0400
Received: from [192.168.1.26]
 (70-36-184-217.dsl.static.sonic.net [70.36.184.217])
 by st11p02mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-27.10(7.0.4.27.9) 64bit (built Jun
  6 2014)) with ESMTPSA id <0N8K00F9RIDLQO00@st11p02mm-asmtp001.mac.com> for
 git@vger.kernel.org; Fri, 11 Jul 2014 21:58:35 +0000 (GMT)
X-Mailer: Apple Mail (2.1878.6)
X-MANTSH: 1TEIXWV4bG1oaGkdHB0lGUkdDRl5PWBoaGxEKTEMXGx0EGx0YBBIZBBsdEBseGh8
	aEQpYTRdLEQptfhcaEQpMWRcbGhsbEQpZSRcRClleF2hjeREKQ04XSxsYGmJCH2lpH29TGXhzB
	xxoGBsfEnAeEQpFQxcWHhgebmkfGmkHbmwTbgceGBlvBxMZbmkHbxNvGBgeaBIdG24aakdLSQR
	JRUcUEQpYXBcZBBoEGx4HTU4cExoaHRMFGx0EGx0YBBIZBBsdEBseGh8bEQpeWRdhE01hRxEKQ
	1oXHRoEGRwEGxIeBBgbHREKQkUXYVpCfXJbQ0dlGEURCkJOF2hGQkAfSHkdRx9kEQpCTBdhQXh
	he0hJUxlYeREKQmwXen9OYwFIeEVSX0MRCkJAF2AfZERZbmIdE2ZCEQpCWBdsfHhNYh19GVlkH
	REKcGgXaU1nYFliXgVyZUQRCnBoF2BbWkd4XH5MGll7EQpwaBdmQkYFYlJiRXIeHhEKcGgXbF1
	kU0xMX2JMRkQRCnBoF2t4Wk1aXn54U25CEQpwbBdiUB9bW0thXX9lcBE=
X-CLX-Spam: false
X-CLX-Score: 1011
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.12.52,1.0.14,0.0.0000
 definitions=2014-07-11_04:2014-07-11,2014-07-11,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=52 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1402240000 definitions=main-1407110267
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253332>

git-fast-import is not writing a commit even after a checkpoint/progress command.

See my previous message "git p4 diff-tree ambiguous argument error". 

The error in git-p4 is caused by git not writing the commit even after git-fast-import has been given a checkpoint and progress command.

On initial use of git p4 to sync a p4 repository, the commits are written properly. But on a subsequent run the commit is not flushed to the file system during the run. Specifically, I can stop the git-p4 command directly after the progress checkpoint command (see the checkpoint() function in git-p4). The file is not found. If I abort/exit the application at that point, the file appears. 

There is a pattern of behavior here that is consistent but I am unable to understand. A bare repository works fine. An already populated repository does not work until the app is quit. What would cause git-fast-import to _NOT_ flush the file?

This certainly seems like a bug. But I don't know enough of the git internals to reproduce.

Suggestions on how to test or isolate this problem?

Thanks

Reproduced consistently on two systems:

$ git --version 
git version 1.8.5.2 (Apple Git-48) 
$ python --version 
Python 2.7.5 
$ uname -a 
Darwin Kernel Version 13.3.0: Tue Jun  3 21:27:35 PDT 2014; root:xnu-2422.110.17~1/RELEASE_X86_64 x86_64 

and 

$ git --version 
git version 1.7.12.4 
$ python --version 
Python 2.6.6 
OS: GNU/Linux 2.6.32-431.el6.x86_64 
