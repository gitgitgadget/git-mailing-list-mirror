From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: BUG?: git-apply sometimes says "corrupt patch" when adding single lines
Date: Wed, 18 Aug 2010 03:37:34 +0200
Message-ID: <AANLkTi=mJdufWiKDQBSA6EVpb6Qj3GfGPKZL4pJGdKYu@mail.gmail.com>
References: <AANLkTineHiG9vCpbJzJ2x9CFjZ7LQeExs7cN5YhoZhft@mail.gmail.com>
	<20100817234314.GK2221@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 03:37:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlXb4-0002W2-00
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 03:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765Ab0HRBhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 21:37:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41313 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab0HRBhf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 21:37:35 -0400
Received: by iwn7 with SMTP id 7so61273iwn.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 18:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oCSqsOaMgB8K+f2KcoBi2Ai1puWTBCt7KsOdRcrhXs4=;
        b=JiHc09jVpcOAqF0mxL1pDDHngfjpPXvbIR816oANLlCQDCrbgC0Z8ACJsfLRnnVECa
         jaCatmdFIm0M1lzhCGwpozmFin4OquCKS1nD3sMJbWKJMVse59GW/+FTGGxv7EtCB4pa
         fx4gWIff/adpFlqptbDmI/zdbLOkNerGhTzmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kYJYP8eC1jWYOV9IqrBWXMX0eIxYdgdqbW+tBtirJ3Gp4C1ZbVcC6mQYxa2rsinRYB
         KzCSllsSmZ1vHZlumohEhN3O1P28r2NgoK9Dso+PPycuEPSFuR0eZ5N3nAhB4ET2aE3J
         YH4S8w37FOYLx1KBAhbNMa3Tf46th+fFY/K6o=
Received: by 10.231.191.16 with SMTP id dk16mr2600585ibb.161.1282095454746;
 Tue, 17 Aug 2010 18:37:34 -0700 (PDT)
Received: by 10.231.177.194 with HTTP; Tue, 17 Aug 2010 18:37:34 -0700 (PDT)
In-Reply-To: <20100817234314.GK2221@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153801>

On Wed, Aug 18, 2010 at 1:43 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Tor Arvid Lund wrote:
>
>> I don't really know the git-gui code or the git C code well, but it
>> seems that I got around the error with this small patch:
>>
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index 12ef9ea..124791f 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -1335,6 +1335,8 @@ static int parse_fragment(char *line, unsigned=
 long size,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* l10n of "\ =
No newline..." is at least that long.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case '\\':
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (newlines =3D=3D oldlines =3D=3D 1)
> [...]
>
> Heh. =C2=A0This code is a roundabout way to say "if (newlines =3D=3D =
oldlines)",
> rather than "if (newlines =3D=3D 1 && oldlines =3D=3D 1)" that might =
have been
> intended.

Right you are, good sir ;-)

> Unfortunately I do not have any more insight than that. =C2=A0If you =
can
> give an example reproducing this with git apply from the command
> line, that would be very helpful.

I'll try to do that tomorrow.. My brain needs sleep before it will func=
tion :)

-Tor Arvid-
