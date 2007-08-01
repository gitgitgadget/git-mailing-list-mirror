From: David Kastrup <dak@gnu.org>
Subject: Re: git-commit --amend -m "..." complains?!?
Date: Wed, 01 Aug 2007 22:45:32 +0200
Message-ID: <857iofrnkj.fsf@lola.goethe.zz>
References: <86643znxgz.fsf@lola.quinscape.zz>
	<7v8x8v5g2z.fsf@assigned-by-dhcp.cox.net>
	<85myxbrrdl.fsf@lola.goethe.zz>
	<7vk5sf3uct.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 22:46:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGL5q-0002Eu-TZ
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 22:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbXHAUqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 16:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbXHAUqY
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 16:46:24 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:48059 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751837AbXHAUqX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 16:46:23 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 072074C864;
	Wed,  1 Aug 2007 22:46:22 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id E4F70213031;
	Wed,  1 Aug 2007 22:46:21 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-017.pools.arcor-ip.net [84.61.17.17])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 1D2FB12379;
	Wed,  1 Aug 2007 22:46:21 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 7AA3F1C3E076; Wed,  1 Aug 2007 22:45:32 +0200 (CEST)
In-Reply-To: <7vk5sf3uct.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 01 Aug 2007 12\:52\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.91.1, clamav-milter version 0.91.1 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54475>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> ...
>>> You can do:
>>>
>>> 	$ git reset HEAD^
>>>         $ git commit -m "blah"
>>>
>>> if you do not want to reuse the commit message.
>>
>> You can pretty much _always_ avoid --amend in a similar manner, but
>> why would you?  It is convenient.
>
> No need to be upset about what I said.  I really do not want to
> change the minor detail this late in the 1.5.3 release cycle, and
> wanted to unblock you by giving an workaround in case you were
> stuck.

Well, there is always
VISUAL='echo "mycommit" >"$1"' git commit --amend 
Uh, no wait, it isn't.  Different thread.

> It should be a straightforward change to git-commit.sh.  Instead of
> "Oops, -m and --amend are incompatible so we will whine" around line
> 300, you can treat --amend somewhat specially by (1) making it first
> not set log_given, which would still keep the combination of
> -m/-c/-C/-F incompatible, (2) when $log_given is false and we are
> amending, honor $use_commit to prime the message.

I actually can't find anything about (2) to be done in the code.

> Then you can keep the current bahaviour for amending starting from
> the existing message, while allowing -m/-c/-C/-F to supply different
> message for the replacing commit.

In a somewhat different vein: it appears strange that -m is treated
completely different from the other commit message specifiers: you can
specify -m multiple times.

I have not changed this in the slightly tested patch posted
separately: while the --amend fix was quite straightforward and
confined (and indeed, not even the documentation appears to warrant
any modification), the m/t mess is something I really don't want to
mess with right now.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
