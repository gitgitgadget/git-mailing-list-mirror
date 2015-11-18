From: Erik Blake <erik@icefield.yk.ca>
Subject: push failure on domain-connected machine
Date: Wed, 18 Nov 2015 17:47:15 +0100
Message-ID: <564CAB93.9040007@icefield.yk.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 18:17:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz6Md-0004xn-81
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 18:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbbKRRRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 12:17:43 -0500
Received: from bosmailout06.eigbox.net ([66.96.186.6]:35435 "EHLO
	bosmailout06.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbbKRRRn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2015 12:17:43 -0500
X-Greylist: delayed 1818 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2015 12:17:42 EST
Received: from bosmailscan06.eigbox.net ([10.20.15.6])
	by bosmailout06.eigbox.net with esmtp (Exim)
	id 1Zz5tD-0005yj-Na
	for git@vger.kernel.org; Wed, 18 Nov 2015 11:47:23 -0500
Received: from [10.115.3.31] (helo=bosimpout11)
	by bosmailscan06.eigbox.net with esmtp (Exim)
	id 1Zz5tD-0001uk-M6
	for git@vger.kernel.org; Wed, 18 Nov 2015 11:47:23 -0500
Received: from bosauthsmtp16.yourhostingaccount.com ([10.20.18.16])
	by bosimpout11 with 
	id j4nL1r00Y0LoEWa014nPhq; Wed, 18 Nov 2015 11:47:23 -0500
X-Authority-Analysis: v=2.1 cv=OMup3EqB c=1 sm=1 tr=0
 a=2OW49aEHms2tn/AeNJ+rfA==:117 a=xP2CbvXzu5dUCFSWO2QZHA==:17 a=pq4jwCggAAAA:8
 a=QPcu4mC3AAAA:8 a=TtUpKRI4puIA:10 a=IkcTkHD0fZMA:10 a=qtqOOiqGOCEA:10
 a=aeboTeiheCE584-34YQA:9 a=QEXdDO2ut3YA:10
Received: from [82.194.202.50] (port=56951 helo=[192.168.20.164])
	by bosauthsmtp16.eigbox.net with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim)
	id 1Zz5tA-00075a-4L
	for git@vger.kernel.org; Wed, 18 Nov 2015 11:47:20 -0500
X-Enigmail-Draft-Status: N1010
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-EN-UserInfo: 20c972d92b49a3da013d5f179c4005f2:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: erik@icefield.yk.ca
X-EN-OrigIP: 82.194.202.50
X-EN-OrigHost: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281452>

When pushing an existing local repo to a new remote repo, git 2.6.3
misidentifies the user's home directory on a domain-connected Windows
machine. My machine is running Win7-64 and I have tried both the 32-bit
and 64-bit version of git.

For example, the following sequence fails on the last command:

>git remote add remote <remote repo URL>
>git config remote.uf.push refs/heads/master:refs/heads/master
>git push remote master

The error returned by the last command is "Could not create directory
'/home/foo/.ssh'."

git should be targeting the directory '/home/foo.domain/.ssh' instead.

The path to the user profile should be taken from %HOMEDRIVE%%HOMEPATH%
or, preferably, %USERPROFILE% and not %USERNAME%, unless %USERDOMAIN% is
appended when a domain-connected computer is detected.

git 1.9.5 does not exhibit this problem.
