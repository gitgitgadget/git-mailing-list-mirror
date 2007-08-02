From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 02 Aug 2007 23:42:32 +0200
Message-ID: <857iodzk8n.fsf@lola.goethe.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:43:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGiRb-00026U-Ci
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761170AbXHBVmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760947AbXHBVmq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:42:46 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:60140 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761170AbXHBVmp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 17:42:45 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 5671615BCFF;
	Thu,  2 Aug 2007 23:42:42 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 47C3F212FAE;
	Thu,  2 Aug 2007 23:42:42 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-245.pools.arcor-ip.net [84.61.49.245])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 0D65924E2F0;
	Thu,  2 Aug 2007 23:42:42 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 042F41D0344E; Thu,  2 Aug 2007 23:42:32 +0200 (CEST)
In-Reply-To: <7vsl71tyyq.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 02 Aug 2007 14\:21\:01 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54619>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Understood.  But using ${...#...} and ${...:+...} does not exactly
>> seem to be news in the git code base.  Even though we have the
>> claim that Solaris' sh won't deal with the former.
>
> I do not think we have trouble with ${parameter#word}.  Much less
> with ${parameter+word}; it has been in /bin/sh forever.

Basically this should mean that the proposed cleanups (apart from a
forgotten shift I had to add) are tenable.

Given that another poster claimed that Solaris /bin/sh does not
support ${parameter#word}, making the suggested changes to git-commit
might actually be a good idea: ${parameter#word} is used in half a
dozen other (likely less used) utilities in various other places.  If
this is an overlooked regression, we want to make it non-overlookable
while we are still in testing, and git-commit would appear to be the
perfect candidate for that...

Depending on the feedback, we can either replace _all_ uses
everywhere, or accept it for good.

While I would think it perfectly understandable if you wanted to avoid
making an infamous "breaks all of Solaris release", _if_ ${...#...}
would indeed be fishy (and I somewhat doubt it), we are already there.
I have this cleaned-up version of git-commit.sh on a computer I can't
access right now.  I'll post the patch tomorrow.  Whether you want to
apply it to git.git remains at your discretion.  I would, however,
strongly urge Solaris and potentially other POSIXly impaired users to
aplly and test this patch: if it breaks (and it will do so pretty
obviously, pretty much being unable to parse any option), then this is
_quite_ alarming with regard to existing uses of ${...#...} and would
need to get addressed _very_ soon.

Frankly, I doubt that this would have escaped notice so far, however.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
