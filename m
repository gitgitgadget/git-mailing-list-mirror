From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/19] bash prompt: don't show the prompt when .git/HEAD
 is unreadable
Date: Wed, 09 May 2012 12:32:36 -0700
Message-ID: <7vipg5rvzf.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-6-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 21:33:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSCd8-0002L8-Mc
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 21:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760847Ab2EITco convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 15:32:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760844Ab2EITcj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 15:32:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EC7987AE;
	Wed,  9 May 2012 15:32:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ga/fLy1Q1s+C
	icrAn4F9M4nAcOY=; b=KRdA2H73g6n7SEKO9x/7hVfopOefUHsHYjKnw+JuEtWe
	uNNJ1Q5WTk9Zb7T06RFsWyknhwWhL3J5peu52v2Q/nsLtJffJ6bJ5uCuhSOkMwhL
	BynleSQsg8itDvcGTT8M8G/2PEJXxFmBn5yqfXrbRN9nxfq/FkStPRi/gpHKrgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dqrkQz
	ISCPBJbPD4u9PMCaN+TD/AQa63Y9jNUPEAanZTk1whXd/b0RosKsu6ChydDBBLN/
	10lwezK48XB0sIYzg9hTl8+Er9EfX1l8aDtli4JGluhNcIggSexaeJLSYrIpQamF
	U5LbjZAh5gHV7YaOlFUwH5Gnn8nLT1gDdN/3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8672A87AD;
	Wed,  9 May 2012 15:32:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B80387AC; Wed,  9 May 2012
 15:32:38 -0400 (EDT)
In-Reply-To: <1336524290-30023-6-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 9 May 2012 02:44:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC3D8ABE-9A0D-11E1-BDD1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197494>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index ab26bdc8..cd6a5f12 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -258,7 +258,7 @@ __git_ps1 ()
>  				esac 2>/dev/null)" ||
> =20
>  				b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
> -				b=3D"unknown"
> +				return

While you are touching the vicinity of the code, could we lose that "cu=
t"
and replace it with "rev-parse --short HEAD", without the hardcoded 1-7=
?

I wondered if we can use a single "git describe" output for all the
describe/default and failure cases but didn't come up with a good way t=
o
do so only by using bash built-ins.
