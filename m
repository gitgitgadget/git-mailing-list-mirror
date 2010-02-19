From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Fri, 19 Feb 2010 09:51:52 -0800
Message-ID: <7vbpflktaf.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <7vzl37z6f3.fsf@alter.siamese.dyndns.org>
 <20100218153249.GA11733@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:52:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiX1S-0000e2-8I
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 18:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab0BSRwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 12:52:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab0BSRwH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 12:52:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CF649B421;
	Fri, 19 Feb 2010 12:52:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=cKa0GNl662G6hgbV6HWmdSZ/ZIk=; b=awynp6uo4YOIQ8uF1Wpz7/v
	icR5D/RSuSvoguyOVH7NG5GQNBkuiODFJ/IeX1GsJE9UOSdf8rNMdSdzxT2ee8r5
	4sY0lCEsJ9Dtd6C1pfc4eApLWeFpEYDJ/gORfxFvxoXQ889F+zBOVDOsCagCHWBL
	XuY4s1BqibRTXPqotUj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LK7NDMBqxTgtAxUiftabL6HJP2SVVF3pKZSEv9eoqDaziJrOo
	qBkVpBQ2n1CUyUjd5x7QcpifShHcoyPOQOFV9BO2XCjVQP1kzKRY37nRmacXMXru
	Q4xX9EilhDScltvhdSiyawRnSF+sQ1GqtqSfOm79YuA/Hao3SR8jbk0y3Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3A5C9B412;
	Fri, 19 Feb 2010 12:52:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A15429B40C; Fri, 19 Feb
 2010 12:51:53 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B1D8CE4-1D7F-11DF-AA33-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140471>

Zygo Blaxell <zblaxell@gibbs.hungrycats.org> writes:

> If git commit runs out of disk space, for example, the commit should
> fail, but the repository should still not be corrupt.  Future commits
> (for example after freeing some disk space) should eventually succeed.

That is true.  It is Ok to create a corrupt object as long as running an
equivalent of fsck immediately after an object creation to catch the
breakage to prevent it from propagating further.

That is essentially what "paranoid" switch does, but it adds overhead that
is unnecessary for the use case we primarily target in git.
