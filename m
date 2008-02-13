From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Optimize rename detection for a huge diff
Date: Wed, 13 Feb 2008 02:23:16 -0800
Message-ID: <7vk5l9qhnv.fsf@gitster.siamese.dyndns.org>
References: <20080127172748.GD2558@does.not.exist>
 <20080128055933.GA13521@coredump.intra.peff.net>
 <alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
 <20080129222007.GA3985@coredump.intra.peff.net>
 <7vfxwgmf87.fsf@gitster.siamese.dyndns.org>
 <7vwspskynz.fsf@gitster.siamese.dyndns.org>
 <7vprvkj58q.fsf_-_@gitster.siamese.dyndns.org>
 <7vodalqj0s.fsf@gitster.siamese.dyndns.org>
 <864pcd9n0e.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 11:24:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPEmX-0003H8-Ft
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 11:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbYBMKX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 05:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbYBMKX1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 05:23:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbYBMKX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 05:23:26 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CE4D736CA;
	Wed, 13 Feb 2008 05:23:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 E46A836C9; Wed, 13 Feb 2008 05:23:18 -0500 (EST)
In-Reply-To: <864pcd9n0e.fsf@lola.quinscape.zz> (David Kastrup's message of
 "Wed, 13 Feb 2008 11:19:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73768>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> We cannot make it 1-bit unsigned bitfield as there is a qsort
>> comparison callback that does (b->name_score - a->name_score).
>
> Hm?  Can't that be changed into ...

Sorry, my "we cannot" was misleading.  We do not have anything
else that we need to store that is 15-bit, so even if we can, it
won't gain us anything.
