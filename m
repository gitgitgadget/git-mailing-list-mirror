From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: More generous accepting of RFC-2822 footer
 lines.
Date: Wed, 28 Oct 2009 00:14:55 -0700
Message-ID: <7vk4yguh00.fsf@alter.siamese.dyndns.org>
References: <20091027234520.GA11433@quaoar.codeaurora.org>
 <20091028000511.GK10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <davidb@codeaurora.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:15:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32kk-00074m-9o
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757527AbZJ1HPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757523AbZJ1HPA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:15:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463AbZJ1HO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:14:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA60969D81;
	Wed, 28 Oct 2009 03:15:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yHF5BkrNmKkB0JRKO6iEfxP/7bs=; b=QYVTLY
	uvlTIXvlL4CuGHep8mKigWuHL4JSwneSrdEW2CwbyEXsPTRqZJRQx/ydLjlRcH63
	P9EdoFCA+BDUbz/Tu7Vg2U/cG5xaStP31lRCjD0d6SvbAJC0SOQ8dHfFly6yg0c+
	iJHBhOovd/3oxh4I479bpVygA8j0g7kco3bYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BGWX2yC98cwD5asT039fKotGq4Qsns24
	H9JPlCzQUvXV4uz0g2FVVD/0hBpvQNITIN22Cl1qH+VcrvJx0IaNAc/nYbZmhar5
	EAFmj9U/7njHHJHcPfpy9oRzV6QribL0gA1eb9kSDs6ixw4gdUPcMRGzdEG9PVdt
	Dcv03KcdcrY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC2FA69D80;
	Wed, 28 Oct 2009 03:15:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9B8D69D7F; Wed, 28 Oct
 2009 03:14:56 -0400 (EDT)
In-Reply-To: <20091028000511.GK10505@spearce.org> (Shawn O. Pearce's message
 of "Tue\, 27 Oct 2009 17\:05\:11 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9B178BC8-C391-11DE-9A45-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131412>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> David Brown <davidb@codeaurora.org> wrote:
>> From: David Brown <davidb@quicinc.com>
>> 
>> 'git commit -s' will insert a blank line before the Signed-off-by
>> line at the end of the message, unless this last line is a
>> Signed-off-by line itself.  Common use has other trailing lines
>> at the ends of commit text, in the style of RFC2822 headers.
>> 
>> Be more generous in considering lines to be part of this footer.
>> This may occasionally leave out the blank line for cases where
>> the commit text happens to start with a word ending in a colon,
>> but this results in less fixups than the extra blank lines with
>> Acked-by, or other custom footers.
>
> The nasty perl I use in Gerrit's commit-msg hook is a bit more
> expressive.  Basically the rule is we insert a blank line before
> the new footer unless all lines in the last paragraph (so all text
> after the last "\n\n" sequence) match the regex "^[a-zA-Z0-9-]+:".

Together with your suggestion for tests, the above makes quite a lot of
sense to me.

There is one thing to be careful about.

When deciding to omit adding a new S-o-b, we deliberately check only the
last S-o-b to see if it matches what we are trying to add.  This is so
that a message from you, that has my patch that was reviewed and touched
up by you with your sign-off, i.e.

	S-o-b: Junio
        S-o-b: Shawn

will not be prevented to have another sign-off by me, so that I can
certify that I know that your change I received from you in the patch is
kosher.  IOW, this is not a "duplicate" check.  The order of S-o-b:
matters as it records the flow of the patch.
