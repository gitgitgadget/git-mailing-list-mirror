From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/13] credentials: add "cache" helper
Date: Mon, 28 Nov 2011 16:42:00 -0800
Message-ID: <7vr50ru5d3.fsf@alter.siamese.dyndns.org>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110710.GH8417@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 29 01:42:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVBlz-0001cx-GZ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 01:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047Ab1K2AmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 19:42:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33031 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab1K2AmE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 19:42:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 139D46237;
	Mon, 28 Nov 2011 19:42:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D25DQYMV5YSbmO2ekWtAicfzH3w=; b=UnKBa0
	V4ZGM88HKlMPsxrd+cMgXXnWvo79/h2/HHXpix71sY7p0xUHluCROCbbfaepzE91
	PNuX9ms4ShIegGm6J97gFfuc7XulLywx1XDyfIo4n8WV90/69/UhSDk/IqTwxbkk
	JEcFHTw4yVXgdt/BZ2HravuLZsRWqU6YlHZZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kudqh0aF8toTsZBn/a8vv0obOB4rXnVD
	uDXhHbF6JXvFejy58mhGExOEpdCtFKQ2EBMtfsFLNaLSS/F2usG7g2Zi+/5qqBsL
	j1efHFYV7kflsC+AfbUADjv34adGPxFaPCXYdNgKUquEMs9dJtZPyYYo9ZVbpZgC
	PLrfpZ+NuHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C04C6236;
	Mon, 28 Nov 2011 19:42:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 690756235; Mon, 28 Nov 2011
 19:42:02 -0500 (EST)
In-Reply-To: <20111124110710.GH8417@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Nov 2011 06:07:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F41A598C-1A22-11E1-9A32-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186040>

Jeff King <peff@peff.net> writes:

> diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> index 54ae1f4..ac54b38 100755
> --- a/t/lib-credential.sh
> +++ b/t/lib-credential.sh
> @@ -21,6 +21,225 @@ read_chunk() {
> ...
> +	test_expect_success "helper ($HELPER) can forget user" '
> +		check reject $HELPER <<-\EOF &&
> +		protocol=https
> +		host=example.com
> +		username=user1
> +		EOF
> +		check fill $HELPER <<-\EOF
> +		protocol=https
> +		host=example.com
> +		username=user1
> +		--
> +		username=user1
> +		password=askpass-password
> +		--
> +		askpass: Password for '\''https://user1@example.com'\'':
> +	'

Missing EOF for here document; I fixed this already in 'pu', but please
squash it in when rerolling after 1.7.8 final.
