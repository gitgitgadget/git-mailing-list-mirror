From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] added more informative error messages to git-mktag
Date: Mon, 22 May 2006 12:22:50 -0700
Message-ID: <7vu07hamph.fsf@assigned-by-dhcp.cox.net>
References: <4471CF91.9010202@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 21:23:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiFzS-000892-Q5
	for gcvg-git@gmane.org; Mon, 22 May 2006 21:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWEVTWw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 22 May 2006 15:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWEVTWw
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 15:22:52 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49143 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751144AbWEVTWv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 15:22:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060522192250.ZVWA24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 15:22:50 -0400
To: =?iso-8859-1?Q?Bj=F6rn?= Engelmann <BjEngelmann@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20523>

Bj=F6rn Engelmann <BjEngelmann@gmx.de> writes:

> -    if (size < 64)
> +    if (size < 64) {
> +        printf("wanna fool me ? you obviously got the size wrong !\n=
");
>          return -1;
> +    }

Please do this instead:

	return error("wanna ...");

you can lose the braces and the message goes to the stderr.

> -    if (memcmp(object, "object ", 7))
> +    if (memcmp(object, "object ", 7)) {
> +        printf("char%i: does not start with \"object \"\n", 0);
>          return -1;

Although they may be synonyms, we tend to use %d for ints and it
is more conventional.

>      tag_line++;
> -    if (memcmp(tag_line, "tag ", 4) || tag_line[4] =3D=3D '\n')
> +    if (memcmp(tag_line, "tag ", 4) || tag_line[4] =3D=3D '\n') {
> +        printf("char%i: no \"tag \" found\n", (int)tag_line - (int)b=
uffer);
>          return -1;
> +    }

If you have to cast, please do not cast pointers to ints and
take their difference, but take the difference and cast the
resulting ptrdiff_t to int, like this:

	(int)(tag_line - buffer)

Or use "%td" instead of "%i" and lose the cast.
