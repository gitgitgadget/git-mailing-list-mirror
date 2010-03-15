From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH] grep: enable threading for context line printing
Date: Mon, 15 Mar 2010 10:14:02 -0700
Message-ID: <7vpr35se1x.fsf@alter.siamese.dyndns.org>
References: <4B9D2864.9090808@lsrfire.ath.cx>
 <4c8ef71003141303h474429aegc0a2eb2f97e7ff69@mail.gmail.com>
 <4B9E5E76.9000702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 15 18:14:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDsZ-00049n-9Z
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965520Ab0COROR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 13:14:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965514Ab0COROK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 13:14:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67088A260E;
	Mon, 15 Mar 2010 13:14:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=hLZ9N1XoJJitEXAHvq8bmpc4N
	Eo=; b=XtjQh2TQzUmUopmJ2znbrNCJzFqe0OvddhjrG9ueg7WggeYp+4dVKHJcb
	Ga/92pL+e2wWAI+nQd3KFeJWuhl3aWiUvFc3O2PEy5nZCQ5sI1EE4Btbb7iH84hw
	NFavwwJKyct9l1Lz4Nl1Kj8zKh9KQ6+d5mSaTOhMToeKlMTm1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=RaD2XDhhzvPw9MwsxzW
	74ORsflCjVYCcZsh8/4FYL/FQJ2P/JdFmbW8lE8YRBdDPPkdX+4W5amdRjhL8Nvy
	LNLVKlXF1vlnQTNh5mET9ZJckuh1scAxE5slBkHkjP6GCf6/R510eJKkcGrIGLSS
	wlkDEh4S4Sfx0fC/IN4FdBnw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36008A2606;
	Mon, 15 Mar 2010 13:14:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F260A2605; Mon, 15 Mar
 2010 13:14:03 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 29DAA72E-3056-11DF-BD0A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142225>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> Symbolic constants for the magic values 0, 1, and 2 would make the
>> code more readable.
>
> Yes, that was a bit too complicated.  I shuffled the code around a bi=
t,
> so the patch is now a bit smaller and avoids introducing value 2 for
> show_hunk_mark.  Better?

I guess.

I still cannot shake off this nagging feeling that the complication mai=
nly
comes from the way threaded support was written as if the control flow =
is
the same as that of the single-threaded implementation (e.g. grep_objec=
t()
and friends are called from a one-path-at-a-time loop and pretend as if
they have returned some meaningful results indicating they have found a
match), and the logic may become more clear if the flow was restructure=
d.

But I haven't tried, so I dunno.  Your patch does not make the situatio=
n
worse, and looks like the right thing to do at the moment.
