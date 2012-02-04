From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t0300: use write_script helper
Date: Fri, 03 Feb 2012 22:58:06 -0800
Message-ID: <7vd39vjda9.fsf@alter.siamese.dyndns.org>
References: <20120204062712.GA20076@sigill.intra.peff.net>
 <20120204063018.GB21559@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 07:58:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtZZf-0007UT-9h
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 07:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709Ab2BDG6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 01:58:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab2BDG6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 01:58:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28274351D;
	Sat,  4 Feb 2012 01:58:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VufRCOmDNaulzDNG3mcc9JV0kFw=; b=ZIw6RC
	0P9ylhzmsT6IN4YxakFB+NvbhDXAkucykCB7Zoo0bBH+yTFx++Yf+07OzbZIWJ2M
	qSssj2TMup8hNHFtHZcK2UdgeKLNF5GcA7Bivm+Q1uJKmosi7TNAlglj8D42EEcD
	tXyWsLsuvo67IcS3lqqV5G7cInWRi1OS1AWd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JfRBvWvq00C11we8xoWiqa2Sd6Lezl1/
	TMh7z5yjT4JB8hTsBYcYUmp+e3afjR2yxh1Lk8pDL3ciu9W3BDSdluT53V4Pus+X
	G9JJHTMH1ueHjpH0xTE6lAXrzci6IMO9EjDOaG5JTar/0hg4KPuguKxRZyKKSiU9
	YSlhI6HLwoM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C9C2351C;
	Sat,  4 Feb 2012 01:58:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 971563518; Sat,  4 Feb 2012
 01:58:07 -0500 (EST)
In-Reply-To: <20120204063018.GB21559@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 4 Feb 2012 01:30:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97AE7524-4EFD-11E1-909C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189854>

Jeff King <peff@peff.net> writes:

> t0300 creates some helper shell scripts, and marks them with
> "!/bin/sh". Even though the scripts are fairly simple, they
> can fail on broken shells (specifically, Solaris /bin/sh
> will persist a temporary assignment to IFS in a "read"
> command).
>
> Rather than work around the problem for Solaris /bin/sh,
> using write_script will make sure we point to a known-good
> shell that the user has given us.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This works fine on my Linux box, but just to sanity check that I didn't
> screw anything up in the whopping 5 lines of changes, can you confirm
> this fixes the issue for you, Ben?
>
>  t/t0300-credentials.sh |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index 885af8f..0b46248 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -14,14 +14,13 @@ test_expect_success 'setup helper scripts' '
>  	done
>  	EOF
>  
> -	cat >git-credential-useless <<-\EOF &&
> +	write_script git-credential-useless <<-\EOF &&
>  	#!/bin/sh

An innocuous facepalm I'd be glad to remove myself ;-)

>  	. ./dump
>  	exit 0
>  	EOF
> -	chmod +x git-credential-useless &&
>  
> -	cat >git-credential-verbatim <<-\EOF &&
> +	write_script git-credential-verbatim <<-\EOF &&
>  	#!/bin/sh

But other than that, looks good.

>  	user=$1; shift
>  	pass=$1; shift
> @@ -29,7 +28,6 @@ test_expect_success 'setup helper scripts' '
>  	test -z "$user" || echo username=$user
>  	test -z "$pass" || echo password=$pass
>  	EOF
> -	chmod +x git-credential-verbatim &&
>  
>  	PATH="$PWD:$PATH"
>  '
