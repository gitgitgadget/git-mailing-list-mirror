From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/18] revert: Save data for continuing after conflict
 resolution
Date: Wed, 27 Jul 2011 15:51:34 -0700
Message-ID: <7vy5zjmj61.fsf@alter.siamese.dyndns.org>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-12-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 00:51:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmCx5-0000NW-5Z
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 00:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446Ab1G0Wvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 18:51:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985Ab1G0Wvh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 18:51:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9110469F;
	Wed, 27 Jul 2011 18:51:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=IBxzs/Kv4mAb7ggxtrCq28TVtZc=; b=bO5w9TkwyG0jAYOgSrNC
	KKU6YBhtbxplh9pW3Ds+dRcPtDGT+q8YG0d8StvqlLzdxTuyy1oLfmQiIW6yIHrY
	TLVO1j0nQoS2bl9+yrSwkJ8SLqZPqvgp+FqNb+qkiE3XeiF0jkHXp9ULFwAbU/Kw
	Jac8x8ANO1gxw2BTgRMazSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oRs6uli+eHfpIc9+LkFxIDXec2MTS2cpZARJ6mmDtjO/0h
	wr6E29UoGTY/Q2KyQPX4acrk92rcQeN5bgJ44i9GVY6F6z5Nfux5pO23DCM7Q2+x
	3KIJoyj8kpIRajMynwnSpg+ADMIAzfKFkZOQyLbWhbpQoAvVH7c79xpKwbufc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0BCB469E;
	Wed, 27 Jul 2011 18:51:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54DC5469D; Wed, 27 Jul 2011
 18:51:36 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB6DA0CC-B8A2-11E0-BD0F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178000>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +	if (!prefixcmp(start, "pick ")) {
> +		action = CHERRY_PICK;
> +		insn_len = strlen("pick");
> +		p = start + insn_len + 1;
> +	}
> +	else if (!prefixcmp(start, "revert ")) {
> +		action = REVERT;
> +		insn_len = strlen("revert");
> +		p = start + insn_len + 1;
> +	}
> +	else
> +		return NULL;

(style)
        if (...) {
                ...
        } else if (...) {
                ...
        } else {
                ...
        }
