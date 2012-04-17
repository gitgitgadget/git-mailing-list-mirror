From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gc --aggressive
Date: Tue, 17 Apr 2012 15:17:28 -0700
Message-ID: <7vr4vmm29z.fsf@alter.siamese.dyndns.org>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <20120417220838.GB10797@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:18:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGim-0002QL-6y
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab2DQWRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 18:17:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45789 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697Ab2DQWRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 18:17:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ED227B5E;
	Tue, 17 Apr 2012 18:17:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qeD3TbCu9Zu6ENJaINMsID+yWpI=; b=WJxp0Z
	KI9gaKJuD2FKm7jj9T36Nkm+8W4eCREH4DVLXer2tiAzm/yRF/X2qVJvgrOjbETu
	JV2+lw3xMSxcLxgHo43vnR5MYyD2P7bk6lRUIVmZHnVguBpTNeLPbkPF1W/ZsxXv
	roLILDhp+SNQq7WM39QumfwifAWvMDqvoCR9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZdBjCmyXbSCZ8ilQq//evZ4LrbndxvlG
	WvL2Vo6KfmX0DZAHtbtsT+SnKIBsAxcIxMiOILbuo8ZnSbO0tt3YSlkAjQsgVqNQ
	z9D0zbaYizCFI/Ope7xUJW7ByZ+fD3dTgxZZ6LGYs9UOHFfAvk43CQ9dus3jZl8p
	QJH9P2t9eKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05DD97B5C;
	Tue, 17 Apr 2012 18:17:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E7067B5B; Tue, 17 Apr 2012
 18:17:29 -0400 (EDT)
In-Reply-To: <20120417220838.GB10797@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 17 Apr 2012 15:08:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EEDED1E-88DB-11E1-AED5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195818>

Jeff King <peff@peff.net> writes:

> ...
> I wonder where the memory is going. In theory, the memory consumption
> for packing comes from keeping all of the objects for a given window in
> memory (so we are looking for a delta for object X, and we have a window
> of Y[0]..Y[$window] objects that we will consider). And for a
> multi-threaded pack, that's per-thread.
>
> How many cores are there on this box? Have you tried setting
> pack.windowMemory to (12 / # of cores) or thereabouts?

Hrm, from the end-user's point of view, it appears that pack.windowMemory
ought to mean the total without having to worry about the division of it
across threads (which the implementation should be responsible for).

> ... But it seems lame that git _can't_
> do a full repack on such a beefy machine. You don't want to do it all
> the time, but you might want to do it at least once.

True.
