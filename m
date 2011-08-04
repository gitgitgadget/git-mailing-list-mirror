From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [PATCH] Tolerate zlib deflation with window size < 32Kb
Date: Thu, 4 Aug 2011 08:40:56 +0100
Message-ID: <CAFY1edZLAjVRs0LUx6CvD9i5aZu6kZ1ecJdUsvZgmtGkajOqow@mail.gmail.com>
References: <1312410730-12261-1-git-send-email-roberto.tyley@gmail.com>
	<7vsjpi82x7.fsf@alter.siamese.dyndns.org>
	<CAFY1edZyO7oYDi+tV2mxbhBHY_cf2F0bD7+KF9rxmKYygSFAjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 09:42:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QosZe-0002pY-Li
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 09:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab1HDHk6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 03:40:58 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:56633 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab1HDHk5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2011 03:40:57 -0400
Received: by qyk38 with SMTP id 38so642032qyk.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=gCL1X6nVGomlUSEwWjHWlJTbcGQl5l6kwDZMr+3Sgf0=;
        b=WioT5QPWLN2kaP5rNElNVx0kJCavtt9dD5OUHv+TSeN4aMs7M1WjYENkjrWg5pVoym
         hmxSqzJZufIEcEZvEZpH+/K0qE9iwcz08Ir7NLtqsWQjheSTuVzHE7m47kvWiudTGDeg
         cgeY3JU1cFaF9sEOUi7T1xkl7jiLmLRKEWnqY=
Received: by 10.224.185.79 with SMTP id cn15mr310422qab.214.1312443656611;
 Thu, 04 Aug 2011 00:40:56 -0700 (PDT)
Received: by 10.224.2.207 with HTTP; Thu, 4 Aug 2011 00:40:56 -0700 (PDT)
In-Reply-To: <CAFY1edZyO7oYDi+tV2mxbhBHY_cf2F0bD7+KF9rxmKYygSFAjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178705>

On 4 August 2011 00:56, Junio C Hamano <gitster@pobox.com> wrote:
> roberto.tyley@gmail.com writes:
> > - =A0 =A0 if (map[0] =3D=3D 0x78 && !(word % 31))
> > + =A0 =A0 if ((map[0] & 0x88) =3D=3D 0x08 && !(word % 31))
>
> Are you sure about this 0x88? Isn't it 0x8F or something?

Ah- yes, you're right - the bitmask should be 0x8F, because the
lower nibble of a deflated zlib stream is 8 (8=3Ddeflate) and we want
to match all 4 bits.

Thankfully the rest of the logic still applies - I'll submit an
updated patch in a minute, once I've conquered my embarrassment :-)
