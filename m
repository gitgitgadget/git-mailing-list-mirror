From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Remove duplicate pathspecs from ls-files command line
Date: Thu, 30 Aug 2007 07:52:21 +0200
Message-ID: <85myw9d0x6.fsf@lola.goethe.zz>
References: <20070829081122.GA604@piper.oerlikon.madduck.net>
	<20070829194410.GA11824@steel.home>
	<7v4piioyu1.fsf@gitster.siamese.dyndns.org>
	<20070829211519.GE11824@steel.home> <85tzqic9bf.fsf@lola.goethe.zz>
	<7vr6llak4h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>,
	439992-quiet@bugs.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 07:52:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQcxO-000693-V8
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 07:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbXH3Fwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 01:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbXH3Fwj
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 01:52:39 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:56957 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752583AbXH3Fwj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2007 01:52:39 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 5C58717FA4C;
	Thu, 30 Aug 2007 07:52:33 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 4A8912D3B2B;
	Thu, 30 Aug 2007 07:52:33 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-040-232.pools.arcor-ip.net [84.61.40.232])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 12CF219B322;
	Thu, 30 Aug 2007 07:52:24 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 122051C3C7A6; Thu, 30 Aug 2007 07:52:21 +0200 (CEST)
In-Reply-To: <7vr6llak4h.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 29 Aug 2007 18\:25\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4107/Wed Aug 29 18:16:42 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57001>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Does anything speak against sorting the pathspecs?  That is an O(n log
>> n) operation,
>
> Not sorting is O(0) operation without losing cycles for the
> normal case.  I think you can sort first in that error handling
> path to avoid O(n^2) but sorting upfront to remove duplicates
> for every case is unnecessary bloat that penalizes sane callers.

Not if you need to sort the file list anyway in order to merge it with
the index.  Of course, sorting patterns will not in all cases
establish the order of their expansions.

In any case, uniqueness should be establishable when matching to the
index, regardless of whether this matching is done by sort&merge
(probably the most efficient variant) or by binary search as it is
done now if I understand correctly.  I am just not happy with the
ensuing binary _insertion_ as this is an O(nm) operation when
inserting n elements into an m element data structure.  A list merge
is O(n+m), in contrast, and we can access the index sequentially.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
