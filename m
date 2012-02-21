From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] utf8: die if failed to re-encoding
Date: Tue, 21 Feb 2012 09:36:59 -0800
Message-ID: <7vk43ggkas.fsf@alter.siamese.dyndns.org>
References: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
 <1329834292-2511-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 18:37:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzteK-0002yG-7J
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 18:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab2BURhE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 12:37:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312Ab2BURhC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 12:37:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3816801;
	Tue, 21 Feb 2012 12:37:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0XQmsqvtEWNN
	LxhaJxeFbL8D4ww=; b=dd0rZEw9oxbCIvzFozSLQyThUoIM7CpScrQoSM33faxN
	Y4vfc0yglDl3C7mSOT4scnRlLeiIvtcZUnvUPvDN3IywTE0cqmrYY9t5IXpxn84U
	FiOSRbQOUXs3NKSU2KAVKGfxG6e5z1TzghTC3Ys5P3zSAf6UzOoqFZDV5eb+1rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HIvwK8
	J+Hon+k0WlyDWJ3xNslEHKW4/F+zpJKMGIZeygFVfk3/qLR01os+evGmrZIjHwiv
	gCwYtovvjWJPfpVAI8F3uyjXYzWpWDNF9Vs1TDaoC3TOl43IS5hd4o3AEB7T4QdS
	lLMb/chUTeEgzpu0pUvfWhfsAyYzqWvXgiIVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56EBA6800;
	Tue, 21 Feb 2012 12:37:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DADAA67FF; Tue, 21 Feb 2012
 12:37:00 -0500 (EST)
In-Reply-To: <1329834292-2511-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 21 Feb
 2012 21:24:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A91DDBFC-5CB2-11E1-9678-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191171>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Return value NULL in this case means "no conversion needed", which is
> not quite true when conv =3D=3D -1.

Doing this only when producing new commits to avoid spreading damage mi=
ght
be a good idea.

But utf8.c::reencode_string() is sufficiently deep in the call-chains t=
o
make me suspect that the codepaths this change affects are not limited =
to
creation ones.  If this also forbids readers from resurrecting salvagea=
ble
bits while reading (imagine your commit had "encodign vscii" but your l=
og
message was in English, except only your name had letters outside ASCII
that I cannot locally convert to utf-8 for viewing), I do not think it =
is
an acceptable change.
