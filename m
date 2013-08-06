From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/16] blame: accept multiple -L ranges
Date: Tue, 06 Aug 2013 15:47:44 -0700
Message-ID: <7vk3jye8rz.fsf@alter.siamese.dyndns.org>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
	<1375797589-65308-6-git-send-email-sunshine@sunshineco.com>
	<7v1u66fqrz.fsf@alter.siamese.dyndns.org>
	<CAPig+cTHbV-ijfXNBn45v2opOH7Jh0A22QaxCeKhRBPA39xAwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 00:47:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6q2i-0003Qn-4G
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 00:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757003Ab3HFWrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 18:47:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756944Ab3HFWrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 18:47:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C0BA37896;
	Tue,  6 Aug 2013 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ntyqsZ4lZL+fQVsnc4UDTQ0Yc+s=; b=oyIDL2
	u1a3LEYKMLears79U0XLpdCUZsE2/q0Z6/SxLezzy6UPlPCU8cBUUmXvsihXRTnu
	T3Z2Ljvyf/Vyx0EDD8brf78a6YTYerqpXY7EFGpc4OUmklzqEgcS0ILhUijwnsFm
	QvsdKf+p68hzeTdcMN98Im5G+n7s/lmbiW7EY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lCw2UwTPfUFpY01o6hM6LXWI54aEXF8N
	L8ikuMZt4T4k9v3+D1B+0XpC38LZ4iwjllleD8FX3ll0dSswzZ1f+DUh9XRIhUtI
	NhYanmgWv3U1jT4iW7Agqw23BrJLiZcJC3lQb5NNrlGLdIQT6dLvJms6gehaVqlA
	ZDLdEe+Um7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F87237895;
	Tue,  6 Aug 2013 22:47:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA40437894;
	Tue,  6 Aug 2013 22:47:45 +0000 (UTC)
In-Reply-To: <CAPig+cTHbV-ijfXNBn45v2opOH7Jh0A22QaxCeKhRBPA39xAwQ@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 6 Aug 2013 18:44:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 360BB93C-FEEA-11E2-9C5E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231793>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Each constructed blame_entry must own a reference to the suspect.
> o->refcnt should equal the number of blame_entries. At construction, a
> 'struct origin' has refcnt 1. In the original code, which supported
> only a single initial range (blame_entry), we had:
>
>   o = get-initial-suspect();  # refcnt already 1
>   ent->suspect = o;  # refcnt still 1

Ah, of course.

I forgot that I initialized a new origin with refcnt 1 exactly for
this.  As you use it once for each range, you would need to
compensate for it.

Thanks.
