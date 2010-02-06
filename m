From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] merge: use new "reset" function instead of running
 "git read-tree"
Date: Fri, 05 Feb 2010 16:03:50 -0800
Message-ID: <7vbpg3nsbd.fsf@alter.siamese.dyndns.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org>
 <20100205231112.3689.34673.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 01:05:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdYB3-0005yL-48
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 01:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933792Ab0BFAEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 19:04:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933495Ab0BFAEL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 19:04:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0FE997E2E;
	Fri,  5 Feb 2010 19:04:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c2QplXBMlWTIWrJVj7cimE79TBI=; b=AqDKKk
	N3N44wnRYOL8cVpeKWYOb+8vGd6bK051BrQwNumxOhoa1VoIEtbumxHm+jRjWKEn
	haGsoX5J3WQF0f44sn2R1FDGM9a7vZr0wfIJ20JzESoBDgCYX6+RoTgdtD8PCp1u
	Y1gTs0eF/wNl6q6RNtdDbgFiKXooglNS/VOXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qsWXR0Xzvt36l9qgaqsiTH/BPwY4+UTm
	3bWXL+8K1aO3cgP+pOxYlERn1cKH+eA64mFSz/JXAJXEz1lZ317pH0b1r5FGWgym
	dx5V/hAbEh/5K/O0rXVj3y35o5dYKXwXJGzJeXtK6CMlLAPNEoFartZyxDIMedGe
	hEdBu7VoBak=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CEEC97E2A;
	Fri,  5 Feb 2010 19:04:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD30797DEB; Fri,  5 Feb
 2010 19:03:52 -0500 (EST)
In-Reply-To: <20100205231112.3689.34673.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat\, 06 Feb 2010 00\:11\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 21E5747E-12B3-11DF-BEB9-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139128>

Christian Couder <chriscool@tuxfamily.org> writes:

> This simplifies "git merge" code and make it more efficient in some
> cases.

I vaguely recall somebody (perhaps it was you) tried to do something like
this before to drive unpack_trees() inside the main process, broke the
program rather badly, and then we ended up keeping read-tree invocation
external to the process.  Am I misremembering things?

If not, could you describe how is this round different from the old one?
