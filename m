From: Johan Herland <johan@herland.net>
Subject: Re: [feature request] git: tags instead of commit IDs in blame output
Date: Sat, 21 Aug 2010 12:10:22 +0200
Message-ID: <201008211210.23280.johan@herland.net>
References: <20100821095352.604a2b85@hyperion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jean Delvare <khali@linux-fr.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 12:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oml20-0007bI-9R
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 12:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab0HUKK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 06:10:28 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54313 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab0HUKK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 06:10:26 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L7H00E0VYXCJOB0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 21 Aug 2010 12:10:24 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 320411EA59A3_C6FA610B	for <git@vger.kernel.org>; Sat,
 21 Aug 2010 10:10:24 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1A03E1EA5301_C6FA610F	for <git@vger.kernel.org>; Sat,
 21 Aug 2010 10:10:24 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L7H003H8YXC4400@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 21 Aug 2010 12:10:24 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <20100821095352.604a2b85@hyperion.delvare>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154134>

On Saturday 21 August 2010, Jean Delvare wrote:
> Hi there,
> 
> I have a feature request for git. In the output of "git blame", I would
> like to be able to see tags instead of commit IDs in front of each
> line. Basically, I would like to know the first tag which was added
> after the last change of every line. Icing on the cake would be the
> possibility to filter out some tags (for example to ignore release
> candidate tags) but I could easily live without that.
> 
> Does it make sense?
> Would it be difficult to implement?

To me, it seems what you want to do is convert the commit ID in front of 
every blame-line into the result of running 'git name-rev' (or 'git 
describe') on that line.

To that effect something like this should work:

  git blame <file> |
  while read sha1 rest
  do
      tag=$(git name-rev --tags --name-only $sha1) &&
      echo "$tag $rest"
  done

Of course, if you're doing this at a bigger scale, you want to wrap this in 
a script that (1) caches commitID -> tag mappings, and that (2) runs 'git 
name-rev in its --stdin mode'.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
