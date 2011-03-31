From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Small "git clean" annoyance
Date: Thu, 31 Mar 2011 15:01:33 -0700
Message-ID: <AANLkTinQscpkRDftLmCrQR+Aq5RacGyurd3kb15y=1FK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:02:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Pwh-0001P3-Ou
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 00:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759356Ab1CaWCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 18:02:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60046 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759332Ab1CaWCW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 18:02:22 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id p2VM1ro9004380
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 31 Mar 2011 15:01:53 -0700
Received: by iwn34 with SMTP id 34so2837405iwn.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 15:01:53 -0700 (PDT)
Received: by 10.231.176.223 with SMTP id bf31mr3237367ibb.28.1301608913079;
 Thu, 31 Mar 2011 15:01:53 -0700 (PDT)
Received: by 10.231.11.4 with HTTP; Thu, 31 Mar 2011 15:01:33 -0700 (PDT)
X-Spam-Status: No, hits=-102.978 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170536>

I don't have a patch for this, and I guess it doesn't much matter, but
I just found this annoying:

  [torvalds@i5 git]$ mkdir -m 0 tmp
  [torvalds@i5 git]$ git clean -dqfx
  warning: failed to remove tmp/
  [torvalds@i5 git]$ rmdir tmp

and the reason is simply that git gives up if the directory is
unreadable and thus cannot be opened.

Which is kind of understandable, but at the same time, if it's empty,
a "rmdir()" will just work. So git gave up a bit too soon.

(In case anybody wonders, the reason I had empty unreadable
directories around is not because I commonly do "mkdir -m 0", but
simply because they got created when I was running a system call
fuzzer for testing).

Now, I realize that if the directory isn't empty, and is unreadable,
we really should give up (although a better error message about _why_
we failed may be in order) rather than try to chmod it or anything
like that. But the simple "try to rmdir it" might be a good addition
for the trivial case.

                     Linus
