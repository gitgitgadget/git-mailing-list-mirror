From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff.c: fix a graph output bug
Date: Thu, 08 Jul 2010 17:57:50 -0700
Message-ID: <7v1vbdo4j5.fsf@alter.siamese.dyndns.org>
References: <y> <4c35eb6c.21078e0a.1455.ffffe42d@mx.google.com>
 <7vhbk9o6ie.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: struggleyb.nku@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 09 02:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX1ux-0006Nc-Uv
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 02:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab0GIA56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 20:57:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab0GIA55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 20:57:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7020C2D95;
	Thu,  8 Jul 2010 20:57:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CuKlkfANVue/HR7xS9DKnaHu8GI=; b=wzzlVC
	XAlfF5HljEB7UMo+c+mZnHuMQCzjW4f8lFMzM0hr4FuCiEP1KzkFF7VUUy7/Qr3+
	R5eSQqYofNmclABwVSgIA9KTpKL98kjq3GSpAuXvElCw6stqPS1Al0Z2DuwKUIBB
	oc1+NdFD+UeB7tQ1UI6Ts5zqEus5o1lW70+Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zwg5YGLTlt8SiLBpEyoAuDLs9md6hvBM
	Jz3J+eeOC0nycqIh8KUv7+piQkqkFh3q6KmqQ3MgCKoyT1GtPoFrtwH7N84i9JZd
	qidoE/MCskytwtrCkPY4RtkAwPU/Eo2HD8QvD9OYzaj3WHmpPeEJ4seMey8oNE+N
	79Tt7m6zBOY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FC77C2D90;
	Thu,  8 Jul 2010 20:57:54 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D26C3C2D8D; Thu,  8 Jul
 2010 20:57:51 -0400 (EDT)
In-Reply-To: <7vhbk9o6ie.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 08 Jul 2010 17\:15\:05 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 01C38B62-8AF5-11DF-9912-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150626>

Junio C Hamano <gitster@pobox.com> writes:

> struggleyb.nku@gmail.com writes:
>
>> From: Bo Yang <struggleyb.nku@gmail.com>
>>
>> Ouput the line_prefix ahead of color sequence.
>
> Justification for the patch, and/or a better bug description ("when run
> with this combination of options, X gets painted in that color that is not
> meant to be used for X") please?
>>
>> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>

Perhaps something like this?

From: Bo Yang <struggleyb.nku@gmail.com>
Date: Thu, 8 Jul 2010 23:12:34 +0800
Subject: [PATCH] diff.c: fix a graph output bug

When --graph is in effect, the line-prefix typically has colored graph
line segments and ends with reset.  The color sequence "set" given to
this function is for showing the metainfo part of the patch text and
(1) it should not be applied to the graph lines, and (2) it will be
reset at the end of line_prefix so it won't be effect anyway.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)
 ...
