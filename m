From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libreoffice merge issue ...
Date: Wed, 16 Feb 2011 13:30:51 -0800
Message-ID: <7vfwrnis50.fsf@alter.siamese.dyndns.org>
References: <1297699635.31477.253.camel@lenovo-w500>
 <20110215094546.GA25530@sigill.intra.peff.net>
 <7vaahxp250.fsf@alter.siamese.dyndns.org>
 <20110216025726.GC7085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Meeks <michael.meeks@novell.com>, git@vger.kernel.org,
	Norbert Thiebaud <nthiebaud@gmail.com>,
	kendy <kendy@novell.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 22:31:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppoxx-0002ue-FF
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 22:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab1BPVbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 16:31:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1BPVbK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 16:31:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D253743E6;
	Wed, 16 Feb 2011 16:32:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FVrXadUPNWpQPWz6AfxTeCRDKmM=; b=I7k8q8
	GLMUfrYl6/RDWOGvIMhLqR0RB9qU/Dl1up0xVyHpDsEqgwrv+fB7aFfew1UTubqZ
	Gwc/fOI+jVFK1zjc8awPTKqz6jOaTYLJNfaTkLxnJs3lwoL4fmM2BVc1/++Z7yq9
	6h/NnJPDJLgyNwQNIk0p90CA1otfE02/qk9z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NbavMHwvIsuGUZxnMFQ9GFh0XKFhRDdv
	VVLe7/BD00jMJVk6hhdctJ1R2eCq8rc57KIE1VcUW69jwYb5oczV5qbQU7BTzcVh
	xrHRq211Hojg34dRBgb2tZz06Qfpo9rg34CV1N+gQ6CF+UXm6KD5wcOuDVBeM2R+
	1KnzO5t8p9g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8379C43E4;
	Wed, 16 Feb 2011 16:32:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C11043E0; Wed, 16 Feb 2011
 16:31:59 -0500 (EST)
In-Reply-To: <20110216025726.GC7085@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 15 Feb 2011 21\:57\:27 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 345F49FC-3A14-11E0-9EF5-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167003>

Jeff King <peff@peff.net> writes:

>> Thanks; I was wondering about this myself but you bisected it faster.
>> 
>> Will revert.
>
> One other thing I noticed during the bisect: when using a version of git
> containing 83c9031, the merge took a lot longer. As in, 13 seconds with
> v1.7.3 versus 69 seconds with master.
>
> That may simply be because the bug being demonstrated causes us to
> erroneously do more file-level merging than we would otherwise need to.

Yeah, the reverted 83c9031 (unpack_trees(): skip trees that are the same
in all input, 2010-12-22) also seems to have seriously broken intermediate
merge merge-recursive makes.  I actually recall scratching my head when I
made 00e6ee7 (Merge branch 'maint', 2011-02-11) that was causing add/add
conflict when it shouldn't.  It turns out that quite a lot of entries were
missing in contrib/ area from the virtual common ancestry tree synthesized
by merge-recursive that called into the botched unpack_trees()---it of
course would result in add/add conflict if a merge is done using such a
tree as the common.

No, I haven't had a chance nor energy to dig further than what I reported
above.
