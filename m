From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: Provide an empty file when no base exists
Date: Thu, 19 Jan 2012 23:37:13 -0800
Message-ID: <7vy5t2g6za.fsf@alter.siamese.dyndns.org>
References: <7vhazqhn8u.fsf@alter.siamese.dyndns.org>
 <1327043453-80965-1-git-send-email-davvid@gmail.com>
 <7v7h0mhm8g.fsf@alter.siamese.dyndns.org>
 <CAJDDKr490XFqGe+y1pa7fnNhPMRE3ZR3=A+_XNUrCA1GZv+wkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jcwenger@gmail.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 08:37:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro92I-0001my-9M
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab2ATHhS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 02:37:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab2ATHhQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 02:37:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C187E298C;
	Fri, 20 Jan 2012 02:37:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fjgG4YEVciWO
	YnFM7XSCXB9E7hY=; b=SeN+GMbpw0ai9iH+xUnCUZme0qmZecPauJuk+Ido92rS
	GmzJMWmZulrj745zJ8moTuZSIdnXyn4Gg8fHgttMaqLQqVyaHK18/KhCFU54vW+3
	lwdIe6ZSf3hIDZ/aDTLn9XjnTcQ9umx0LCR//e/b/hlKDZ/20bTVkxPsnxnYOG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mOkI+T
	/j4vFKh9e3iQw937B6GLqcm9lWLo+lDMoncBkRIZeKOzR90lA2RU6X64lYdc/cTJ
	PBpXFgx16qFFzXARVGSb2aa52aB7D8VvzoJ3YU94S9+uzHDqUhdTFnCUYdmvbIXM
	QBCBU/6eo2y90746O9zV4AXeKrmq6lG9rXeV4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B96A6298B;
	Fri, 20 Jan 2012 02:37:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 495BC2989; Fri, 20 Jan 2012
 02:37:15 -0500 (EST)
In-Reply-To: <CAJDDKr490XFqGe+y1pa7fnNhPMRE3ZR3=A+_XNUrCA1GZv+wkw@mail.gmail.com> (David
 Aguilar's message of "Thu, 19 Jan 2012 23:26:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92CFCDD4-4339-11E1-BA08-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188864>

David Aguilar <davvid@gmail.com> writes:

>>> =C2=A0 =C2=A0 =C2=A0local_present =C2=A0&& checkout_staged_file 2 "=
$MERGED" "$LOCAL"
>>> =C2=A0 =C2=A0 =C2=A0remote_present && checkout_staged_file 3 "$MERG=
ED" "$REMOTE"
>>
>> Sorry to be ping-pong-ing like this, but wouldn't we have a similar =
issue
>> when LOCAL or REMOTE does not exist (e.g. "they modified, we removed=
")?
>
> Yes.  I'll have a [PATCH v3] soon.

It almost makes me wonder if the obviously simplest change to make
checkout_staged_file create an empty file when the asked-for stage does
not exist, i.e.

	checkout_stage ()
        {
		if test -n "$1"
                then
			... whatever checkout_staged_file() does ...
		else
			>"$4"
                fi
        }

	checkout_stage $base_mode 1 "$MERGED" "$BASE"
	checkout_stage $local_mode 2 "$MERGED" "$LOCAL"
	checkout_stage $remote_mode 3 "$MERGED" "$REMOTE"

Or even:

	checkout_stage ()
	{
		tmpfile=3D$(...)
                if test $? -eq 0 -a ...
                then
                	mv -- "$(git rev-parse ...)"
		else
			>"$3"
		fi
        }

	checkout_stage 1 "$MERGED" "$BASE"
	checkout_stage 2 "$MERGED" "$LOCAL"
	checkout_stage 3 "$MERGED" "$REMOTE"

as the current checkout_staged_file() does not seem to check errors in =
any
meaningful way.
