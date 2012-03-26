From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] grep: add more information to hunk separators
Date: Mon, 26 Mar 2012 11:01:21 -0700
Message-ID: <7vobrjp7gu.fsf@alter.siamese.dyndns.org>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
 <4F709664.1060206@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:01:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEEV-0001xk-PY
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230Ab2CZSB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 14:01:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933184Ab2CZSBZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 14:01:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B22C572BF;
	Mon, 26 Mar 2012 14:01:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wHijae/9krBC
	BRnyo/kiau2Jg2Y=; b=TKNYNdtlf3ew+lavCg/uF8OlLifSNJRKyKI2i3ykBCTx
	UyY4p6H8MdLniBltw4VI/M/klpgdYaftnafnMwGvIRyVZWMtR6hr9toi7VIf3od2
	4+aVil+T+GD4UsPCapNiWzilXe5An54uKzDn1SEznOq/P6sD2P2QuymziggipKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RbhTe8
	fB5o1Lr3NDxqYYC1mGLxxnAUigDTAl72AJYWM45ylz7mjhoTufRedbAy5R79MqQY
	rVPihvHHohfQn4irphDJDAFnJI8axpCnIqk+4OJQ2lzbJzshl3FQ7nVT/jwc8Ryo
	mGEXuFVVEcaxLT1IhB5IBUfvzJVGPSNZRo+hU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A968372BE;
	Mon, 26 Mar 2012 14:01:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3ECAE72BC; Mon, 26 Mar 2012
 14:01:24 -0400 (EDT)
In-Reply-To: <4F709664.1060206@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 26 Mar 2012 18:16:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B364A3FE-776D-11E1-9A2A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193942>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Looking at the above, I thought: We have unified diffs between two
> files, we have combined diffs between more than two, what about
> showing grep results as one-sided unified diffs?  ("What's the sound
> of one hand clapping?" :-)
>
> 	--- a/git.c
> 	@ -570,3 @ int main(int argc, const char **argv)
> 	-		printf("usage: %s\n\n", git_usage_string);
> 	:		list_common_cmds_help();
> 	-		printf("\n%s\n", git_more_info_string);
>
> Pro: Generalization of an established format for showing interesting
> parts of a file.  Less duplication of meta-information.  Markers that
> tell us the kind of the shown lines are kept ("-" for context, ":" fo=
r
> matches).  Machine parsable.
>
> Con: Why the "a/" prefix?  One-sided diffs, srsly?

Cute, and I tend to agree that this is probably easier to read if you a=
re
used to reading unified diffs.

Wouldn't it make more sense to replace your '-/:' with ' /=3D', so that=
 at
least ' ' SP retains the meaning of "this is shown merely to give you
context, it is not a proper part of what you are looking for"?

The reasoning behind '=3D' is that it is not either -/+ as we are not r=
eally
comparing anything with anything.  It may also make sense to replace th=
e
per-file header line with "=3D=3D=3D git.c" to be consistent.  I haven'=
t formed
an opinion on the prefix yet; there might be a good reason to keep the
depth of the path each file appear in this "grep --unidiff-like" output
and "diff --patch" output, in which case "=3D=3D=3D a/git.c" or "=3D=3D=
=3D ./git.c"
might be give us more uniformity.
