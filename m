From: nathan spindel <nathans@gmail.com>
Subject: git-instaweb should 'just work' on Mac OS X
Date: Sat, 10 May 2008 12:27:38 -0700
Message-ID: <B41867BF-1635-4611-9656-04F8C375BE61@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 21:28:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuukC-0001Mg-1S
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 21:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbYEJT1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 15:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754741AbYEJT1n
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 15:27:43 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:41984 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbYEJT1m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 15:27:42 -0400
Received: by py-out-1112.google.com with SMTP id u52so1962250pyb.10
        for <git@vger.kernel.org>; Sat, 10 May 2008 12:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=PBMJFsZvxkBjAzGVJ6+uFAKjEgOJsvw4iTqXHiNjttU=;
        b=sQW3BHM4XirZT57DOs0AgtPVlViCU3qFbuZgISvGT+4c/GXex7A6VFSXBkaK01UtcwkEwuyIviVZdiyyLzKS28K6tW1W4RjxDRF7CM2cm7sxW5PF73e8wBbK9DDRQs1UZlfN3XmNtPzzuNRGxX6INhExIPegR6eaK12AKLivfWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=RpoWIYWNMbOjM+pbIoA97Irs9CieUJbUpqdh1xHveJLMZtFBkpRxXCmaGyYAE1c4yPvh534yPUwtUdwBI1p0+gdeBEDx7Lbb3K24o5dDQL71syiOa0aBZfu0eM8fU745lszPRG2Mk+ZaB6Zhv7RBEWFkovmgZ711YxXhoh4HwuU=
Received: by 10.143.37.14 with SMTP id p14mr2539852wfj.267.1210447660180;
        Sat, 10 May 2008 12:27:40 -0700 (PDT)
Received: from ?10.0.1.4? ( [76.14.71.118])
        by mx.google.com with ESMTPS id 9sm14230955wfc.6.2008.05.10.12.27.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 May 2008 12:27:39 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81693>

I've investigated what it would take for git-instaweb to 'just work' on
Mac OS X 10.5 when running the command with no arguments. This would be
of benefit to many Mac git users since they shouldn't be expected to
troubleshoot this problem. Here are the current issues at play:

  - lighttpd does not come with Mac OS X by default, so git-instaweb
    currently exits with "lighttpd not found...".

  - git-instaweb doesn't fallback to using other web servers on the  
system
    if the default command doesn't exist.

  - Mac OS X does come with webrick and 'git-instaweb -d webrick'  
_does_ just
    work. It's probably slower than Apache though (?).

  - Mac OS X also comes with mongrel, which is a great alternative, but
    git-instaweb doesn't support it.

  - Mac OS X's Apache installation is different than what git-instaweb
    expects in a couple areas:
    - the Apache binary is called 'httpd', not 'apache2', and git- 
instaweb
      only looks for the latter.
    - the modules on Mac OS X live in /usr/libexec/apache2 but by  
default
      git-instaweb looks for /usr/lib/apache2/modules.
    - Apache attempts to create its 'accept serialization lock file' at
      /private/var/run/ but that path is only writeable by root (a  
workaround
      is to add a LockFile directive to the conf file that places it
      in $fqgitdir/gitweb/tmp).

I'm interested in fixing this to make the experience smoother for Mac  
users.
What is the community's preferred avenue of fixing this?

-nathan
