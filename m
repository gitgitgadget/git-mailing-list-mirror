From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-commit --amend -m "..." complains?!?
Date: Wed, 01 Aug 2007 12:52:50 -0700
Message-ID: <7vk5sf3uct.fsf@assigned-by-dhcp.cox.net>
References: <86643znxgz.fsf@lola.quinscape.zz>
	<7v8x8v5g2z.fsf@assigned-by-dhcp.cox.net>
	<85myxbrrdl.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 21:53:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGKG2-0000Os-UH
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 21:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762502AbXHATwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 15:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762516AbXHATww
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 15:52:52 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61234 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761863AbXHATww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 15:52:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801195250.XGRD7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 15:52:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wjsq1X0041kojtg0000000; Wed, 01 Aug 2007 15:52:50 -0400
In-Reply-To: <85myxbrrdl.fsf@lola.goethe.zz> (David Kastrup's message of "Wed,
	01 Aug 2007 21:23:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54472>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> You can do:
>>
>> 	$ git reset HEAD^
>>         $ git commit -m "blah"
>>
>> if you do not want to reuse the commit message.
>
> You can pretty much _always_ avoid --amend in a similar manner, but
> why would you?  It is convenient.

No need to be upset about what I said.  I really do not want to
change the minor detail this late in the 1.5.3 release cycle,
and wanted to unblock you by giving an workaround in case you
were stuck.

It should be a straightforward change to git-commit.sh.  Instead
of "Oops, -m and --amend are incompatible so we will whine"
around line 300, you can treat --amend somewhat specially by (1)
making it first not set log_given, which would still keep the
combination of -m/-c/-C/-F incompatible, (2) when $log_given is
false and we are amending, honor $use_commit to prime the
message.  Then you can keep the current bahaviour for amending
starting from the existing message, while allowing -m/-c/-C/-F
to supply different message for the replacing commit.
