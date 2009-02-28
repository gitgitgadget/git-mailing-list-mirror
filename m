From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] diffcore-pickaxe: further refactor count_match()
Date: Sat, 28 Feb 2009 09:40:32 -0800
Message-ID: <7vmyc6foj3.fsf@gitster.siamese.dyndns.org>
References: <cover.1235629933.git.gitster@pobox.com>
 <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com>
 <49A88FA7.1020402@lsrfire.ath.cx> <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org>
 <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org> <49A937B8.1030205@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Feb 28 18:42:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdTCS-0000Q4-Ub
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 18:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbZB1Rkk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 12:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbZB1Rkk
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 12:40:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbZB1Rkj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 12:40:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5DE2A2A39;
	Sat, 28 Feb 2009 12:40:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BF3E82A38; Sat,
 28 Feb 2009 12:40:34 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E8B451E0-05BE-11DE-B83B-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111780>

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

Yeah, what does glibc use these days?  Some variant of Boyer-Moore?

> So using memmem() is worthwhile.  And providing a better fall-back
> version in compat/ can speed up this particular case to the point whe=
re
> the fourth patch becomes moot.
>
> Hmm, gnulib (http://git.savannah.gnu.org/gitweb/?p=3Dgnulib.git;a=3Ds=
ummary)
> contains all parts ready for copy & paste, licensed under the GPL 2 o=
r
> up.  That won't cause problems with the libgit2 relicensing effort, a=
s
> memmem()  won't end up in there, right?

Correct.
