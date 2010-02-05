From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase vs rebase -i
Date: Thu, 04 Feb 2010 16:45:21 -0800
Message-ID: <7vmxzose72.fsf@alter.siamese.dyndns.org>
References: <76718491002032019i5f8ea947paa527988ddb7a378@mail.gmail.com>
 <alpine.DEB.1.00.1002041414530.4505@intel-tinevez-2-302>
 <76718491002040914t12956bb2gbe21ae89f31cbc7f@mail.gmail.com>
 <alpine.DEB.1.00.1002041859000.4505@intel-tinevez-2-302>
 <76718491002041010k84ad55ct5c3e80529e8f8428@mail.gmail.com>
 <alpine.DEB.1.00.1002041946170.4505@intel-tinevez-2-302>
 <76718491002041157o37de139brb7995076274375aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 01:45:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdCKL-0002av-BR
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 01:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305Ab0BEApf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 19:45:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757688Ab0BEApe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 19:45:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 842FA96477;
	Thu,  4 Feb 2010 19:45:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eJS4x3hSi3T52BiCiirgV7RcV9Q=; b=w/vXgq
	uN1ivgrXpAFFK9/CCq2pzu4vCpKBtVSWHk7rnnSm+hGBtRNpfw4pm+f5GbPLZgrB
	KyVvufW3O2E/BDtQ6J9X3zaK8iMSzINJoWWvtgCMY1qea/nT6hq409R72zFUZYGY
	8dGEfwZ1KM17GEYT0aAkq8KVNLBbiSQ+ptmic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OmF40RKzECC28kUnRirQEl9WFsNtakqi
	CH3aFu9F9reOffsHbBDr0+ETmLU/davc2FveWjk6XggZBl8+iftQauOevRRT2KNI
	c6bgdkjtwFXoraqtzmwSREe1LV1bRavIfzd5A9/ydamz4yjcsO/BTmqx/nMImL55
	C8RdDOXOM2A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 489FA9646F;
	Thu,  4 Feb 2010 19:45:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66BFD96468; Thu,  4 Feb
 2010 19:45:23 -0500 (EST)
In-Reply-To: <76718491002041157o37de139brb7995076274375aa@mail.gmail.com>
 (Jay Soffian's message of "Thu\, 4 Feb 2010 14\:57\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0B9B8D6-11EF-11DF-A6EC-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139016>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Thu, Feb 4, 2010 at 1:46 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Both "rebase -i" and "rebase -m" are really a cherry-pick in a loop.
>
> Well then I'm still confused. I see where pick_one() in
> git-rebase--interactive.sh is using cherry-pick.
>
> But call_merge() in git-rebase.sh is using git-merge-recursive (absent
> specifying another strategy).
>
> ?

I think Dscho's point is that cherry-pick internally runs the same
merge-recursive.

When you have a change C based on its parent C^ and want to replay that
effect on a (possibly unrelated) commit A, you would run three-way merge,
merging C into A as if C^ is the common ancestor.  The rebase script
cherry-pick, and revert all work with the same principle (for revert
obviously you would swap C and C^---you are applying the effect of going
from C to C^ in that case).

And no, "format-patch --stdout | am -3" pipe in the normal rebase codepath
will stay unless you can produce a benchmark that says the performance of
merge machinery is good enough these days.  Back when "rebase -m" was
introduced, it wasn't.
