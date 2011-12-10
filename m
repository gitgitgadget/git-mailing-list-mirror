From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: process committed files in post-receive hook
Date: Sat, 10 Dec 2011 12:21:54 +0100
Message-ID: <4EE340D2.200@elegosoft.com>
References: <loom.20111210T111457-837@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hao <billhao@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 12:23:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZL1n-0003GS-U0
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 12:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab1LJLXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 06:23:08 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:43478 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623Ab1LJLXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 06:23:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 3C743DE762;
	Sat, 10 Dec 2011 12:23:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zh9cGpu32trj; Sat, 10 Dec 2011 12:22:59 +0100 (CET)
Received: from [192.168.1.101] (e178182231.adsl.alicedsl.de [85.178.182.231])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 34774DE0D5;
	Sat, 10 Dec 2011 12:22:59 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111108 Thunderbird/8.0
In-Reply-To: <loom.20111210T111457-837@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186758>

On 12/10/2011 11:29 AM, Hao wrote:
> I am writing a post-receive hook in Python that examines the content of some 
> files (the HEAD rev). Because the repo is a bare one on the server. My current 
> approach is to check out a working copy on the server and run 'git pull' in post-
> receive to get the most up-to-date version, and then process files in the 
> working copy.

You could do something like this as a post-receive hook:

#!/bin/sh

test_dir=$(mktemp -d /tmp/test.XXXXXXXXXX)
GIT_WORK_TREE=$test_dir git checkout -f
/usr/local/bin/check.py $test_dir
rm -rf $test_dir
