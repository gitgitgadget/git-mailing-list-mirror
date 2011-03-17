From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sharing a massive distributed merge
Date: Thu, 17 Mar 2011 13:54:19 -0700
Message-ID: <7vd3lp31tw.fsf@alter.siamese.dyndns.org>
References: <4D8119BE.2090208@workspacewhiz.com>
 <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
 <20110317063816.GD11931@sigill.intra.peff.net>
 <AANLkTimTKbKWmf80u-kgnvQ2gT8hx2KTm6HGbWejt3eg@mail.gmail.com>
 <AANLkTi=25=99Gh9hGUxEuvB9Xvv=f8uJxThaMxaAQKbq@mail.gmail.com>
 <AANLkTikfp_d00zrtU8kuvyUk81gGMkOXEVDNXr-hRhBU@mail.gmail.com>
 <AANLkTinQYjq=NiHK6MK0tA5AEE7=NCg8kthJT9Xz=xNk@mail.gmail.com>
 <AANLkTi=Fnacc9JamGdOEYhHY8PJgaidSLmif_z5Qdfp0@mail.gmail.com>
 <20110317191517.GC20508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 21:54:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0KDQ-0004hN-Na
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 21:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab1CQUyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 16:54:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab1CQUye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 16:54:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 707184326;
	Thu, 17 Mar 2011 16:56:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3RQygiFpofTmjq+eM8tjh4O3G0M=; b=Mzdl9m
	+Jy/+sXlCZjE98kj1l0r0x7q1eKgQt/4HH7EH4+9//+d9zWwBov5LllTuBE4OFj6
	5JSaTKDm/THYzTCkLmD9F7NAkBwBV5yGGj1qsrmSDK9XEOlk90TX40o/l/cdWvjS
	r5utSLTv6Ft0dAUZ81obcBXlgsM31ZB/MlMHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E5SeayQs1HFjBiMCbzC8fiXW/bTRET+k
	LbWqkrAYA8XCZ8b4uTaO8+ggIM+hFpT0/WF5KZ1Jjk+xw5VObcLbig63wEgE5K8L
	FHeW2JsrMC77vRcgEDoD2m84hJJHw5Uycizwwl9PgXtkQ3BHyrRXGCq5OoCRbzqC
	2Bu9BTZfrpg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1CCBB4324;
	Thu, 17 Mar 2011 16:56:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 76B1A4322; Thu, 17 Mar 2011
 16:55:56 -0400 (EDT)
In-Reply-To: <20110317191517.GC20508@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 17 Mar 2011 15:15:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F850BB0E-50D8-11E0-89FC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169276>

Jeff King <peff@peff.net> writes:

> It would be neat if the tree could somehow mark a bit for "this is
> unresolved". I guess we could shove it into a mode bit. But that seems
> like a waste of a mode bit for this one use case that doesn't come up
> all that often, and which doesn't _need_ to represent that information
> in-tree. The commit-message solution would work perfectly fine.

Just adding the blob with the whole glory of <<</>>> markers would be
better than recording --ours or --theirs.  Deleting might be a workaround
that would work better in practice as somebody already mentioned, though.

I agree that message is an essential part of the communication medium to
coordinate this kind of workflow.  It is not like the downstream is a dumb
machinery that blindly grab and overlay the partial merge results that can
only read from tree objects and not commit messages.
