From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not allow refnames to start with a slash
Date: Thu, 25 Aug 2011 11:17:22 -0700
Message-ID: <7v39gpmk3x.fsf@alter.siamese.dyndns.org>
References: <4E55FFAA.9030904@alum.mit.edu>
 <1314259695-30801-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cmn@elego.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 25 20:17:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QweUc-00066u-Kk
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 20:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab1HYSR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 14:17:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893Ab1HYSRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 14:17:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA3CA4941;
	Thu, 25 Aug 2011 14:17:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DFIfz5XHiLrN1rSlZhXa9C1ob9c=; b=t1Piv4
	KyEVAq9FWXHC1AFtfJjHHf1AmaPJ0/5kVKKnT0ECa3EQdV2hW1lQQR7joLuBX4c4
	bdeo8vOo+zm5Z1wPfu/k1i+hEC8GTtYYtiQ4nnbC3434lSKBFIrWFt46xQ+gEhve
	knkIi9jKNc9BTc9Ymi0OhefDMWvSoFxeJa0qU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wkum3D2kwRSy0JnQeIg6zIHHtVD89PZI
	1TW2xB3hx6cT5IkevSso2sr6ZTGJGhxscQ/C5pjjc9jt62h5H/rrYDW3RDrtvV1D
	cDCuhEb7+KSXczf2Yg12w64J2XpdZ7QwjTPOKlcQWF47HagpQvrUZLTZE9zYxzYZ
	tja0kp7FrNc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF8304940;
	Thu, 25 Aug 2011 14:17:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BFBD493E; Thu, 25 Aug 2011
 14:17:24 -0400 (EDT)
In-Reply-To: <1314259695-30801-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Thu, 25 Aug 2011 10:08:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B30BBF0-CF46-11E0-851B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180095>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
> index 1b0f82f..b05ca26 100755
> --- a/t/t1402-check-ref-format.sh
> +++ b/t/t1402-check-ref-format.sh
> @@ -18,6 +18,10 @@ invalid_ref 'foo'
>  valid_ref 'foo/bar/baz'
>  valid_ref 'refs///heads/foo'
>  invalid_ref 'heads/foo/'

> +invalid_ref '/foo'
> +invalid_ref '/foo/bar'

As refs///heads/foo is defined to be valid_ref, I am moderately against
this change, which can break existing scripts.

> +invalid_ref 'foo/'
> +invalid_ref 'foo/bar/'

We already check trailing slash in existing checks, so I do not see a
point in these two additional lines.

>  invalid_ref './foo'
>  invalid_ref '.refs/foo'
>  invalid_ref 'heads/foo..bar'

I was about to write "other than that the patch looks good", but then
realized there is nothing remaining after rejecting the new "now slash
cannot come at the beginning".
