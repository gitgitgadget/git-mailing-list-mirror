From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] diffcore-pickaxe: further refactor count_match()
Date: Sat, 28 Feb 2009 23:31:55 -0800
Message-ID: <7viqmtaec4.fsf@gitster.siamese.dyndns.org>
References: <cover.1235629933.git.gitster@pobox.com>
 <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com>
 <49A88FA7.1020402@lsrfire.ath.cx> <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org>
 <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org> <49A937B8.1030205@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Mar 01 08:37:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdgFE-0007x7-2u
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 08:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbZCAHcJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 02:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbZCAHcI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 02:32:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbZCAHcH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 02:32:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A7D639E70D;
	Sun,  1 Mar 2009 02:32:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 429BE9E70C; Sun,
  1 Mar 2009 02:31:57 -0500 (EST)
In-Reply-To: <49A937B8.1030205@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sat, 28 Feb 2009 14:10:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0E0EA976-0633-11DE-8F40-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111825>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> I get this (Ubuntu 8.10 x64, Fedora 10 x64 using the same Linux repo,
> Windows Vista x64 using a different Linux repo with the same HEAD on
> NTFS and msysgit, numbers are the elapsed time in seconds, best of fi=
ve
> runs):
>
>                            Ubuntu  Fedora  Windows
>    v1.6.2-rc2                8.14    8.16    9.236
>    v1.6.2-rc2+[1-4]          2.43    2.45    2.995
>    v1.6.2-rc2+[1-4]+memmem   1.31    1.25    2.917
>    v1.6.2-rc2+[1-3]+memmem   1.51    1.16    8.455
>
> Ubuntu has glibc 2.8, while Fedora 10 has glibc 2.9, with a new and m=
ore
> efficient memmem() implementation.  On Windows, we use our own naive
> memmem() implementation.

Shoot, I was not being careful enough.

> So using memmem() is worthwhile.  And providing a better fall-back
> version in compat/ can speed up this particular case to the point whe=
re
> the fourth patch becomes moot.

Are these numbers telling me that with a good memmem() implementation,
patch 4/4 is not just moot but actively detrimental?

With a long enough needle, it entirely is possible that scanning the wh=
ole
image with sublinear string search algorithm would perform much better
than the preprocessing patch 4/4 does which has to scan all the bytes i=
n
the common parts.
