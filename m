From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ce_stage(..) == 2?
Date: Sun, 14 Feb 2010 22:53:34 -0800
Message-ID: <7vbpfrhtw1.fsf@alter.siamese.dyndns.org>
References: <4B78EE4B.2040707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: chengang31@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 15 07:53:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nguq3-0001Io-4v
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 07:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab0BOGxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 01:53:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab0BOGxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 01:53:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CE049ADEC;
	Mon, 15 Feb 2010 01:53:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hnx3V6GvSZLH2naoZOT27xvSWKU=; b=d79YXc
	ZVC3kko91nj155J/LSRcUyeumJincjsM8XMQ9QH9NRHi13NLl8UpqLfy5KSvJK/q
	u3XVLHDYVAHLJnwlfmX6ghradya2Ggc5pw03+2FuBA5TsQ5BA0TkDKh4Wjsjk1rh
	KnRvyN8VC+ZhA5nTIgUAMnPFjczkVQIFuf7SY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SpikZ9Egadlw+/9lu/zXfZ5ID3XGMJRB
	TlsRdCEKsmd4cjHrZu8ubSFIh6L94CkVaCwGqkovvDXcdNSbVkjy/b8xYN/He8Nn
	2DqRV9VdAAPdyXBKcW6lOHaQEIvXdu4YYNntRNNTKAMNAUntuSWLHuGlVGiNKU2V
	sVB1/GetS9M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF7B99ADEA;
	Mon, 15 Feb 2010 01:53:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F1E99ADE9; Mon, 15 Feb
 2010 01:53:36 -0500 (EST)
In-Reply-To: <4B78EE4B.2040707@gmail.com> (cg's message of "Mon\, 15 Feb 2010
 14\:48\:43 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D887126C-19FE-11DF-9F31-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139990>

cg <chengang31@gmail.com> writes:

> I  saw some code like:
> attr.c(365): if (ce_stage(istate->cache[i]) == 2)
> ...
> rerere.c(352):  if (ce_stage(e2) == 2
> ...
>
> but there is no 0x200 in cache.h(158):
> #define CE_NAMEMASK  (0x0fff)
> #define CE_STAGEMASK (0x3000)
> #define CE_EXTENDED  (0x4000)
> #define CE_VALID     (0x8000)
> #define CE_STAGESHIFT 12
>
> so what does "2" mean?

#define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT)

0x3000 shifted 12 places is a mask for two bits, as you can have cache
entries at stage 0 (normal), or stage 1/2/3.
