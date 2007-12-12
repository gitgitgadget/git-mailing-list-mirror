From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/4] Extract and improve whitespace check from "git apply"
Date: Wed, 12 Dec 2007 23:50:29 +0100
Message-ID: <C0D2E543-2F35-455B-BE58-A0177D087A8D@wincent.com>
References: <1197476582-18956-1-git-send-email-win@wincent.com> <1197476582-18956-2-git-send-email-win@wincent.com> <1197476582-18956-3-git-send-email-win@wincent.com> <7vsl277ldc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2aPy-0004i6-D0
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 23:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbXLLWuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 17:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbXLLWuo
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 17:50:44 -0500
Received: from wincent.com ([72.3.236.74]:45533 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbXLLWun convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 17:50:43 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBCMoTLP003198;
	Wed, 12 Dec 2007 16:50:30 -0600
In-Reply-To: <7vsl277ldc.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68106>

El 12/12/2007, a las 20:39, Junio C Hamano escribi=F3:

> I like the direction, but I think it would make much more sense if yo=
u
> make check_whitespace() not about "a line in a patch that adds a =20
> line",
> but about "here is a line, check if that is acceptable".  IOW, make =20
> line
> variable zero-based (and len =3D strlen(line)).  The change would mea=
n
> that existing callers need to be modified to do something like:
>
> 	if (line[0] =3D=3D '+')
>        	check_whitespace(line+1, len-1, ...);

Yes, good point. As you say, it can then potentially be used for any =20
line, not just lines in patches.

> but at the same time we could conceivably teach "git show" to show
> whitespace errors in a blob, i.e. "git show --show-ws-error HEAD:ws.c=
"
> by using such a check_whitespace().
>
> The highlighting code may need similar changes.  I was actually hopin=
g
> you would consolidate the logic there that decides which segment of =20
> the
> string to highlight, and the logic in check_whitespace() to decide if
> there is an error to begin with.  Conceptually, if emit_line_with_ws(=
)
> decides there is nothing to highlight with DIFF_WHITESPACE color, tha=
t
> means there is no whitespace error on the line and vice-versa, no?

You're dead right. As I said in my original message, there is a *lot* =20
of diff code and I basically only looked at enough of it to figure out =
=20
what changes would be necessary to implement what I wanted. I hadn't =20
looked inside emit_line_with_ws but it is an obvious site of =20
duplication and as you point out there is definitely scope for more =20
refactoring here; instead of doing the whitespace checking in three =20
places (the three that I know about so far) we can do it in just one =20
place. I'll see what I can cook up.

Cheers,
Wincent
