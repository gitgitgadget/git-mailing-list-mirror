From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 6/6] Make --color-words work well with --graph
Date: Fri, 28 May 2010 18:10:46 -0700
Message-ID: <7viq675x7t.fsf@alter.siamese.dyndns.org>
References: <1274858637-13243-1-git-send-email-struggleyb.nku@gmail.com>
 <1274858637-13243-2-git-send-email-struggleyb.nku@gmail.com>
 <1274858637-13243-3-git-send-email-struggleyb.nku@gmail.com>
 <1274858637-13243-4-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 03:10:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIAZn-0005RO-0P
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 03:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992Ab0E2BK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 21:10:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab0E2BKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 21:10:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47FE6B77B7;
	Fri, 28 May 2010 21:10:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=eInziLMtAyTOEd5lLIcUpJvqO+c=; b=Cn8B/VKhz9/WhcasyEYA9ek
	iIdIZL9JPvdsZr+cdzssuzQOMWjQrUjC1pWCApAEfUeK3x4wCkT8B13B5XA2qBih
	C5oAeWWe5mTC3jyeEkRA8fBiHCp8EpEaJOsn51OjS1z/UIhoLiw7P2LXezj8LLed
	lpiBz3L9mL3sxiZcCQn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OflHwUV61imVKNPBrC5OR8lkEuKVWHyXzMl44WaS1FuKPmy6R
	bREAiMn94tq+fkRAilOsYSYydDcv3vwDUPYRc2wX/KsGg65tdylD1WvHr2SrSDBb
	wuvDvi3iZyg36EqKC11gPtAJGoMkqujsfQIWPtZQaDrppeui00HpuhKPyA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 081E4B77B5;
	Fri, 28 May 2010 21:10:52 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23747B77B3; Fri, 28 May
 2010 21:10:47 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 06370710-6ABF-11DF-B680-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147944>

Bo Yang <struggleyb.nku@gmail.com> writes:

> '--color-words' algorithm can be described as:
>
> 1. collect a the minus/plus lines of a diff hunk, divided into minus-lines and plus-lines;
> 2. break both minus-lines and plus-lines into words and place them into two
>    mmfile_t with one word for each line;
> 3. use xdiff to run diff on the two mmfile_t to get the words level diff;

Please wrap lines at reasonable length, and indent bulleted lists like
this a bit from the left, with a blank line between each item, like this:

|'--color-words' algorithm can be described as:
|
|  1. collect a the minus/plus lines of a diff hunk, divided into
|     minus-lines and plus-lines;
|
|  2. break both minus-lines and plus-lines into words and place them
|     into two mmfile_t with one word for each line;
|
|  3. use xdiff to run diff on the two mmfile_t to get the words level
|     diff;
|
|And for the common parts of the both file, we output the plus side...
| ...
|For '--graph' to work with '--color-words', we need to output the
|graph prefix on each line of color words output. Generally, there are
|two conditions on which we should output the prefix.
|
|  1. diff_words->last_minus == 0 &&
|     diff_words->current_plus == diff_words->plus.text.ptr
|
|     that is: the plus text must start as a new line, and if there is
|     no minus word printed, a graph prefix must be printed.
|
|  2. diff_words->current_plus > diff_words->plus.text.ptr &&
|     *(diff_words->current_plus - 1) == '\n'
|
|     that is: a graph prefix must be printed following a '\n'.

Same thing for the in-code comments; it would probably be easier to read
if you made a small helper function (that a compiler would inline for you)
that decides if you would want to show the line_prefix, and make that big
comment a comment to that helper function.
