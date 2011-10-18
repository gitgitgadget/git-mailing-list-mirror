From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT] handle branches with slashes in guilt-graph
Date: Tue, 18 Oct 2011 12:40:59 +0200
Message-ID: <4E9D57BB.2030707@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ceder@lysator.liu.se
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue Oct 18 12:51:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG7Go-0002lz-BK
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 12:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab1JRKvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 06:51:38 -0400
Received: from smtp.opera.com ([213.236.208.81]:48644 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680Ab1JRKvh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 06:51:37 -0400
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Oct 2011 06:51:36 EDT
Received: from [10.30.1.61] (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p9IAf1Xj009676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 18 Oct 2011 10:41:03 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110922 Thunderbird/3.1.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183878>

Avoid sed errors when the branch name contains a slash.

Signed-off-by: Per Cederqvist <cederp@opera.com>

--- /usr/bin/guilt-graph~	2011-01-25 20:15:50.000000000 +0100
+++ /usr/bin/guilt-graph	2011-10-18 12:30:31.000000000 +0200
@@ -37,9 +37,10 @@ disp "digraph G {"

  current="$top"

+safebranch=`echo "$branch"|sed 's%/%\\\\/%g'`
  while [ "$current" != "$base" ]; do
  	pname=`git show-ref | sed -n -e "
-/^$current refs\/patches\/$branch/ {
+/^$current refs\/patches\/$safebranch/ {
  	s,^$current refs/patches/$branch/,,
  	p
  	q
