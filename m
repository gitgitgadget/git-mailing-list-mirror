From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sat, 13 Feb 2010 17:37:21 -0800
Message-ID: <7vtytk61im.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 02:37:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgTQe-0001fB-IT
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 02:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131Ab0BNBhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 20:37:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126Ab0BNBhh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 20:37:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AEC4A98E59;
	Sat, 13 Feb 2010 20:37:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1A51sGzRES/TvjtA0bHV5f14Bao=; b=cyWNaI
	62w4oMPKryU8qQxVovuTp8TnJbHpRlAYjbpZlaT1Uod+wzW24GD/2Sj6xK1+8Jlu
	oY5nzPZpV3smXmsRASAmvPAqmuu1drCwrJEe45yF9E2bnTIsPP8wJ+AHQMdgQrYW
	Bl2vbIcEw2h1mWV+nFBeR2zsfUaJfDlSK/Fas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KhlxUwmIsOWMWdiJsBNRJkTypN3TXykH
	AzhG67cN9VmD0KBFqRCuqhbHFMq/5bf9HjZk5cYFk6HfCN4kxr2FarKE7oOExRnA
	cdqhYSzNj8n74kd+yqkKdsNwYfXTf16fJwuRPPP/ePMJwvARDZKYyrGhrwxGB232
	mDxk4KtVSd0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B37598E58;
	Sat, 13 Feb 2010 20:37:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4733C98E56; Sat, 13 Feb
 2010 20:37:23 -0500 (EST)
In-Reply-To: <20100214011812.GA2175@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Sun\, 14 Feb 2010 04\:18\:12 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83E74682-1909-11DF-BF8B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139878>

Dmitry Potapov <dpotapov@gmail.com> writes:

> If a mmapped file is changed by another program during git-add, it
> causes the repository corruption. Disabling mmap() in index_fd() does
> not have any negative impact on the overall speed of Git. In fact, it
> makes git hash-object to work slightly faster....
> ...
> I think more people should test this change to see its impact on
> performance. For me, it was positive. Here is my results:

I wasn't particularly impressed by the original problem description, but
this is a very interesting result.
