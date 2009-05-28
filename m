From: Villeneuve <dvilleneuve@kronos.com>
Subject: exit status = 1 from git fetch -t
Date: Wed, 27 May 2009 23:57:07 -0400
Message-ID: <200905280357.n4S3v73G016535@hilo.ca.kronos.com>
Reply-To: dvilleneuve@kronos.com
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 06:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9X1q-0001mj-PP
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 06:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbZE1EOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 00:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbZE1EOm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 00:14:42 -0400
Received: from mx1.kronos.com ([158.228.122.16]:40481 "EHLO mx1.kronos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbZE1EOm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 00:14:42 -0400
X-Greylist: delayed 1051 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2009 00:14:41 EDT
X-WSS-ID: 0KKC5N9-01-0SB-02
X-M-MSG: 
Received: from kex-us-hub02.KRONOS.COM (kex-us-hub02.kronos.com [10.0.64.82])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mx1.kronos.com (Tumbleweed MailGate 3.6.1) with ESMTP id 2684F111C6C4
	for <git@vger.kernel.org>; Wed, 27 May 2009 23:57:08 -0400 (EDT)
Received: from exchg-m.KRONOS.COM (158.228.0.206) by kex-us-hub02.KRONOS.COM
 (10.0.64.82) with Microsoft SMTP Server id 8.1.291.1; Wed, 27 May 2009
 23:57:08 -0400
Received: from exchange-ca1.CA.KRONOS.COM ([10.129.60.29]) by
 exchg-m.KRONOS.COM with Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 27 May 2009
 23:57:08 -0400
Received: from hilo.ca.kronos.com ([10.129.63.5]) by
 exchange-ca1.CA.KRONOS.COM with Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 27
 May 2009 23:57:07 -0400
Received: from hilo.ca.kronos.com (localhost [127.0.0.1])	by
 hilo.ca.kronos.com (8.13.1/8.13.1) with ESMTP id n4S3v7Wi016538	for
 <git@vger.kernel.org>; Wed, 27 May 2009 23:57:07 -0400
Received: (from dvilleneuve@localhost)	by hilo.ca.kronos.com
 (8.13.1/8.13.1/Submit) id n4S3v73G016535;	Wed, 27 May 2009 23:57:07 -0400
X-OriginalArrivalTime: 28 May 2009 03:57:07.0628 (UTC) FILETIME=[5EB43EC0:01C9DF48]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120143>

Hi,

I'm getting an unexpected exit status of 1 from "git fetch
-t" on one of our largest repositories (by large, I mean 47
branches and 5442 tags, some of which might not be reachable
from branch heads).

The docs are not clear about the interpretation of git
fetch's exit status, so maybe I should not bother.

But assuming the exit status of 1 really indicates some
trouble, here are more details.

Next tests done with git over ssh (server 1.6.1.3, client
1.6.3.1) on RHEL4.

In the "REPO1" repository (exit status printed just before $
in prompt following command):

[REPO1] 0 $ git fetch -t -v -v
Server supports multi_ack
Server supports side-band-64k
Server supports ofs-delta
Marking 60e4d540748c5c3d368c888c4c248de0bdd684cc as complete
Marking 60e4d540748c5c3d368c888c4c248de0bdd684cc as complete
[REPO1] 1 $

while with another repository, "REPO2":

[REPO2] 0 $ git fetch -t -v -v
From ssh://user@machine/path/to/GIT/dir1/dir2/REPO2
 = [up to date]      v1.1 -> v1.1
 = [up to date]      v1.2 -> v1.2
 = [up to date]      v2.0 -> v2.0
... # lots of other similar lines
[REPO2] 0 $

I've compiled git in debug to step in the code, and the
source of the "error" exit status seems to come from
builtin-fetch-pack.c:everything_local, where *refs being
NULL leaves retval to 1 in the final loop.

I'm also puzzled that I don't get the "From ssh://..." in
the trace from "REPO1" as for the "REPO2" repository above.
I do get the "From ssh://..."  line if doing only "git fetch
-v -v" without the "-t" option in "REPO1".

Any help/advice appreciated,
--
Daniel Villeneuve
Kronos, AD OPT Division
