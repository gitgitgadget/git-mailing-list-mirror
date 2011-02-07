From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: [PATCH v4 5/5] mingw_rmdir: set errno=ENOTEMPTY
 when appropriate
Date: Mon, 07 Feb 2011 13:54:35 -0800
Message-ID: <7vk4hbtsro.fsf@alter.siamese.dyndns.org>
References: <20101214220604.GA4084@sandbox>
 <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com>
 <7vmxo6pxyi.fsf@alter.siamese.dyndns.org>
 <20110207204818.GA63976@book.hvoigt.net>
 <20110207205400.GF63976@book.hvoigt.net>
 <AANLkTin6A-HVKvM9_5ggMezpM--tt1qUwSXF+CEaXg7J@mail.gmail.com>
 <20110207211844.GH63976@book.hvoigt.net>
 <AANLkTi=ntgYOW58pPnt-azMw6rFZfJjDW3OaCgLsvJp6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 07 22:55:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmZ33-0005v0-1n
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 22:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010Ab1BGVy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 16:54:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab1BGVy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 16:54:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D96864996;
	Mon,  7 Feb 2011 16:55:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Swk7jS1WwQAW7ZgcO4BONDfZmpI=; b=HmwgZ2
	zLcwLY1cgC2la/osfZOrPZefAeTGcEJnWpVz0FjooKwWoPSTIHlgFFoYPIu4CRG9
	NoY34r0W9Y2jkqVv7vwvPuR7GzpAcO4qGJ+VwyGQv0MR9JpHKVDxGaE+G/8Ejvle
	FeDCeWAR0d8hPkP9TmZ1OJrGEjNo6dM5VQ0OM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ppzKHTqbwSIki7LOQcyUioG8Y5T1ZzOh
	3+a9txf1DZ4BkFnpMCcZXCRth6CdVtlPAwfu0Kavhq/WkH5uJnvkChLl3+oWemca
	ztSrS0OF+kyGdGtZOurkyr2nN4obXjQ6WVzLRC0MLLFyN5aGKFBsoz53fvR/G3cb
	bzWZwYIWCsw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 663504995;
	Mon,  7 Feb 2011 16:55:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D44E24994; Mon,  7 Feb 2011
 16:55:34 -0500 (EST)
In-Reply-To: <AANLkTi=ntgYOW58pPnt-azMw6rFZfJjDW3OaCgLsvJp6@mail.gmail.com>
 (Erik Faye-Lund's message of "Mon\, 7 Feb 2011 22\:23\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03DCC5A4-3305-11E0-BDFA-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166303>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Mon, Feb 7, 2011 at 10:18 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> ...
>> I think Johannes was referring to the case when a directory is busy.
>> E.g. a process is running that has its working directory inside that
>> directory. In that case ENOTEMPTY was not returned even though the
>> directory is not empty. Thats what I read from the patch.
>
> I don't think that's the case either:
> $ echo "int main() { while (1); }" | gcc -x c - -o foo/bin.exe
> [kusma@HUE-PC:/git@work/xgetenv]
> $ foo/bin.exe &
> [2] 3188
> [kusma@HUE-PC:/git@work/xgetenv]
> $ ./a.exe
> rmdir: Directory not empty
> errno: 41 (expected 41)

I don't do windows, but I think Heiko is talking about running some
process inside the directory that is getting removed.  Assuming that your
a.exe is to remove the 'foo' directory, you would need to run ./bin.exe
after going into 'foo' directory, perhaps like this:

    $ (cd foo && ./bin.exe) &
    $ ./a.exe
