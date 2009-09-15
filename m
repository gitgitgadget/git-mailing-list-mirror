From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git crashes on pull
Date: Tue, 15 Sep 2009 15:54:19 -0700
Message-ID: <7vzl8v4y5g.fsf@alter.siamese.dyndns.org>
References: <alpine.LSU.2.01.0909152044450.10936@bianca.dialin.t-online.de>
 <7vljkg57xs.fsf@alter.siamese.dyndns.org>
 <alpine.LSU.2.01.0909160022430.24554@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Sep 16 00:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mngv4-0001zZ-JQ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 00:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbZIOWye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 18:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757498AbZIOWyb
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 18:54:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbZIOWy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 18:54:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E519134911;
	Tue, 15 Sep 2009 18:54:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tvsYkMzY3DB5o87onObKLWPaiz4=; b=bESw4Z
	EH+pXn9UujZMBSevnuqcqvoalmy1tp0UmN4Rg1pBoAbCsZZZgoBkDkxSrIDDz2t/
	6Ci3oM64oUuWb8T7YDytgeeDarAWu13IAnEk5OVyJ++KvHHw8xIKhXKo+vOJXzUr
	LwWWWfhmSMWrpLdkgvC7UluSBA66fX34EOvDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nlfIbbIkDS2RfPxEuZ6EDNKjp6h6TCTY
	nM8cVnPMdxjo2ZQ9WOaK2VCuS6u4AwGznyOrgVfHhqdgJd4rmMl/O417yIIexx90
	+H5KyjlylE5B5R6DtZeI4xSI3HmVzN82dTZgML9/l+lt7ee4uIFHmjIz2Q060zLe
	aVbW0ZilKUQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BCE9E34910;
	Tue, 15 Sep 2009 18:54:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ECDA3490B; Tue, 15 Sep
 2009 18:54:20 -0400 (EDT)
In-Reply-To: <alpine.LSU.2.01.0909160022430.24554@bianca.dialin.t-online.de>
 (Guido Ostkamp's message of "Wed\, 16 Sep 2009 00\:30\:16 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B6E59E0C-A24A-11DE-B243-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128593>

Guido Ostkamp <git@ostkamp.fastmail.fm> writes:

> On Tue, 15 Sep 2009, Junio C Hamano wrote:
>
>> Please try this patch, which I have been preparing for later pushout.
>>
>> From: Junio C Hamano <gitster@pobox.com>
>> Date: Mon, 14 Sep 2009 14:48:15 -0700
>> Subject: [PATCH] http.c: avoid freeing an uninitialized pointer
>>
>> An earlier 59b8d38 (http.c: remove verification of remote packs) left
>> the variable "url" uninitialized; "goto cleanup" codepath can free it
>> which is not very nice.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Appears to be working ok now, thanks.

Thanks.

The sad part of the story was that this regression was introduced by a
change to work around recent breakage observed when fetching from the http
server github runs, and it was the primary purpose of pushing 1.6.4.3 out.

Now we need to cut a 1.6.4.4 with this fix-on-fix soon, like tomorrow.

> BTW: Is there any way to easily invoke GDB in case of such a problem
> to get a real symbolic stack backtrace?
>
> I tried it on the 'git' binary, but of course this didn't work because
> it invokes a git-pull script which again runs another git-remote-curl
> binary.

Not very easily.  The best you can do is to run with GIT_TRACE to see what
command actually dies and run that binary directly.  gdb can choose to
follow either parent or child across forks, but I do not know how to tell
it to follow across execs into a different binary.
