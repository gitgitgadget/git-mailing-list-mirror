From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] commit-slab: avoid large realloc
Date: Sun, 14 Apr 2013 18:29:41 -0700
Message-ID: <7vtxn84m4a.fsf@alter.siamese.dyndns.org>
References: <1365919489-17553-1-git-send-email-gitster@pobox.com>
 <1365919489-17553-3-git-send-email-gitster@pobox.com>
 <20130414152842.GB1544@sigill.intra.peff.net>
 <7vk3o554jn.fsf@alter.siamese.dyndns.org>
 <20130414191947.GB4599@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 15 03:29:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URYEu-0003qL-Ep
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 03:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab3DOB3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 21:29:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366Ab3DOB3o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 21:29:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A383011AEC;
	Mon, 15 Apr 2013 01:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G/Trfw7sqVVJbamAIiHDz0t/vnc=; b=LPLlYO
	sO819UvfBIpscK/7ymReh+c1t6ymftzZPpJ8+bxChVWlU1j9kRQRrvNG8I55xgVv
	t7jvRvLDAng9lQrDW43EmkEE3lpwUaqW9bly+SsyjH3BaeNf0OhSIt0I7pgjqdQm
	ccAOXYEZwSE6tOe+SnILA9cTEbA5t7y6hVzWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s/qSsoExFwhmVVgRxMtHr/rULP4QE2db
	lWMubJVa3F/J/UdGTEokXeuTHUoTcsgomPjGHm9ovmvmvzrEFk/1Sl/4i55dMtJI
	2eXvLVvIthbtk5PMv7t3tsMdXdIYNJzXhQSrszzodQjd9+4CLzrN+tPXx7yN37jb
	q9KWzVcKtoY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A77E11AEB;
	Mon, 15 Apr 2013 01:29:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB0CC11AE9; Mon, 15 Apr
 2013 01:29:42 +0000 (UTC)
In-Reply-To: <20130414191947.GB4599@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 14 Apr 2013 15:19:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2DB3AB6-A56B-11E2-8F31-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221175>

Jeff King <peff@peff.net> writes:

> Yes, but isn't that a constant:
>
>   (512*1024-32) / sizeof(struct commit_slab_piece)
>
> Leaving it as such lets the compiler optimize better, and is safe from
> anybody changing it at runtime. But I think the answer to my question is
> "yes, that would be the best thing for patch 2, but patch 3 will allow a
> run-time stride parameter anyway". Correct?

Yup.
