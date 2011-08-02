From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Diff patterns for POSIX shells
Date: Tue, 02 Aug 2011 10:51:56 -0700
Message-ID: <7vzkjrem6b.fsf@alter.siamese.dyndns.org>
References: <1312195069-10782-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1312195069-10782-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 19:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoJ8P-0005gD-AP
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 19:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab1HBRwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 13:52:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330Ab1HBRv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 13:51:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 575B43872;
	Tue,  2 Aug 2011 13:51:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OMYvxCMHLTKYPq7TmqFkITiArWE=; b=KHU9d7
	amlku2cWz1F/akswqA6X3yUhkwjzhfGGVyr3/i6BW3XKpAgktmNfobCe+vrSTT2k
	obVZ+5SkVUb0teeM529zqoHD5Ki4kKs4ZQKJ+Mh+M+2n5GAgLmwPXPYItoROwTvk
	mWoRoxbvS324i8FDtI7EXka5/TIkUxicWouGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xj9Z8KaK2uYLuWxlFKBmQ8EfrVBizxcU
	cfy2h4MENsvTXM7RIHkzUcLLCE/fJBsDclrIved3Kaj4dYUr5K0+LINwvtSP3xJM
	bWns1vKM1tXr6GxNdpn++Ny29sZQgY/MUsaqsCdffHL331TBbPLkmQ+omQxObRvA
	zhkKPC72Tbw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F47E3871;
	Tue,  2 Aug 2011 13:51:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2DF53870; Tue,  2 Aug 2011
 13:51:57 -0400 (EDT)
In-Reply-To: <1312195069-10782-2-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Mon, 1 Aug 2011 12:37:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DD0FBAA-BD30-11E0-AAD3-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178489>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> All diffs following a function definition will have that function name
> as chunck header, but this is the best we can do with the current
> userdiff capabilities.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  userdiff.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/userdiff.c b/userdiff.c
> index 01d3a8b..70120c3 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -107,6 +107,9 @@
>  	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
>  	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
> +PATTERNS("shell", "^[ \t]*([a-zA-Z_0-9]+)[ \t]*\\(\\).*",
> +	 /* -- */
> +	 "(--|\\$)?[a-zA-Z_0-9]+|&&|\\|\\|"),

Hmm, what is this "double-dash -- might be present before a name" about?

>  PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
>  	 "[={}\"]|[^={}\" \t]+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
