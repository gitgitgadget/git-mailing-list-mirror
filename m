From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git-upload-pack: the timeout gets corrupted?!
Date: Sat, 10 Mar 2007 17:45:28 -0800
Message-ID: <45F35F38.1080206@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 02:45:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQD7z-0002Mn-MR
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 02:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbXCKBpg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 20:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbXCKBpg
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 20:45:36 -0500
Received: from terminus.zytor.com ([192.83.249.54]:44237 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932325AbXCKBpf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 20:45:35 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l2B1jTEk010803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 10 Mar 2007 17:45:29 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
X-Virus-Scanned: ClamAV 0.88.7/2801/Sat Mar 10 11:14:47 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=2.3 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,PLING_QUERY,RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL
	autolearn=no version=3.1.8
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41891>

git-1.5.0.3-1.i386 rpm from Junio's repository on kernel.org:

Since we got the new git server on kernel.org, we are having a problem 
with git-upload-pack processes getting reparented to init, and then 
sitting there forever.  Going in with gdb, it appears the "timeout" 
variable gets overwritten:

(gdb) p timeout
$1 = 608471321

... which should have been 600.

The process spends effectively forever waiting in on the fflush() in 
show_commit() (in upload-pack.c); /proc/*/fd shows it is trying to write 
to a pipe, but I'm not sure what is at the other end of that same pipe.

	-hpa
