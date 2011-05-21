From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/11] streaming: a new API to read from the object
 store
Date: Fri, 20 May 2011 18:49:41 -0700
Message-ID: <7v1uzs256y.fsf@alter.siamese.dyndns.org>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-7-git-send-email-gitster@pobox.com>
 <4DD6F3C0.4060107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat May 21 03:50:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNbLF-0001w6-1M
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 03:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472Ab1EUBtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2011 21:49:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1EUBtt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2011 21:49:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1C1849EC;
	Fri, 20 May 2011 21:51:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=7jfvcQ2sh53H1PH4HvI30PK7t
	j4=; b=g2hI7ybCmWo4hqOydkbAleSMARO8KC/16hXJ8a3bxEthS4LnEY9RGGmJY
	olnhcyqspEs0Eb2vjN8IbXNwaJIhjJKAUl5NecY1+3TYOYowsmf3sak0GSOyFdUm
	Wq0kjiPgEJSNlP9M2uYb9nj84bjWU8Ke+0Gkm/KpoKDnqAEegc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=q5w55Im4zZ3oxZq9lvJ
	s8rlEdBzauR9w/bZPJ9kmENXdJCGDZip6eZetiONuRtz/xHSOsJCLmvrzTJIAjD8
	L4dRjRQDUIK9FXcqkjISA5LiTYRd57U3imH01+vBVWYe/cc2QI4/PjgPRQbGhd5b
	DMpLDfM1vgvBHe/y/GHjBLmo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 80A4C49EA;
	Fri, 20 May 2011 21:51:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A6BFB49E9; Fri, 20 May 2011
 21:51:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6D3255A-834C-11E0-9277-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174088>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> +#define read_method_decl(name) \
>> +	ssize_t read_istream_ ##name \
>> +	(struct git_istream *st, char *buf, size_t sz)
>
> It would be nice if those macros could be got rid of once the interfa=
ce
> stabilizes.

Probably, but not while it is still in flux in 'pu'. I already had to
tweak something to support my unpublished series I was working on today=
=2E

>> +struct git_istream {
>> +	enum input_source source;
>
> source seems to be write-only.

Yes, I had this initially but later ended up with a design that makes
everything go through vtbl, so this is only useful for debugging and ca=
n
be removed.

Thanks.
