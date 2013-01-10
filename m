From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Thu, 10 Jan 2013 14:51:11 -0800
Message-ID: <7vvcb4ejog.fsf@alter.siamese.dyndns.org>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vr4lu3wx7.fsf@alter.siamese.dyndns.org>
 <20130109205116.GA24605@sigill.intra.peff.net>
 <7vehhu3u2y.fsf@alter.siamese.dyndns.org> <20130110001844.GC21054@google.com>
 <20130110112655.GB21993@sigill.intra.peff.net>
 <7vbocw23fq.fsf@alter.siamese.dyndns.org> <50EF380A.9010809@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 23:51:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtQyG-0005WE-Br
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 23:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab3AJWvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 17:51:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168Ab3AJWvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 17:51:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06F14ADAE;
	Thu, 10 Jan 2013 17:51:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iam7J/mwmZFdk70otHmQlY2MG+8=; b=PaAs5J
	ODKGckmgrROn7AN7RZCLv3IXyxE/ee8k9syM9bctVgSJR5GgqVUqKQho4li3xcfW
	EplFQxaWSFF1vBjkWZ5ilq2owEIxvwaagXjCys89eSh7I0taQlXORM/vTZ49+b1n
	4lH5VT5KtQhzrqunnsP3jVS/yRcOHVXNkLuLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cZBdaHURuUaQe2cnWj0kTtAx3ZwqAkzh
	XaH8kEi7rYsxGuvrq0gVjYT+cBAtwyu2QrpfA9LSoczJWT2KWCUAzGMV94/EKoA4
	cGgV/uNfdzkx88a8oLNVaTzZZUhqg88EoJftgcifzjnfHcOi8c+9zzmbSPrwrpIw
	INTA7/jWWVA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF11AADAD;
	Thu, 10 Jan 2013 17:51:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AF77ADAB; Thu, 10 Jan 2013
 17:51:13 -0500 (EST)
In-Reply-To: <50EF380A.9010809@kdbg.org> (Johannes Sixt's message of "Thu, 10
 Jan 2013 22:52:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BF242D2-5B78-11E2-9B0C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213157>

Johannes Sixt <j6t@kdbg.org> writes:

> The interesting cases are when git reads back the output of the command.
> Here, a SIGPIPE death of the child would indicate a bug in git, I think,
> and some diagnostic would be worth it. But we can just as well declare
> that git doesn't have bugs ;)
>
> These are the interesting cases:
> connect.c:640:          conn->use_shell = 1;
>     a connection to a local repository
> convert.c:372:  child_process.use_shell = 1;
>     clean/smudge filter
> credential.c:216:       helper.use_shell = 1;
>     credential helper
> diff.c:4851:    child.use_shell = 1;
>     textconv
>
> All in all, I think the heuristics makes sense.

Fair enough.  Thanks for grepping.
