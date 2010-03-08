From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Notes Usage
Date: Mon, 08 Mar 2010 15:20:00 -0800
Message-ID: <7vhboqjt9b.fsf@alter.siamese.dyndns.org>
References: <d411cc4a1003081152j5b9f3028wa230b5e1d22a36ae@mail.gmail.com>
 <4B95652E.6070802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoySB-0001Do-Da
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab0CHXUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 18:20:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054Ab0CHXUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 18:20:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 906CEA0B7D;
	Mon,  8 Mar 2010 18:20:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cKmt1eVVxD/Ow57/enCSjG57Mk0=; b=P89k0B
	hDwM8xHkBSL53EG4MX9jQAbKsATfq6XWoLZaQyA0LKmb3lWxfI7ffLDTFX6utoNB
	ZlKX1zuCU19IWk8N9MQr0zsPKKa5D+SMYTR4bIUjgoAr/cHVdJ3F1CQbtCn7w8wC
	vBAuWK2VRHn7Lmw8yC8yW4fjxURPMKOcp6EA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hvYXPaPO+z5X/BxwIZ4dRR9zS2fkPQYi
	UfEnqLk5/EiGJdDK6WCGEOtOnHkLR6CsRkhDCUJqxTtgFZQkEWjzNCPWWQaXUn0t
	TQSn55EKmGMiwow9o+TyWYbdmtL9tl3lyKTJRqFLiRsD/ioguHn4IOOSTK+nrgfq
	TFMt2RBQaZs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C03BA0B77;
	Mon,  8 Mar 2010 18:20:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E3F2A0B75; Mon,  8 Mar
 2010 18:20:02 -0500 (EST)
In-Reply-To: <4B95652E.6070802@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon\, 08 Mar 2010 21\:59\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 21A2E1D6-2B09-11DF-867B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141814>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Also, if two people write notes into the same namespace at the
>> same time, how does one merge them?  Is the only way to do so to
>> actually checkout the notes branch into your working directory and
>> merge the notes trees?
>
> I'd say every merge needs a working directory, so, yes.

While that is true in the most general case, I do not necessarily agree
that people would use notes that way.

Merging two notes trees would require a lot more than the ordinary merge
machinery offers (there is a tree rebalancing logic in notes tree
mechanism, and notes specific merge that is yet to be written should take
advantage of it) and if one wants to do the merge manually, you would need
to check them out in a working tree.

The "notes copy" feature (parked in 'pu') lets you deal with conflicts by
allowing you to concatenate (or overwrite) while copying a note for commit
Y to another commit X and when X already has a note attached to it.  If
you think about it, it is merging an old note (that came from emptiness)
with a new note (that also came from emptiness) using an emptiness as
their common ancestor, i.e. two-tree merge with "union" merge semantics
(or "ours" if you say "overwrite", "theirs" if you say "ignore").

I suspect that in practice people would want notes to be resolved more
automatically and inclusively (read: union merge) compared to how the
normal payload would be merged, without the need to have a checkout in the
working tree.
