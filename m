From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] convert filter: supply path to external driver
Date: Wed, 22 Dec 2010 15:22:35 -0800
Message-ID: <7vmxnx4clg.fsf@alter.siamese.dyndns.org>
References: <20101218223822.GA18902@arf.padd.com>
 <20101219212925.GA7393@arf.padd.com>
 <7vzks1e84p.fsf@alter.siamese.dyndns.org>
 <20101220160911.GA32136@honk.padd.com>
 <7v8vzkcol8.fsf@alter.siamese.dyndns.org>
 <20101221134403.GA10401@honk.padd.com> <20101221181924.GB25812@burratino>
 <20101221203322.GA13868@honk.padd.com>
 <7vzkry7rb4.fsf@alter.siamese.dyndns.org>
 <20101222144013.GA22089@honk.padd.com>
 <7v4oa565lc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 00:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVY1o-0007Zn-RT
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab0LVXWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 18:22:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab0LVXWu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:22:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FDDB2FD8;
	Wed, 22 Dec 2010 18:23:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pe5PBMpYKMB5CqflITkgJBY0a9Y=; b=rPPQ8f
	nfyZPHMRiACxmcsQpaigpIW9n6ONK1JaSlpGYT3kUBR+IUUHrTvbMnn1SfSf/vhf
	l20CrM7linXDdqXqsQNx5qVWe/iKAmAGeX0ikBOJGztbIXl7ouUjBO0Iu6kYdsR2
	nmaRsdlqhiI/acQ+Qkll0AcyNHjlCXT6ITglA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=As5zAsYXXVNUej1sD6XQbvVm730J2Tl+
	v7+HL8HhoS7SUZuVAWYSjK2vm8cGyqtJ6bQICbUzsAel6iriLYafOQZNre1LzdYn
	nVlHODrEKvx1K+07tfsICU0NHss5KQP4WHs+fQU6EfPzVBgdEtNCVddjet9+8TJs
	pNiYuIYjmjc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AFA162FD3;
	Wed, 22 Dec 2010 18:23:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3A3622FCD; Wed, 22 Dec 2010
 18:23:06 -0500 (EST)
In-Reply-To: <7v4oa565lc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 22 Dec 2010 10\:10\:55 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72ADBFD6-0E22-11E0-8559-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164100>

Here is another, just FYI.

-- >8 --
Subject: [PATCH] t0021: avoid getting filter killed with SIGPIPE

The fake filter did not read from the standard input at all,
which caused the calling side to die with SIGPIPE, depending
on the timing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0021-conversion.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index aacfd00..9078b84 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -100,6 +100,7 @@ test_expect_success expanded_in_repo '
 test_expect_success 'filter shell-escaped filenames' '
 	cat >argc.sh <<-EOF &&
 	#!$SHELL_PATH
+	cat >/dev/null
 	echo argc: \$# "\$@"
 	EOF
 	normal=name-no-magic &&
-- 
1.7.3.4.811.g38bda
