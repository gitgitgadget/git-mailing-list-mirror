From: David Kastrup <dak@gnu.org>
Subject: Re: possible bug in git apply?
Date: Sun, 05 Aug 2007 09:55:45 +0200
Message-ID: <857ioact4u.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
	<alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
	<7vvebuh8g8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, david@lang.hm,
	git@vger.kernel.org, rob@landley.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 09:56:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHay1-00045h-81
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 09:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbXHEHzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 03:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755845AbXHEHzy
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 03:55:54 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:42861 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754662AbXHEHzx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 03:55:53 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 0FC091F59EC;
	Sun,  5 Aug 2007 09:55:52 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id ECD1423D2D9;
	Sun,  5 Aug 2007 09:55:51 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id B1C6B2BB53A;
	Sun,  5 Aug 2007 09:55:51 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 722BE1C4F932; Sun,  5 Aug 2007 09:55:45 +0200 (CEST)
In-Reply-To: <7vvebuh8g8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 04 Aug 2007 22\:11\:19 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3857/Sun Aug  5 08:20:59 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54964>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> It should. I thought we did that, but maybe there's some bug there.
>>
>> See "remove_file()" in builtin-apply.c.
>>
>> But yeah, it seems that the file *rename* ends up not triggering that 
>> logic! Very annoying.
>>
>> Does this fix it? Totally untested, but it _looks_ obvious enough..
>
> That would regress the fix made in aea19457, I am afraid.  If
> you are in a subdirectory and the rename patch moves away the
> last file in your current directory, the shell session you ran
> the git-apply from will end up in an unlinked directory.
>
> Maybe that is a pilot error, and we can revert aea19457
> altogether?

I'd call it pilot error.  We can't really have git's behavior depend
on where somebody might point his cwd.  If we do that, we may never
remove any directory.  Once git tracks directories, it will be harder
to make this particular pilot error (git rm ../mycwd is more obviously
having this effect than git rm *), but a pilot error it is in my book.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
