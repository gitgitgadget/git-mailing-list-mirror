From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/6] gitignore: do not do basename match with patterns
 that have '**'
Date: Fri, 5 Oct 2012 18:23:23 +0700
Message-ID: <CACsJy8BTWEeWvdwCDGBdoLndh8hXpgCgXrQxhWeaO1m9Qrqvgw@mail.gmail.com>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org> <1349336392-1772-1-git-send-email-pclouds@gmail.com>
 <1349336392-1772-6-git-send-email-pclouds@gmail.com> <506E85BF.8010302@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 13:24:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK60i-0008Cv-HL
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 13:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab2JELXz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 07:23:55 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41297 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab2JELXy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2012 07:23:54 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3442376iea.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DQRHmXNAXJO4+yUceAqpUrQKDHT3PQ/1zJApsGQM45Q=;
        b=p8jCTSvyhN9vwUMtin6+s277UWoOV5VlVjaQy33Zw4OtWMbzxZwkraMQPspI6KMbYT
         /pP358DxWrAGuw4g7m8HGRCId8zI4SRQ6jkxJZH110AlZnSPdbXB6YuHxcZ1c1Lfb/Oh
         2OdK+UjqVCA2llQJi8U5iLhex12iS/bzlDZt7TUBoirqHG7PljavCXv0pYvvETz2V0XB
         BaD8YWg4gSvDS8HcKEZWDilo0kzRpxkTtHiSgl4TtdnAc6mF74uvoxZ/NxskYgWmyZ3o
         iqHtrVNXPvHKyXVvpoCH2LaGxZOmqLWjnVisVvDfXtZoaCf0xzqYq/iMC8OKnUCZsfql
         /UsQ==
Received: by 10.50.207.33 with SMTP id lt1mr821229igc.40.1349436233747; Fri,
 05 Oct 2012 04:23:53 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Fri, 5 Oct 2012 04:23:23 -0700 (PDT)
In-Reply-To: <506E85BF.8010302@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207100>

On Fri, Oct 5, 2012 at 2:01 PM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Am 10/4/2012 9:39, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
>> - - If the pattern does not contain a slash '/', git treats it as
>> -   a shell glob pattern and checks for a match against the
>> -   pathname relative to the location of the `.gitignore` file
>> -   (relative to the toplevel of the work tree if not from a
>> -   `.gitignore` file).
>> + - If the pattern does not contain a slash '/' nor '**', git
>> +   treats it as a shell glob pattern and checks for a match
>> +   against the pathname relative to the location of the
>> +   `.gitignore` file (relative to the toplevel of the work tree
>> +   if not from a `.gitignore` file).

I think in the latest round, we forbid this case (i.e. a/**, **/b and
a/**/b are ok, but a**b is not), exactly because it's hard to define
how it should do. Thanks for another example.

>> +test_expect_success '"**" with no slashes test' '
>> +     echo "a**f foo=3Dbar" >.gitattributes &&
>> +     cat <<\EOF >expect &&
>> +f: foo: unspecified
>> +a/f: foo: bar
>> +a/b/f: foo: bar
>> +a/b/c/f: foo: bar
>> +EOF
>
> Should the above .gitattributes match nested paths, such as b/a/c/f?
>
> I think it should, because the user can easily say "/a**f" that neste=
d
> paths should not be matched.

The user can also say **/a/**f to match b/a/c/f.
--=20
Duy
