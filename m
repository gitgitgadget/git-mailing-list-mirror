From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: Properly escape From_ lines when creating
 an mbox.
Date: Thu, 10 Jun 2010 07:49:34 -0700
Message-ID: <7vaar3nds1.fsf@alter.siamese.dyndns.org>
References: <1276045305-20743-1-git-send-email-cworth@cworth.org>
 <7vljaorhjq.fsf@alter.siamese.dyndns.org>
 <87eiggiy8g.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 16:49:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMj4q-0005Q7-V0
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 16:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759295Ab0FJOtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 10:49:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758727Ab0FJOtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 10:49:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1179CBB731;
	Thu, 10 Jun 2010 10:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r7aKU5GF+TVUoUbEmiTJ/cOT8IE=; b=LSFH3t
	/7wSlU2mdV3PBi9PKpo1ovHYyuKQ1PDStOAnbeqwTKaFhG3TO7UwJdVzEGLxN4gq
	IupJeEVNj3Ae+grepTbRfCeUFcPUA+H3cK0i2sbx29ffESD4fuHB1/a08CzPMFEZ
	qVJ4LFINABbG6QPfUSWzM+3aIJ9gduNNB8rHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K2FUnsDDGfcta8YsQI41sWxMebne8V74
	TXxi1oH2HMvvfqj/RGCiH9hEjfmvgJpo0TYylqqDaukX1yxAjJfVMz7/doHqxSeC
	Y9sEmGeSVyUC3kq0bKLjMbW1dvQRz4/QG9nk5ZnC4ZmS2ra1VqEaEvrD9KzAAywy
	ej/HrsZREtA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9847BB72F;
	Thu, 10 Jun 2010 10:49:40 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEF73BB72C; Thu, 10 Jun
 2010 10:49:36 -0400 (EDT)
In-Reply-To: <87eiggiy8g.fsf@yoom.home.cworth.org> (Carl Worth's message of
 "Tue\, 08 Jun 2010 22\:14\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6637D498-749F-11DF-A5B8-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148879>

Carl Worth <cworth@cworth.org> writes:

> On Tue, 08 Jun 2010 20:50:01 -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Carl Worth <cworth@cworth.org> writes:
>> Especially because your implementation quotes lines that begin with "From "
>> unconditionally (even when the tail end of the line would never be a
>> valid-looking timestamp).  Such an output will confuse existing mailsplit,
>> but the worst part of the story is that somebody who is applying a series
>> of patches will _not_ notice the breakage.  The payload of the second and
>> subsequent messages will likely be concatenated as if it were part of the
>> first message, ignoring cruft between patches, but the resulting tree
>> would likely to be the same as what the sending end intended.

Please disregard the above; I wasn't thinking straight.

If your format-patch quotes ">*From " in the log message, and you unquote
it somewhere in mailsplit to mailinfo pipeline, then the only time any
funny interaction between the current git and your git would happen is
when your git formats a commit with a line in its log that begins with
"From " that cannot be a mistaken as a UNIX-From line and you use "am"
from the current git on the output; the resulting commit would get an
extra ">" left in the message, but that is a small price to pay.  There is
no other downside I can see (and the upside is that the output from your
format-patch won't be split incorrectly, of course).

I find that the change to format-patch not to emit the UNIX-From line when
generating one file per commit is somewhat iffy.  An upside is that the
existing mailsplit-mailinfo pipeline already knows not to split such an
input, so the change makes

    git format-patch <revspec> |
    while read path
    do
        git am $path || break
    done

(which is essentially what an old rebase did) do the right thing, even in
the presense of a confusing "From " in the log message.

That change however is not without downsides.  You may potentially be
breaking people's existing scripts in various ways.  They may be relying
on the presense of the line by:

 - using it to pick up the original commit object name from, just like
   "rebase" does;

 - using it as the "magic" number to protect them from being fed a bad
   input;

 - stripping the first line unconditionally, assuming it is that UNIX-From
   line they shouldn't cut and paste into the MUA.

It is nice at the conceptual level, though.  By declaring individual file
RFC2822 message (not mbox), it makes it very clear that it is MUA's
responsibility to quote "From " in the payload when the output is used by
MUA to compose and send a message.  IOW, we shouldn't be doing the quote
in our output when operating in that mode.

Thanks.
