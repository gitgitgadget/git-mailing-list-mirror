From: Jeff Carr <jcarr@linuxmachines.com>
Subject: Re: suggestion: store the URL somewhere in .git/
Date: Mon, 22 Aug 2005 18:46:14 -0700
Message-ID: <430A7FE6.4010801@linuxmachines.com>
References: <430A30C8.3080908@linuxmachines.com> <Pine.LNX.4.63.0508222217310.695@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 03:45:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7Nq6-0005DG-L2
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 03:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVHWBoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 21:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVHWBoU
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 21:44:20 -0400
Received: from [64.71.148.162] ([64.71.148.162]:37788 "EHLO
	mail.linuxmachines.com") by vger.kernel.org with ESMTP
	id S1750994AbVHWBoT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2005 21:44:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.linuxmachines.com (Postfix) with ESMTP id 735366E7EE;
	Mon, 22 Aug 2005 18:46:14 -0700 (PDT)
Received: from mail.linuxmachines.com ([127.0.0.1])
	by localhost (giant [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02156-05; Mon, 22 Aug 2005 18:46:13 -0700 (PDT)
Received: from [172.21.43.70] (x.packeteer.com [12.104.153.15])
	by mail.linuxmachines.com (Postfix) with ESMTP id 9C9E96E7B7;
	Mon, 22 Aug 2005 18:46:13 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508222217310.695@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.91.0.0
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at example.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 08/22/2005 01:18 PM, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 22 Aug 2005, Jeff Carr wrote:
> 
> 
>>It would be nice if the URL could be stored somewhere in .git/ This
>>makes it a lot easier to update repositories because you don't always
>>have to go and track down where you got it in the first place.
> 
> 
> This is why your original target (when you clone) is stored as "origin".

OK. I rsync'ed the repository directly so a origin file wasn't created.
That explains that. So my small "feature" request reduces to adding
something like this to git-pull-script. Thanks, Jeff


diff --git a/git-pull-script b/git-pull-script
--- a/git-pull-script
+++ b/git-pull-script
@@ -1,10 +1,20 @@
 #!/bin/sh
 #
+ORIGIN="$@"
+
+if [ ! $ORIGIN ]
+then
+	if [ -f .git/branches/origin ]
+	then
+		ORIGIN=`cat .git/branches/origin`
+	fi
+fi
+
 . git-sh-setup-script || die "Not a git archive"
-. git-parse-remote "$@"
+. git-parse-remote "$ORIGIN"
 merge_name="$_remote_name"

-git-fetch-script "$@" || exit 1
+git-fetch-script "$ORIGIN" || exit 1

 git-resolve-script \
 	"$(cat "$GIT_DIR"/HEAD)" \
