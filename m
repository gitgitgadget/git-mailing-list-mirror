From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Difference between 'git rebase' and 'git rebase -m'
Date: Tue, 16 Nov 2010 10:35:41 -0700
Message-ID: <4CE2C0ED.1030309@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 16 18:35:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIPRd-0005px-OO
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 18:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab0KPRfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 12:35:44 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39139 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab0KPRfo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 12:35:44 -0500
Received: (qmail 25549 invoked by uid 399); 16 Nov 2010 10:35:41 -0700
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 16 Nov 2010 10:35:41 -0700
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b3pre Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161568>

We ran into an interesting issue yesterday during a rebase.

User Bob had added a line at the same place in a (C++) .h file as User 
Joe, who had already pushed his one line change.  The natural 
expectation would be a conflict during User Bob's rebase operation, but, 
in fact, the conflicting patch applied without difficulty.

After an investigation, we discovered this particular file had a near 
duplicate of its C++ class definition immediately following the original 
but renamed into a thread-safe version; the rename of the class was the 
only change to its contents.  The default  'git rebase' operation looked 
some 150 lines into the file, discovered the patch didn't match due to 
User Joe's added line, continued scanning the file until it found 
another matching location some 300 lines later (the near duplicate 
thread-safe version of the class), and applied the patch there.

While coming up with a repro to post here, we cherry picked the 
individual changes and found the cherry pick properly conflicted.

We further discovered 'git rebase -m' (or 'git rebase -s recursive') 
also conflicted at the User Bob/Joe modification.

I can post a repro here, if needed.

I'm curious as to why 'git rebase -m' isn't the default and what the 
real difference is between 'git rebase' and 'git rebase -m'.  
Additionally, is there any documentation describing how the patch 
algorithm determines context?

Thanks!

Josh
