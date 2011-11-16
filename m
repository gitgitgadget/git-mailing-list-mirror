From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] sequencer: sequencer state is useless without todo
Date: Tue, 15 Nov 2011 23:38:49 -0800
Message-ID: <7vhb24qzxy.fsf@alter.siamese.dyndns.org>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
 <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 08:38:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQa5C-0003Ps-Tn
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 08:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab1KPHiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 02:38:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754098Ab1KPHix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 02:38:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EFDD32C1;
	Wed, 16 Nov 2011 02:38:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jYXqjgG0B8Tc87WBcRdRVUpqyi8=; b=l8F5ku
	II5RUaHVwADpU1cUTQKP9k148l2DjcrtcWXyMrvXH13QbtPjbovX207R4bfZ01x/
	ICYj1W9k3+uNJ7vVhSo4fFE4+DrmlRAMz8YHrWnVO9Wp1+f0D+WM+iMwDa7VoDCB
	MV+G5ac3RFlmyyHTTsq8wr5LpazG96ILhUx40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CZWu3CeQmZunlqpS5FIOGUHG6wXpOVp1
	+IdiUXvXUrr8ooe0fd032bvmmzkgO4hiPTkQT0xzAHwyW6RTCWR3pMfwCE+qSCcz
	7GytRJzQ5X+3drXfReuoBDxJDr+FhDBRW64v5GJ4A3HXdiOmFVyXstLw5VZzUnW2
	23d7c34mFTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46AB532BF;
	Wed, 16 Nov 2011 02:38:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3E6132BE; Wed, 16 Nov 2011
 02:38:50 -0500 (EST)
In-Reply-To: <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 16 Nov 2011 11:47:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07006F34-1026-11E1-8AE2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185519>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I noticed that sha1_to_hex() also operates like this.

A function to externalize our internal representation like sha1_to_hex()
is not such a big problem in practice, as the lifetime of its result is
inherently much shorter.

Anybody sane with a datum that eventually needs to be externalized will
keep it in its internal representation as long as possible, and then call
such an internal-to-external function just before it becomes absolutely
necessary to externalize it (e.g. calling printf(), packet_write(), etc).
This is because the whole point of having an internal representation
(e.g. when our code talks about an object name, we always use "unsigned
char[20]") is so that all of our functions can use that representation to
pass it around. It would be insane to call such a function earlier than
necessary, having to pass external representation around.

On the other hand, resolve_ref() is an interface to canonicalize external
representation into a form suitable to be kept and passed around as its
internal representation. The lifetime of its result fundamentally has to
be a lot longer than that of functions that work in the opposite
direction, e.g. sha1_to_hex().
