From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] Refactoring: connect.c: move duplicated code to a
 new function 'get_host_and_port'
Date: Tue, 16 Feb 2010 16:07:51 -0800
Message-ID: <7vaav8ybag.fsf@alter.siamese.dyndns.org>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
 <0d6d0066fecc892bd5b6afda64e1aa5591347504.1266360267.git.michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:08:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhXSX-0005fM-UT
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 01:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933683Ab0BQAH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 19:07:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933630Ab0BQAH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 19:07:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 917C09A1AE;
	Tue, 16 Feb 2010 19:07:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SUgnmXm5nCmIvUOC+/58bXjrn5w=; b=Fi+DCE
	7g0JfgqN3BVQRyjI1igu6Ngm5wYApTZ6rg+ZPlfjx7lLGa4O6bSm4XaYrlhyutap
	EppurZvDD3YYdJokOx4cWcO92x4gpcCNSEsMmEKipeDVW1qUyJS4iMjclqpmnRhn
	+IE4viHCEtgDUSu2RrYE5UCMqOSmhQLdNmYB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KhmHdk/lSmkA2Tr2k9C0k5P1rXLZzYQe
	K47juynRgkzhFlvrPos1ZlJed6C0US9y2lQ4ZCp0nvZgKKf1WmuBSNje2aCQpEHD
	yNmjuQfz75SX63WXClj5VcUZw0uicE8zUyWG8djijGopejJykLbjB90bPfo5a6ZC
	xTJSBBDYv6s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E4279A1A9;
	Tue, 16 Feb 2010 19:07:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD2D79A1A7; Tue, 16 Feb
 2010 19:07:52 -0500 (EST)
In-Reply-To: <0d6d0066fecc892bd5b6afda64e1aa5591347504.1266360267.git.michael.lukashov@gmail.com> (Michael Lukashov's message of "Tue\, 16 Feb 2010 23\:42\:53 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F7A76D6-1B58-11DF-845E-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140187>

Michael Lukashov <michael.lukashov@gmail.com> writes:

> The following functions:
>
>   git_tcp_connect_sock (IPV6 version)
>   git_tcp_connect_sock (no IPV6 version),
>   git_proxy_connect
>
> have common block of code. Move it to a new function 'get_host_and_port'
>
> Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>

> @@ -170,30 +192,14 @@ static const char *ai_name(const struct addrinfo *ai)
>  static int git_tcp_connect_sock(char *host, int flags)
> ...
> -	if (colon) {
> -		*colon = 0;
> -		port = colon + 1;
> -		if (!*port)
> -			port = "<none>";
> -	}
> +	get_host_and_port(&host, &port);
> +	if (!*port)
> +		*port = "<none>";

Is this version any different from v2?

I expected that at least this one would have been fixed from the older
version.
