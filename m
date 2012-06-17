From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Sun, 17 Jun 2012 00:15:13 -0700
Message-ID: <7vipeq76ke.fsf@alter.siamese.dyndns.org>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org>
 <4FDD7AE6.6000000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vfr@lyx.org, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jun 17 09:16:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sg9iH-0004AX-Mp
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 09:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab2FQHPR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jun 2012 03:15:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913Ab2FQHPQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jun 2012 03:15:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8102556D4;
	Sun, 17 Jun 2012 03:15:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KYNohAnJxpDS
	Q/tOaFqbQizTmw0=; b=xGMeG0h8GOol7OEs4eqfrJPoWWibxF9aWkFfx+GAl7R/
	EHzbyN35wj7ZzTSbMoqHrUcc3N7fqy96vNIuQ52ObV8B/8A6uIu3AsrIfcCVflQl
	9WMEiyuGnZWqC9sTBU6D9v7uHeIF+T5fOhEjcBHKA8TN/1pC2TLrLx6eWj5eAHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xoY074
	VIwcLa2XJORH0CljBWmIGKG6PIODCqR+r7dv2Pk7nkQoNxxn94T68BMa4NsBMnVt
	uQy2v5dQStLhj3bFdaLneWfXVSogtH5KSrXLgHO3LlY57gpISdZiyWPPH6sNwPto
	fFMdsGy7tg020HD3er+ti/ZB/W0UVopgXUx9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 777F156D3;
	Sun, 17 Jun 2012 03:15:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECB2856D2; Sun, 17 Jun 2012
 03:15:14 -0400 (EDT)
In-Reply-To: <4FDD7AE6.6000000@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Sun, 17 Jun 2012 08:36:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F62368C-B84C-11E1-B98A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200119>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> When I try to debug it, the $PERL_PATH seems to be empty:

Ahh, given that it does this:

    cat >hexdump <<'EOF'
    #!/bin/sh
    perl -e '$/ =3D undef; $_ =3D <>; s/./ord($&)/ge; print $_' < "$1"
    EOF
    chmod +x hexdump

PERL_PATH should be exported from test-lib.sh; we dot-source
GIT-BUILD-OPTIONS to get its value, but it is not propagated to the
subprocess like this hexdump script.
