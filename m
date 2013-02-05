From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Mon, 04 Feb 2013 16:21:13 -0800
Message-ID: <7vip67zk3q.fsf@alter.siamese.dyndns.org>
References: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
 <20130201085248.GA30644@sigill.intra.peff.net>
 <7vip6bc3e1.fsf@alter.siamese.dyndns.org>
 <20130201185827.GA22919@sigill.intra.peff.net>
 <7va9rk5z02.fsf@alter.siamese.dyndns.org>
 <20130204083824.GB30835@sigill.intra.peff.net>
 <CAJo=hJtZ64ER4X+axtFZJ5ArnEg3h_nCVEBdd8KmE0nUpskzBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 01:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2WIL-0006Iv-60
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 01:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab3BEAVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 19:21:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612Ab3BEAVP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 19:21:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D1EBC382;
	Mon,  4 Feb 2013 19:21:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IGwR+kcTARv0OMnoycheCqzUmZo=; b=Qvaq4y
	P9wyF5vqsJt2W4K1B14q+1Bfj4pnfTyV0BYNHQfCLvdcGRLM3+KMu+zftDgnEgZU
	xtwf8QCG6JXw0FhEBG2E01OjYU7q1bQK7PHuuMf9MZmyeX+w5l7If5XUHm+D6iXz
	71nK6F3TCCaQ03ns8U8P+Vv/D3aH/1Z0PBcgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SSQCIcpRiG8ZcZk5ciObqpm62UE9XKbx
	29QWF9cbYxXZ3aZjXeEvPy9ar0H+i/F3QuIwQeRnjMu1VLc982aCvJtjr7v+PdTj
	fkICe4mEW8luyydiDpO44OHDdIGNxDuDkzQTFUzC2l1zLK+TnRu936O079vWZvsH
	zW+cf+xlo88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71D6EC381;
	Mon,  4 Feb 2013 19:21:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E94C0C37E; Mon,  4 Feb 2013
 19:21:14 -0500 (EST)
In-Reply-To: <CAJo=hJtZ64ER4X+axtFZJ5ArnEg3h_nCVEBdd8KmE0nUpskzBA@mail.gmail.com> (Shawn
 Pearce's message of "Mon, 4 Feb 2013 15:49:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3D4075E-6F29-11E2-8949-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215439>

Shawn Pearce <spearce@spearce.org> writes:

> Looks fine to me too, but I think the test won't work now. :-)

Heh, that's amusing ;-)

 t/t5551-http-fetch.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index cb95b95..47eb769 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -158,9 +158,8 @@ test_expect_success 'GIT_SMART_HTTP can disable smart http' '
 '
 
 test_expect_success 'invalid Content-Type rejected' '
-	echo "fatal: invalid content-type text/html" >expect
 	test_must_fail git clone $HTTPD_URL/broken_smart/repo.git 2>actual
-	test_cmp expect actual
+	grep "not valid:" actual
 '
 
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
