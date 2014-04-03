From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in git-diff output
Date: Thu, 03 Apr 2014 11:10:19 -0700
Message-ID: <xmqqeh1eqo6s.fsf@gitster.dls.corp.google.com>
References: <CALgQ2n-vPK6_0LnWA_AAD2GLvepjLN4A3UZFCAWzEp9r_=XOVg@mail.gmail.com>
	<CALgQ2n9VXVpqXe1NQO4+b-Ngmbhxnza52GJqr81t_ubLfjY75g@mail.gmail.com>
	<vpqmwg4c4q8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "rocketscienc01100101 ." <rocketscienc01100101@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 03 20:10:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVm5u-0001U7-SE
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 20:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbaDCSKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 14:10:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbaDCSKX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 14:10:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF92C7A50C;
	Thu,  3 Apr 2014 14:10:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+X8gLvJ8sImjD4ORwg9DwO+J6zQ=; b=ftlblI
	jfsquNWaDr+hwJ5In1fV1ltLVXyVI24nzcrlE9QulYR2/6Vr/lcLa99OV3v9hhMm
	Lh4c+AnGGO4TifNh8x6hT7MId1YMzJ6iHdpHzTyG8wlRJKVqjaOTJqUwBqVFGBWJ
	dIexVX9wvmkWGThiQSnIRAOKbtVB1PTCqlG20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KMq39ojIx8zA5YJ5qjn+Uh6usMPE0XNY
	lIxC2bpnjbZJiCq9i3OC1FLZ2rZLoN0mVz5SjUUfRQQy3r3PZ0ROjDf+pjyxqNd5
	Woq3+EJXBEyDrLLWfEyIVXMCF3jb0E91riT3Wh7ajo4Rzn8j+Yc7rUmaZrROdtgZ
	+v2/0AHoGNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F0807A50B;
	Thu,  3 Apr 2014 14:10:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C22817A509;
	Thu,  3 Apr 2014 14:10:21 -0400 (EDT)
In-Reply-To: <vpqmwg4c4q8.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	02 Apr 2014 14:09:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 38A56F48-BB5B-11E3-B9BC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245744>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> "rocketscienc01100101 ." <rocketscienc01100101@gmail.com> writes:
>
>> http://i.imgur.com/BoJSjm9.png
>>
>> Here's a screenshot that shows the problem.
>
> (better cut-and-paste the text than sending a PNG image)
>
>> There's always a misplaced line in the output (most of the time
>> a[href^=tel] { }), no matter where in the file the changes are.
>
> The part after the @@ are ignored by patch tools. They are here just for
> convenience. They are a guess of what the patch hunk belongs to. For
> C/Java/Ada/... programs, it's the function name. Git does not know about
> CSS syntax, so it guesses wrong (last line starting with a letter I
> guess, not sure exactly what happens when Git doesn't know the syntax).

Ask "git grep -A14 'long def_ff' xdiff/" for details ;-)

This was an attempt to be compatible with stock behaviour of GNU
diff: a line that begins with an alpha, _ or $.

>> Sometimes it's even in the wrong position, above the @@ numbers.
>
> That is strange. Do you have a way to reproduce this?

That indeed is unusual.  If the payload that was identified by the
find_func function has a funny escape sequence or something, you may
get funkiness like that in the output on the terminal, which we may
want to take notice and sanitize in xdl_emit_hunk_hdr(), instead of
straight memcpy() there, but I do not see how that would be an issue
in a css source.
