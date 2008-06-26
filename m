From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Thu, 26 Jun 2008 15:04:25 -0700
Message-ID: <7vod5nq2dy.fsf@gitster.siamese.dyndns.org>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com>
 <20080626204606.GX11793@spearce.org>
 <7vskuzq5ix.fsf@gitster.siamese.dyndns.org>
 <20080626210556.GZ11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 00:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBzb8-0001UJ-3k
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 00:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbYFZWEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 18:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYFZWEf
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 18:04:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbYFZWEe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 18:04:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E8CE623995;
	Thu, 26 Jun 2008 18:04:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2DD8B23994; Thu, 26 Jun 2008 18:04:29 -0400 (EDT)
In-Reply-To: <20080626210556.GZ11793@spearce.org> (Shawn O. Pearce's message
 of "Thu, 26 Jun 2008 17:05:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB679D7C-43CB-11DD-9B09-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86491>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We have a file position we saw once before as the start of a delta.
> We wrote it down to disk.  We want to go back and open it up, as
> we have the base decompressed and in memory and need to compute
> the SHA-1 of the object that resides at this offset.
>
> And *wham* we get an EOF.  Where there should be data.  Where we
> know there is data.

We have written that earlier in the same process?  Are we playing games
with mixed mmap() and pread()?  Is fsync() or msync() or unmap/remap
needed?

> Actually, I think the last time someone reported something like this
> in Git it turned out to be an NFS kernel bug.  I didn't quote it
> in my reply to him, but I think he did say this was a linux client,
> linux server.

This is getting into the area Linus would immediately know the answer to,
but he is away for this week.
