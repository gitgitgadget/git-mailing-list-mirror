From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Teach '--cached' option to check-attr
Date: Thu, 22 Sep 2011 16:36:45 -0700
Message-ID: <7vzkhww3n6.fsf@alter.siamese.dyndns.org>
References: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 01:36:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6sp3-0003RR-Qa
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 01:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab1IVXgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 19:36:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746Ab1IVXgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 19:36:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51BE161F0;
	Thu, 22 Sep 2011 19:36:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8JSVCQ91g74HUPWMDELay48SjTM=; b=Hpge2x
	AdiN5d64mBMmMQ/GOi+jTKrIzR0uHxu7EqNyetOQwLoSOd1rpMPef2SCTfDVe523
	62CaY6Q/mRSVPQ3J3j3cDHjCI65Znh2Ui8f+hKyHQEQvjSejTY9aFcK9cm7PpiMo
	RWv608Zl0dK2vAtzEQBqRMbTii2vC1vVoEvTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E+j22fnsFK+oaWqrfzryfQOTPMKG6gNc
	dVUCZ9mZcB900OGlW/ni61Vqk8CeUuUNAFBHXDrzJ/RQZZ4pY8qis+RN0CLoOHaD
	9myL8/IUy0K4Z6+ZIFWHyJs2FSuMzzAar3+XwbqZ9j82LO7jqg2eg9JV9I7zIin+
	n0BPj8DH26k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48CFA61EF;
	Thu, 22 Sep 2011 19:36:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D386561EC; Thu, 22 Sep 2011
 19:36:46 -0400 (EDT)
In-Reply-To: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Thu, 22 Sep 2011 17:44:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC91C466-E573-11E0-A7B8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181936>

Jay Soffian <jaysoffian@gmail.com> writes:

> This doesn't seem too controversial to me, and allows server-side
> reading of .gitattributes, albeit with the need to setup an index.

Thanks; will queue with a few trivial tweaks.

> +test_expect_success 'bare repository: check that --cached honors index' '
> +
> +	export GIT_INDEX_FILE=../.git/index &&
> +	git check-attr --cached --stdin --all < ../stdin-all |
> +		sort > actual &&
> +	test_cmp ../specified-all actual
> +
> +'

This is unfriendly to others who need to add more tests after this piece
by contaminating their environment. A single-shot export would be more
appropriate here:

	GIT_INDEX_FILE=../.git/index git check-attr --cached ...
