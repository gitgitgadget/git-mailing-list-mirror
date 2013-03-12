From: Junio C Hamano <gitster@pobox.com>
Subject: Re: linux-next: unneeded merge in the security tree
Date: Tue, 12 Mar 2013 13:02:19 -0700
Message-ID: <7vobeo75f8.fsf@alter.siamese.dyndns.org>
References: <20130312100950.e45ef0e721492ff0d5fd7c8d@canb.auug.org.au>
 <alpine.LRH.2.02.1303121510270.25612@tundra.namei.org>
 <20130312041641.GE18595@thunk.org>
 <CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
 <7vsj40760d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-next-owner@vger.kernel.org Tue Mar 12 21:02:48 2013
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-next-owner@vger.kernel.org>)
	id 1UFVPK-0004UH-E2
	for glkn-linux-next@plane.gmane.org; Tue, 12 Mar 2013 21:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361Ab3CLUCX (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Tue, 12 Mar 2013 16:02:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755533Ab3CLUCW (ORCPT <rfc822;linux-next@vger.kernel.org>);
	Tue, 12 Mar 2013 16:02:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D67EADD7;
	Tue, 12 Mar 2013 16:02:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0CINCBYFxUJvUT44lK91TGY8Awg=; b=ibC3kV
	BfPZu+gEoSwNhJkpNc4ZCVoeSwHGkyYmThIdfi1YuH75D9AtbmL3MuvNgt7WRdsJ
	alS7PuTC67KYIb5BtCeamUShalno34bzPRIoKOrvKKvzkTovWfqar6vKaAT60AGa
	fV/EQnRUqoe6O5mjPRoKTZ/zWe2l4XybN6FMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F2szMvaICj9gGAjbddY/V+PJ4IvAoHmX
	kacmkWuh16mJZFELnggWL+aiRIxiKWnOEl58gqAAAB5TZTWunRiYvyQYO0LmVwjK
	bOAuI7iSQdsMJke3Wta/Ywv/hWVbJ0W1lOwZM9L6e5vKUObFUyTgfLLAXOwy1emW
	gCAUBAOWPSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32158ADD5;
	Tue, 12 Mar 2013 16:02:22 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88CF3ADD1; Tue, 12 Mar 2013
 16:02:21 -0400 (EDT)
In-Reply-To: <7vsj40760d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 12 Mar 2013 12:49:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C016A4C0-8B4F-11E2-8500-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217990>

Junio C Hamano <gitster@pobox.com> writes:

> Then under the "--no-ff activates the magic" rule:
>
> 	git merge v3.9-rc2
>
> will fast-forward, but this
>
> 	git merge --no-ff v3.9-rc2
>
> creates a real merge with the "mergetag" signature block.  The one
> that caused trouble in the "security tree", i.e.
>
>         git pull linus v3.9-rc2
>
> or its equivalent
>
>         git fetch linus v3.9-rc2
>         git merge FETCH_HEAD
>
> would still fast-forward under this rule.  The maintainer needs to
> do
>
> 	git pull --no-ff git://git.kernel.org/... for-linus
>
> if the pull could fast-forward under this rule, though.

Scratch the last sentence.  It should have been

"whether the pull fast-forwards or not".  You'd always need to.
