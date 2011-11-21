From: Junio C Hamano <gitster@pobox.com>
Subject: Re: clean bug on ignored subdirectories with no tracked files?
Date: Mon, 21 Nov 2011 11:28:34 -0800
Message-ID: <7vty5xff6l.fsf@alter.siamese.dyndns.org>
References: <CAG+J_Dxw00e_cr7i3R9DAbTrqZvJHYk2yeUa=xGKh+Zqqmp-SA@mail.gmail.com>
 <7vy5vbj4rb.fsf@alter.siamese.dyndns.org>
 <CAG+J_DwKeWntmi22vHS6CRud6Lo0P_+D5u5ih2Bbc50ekYji5w@mail.gmail.com>
 <7vy5v9fgel.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 20:28:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSZXl-00029G-UU
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 20:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab1KUT2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 14:28:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56612 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803Ab1KUT2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 14:28:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2769461B;
	Mon, 21 Nov 2011 14:28:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y4jPtzcMxzby6Lt6RX1zCPwo6vI=; b=sLZe6N
	5dGrLqJ7OQ/2Djb8hDrvnwoVmOtlL/TVSvjO4tjyOncOx9OcPpF9k1vKP654r1rG
	d6oiHP/IGJ4G43lCjnppKfi2EBIidoWBCPKrfWBs3dsRWZPGSBPKoDC326RIkV2+
	pEGA1LGHHZYo7Dju+cczVt93p8rTT4Eab/1vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TjQCZI8e2qK8RgLJHgAqw2IaD8ec0mj8
	Ls7rAbxic2y9l7wqBviWu2STlx+42dLoHb/1s7PIYUQYh1Kdj/3iLkJH9XgRCLnB
	Y7catI6/8M98SWNaDfSH3aBzGzhTY1pIb4zg4BhzEe/kiHPQn+g4yZoQA/Nlv/Pf
	1wZDHnwLVwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA38F461A;
	Mon, 21 Nov 2011 14:28:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 790CB4619; Mon, 21 Nov 2011
 14:28:35 -0500 (EST)
In-Reply-To: <7vy5v9fgel.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 21 Nov 2011 11:02:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0167B19A-1477-11E1-A6C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185759>

Junio C Hamano <gitster@pobox.com> writes:

> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> Just because it is uninteresting to git does not mean that it isn't
>> precious.
>
> That statement is false with the versions of Git so far. See the other
> thread for the current status and possible future directions.

Oops, sorry, I was really confused. You are right that "ignored" for
"clean" does not mean "they are not tracked and should be removed". That
would result in removal of build artifacts '*.o' and unnecesary
recompilation.

What "precious" means is a bit different, however. With verisons of Git so
far, what "ignored" means is that they are not tracked, and _can_ be
removed when needed to complete normal Git operations. When checking out
another branch that has a tracked file at the same path as an untracked
and ignored file in your current branch, removal of that ignored file is
necessary to complete the checkout, and for that purpose, the ignored file
is considered expendable. And we do not have a concept of "precious",
unexpendable but untracked file, nor a way to specify that to gitignore
mechanism (which is the topic of the other discussion thread).

"clean" without "-x" is meant to preserve untracked but expendable paths
(e.g. build products), so if something is removed that is untracked but
matches the ignore pattern, then that is a bug to be fixed.  Care to roll
a patch to fix it?

Sorry for the confusion, but as I said, I do not use (hence nor care much
about) "clean" myself, so...
