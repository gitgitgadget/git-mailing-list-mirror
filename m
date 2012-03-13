From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 01/9] Add column layout skeleton and git-column
Date: Tue, 13 Mar 2012 15:24:52 -0700
Message-ID: <7vaa3kt9zf.fsf@alter.siamese.dyndns.org>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <cover.1331638663.git.pclouds@gmail.com>
 <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 23:25:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7a9N-0002PV-6R
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 23:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759535Ab2CMWY4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 18:24:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769Ab2CMWYz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 18:24:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B01477D6;
	Tue, 13 Mar 2012 18:24:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TgkdIm47bYfI
	fMCS0dt/tSj8dAM=; b=VtC8N1W+sl2rnoowVV7+HcOsR8AZPgfhQnlSKpFOSHcD
	g8fyVF0nLRPk7HD+VT7YY2ZoKdE7Fg1naGRLIqSzaGF2U2rGkK+hE3SFRLP1s6A9
	wiNTXCXK9dSeuIfHuXJjdUDYj+WSt40/OipxCRApzxz+0W9Fmr3tSr5mtEpnChQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NKOZgC
	D6olJoxoF/jOuV/mG5FuAv6Vzm1mDsA+gIAdDyaJB+zs4GS7b5c14NhsLdR4RJIH
	hJPEmoePSMbs9OQnm8X+q9Ck09Y4hRfLZNlZdNRoZYmiArVijgmJkPZqwvwSK/wi
	D8Q4Y9MJwlA4T8qiLW5regDuiHb9drFPJ/F+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E9E977D5;
	Tue, 13 Mar 2012 18:24:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8BFF77D4; Tue, 13 Mar 2012
 18:24:53 -0400 (EDT)
In-Reply-To: <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 13 Mar
 2012 19:09:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B560C64-6D5B-11E1-AF70-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193075>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +#define COL_ENABLE(c) ((c) & COL_ENABLE_MASK)

That is a misleading name for a boolean macro.  It looked as if this

> +	assert(COL_ENABLE(colopts) !=3D COL_AUTO);

was asking the helper to *enable* the column machinery with the given s=
et
of option in colopts, and expecting the helper to answer how it enabled
("I took the 'automatic' decision path").  But that is not what is
happening.

Unfortunately, COL_ENABLED?(c) is not an option, but this seriously nee=
ds
a better name to avoid reader confusion.

Regarding the "denser" mode, I very much like the simplicity of the ide=
a.
I was wondering if a solution that aims for the maximum density that do=
es
not shuffle the original order of items would end up taking the output
from "fmt" and distributing the words on each line evenly to the width,
which would be totally unusable. Your "punt at an item that does not fi=
t
and restart from there" is simple and seems to work well.

I haven't formed an opinion on your "grouping" mode yet.  The hardcoded
slash hierarchy delimiter somewhat bothers me, but I haven't thought it
deeply enough to judge if it is worth making it more generic. My gut
feeling is that '/' probably is OK.

Thanks.
