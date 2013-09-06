From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] connect.c: save symref info from server capabilities
Date: Fri, 06 Sep 2013 12:46:27 -0700
Message-ID: <xmqqvc2dwx64.fsf@gitster.dls.corp.google.com>
References: <20130906155204.GE12966@inner.h.apk.li>
	<20130906155655.GG12966@inner.h.apk.li>
	<xmqqob85ygt8.fsf@gitster.dls.corp.google.com>
	<20130906192515.GI12966@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 06 21:46:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI1zN-000324-CU
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 21:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838Ab3IFTqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 15:46:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750Ab3IFTqg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 15:46:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6DE03F472;
	Fri,  6 Sep 2013 19:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8GWyCGUV6O2aIUTTuEDJ8jxgF1U=; b=bVombV
	GTerve9Y3MxfZGYhSLBk57Re4gUJT6TYlMJEkIUPZ2/5nvBHmPwlavfyQki+3Jjt
	Eg3Ps2RL7484SmfTxfo85zXhdaes10k0OLgMkUd93BIsTAnqwkDje3G46gnISL+C
	pNheqtCvkqMwW6WWKFPTjPyD6hy8cgVgiLHfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QMTMSp66QpMj+2YtPmluL9d42U9Ww8Au
	42vujioZw3zfSBxRIXRRvdLTjGrg4TR1EPNj1vM+5Vk1Nex6rAwWMCeyqX/VzLoP
	gJldkO856hq5IgP/t9YPQZ6MHsZDGUxNRow3Ok6HwMHPz3GXvMmQ1FEq9Noh3gye
	OAVrTeYrJMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 800EC3F46B;
	Fri,  6 Sep 2013 19:46:33 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 466433F45C;
	Fri,  6 Sep 2013 19:46:31 +0000 (UTC)
In-Reply-To: <20130906192515.GI12966@inner.h.apk.li> (Andreas Krey's message
	of "Fri, 6 Sep 2013 21:25:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0767E0D2-172D-11E3-BC40-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234091>

Andreas Krey <a.krey@gmx.de> writes:

> Can I assume that the only capability list is always on the
> first ref sent (as it is now)?

The capability list _could_ be sent more than once, and the
receiving end is prepared to accept such a stream.  Everything
learned from an older capability list needs to be forgot and only
the last one is honored, I think.
