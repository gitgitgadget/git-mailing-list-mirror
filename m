From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Use the same source directory for "ln -s"
 as for "ln" / "cp"
Date: Thu, 5 Feb 2015 21:29:04 +0100
Message-ID: <CAHGBnuPL7NN9J+4xd7xifsmbSPcC5V2ze05ji7P_qnvWHPGV+A@mail.gmail.com>
References: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com>
	<D060A1E5-DAF3-49D5-B0B3-F831BCDFD41F@gmail.com>
	<xmqqmw4skvrn.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP5e7NsDrD31otFGZiFYW-vxsOf7kV61=Zt32n3S78RBg@mail.gmail.com>
	<20150205195143.GB15326@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:29:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJT32-0008RI-7B
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 21:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbbBEU3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2015 15:29:07 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:52782 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbbBEU3G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2015 15:29:06 -0500
Received: by mail-yk0-f169.google.com with SMTP id 79so1516799ykr.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 12:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eae6NrZ3CkkACG+yN/q7/W319I+2uXICdT9vuWfRDYU=;
        b=WukxW5d2HmTV0oM5+eFo3PEmn+9hdOqLhq+EkQXjDUimDRxIss9I3PkQ6RfREI8s0k
         y3DGmk4l/vpcC+bw/AS3YHuzHvpd9PHO9Ig3RdUY4lnoX/W/MA9zIFDE+crNFsS2FbKz
         wv38CyKNOqC2ZR/QHE050vSqQ3Zf56AYe0MJ7pl7O0oSRDYZSqIa048juCAaAbjMeLWh
         gKR8M0pRvWq/BJ5m+MXKvYw7yDahUG8+77k3aSWkTvt2QJI1AN2OKa2VJY2iGXRWRUFB
         bADjrZJfhMRiwpDH7D8v0kJM9Y33k3iGh7CziW7rX7gzzeHIkIgDGHZZBTFNo0ckazOB
         DtCg==
X-Received: by 10.170.84.134 with SMTP id b128mr2706863yka.82.1423168144643;
 Thu, 05 Feb 2015 12:29:04 -0800 (PST)
Received: by 10.170.132.133 with HTTP; Thu, 5 Feb 2015 12:29:04 -0800 (PST)
In-Reply-To: <20150205195143.GB15326@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263399>

On Thu, Feb 5, 2015 at 8:51 PM, Jeff King <peff@peff.net> wrote:

> On Thu, Feb 05, 2015 at 08:26:08PM +0100, Sebastian Schuberth wrote:
>
>> > It is not even correct, is it?
>> >
>> > When DESTDIR is set to allow you to install into a temporary place
>> > only so that you can "tar" up the resulting filesystem tree, bindi=
r
>> > points at the location we need to "cp" the built programs into, i.=
e.
>> > inside DESTDIR.
>>
>> Agreed folks, please disregard this as well as 2/2 of this series.
>
> We would still want an equivalent to 2/2 to set up a relative symlink
> for $(ALL_PROGRAMS), though, right?

Probably. But I'm not sure how to calculate the relative path
correctly so that it'll work with all possible bin / execdir
combinations. A simple

diff --git a/Makefile b/Makefile
index 21f23cb..d2849c3 100644

--- a/Makefile
+++ b/Makefile

@@ -2258,8 +2258,8 @@

 endif
 =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7$(RM)=C2=B7"$$execdir/=
$$p"=C2=B7&&=C2=B7\
 =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7test=C2=B7-z=C2=B7"$(N=
O_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)"=C2=B7&&=C2=B7\
 =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7ln=C2=B7"$$bindir/$$p"=
=C2=B7"$$execdir/$$p"=C2=B72>/dev/null=C2=B7||=C2=B7\
+=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7ln=C2=B7-s=C2=B7"../$$=
p"=C2=B7"$$execdir/$$p"=C2=B72>/dev/null=C2=B7||=C2=B7\
 =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7cp=C2=B7"$$bindir/$$p"=
=C2=B7"$$execdir/$$p"=C2=B7||=C2=B7exit;=C2=B7\
 =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7done;=C2=B7\
 =C2=B7=C2=B7=C2=B7=C2=B7}=C2=B7&&=C2=B7\
--=C2=B7

does not seem to be correct in all cases.

--=20
Sebastian Schuberth
