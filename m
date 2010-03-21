From: Wincent Colaiuta <win@wincent.com>
Subject: "git add -i" with path gives "Argument list too long"
Date: Sun, 21 Mar 2010 21:52:56 +0100
Message-ID: <45CD9D1B-6774-46F2-A444-654B1DEF7F69@wincent.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 22:17:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtSWa-0003Ys-OV
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 22:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab0CUVR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 17:17:26 -0400
Received: from outmail148109.authsmtp.co.uk ([62.13.148.109]:53138 "EHLO
	outmail148109.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753443Ab0CUVRZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 17:17:25 -0400
X-Greylist: delayed 1446 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2010 17:17:24 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt4.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o2LKr6XH085695;
	Sun, 21 Mar 2010 20:53:06 GMT
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o2LKr3v4000269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 21 Mar 2010 20:53:04 GMT
Received: from [192.168.1.6] (174.Red-88-5-248.dynamicIP.rima-tde.net [88.5.248.174])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o2LKqwjJ013535
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 21 Mar 2010 16:53:02 -0400
X-Mailer: Apple Mail (2.1077)
X-Server-Quench: bf0b73fd-352b-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJDkVH aB8dC1NJdwdEHAkR AWYBXldeUFk/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNFnkTQx9H Ah4eUht0fktHeHt4 YQgwCHAJW0csIVt+ R0wGCGwHMTF9YWdN Al1YdwFWdgdDeRdA a1gxRiRUJXVWMi5w Wg55dy8wITUXMC1J QkkCLEwfWg5BNyQz WhUPGylnGUweW20v KBtuLlkaEwx5
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142863>

Back in January I reported a wart in "git add -i" and discussion kind of petered out and I forgot about the bug until today when I ran into it again. Now I have a few more cycles to burn I have the time to sort it out.

Just to revise what was discussed back in January:

- my original report: http://lists-archives.org/git/708569-git-add-i-with-path-gives-argument-list-too-long.html

- quick and easy fix posted by Jeff King: http://lists-archives.org/git/708591-git-add-i-with-path-gives-argument-list-too-long.html

- notes on inconsistencies between "git add" and "git add -i" by Jeff king: http://lists-archives.org/git/708698-git-add-i-with-path-gives-argument-list-too-long.html

To summarize and expand a bit upon what Jeff noted in that last post:

  - given _tracked_ file "foo.c" and _untracked_ file "bar.c"
  - "git add '*.c'" ignores the tracked file and stages the untracked file
  - "git add -i '*.c'" ignores the untracked file and operates on the tracked file

So, I gather that we can agree that this behavior isn't right. Either we treat the arguments as pathspecs or we don't, but it doesn't seem right to do one thing for tracked files and another for untracked ones, and it seems especially wrong for the differential treatment to apply in one direction with "git add" and in the other with "git add -i".

So, as a first step I'd like to make some test cases to serve as a specification for what we want the desired behavior to be. I saw in one of the "what's cooking messages" in February that there was some changes cooking in the "cp/add-u-pathspec" topic, so I am not entirely clear on if there is consensus about the desired behaviour.

Before I run ahead and start writing test, do we have consensus?

(Will have to worry about the initial cause of my bug report -- the "argument list too long" error -- later on.)

Cheers,
Wincent
