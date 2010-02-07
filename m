From: Pavel Roskin <proski@gnu.org>
Subject: Current stgit asks SMTP password for every patch
Date: Sat, 06 Feb 2010 21:18:30 -0500
Message-ID: <1265509110.10712.22.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 03:21:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndwmb-0000AQ-Sp
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 03:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab0BGCSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 21:18:43 -0500
Received: from c60.cesmail.net ([216.154.195.49]:63965 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540Ab0BGCSn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 21:18:43 -0500
Received: from unknown (HELO smtprelay1.cesmail.net) ([192.168.1.111])
  by c60.cesmail.net with ESMTP; 06 Feb 2010 21:18:42 -0500
Received: from [192.168.0.22] (unknown [72.92.88.10])
	by smtprelay1.cesmail.net (Postfix) with ESMTPSA id BAF6E34C6D;
	Sat,  6 Feb 2010 21:18:38 -0500 (EST)
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139211>

Hello, Alex!

I was unpleasantly surprised when the current STGit started asking me
for the SMTP password for every patch in the series:

$ stg mail --to minicom ncurses-const..clobber
Checking the validity of the patches ... done
Sending patch "ncurses-const" ... Please enter SMTP password: 
done
Sending patch "precision-int" ... Please enter SMTP password: 
done
Sending patch "aliasing" ... Please enter SMTP password: 
done
Sending patch "clobber" ... Please enter SMTP password: 
done

The code in __send_message_smtp() lacks any caching for the smtppassword
variable.  The code comes from your commit
89d7ec43e0b25cc6cbc9feb044d7ce7048f224eb
stg mail: Refactor __send_message and friends

Ideally, asking for the password (as well as other verification of the
e-mail credentials) should be done before "Sending patch" is shown, and
before the cover letter if any.  That is, it should be in func() in
stgit/commands/mail.py.

But I'll also be fine with a simple-minded password caching in
__send_message_smtp().

-- 
Regards,
Pavel Roskin
