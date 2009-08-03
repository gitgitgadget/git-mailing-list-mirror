From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Mon, 3 Aug 2009 08:36:38 +0100
Message-ID: <57518fd10908030036l22ccdcf1va2e8ee450c4f5ee5@mail.gmail.com>
References: <20090731104602.15375.qmail@science.horizon.com> 
	<20090803034741.23415.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, appro@fy.chalmers.se, appro@openssl.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 09:37:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXs6b-0008Fz-9f
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 09:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbZHCHg7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2009 03:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbZHCHg6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 03:36:58 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:52867 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbZHCHg6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 03:36:58 -0400
Received: by gxk9 with SMTP id 9so5616097gxk.13
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=DY6rCckWCH5+SVwkV0SulfFeKOtS2IHRkQJEOXm7ZBo=;
        b=eEgtyqhwoALuRSAGpxHGFS8du4Baf1TDO/wkGR0Q3k3h7F+ozd+ROhANgQvgCz7n+F
         QwY2CU9aSLXEOQJi/E8a2l0YqDYvHn0z1cQm3xOy0LxNmUlM9c+tPti+gMjps2ZUhQuX
         eqlw+ExtHWWbJZoXMHcrMIWSZ0C+OCSy7qPPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=TevMVN3APP16uZptTgDtQKNgl97MS8NbovgRjXkDwRQK3gXxdQ8uLJOf/eneo6wFTe
         XSEK6Q9SvJWfVOuieV0tuvLhnC8jGbPDvBiMakH7stDV71QR2Oyx16V9uUHDLsSfNXs2
         lVC6HQZLUvYSTz2BtK9pTTcza9+W6wm7eVsfE=
Received: by 10.150.225.14 with SMTP id x14mr159609ybg.32.1249285018092; Mon, 
	03 Aug 2009 00:36:58 -0700 (PDT)
In-Reply-To: <20090803034741.23415.qmail@science.horizon.com>
X-Google-Sender-Auth: d5b9c4878960ae39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124687>

On Mon, Aug 3, 2009 at 4:47 AM, George Spelvin<linux@horizon.com> wrote=
:
> (Work in progress, state dump to mailing list archives.)
>
> This started when discussing git startup overhead due to the dynamic
> linker. =C2=A0One big contributor is the openssl library, which is us=
ed only
> for its optimized x86 SHA-1 implementation. =C2=A0So I took a look at=
 it,
> with an eye to importing the code directly into the git source tree,
> and decided that I felt like trying to do better.
>

=46WIW, this doesn't work on OS X / Darwin.  'as' doesn't take a --32
flag, it takes an -arch i386 flag.  After changing that, I get:

as -arch i386  -o sha1-586.o sha1-586.s
sha1-586.s:4:Unknown pseudo-op: .type
sha1-586.s:4:Rest of line ignored. 1st junk character valued 115 (s).
sha1-586.s:5:Alignment too large: 15. assumed.
sha1-586.s:19:Alignment too large: 15. assumed.
sha1-586.s:1438:Unknown pseudo-op: .size
sha1-586.s:1438:Rest of line ignored. 1st junk character valued 115 (s)=
=2E
make: *** [sha1-586.o] Error 1

- at which point I have no idea how to fix it.
