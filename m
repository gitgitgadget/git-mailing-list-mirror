From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] bash: improve aliased command recognition
Date: Tue, 23 Feb 2010 14:11:20 -0800
Message-ID: <7v3a0rd2lz.fsf@alter.siamese.dyndns.org>
References: <20100131191936.GA30466@neumann>
 <cover.1266958460.git.szeder@ira.uka.de>
 <90724961a941edd1317514dea0a1c64112dab61d.1266958460.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Rhodes Clymer <david@zettazebra.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:11:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2yj-0007XG-1o
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 23:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab0BWWLg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 17:11:36 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346Ab0BWWLf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 17:11:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 549939C2AD;
	Tue, 23 Feb 2010 17:11:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Anvt//JUh/U/
	6JGi6+b6ihfdMa8=; b=TDPkvf7xyIgqBuinYKSg40FC449f2VplnRiO48PY8pr6
	S2VbtdgyMEBETiMQwapsSjSbQn80R92QVGQUk2EDfsX1YNhQn4YE1FKTu+bp2Vvp
	f+xDD6gOWwchjTNIdBFfXgWADzzRfkMLlsPQWjkOc5nIrULHS9/GydFWeii0c44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rcCMSH
	PoMnNDbfOxPs6RTuFyTf3jFVJERPyGVGr+SOj2S2f+8xJZtVxwNRYrTtwLQPBjyg
	qMXiijMZSZFYuBmGq7sCRWBskg/bSHCUZuoioIASaG/WqN/QlDKeyz++TgqD4/rQ
	4Pte/ADv48lCigpfgBybRgeviMpw99o+S2MGY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E32539C2A4;
	Tue, 23 Feb 2010 17:11:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E68EB9C2A1; Tue, 23 Feb
 2010 17:11:21 -0500 (EST)
In-Reply-To: <90724961a941edd1317514dea0a1c64112dab61d.1266958460.git.szeder@ira.uka.de>
 ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Tue\, 23 Feb 2010 22\:02\:57
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 637AE0CC-20C8-11DF-83E3-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140854>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> [alias]
>     lgm =3D "!sh -c 'GIT_NOTES_REF=3Drefs/notes/amlog git log \"$@\" =
|| :' -"
>
> The full parsing of a shell command alias like that in the completion
> code is clearly unfeasible.  However, we can easily improve on aliase=
d
> command recognition by eleminating stuff that is definitely not a git
> command: shell commands (anything starting with '!'), command line
> options (anything starting with '-'), environment variables (anything
> with a '=3D' in it), and git itself.  This way the above alias would =
be
> handled correctly, and the completion script would correctly recogniz=
e
> "log" as the aliased git command.

I personally do not think such a heuristic is worth the trouble (both f=
or
writing and maintaining the completion code nor runtime overhead to
iterate over words on the expansion).

I vaguely recall somebody floated an idea to tell completion code that
"you may not know what lgm is, but it takes the same set of options as
log" (either via config or a shell function---I don't recall the detail=
s).
I think that would be a lot more robust, efficient and easy to explain
solution to the same problem.
