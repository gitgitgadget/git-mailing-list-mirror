From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 1/4] git-p4: add optional type specifier to gitConfig reader
Date: Thu, 3 Sep 2015 22:14:32 +0200
Message-ID: <A76D6BC6-E0AD-48F4-AE33-80BD0803BFA3@gmail.com>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com> <1441298148-63885-2-git-send-email-larsxschneider@gmail.com> <55E8A5C2.9090500@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 22:14:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXau8-0005lg-4l
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 22:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbbICUOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 16:14:36 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34970 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbICUOf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 16:14:35 -0400
Received: by wicge5 with SMTP id ge5so85507287wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 13:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9M+lcpCL1rqbP15E8f4aecM8efLRj8RjoDVoL+JycoI=;
        b=C8vrWvfRKNkbIHTDcx78D++B1V3CkZPzFKRBJiSFpWR9zJ7rHReMPqk3gS96JZEszT
         +oFIFWKxPBQxunNqU8tLPPRJJwQZa6fJWMF2yawW1cnMIJC/PDq/CkIQssjIyUA5i+g7
         QzQDTJZaFgo7+ssN9OiuyeUXyTTB2J9yCgeWn2jNLZFOXfyz9AesoI46cw0FCN4W34m+
         xKGxJrBiN5rggCJqhD+qWD+Qr/n7wosQ25Fm3L1CXuim/ln2rnfYyTQsFISc3OO23Xuf
         IQtaXOi1WZADzCZHZ7AsfLSr1RxU9WFhH9rlYf5y6XCbLN+jjWdtpKGoG7WH7BZ6l9ng
         v0vw==
X-Received: by 10.180.108.177 with SMTP id hl17mr17722875wib.45.1441311274719;
        Thu, 03 Sep 2015 13:14:34 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-092-078-130-241.092.078.pools.vodafone-ip.de. [92.78.130.241])
        by smtp.gmail.com with ESMTPSA id lh3sm22127980wjc.44.2015.09.03.13.14.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 13:14:33 -0700 (PDT)
In-Reply-To: <55E8A5C2.9090500@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277251>


On 03 Sep 2015, at 21:55, Luke Diamand <luke@diamand.org> wrote:

> On 03/09/15 17:35, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>=20
> I think this commit may need some explanation!

The functions =93gitConfig=94 and =93gitConfigBool=94 are almost identi=
cal. Make =93gitConfig=94 more generic by adding an optional type speci=
fier. Use the type specifier =93=97bool=94 with =93gitConfig=94 to impl=
ement =93gitConfigBool. This prepares the implementation of other type =
specifiers such as =93=97int=94.

OK?

Thank you,
Lars

>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  git-p4.py | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/git-p4.py b/git-p4.py
>> index 073f87b..c139cab 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -604,9 +604,12 @@ def gitBranchExists(branch):
>>=20
>>  _gitConfig =3D {}
>>=20
>> -def gitConfig(key):
>> +def gitConfig(key, typeSpecifier=3DNone):
>>      if not _gitConfig.has_key(key):
>> -        cmd =3D [ "git", "config", key ]
>> +        cmd =3D [ "git", "config" ]
>> +        if typeSpecifier:
>> +            cmd +=3D [ typeSpecifier ]
>> +        cmd +=3D [ key ]
>>          s =3D read_pipe(cmd, ignore_error=3DTrue)
>>          _gitConfig[key] =3D s.strip()
>>      return _gitConfig[key]
>> @@ -617,10 +620,7 @@ def gitConfigBool(key):
>>         in the config."""
>>=20
>>      if not _gitConfig.has_key(key):
>> -        cmd =3D [ "git", "config", "--bool", key ]
>> -        s =3D read_pipe(cmd, ignore_error=3DTrue)
>> -        v =3D s.strip()
>> -        _gitConfig[key] =3D v =3D=3D "true"
>> +        _gitConfig[key] =3D gitConfig(key, '--bool') =3D=3D "true"
>>      return _gitConfig[key]
>>=20
>>  def gitConfigList(key):
>>=20
>=20
