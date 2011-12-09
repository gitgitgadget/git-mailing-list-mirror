From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] revert: allow mixed pick and revert instructions
Date: Fri, 9 Dec 2011 11:04:15 +0530
Message-ID: <CALkWK0=4Mzu57t3_CCTpbWrTFfHu3aF=5aNv-NqcmQ6BMG2tSg@mail.gmail.com>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-5-git-send-email-artagnon@gmail.com> <20111207074501.GE11737@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 06:34:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYt6Z-0001Ix-4c
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 06:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab1LIFei convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 00:34:38 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56265 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab1LIFei convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 00:34:38 -0500
Received: by wgbdr13 with SMTP id dr13so4931950wgb.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 21:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MBezTy418BJga0TMgXIl2mSd0GtpasaQjbe3fuNel9U=;
        b=CtjBTrzr4JvMqSFBSkEQD8uCR4QXvF1EJ7kOVn4qOcK/WCjkwqjXajayaiJ8CXvigd
         lZqSSXaOmuYWQQsCu0lY/rc5DwvIFhWZ9II5pk9enABTnCUhJFkeOGHzznN11qjwjl6H
         sW23zOAix7lGrmxhdvHxmUVoreA05J0Gi7lxs=
Received: by 10.216.14.209 with SMTP id d59mr322245wed.112.1323408876187; Thu,
 08 Dec 2011 21:34:36 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Thu, 8 Dec 2011 21:34:15 -0800 (PST)
In-Reply-To: <20111207074501.GE11737@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186609>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> This patch lays the foundation for extending the parser to support
>> more actions so 'git rebase -i' can reuse this machinery in the
>> future. =C2=A0While at it, also improve the error messages reported =
by the
>> insn sheet parser.
>
> I don't know what this part is about...

I'll separate out these changes in the re-roll.  Thanks.

>> @@ -733,37 +739,29 @@ static struct commit *parse_insn_line(char *bo=
l, char *eol, struct replay_opts *
> [...]
>> =C2=A0 =C2=A0 =C2=A0 status =3D get_sha1(bol, commit_sha1);
>> =C2=A0 =C2=A0 =C2=A0 *end_of_object_name =3D saved;
> [...]
>> =C2=A0 =C2=A0 =C2=A0 if (status < 0)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("Line %d:=
 Malformed object name: %s"), lineno, bol);
>
> (Not about this patch, but an earlier one) =C2=A0What is this idiom a=
bout?
> Why not
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_sha1(bol, commit_sha1))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error(_=
(...));
>
> ?

I'm first detecting the end of the object name and terminating it with
a '\0', before using using get_sha1() to read out the object name.
Then, I restore the instruction sheet to the original state by
restoring the character from 'saved'.  If I use the idiom you
suggested, I'll leave midway after editing the instruction sheet, and
this is undesirable.

-- Ram
