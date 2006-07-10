From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-log to go forward instead of reverse?
Date: 10 Jul 2006 13:31:14 -0700
Message-ID: <861wstnqwd.fsf@blue.stonehenge.com>
References: <86bqrxpai1.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101151470.5623@g5.osdl.org>
	<863bd9p9en.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101212410.5623@g5.osdl.org>
	<86mzbhntxu.fsf@blue.stonehenge.com>
	<7vpsgdb40s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 22:31:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G02PW-0003kM-It
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 22:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbWGJUbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 16:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWGJUbQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 16:31:16 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:41811 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1422808AbWGJUbP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 16:31:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id F2D3E8F34C;
	Mon, 10 Jul 2006 13:31:14 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 03238-02-84; Mon, 10 Jul 2006 13:31:14 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 753368F360; Mon, 10 Jul 2006 13:31:14 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.8.4; tzolkin = 1 Kan; haab = 17 Tzec
In-Reply-To: <7vpsgdb40s.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23651>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

>> ## (code here to cd to the right dir omitted)
>> git-fetch
>> if git-status | grep -v 'nothing to commit'

Junio> git-status exits non-zero for "nothing to commit" case, so do
Junio> not grep its output, but check the status of the command, to see
Junio> if your tree is in a good shape to do a pull.

No, this is deliberate.  I want to see nothing if we're up to date, but if
not, I want to see *everything else* that git-status said.  This nice "grep
-v" does precisely the right thing.

Junio> Do we not leave ORIG_HEAD when we are already up-to-date?  If so
Junio> that would be confusing...  No, we do leave ORIG_HEAD no matter
Junio> what, so you do not have to have this inner if to grep
Junio> up-to-date (on the other hand, you might want to do intelligent
Junio> things when git-pull fails).  So just drop the if and say
Junio> something like:

Junio> 	else
Junio>         	PAGER= ; export PAGER
Junio>                 git pull . origin &&
Junio>                 git log --pretty ORIG_HEAD..HEAD |
Junio>                 git shortlog
Junio> 	fi

However, this is good to know.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
