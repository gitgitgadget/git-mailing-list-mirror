From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: simple test for operation in a bare repository
Date: Sat, 06 Feb 2010 10:47:29 -0800
Message-ID: <7v7hqqyzem.fsf@alter.siamese.dyndns.org>
References: <4B69BD7C.4010608@lsrfire.ath.cx>
 <4B6A0BDE.2050908@lsrfire.ath.cx> <4B6B653A.8060909@lsrfire.ath.cx>
 <fcaeb9bf1002041840l4d8e8ac9k3ad5e9e8761aa1b@mail.gmail.com>
 <4B6D37D7.6010505@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Feb 06 19:47:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndph5-00050X-W7
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 19:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296Ab0BFSrm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 13:47:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab0BFSrl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 13:47:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A248D972BB;
	Sat,  6 Feb 2010 13:47:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BXO0OrTV1wni
	gqPNFKnqnJbNB0I=; b=YV5ZxdEFC/eGfV87w9SqXFUjO17zwKjsQvJ4gpMWOQl/
	7ghwTXoyxswtppVBnsMWmA+JJt+qihcl+kPD0wbIbASxgTOg4QOD/yM2nMdvZkWm
	Vm4LF+b4OUdpDL1MSZ+soiLUJgAmbK8B/xZ+PHZwD+purPiGDLCnBW1waGKU+IA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ufzi6E
	hLdhn0jtkF4MOvpZsuw7GSt1nX0czSFFVAYD2N9M0PW7Y7V3bmaSamrzGFjIRzCQ
	3B9TuqVFm7eV1LF1Zh4E6ZlZ+bjOlhd7LN7BLqoYGJvVyaZVs/QHGcK5Wkr9+bfN
	xXDfQDEYAgOZuzVPPZBg+p6OSJFx9OR58ANFw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71C09972B8;
	Sat,  6 Feb 2010 13:47:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C858972B4; Sat,  6 Feb
 2010 13:47:31 -0500 (EST)
In-Reply-To: <4B6D37D7.6010505@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat\, 06 Feb 2010 10\:35\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 17F0D114-1350-11DF-B877-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139184>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> This patch converts the setenv() calls in path.c and setup.c.  After
> the call, git grep with a pager works again in bare repos.
>
> It leaves the setenv(GIT_DIR_ENVIRONMENT, ...) calls in git.c alone, =
as
> they respond to command line switches that emulate the effect of sett=
ing
> the environment variable directly.
>
> The remaining site in environment.c is in set_git_dir() and is left
> alone, too, of course.  Finally, builtin-init-db.c is left changed
> because the repo is still being carefully constructed when the
> environment variable is set.

Thanks for a thorough analysis.  The patch looks correct and I am very
tempted to put it into 1.7.0, though I'd stop at queuing it to 'next'.
