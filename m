From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Use git_mkstemp_mode and xmkstemp_mode in
 odb_mkstemp, not chmod later.
Date: Sat, 20 Feb 2010 12:01:05 -0800
Message-ID: <7vy6inekxq.fsf@alter.siamese.dyndns.org>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
 <1266597207-32036-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Feb 20 22:31:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NivW4-0004p6-2a
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 21:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996Ab0BTUBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 15:01:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab0BTUBN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 15:01:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C3649BE4F;
	Sat, 20 Feb 2010 15:01:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZmKB88LfwQqXBlRRsn3nkxdvqQY=; b=V9CJUIfYXLdOcexAQRJZRWD
	4cXKiH+PYSvxmkXqPEuEmcW0BLflwcbKzJRY8b2UXlQOm/E/TZdR+0Q8KBle4mXj
	L6rhxtLKqAvCCxXPv/sj1f5uEHNsVsb86t5RRMFyW8wJoLssLG9soK4kgtvC/jGc
	UT6KEV7Y4uHRr8koNFjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=C5/HdENPBolU7nkihDKL2TV/KC6VMTqc5mtmmER+uBesUuOVO
	5bI+Q8xCcNqj21esFxrA2YPmvZp9GY2sndKnekKmmEknpsOCKO/WiTwBS/B1fpNb
	37lFBFGGcB+PSs+n0m5rPTZYBldU+NgTIWyWfXnQyPNKLBEp+rc3mu4wUc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67A009BE4E;
	Sat, 20 Feb 2010 15:01:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C739B9BE4D; Sat, 20 Feb
 2010 15:01:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B00CBE30-1E5A-11DF-B8CB-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140555>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
> index 4ee44a1..b8e9c34 100755
> --- a/t/t1304-default-acl.sh
> +++ b/t/t1304-default-acl.sh
> @@ -27,7 +27,7 @@ modebits () {
>  	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
>  }
>  
> -test_expect_failure 'git gc does not break ACLs with restrictive umask' '
> +test_expect_success 'git gc does not break ACLs with restrictive umask' '
>  	umask 077 &&
>  	git gc &&
>  	actual=$(modebits .git/objects/pack/*.pack) &&

This does not seem to pass for me; I get 0444 instead of 0440 as you expect.
