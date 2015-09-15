From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7] git-p4: improve path encoding verbose output
Date: Tue, 15 Sep 2015 17:55:40 +0200
Message-ID: <1E65031B-DE14-4B8A-9105-9EA0E6279573@gmail.com>
References: <1442250640-93838-1-git-send-email-larsxschneider@gmail.com> <1442250640-93838-2-git-send-email-larsxschneider@gmail.com> <xmqqbnd4x2se.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 17:56:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsaF-0002GZ-0g
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbbIOPzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2015 11:55:45 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34728 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbbIOPzo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2015 11:55:44 -0400
Received: by wicfx3 with SMTP id fx3so35399591wic.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 08:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=H5dZxFvmKNPyRuGHd3Idukll5bIdU8T8TbJY77kLVnw=;
        b=faAarHhTsIXmKz/X8VFNr8Cj71cGY/P86J5VVhkdoeiIUmWq78ySv2Dp6dD7RfOgpW
         Z0IDPrIy4Qvxk8Spph7pfdu7F3ug+kIVjPPmmclSW87ZMQuBACGoOFHqhzEB1xwfV2R4
         bLSmrGtR8G34bKaOuBDKU7e4xE79LIPtjPc7tzzJ7kSsAZ04hk2NZSG/YIUFmM9BARn/
         gGWk73Y4AxWf+7OAJAJLUFinmtf+YGnsW7OIL3USnC++zb7vrNsCEfHkmGZ7G5G/suZR
         9wZPNGmltnJg5X1DVtuYNnxDWYWXVpr8QBiLnrkbeUdKtHc+N9GgO2Eh6aD3Ja9soJUL
         69oQ==
X-Received: by 10.180.104.68 with SMTP id gc4mr8513088wib.78.1442332542675;
        Tue, 15 Sep 2015 08:55:42 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id fs2sm20595306wib.12.2015.09.15.08.55.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 08:55:42 -0700 (PDT)
In-Reply-To: <xmqqbnd4x2se.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277941>


On 14 Sep 2015, at 20:40, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> If a path with non-ASCII characters is detected then print always th=
e
>> encoding and the encoded string in verbose mode.
>=20
> Earlier if the user tells us that s/he knows what she is doing
> by setting the configuration, we just followed the instruction
> without complaining or notifying.  The differences in this version
> are
>=20
> (1) if the path is in ASCII, the configuration is not even
>     consulted, and we didn't do any path munging.
Correct!


> (2) for a non-ASCII path, even if the user tells us that s/he knows
>     what she is doing, we notify what we did under "--verbose"
>     mode.
Correct!


> I think (1) is a definite improvement, but it is not immediately
> obvious why (2) is an improvement.  It is clearly a good thing to
> let the user know when we munged the path without being told, but
> when the configuration is given, it can be argued both ways.  It may
> be a good thing to reassure that the configuration is kicking in, or
> it may be a needless noise to tell the user that we did what we were
> told to do.
I get your point. However, changing file names in a repository is a pre=
tty significant action and therefore I would prefer to explicitly tell =
the user about it. Some encodings differ only slightly I would like to =
have an easy way to look at all the changed paths to ensure I picked th=
e right encoding (e.g. grep =93Path with non-ASCII characters detected=94=
). I also assume the user is OK with noise since s/he enabled =93verbos=
e=94 mode :-)


> In any case, I suspectq that the call to decode-encode to munge
> relPath is indented one level too deep in this patch.  You would
> want to use the configured value if exists and utf8 if there is no
> configuration, but in either case you would want to munge relPath
> when it does not decode as ASCII, no?
Good catch! It works with the indented code too because UTF8 is the def=
ault encoding for relPath later on. However, with your suggestion the c=
ode is more explicit. I will change it in the next roll

Thanks!

>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> git-p4.py | 19 +++++++++----------
>> 1 file changed, 9 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/git-p4.py b/git-p4.py
>> index d45cf2b..da25d3f 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2220,16 +2220,15 @@ class P4Sync(Command, P4UserMap):
>>             text =3D regexp.sub(r'$\1$', text)
>>             contents =3D [ text ]
>>=20
>> -        if gitConfig("git-p4.pathEncoding"):
>> -            relPath =3D relPath.decode(gitConfig("git-p4.pathEncodi=
ng")).encode('utf8', 'replace')
>> -        elif self.verbose:
>> -            try:
>> -                relPath.decode('ascii')
>> -            except:
>> -                print (
>> -                    "Path with Non-ASCII characters detected and no=
 path encoding defined. "
>> -                    "Please check the encoding: %s" % relPath
>> -                )
>> +        try:
>> +            relPath.decode('ascii')
>> +        except:
>> +            encoding =3D 'utf8'
>> +            if gitConfig('git-p4.pathEncoding'):
>> +                encoding =3D gitConfig('git-p4.pathEncoding')
>> +                relPath =3D relPath.decode(encoding).encode('utf8',=
 'replace')
>> +            if self.verbose:
>> +                print 'Path with non-ASCII characters detected. Use=
d %s to encode: %s ' % (encoding, relPath)
>>=20
>>         self.gitStream.write("M %s inline %s\n" % (git_mode, relPath=
))
