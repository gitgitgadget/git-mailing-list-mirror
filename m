From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/12] Wildmatch v4
Date: Thu, 11 Oct 2012 16:50:34 -0700
Message-ID: <7vipag601h.fsf@alter.siamese.dyndns.org>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
 <7vd30panxo.fsf@alter.siamese.dyndns.org>
 <7v1uh5aar7.fsf@alter.siamese.dyndns.org>
 <CACsJy8B2JJmUbjAauMwbg95fCvPdUYqy4CKZp3ac44XHoh1NLQ@mail.gmail.com>
 <7vlifd7zz3.fsf@alter.siamese.dyndns.org>
 <7vvceh6imi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 01:54:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMSa6-0000pv-MU
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 01:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864Ab2JKXui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 19:50:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44679 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334Ab2JKXuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 19:50:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD82791C0;
	Thu, 11 Oct 2012 19:50:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=A9FGlMFh6bqxlF5zjzISs4vfDrQ=; b=eOzl4WHmWR6d0Ltuvbv0
	iqtlTYyqSQGRQxlVIUTuvoey0/KSzqnp7hc60TjCElyOjz0TmjADTM/trOy+D/L3
	vBeMLjKs/Xjr35YrMnh7ZULZZpNVRyP6DN9i855kDg1dg0gnaSFyHiHWSq2p3qo7
	ilxcmkbGehd8TKODBe6YqqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DGzGjXnEx1zggsIQvWpUP/Mz1mOncfDRUWoZPPAX3RYCVL
	7K98Q9tm0edYOA9gon6Vcs9az/Izee4BtzNaSAbHJp7+Z6C1klfsMve5EJhRLc0H
	nE582nfagZIaWjjB0Mp/Ifox2WzRFOazTRJNQwM01CDFntZGS0I7jHjRjf+pA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9903691BF;
	Thu, 11 Oct 2012 19:50:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA0F091BC; Thu, 11 Oct 2012
 19:50:35 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73C8677A-13FE-11E2-9A51-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207522>

Junio C Hamano <gitster@pobox.com> writes:

> Ahh, it must be this bits from t/test-lib.sh
>
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git i/t/test-lib.sh w/t/test-lib.sh
> index 514282c..489bc80 100644
> --- i/t/test-lib.sh
> +++ w/t/test-lib.sh
> @@ -230,7 +230,7 @@ else
>  	say_color() {
>  		test -z "$1" && test -n "$quiet" && return
>  		shift
> -		echo "$*"
> +		printf "%s\n" "$*"
>  	}
>  fi

I'll queue this fix separately before your series on 'pu'.

-- >8 --
Subject: [PATCH] test-lib: Fix say_color () not to interpret \a\b\c in the message

When running with color disabled (e.g. under prove to produce TAP
output), say_color() helper function is defined to use echo to show
the message.  With a message that ends with "\c", echo is allowed to
interpret it as "Do not end the line with LF".

Use printf "%s\n" to emit the message literally.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c0d04c4..280b3aa 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -169,7 +169,7 @@ else
 	say_color() {
 		test -z "$1" && test -n "$quiet" && return
 		shift
-		echo "$*"
+		printf "%s\n" "$*"
 	}
 fi
 
-- 
1.8.0.rc1.82.ga68bb49
