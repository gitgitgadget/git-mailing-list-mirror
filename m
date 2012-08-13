From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Re: cherry-pick and 'log --no-walk' and ordering
Date: Mon, 13 Aug 2012 00:26:11 -0700
Message-ID: <7vd32vfe24.fsf@alter.siamese.dyndns.org>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
 <7vhas7fefs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 09:26:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0p2a-0003eO-2R
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 09:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab2HMH0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 03:26:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250Ab2HMH0O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 03:26:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26ECF7BC9;
	Mon, 13 Aug 2012 03:26:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m1k9M45bx+YNMCBaipBZ8BotCBQ=; b=xdCTEt
	Skj/KxbOWXvqRZtCbCK/+xjpspNQxZcRZrcql8VDoYCn8HhjSJqKKjDzpYuidoIp
	FfxQJ28UnZxdZ94qKKdRLK09xIRYc3VsJfVrmGVbTSIW+lcBrexPFh3wqkPIdTea
	/VWqtbPQWa8mAqTarRIeGcpgHCcZzF36r5NkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YjvNoDu4oiQ/0ClIBuv31qhVx/oFs1m2
	UxRWQAH/NPXTBeurjorNRRU2Dq5Ll3Pj0nDdRxQfjGeQC6rQRvD+RxeHpw0uSy4o
	ycPJQxIUMDiFlF7nzcn/NSfJqdcGGXi+qWsF+vnxCTQ817Ko50yAAaaSx3QC6jq2
	8WJdU4imVSE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13E6D7BC8;
	Mon, 13 Aug 2012 03:26:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BC9E7BC7; Mon, 13 Aug 2012
 03:26:12 -0400 (EDT)
In-Reply-To: <7vhas7fefs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 13 Aug 2012 00:17:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28E3AF72-E518-11E1-B4F6-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203330>

Junio C Hamano <gitster@pobox.com> writes:

> Would anything break if we take your patch, but without two
> possibilities to revs->no_walk option (i.e. we never sort under
> no_walk)?

By the way, by "would anything break", I do not just mean if our
existing tests trigger failures from "test_expect_success"; I
suspect some do assume the sorting behaviour.  I am wondering if the
sorting makes sense in the real users; in other words, if the
failing tests, if any, are expecting sensible and useful behaviour.

After all, the sorting by the commit timestamp is made solely to
optimize the limit_list() which wants to traverse commits ancestry
near the tip of the history, and sorting by the commit timestamp is
done because it is usually a good and quick approximation for
topological sorting.
