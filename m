From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5] git-p4: Obey core.ignorecase when using P4 client specs.
Date: Tue, 25 Aug 2015 10:17:56 +0200
Message-ID: <E4AEC9F5-F86A-42FE-A893-E0238AA8E662@gmail.com>
References: <1440451805-85095-1-git-send-email-larsxschneider@gmail.com> <55DC111A.6090501@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pw@padd.com, torarvid@gmail.com,
	ksaitoh560@gmail.com, tboegi@web.de, sunshine@sunshineco.com,
	gitster@pobox.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 10:22:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU9VG-0003Rj-8y
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 10:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbbHYISD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 04:18:03 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36825 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbHYIR7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2015 04:17:59 -0400
Received: by wicja10 with SMTP id ja10so7162130wic.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V/5RQHTU4aFLVmpUovDEqITtf2HY/UnyO3SY0bhKAxw=;
        b=euIOLewRAW232nBHMps0OlDRFHVFsn6ZcPHDLiCQdcpXzHB9llTRTWvwamzB+SMW93
         Ofg7mIUQfXC3H3ox+6FLEABEy9nnMosM1WV4KRwEHGv6DxZH/USXRMo4pTffem0+q4/N
         Zi7gkq5Al09XW9V9lu4+BigHBMfq72WQsD7oVuqrVzGBkdM4vkspPAeMiZSpwjujqMYk
         A2ZOrcEbf3ZQ+YGZtIYE3Fi206+sP26DEDY732MNWgxr1/DPG4j+6xin7iLCepl7y5c5
         Qz4duZJH7YVbW9YIjxeNdoYCVZCEVQGL3EuEL00SgI0Zsup7WcKvtMVsabGAueoggQlW
         PDJQ==
X-Received: by 10.180.211.82 with SMTP id na18mr2668743wic.76.1440490678782;
        Tue, 25 Aug 2015 01:17:58 -0700 (PDT)
Received: from [10.146.248.55] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e8sm1412145wiz.0.2015.08.25.01.17.57
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Aug 2015 01:17:58 -0700 (PDT)
In-Reply-To: <55DC111A.6090501@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276510>

On 25 Aug 2015, at 08:54, Luke Diamand <luke@diamand.org> wrote:

> On 24/08/15 22:30, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Thanks to Luke Diamand I realized the core problem and propose here =
a
>> substiantially simpler fix to my PATCH v4.
>>=20
>> The test cases remain and prove the problem. In particular
>> "8 - Clone path (ignorecase)" and
>> "Add a new file and clone path with new file (ignorecase)" fail with=
 the
>> current implementation on OS X and Linux.
>=20
> That's a lot simpler, thanks!
>=20
> Could we give this its own command line option and git config variabl=
e?
Can you outline the command line option you have in mind?

>=20
> Core.ignorecase gets set if the client is on a filing system that ign=
ores case. This is slightly different - it squashes case in depot files=
 for people with depots that have incorrectly jumbled-up case.
Well, you can=92t tell if the depots have incorrectly jumbled-up case. =
It could be intentional after all. Therefore I believe the =93ignorecas=
e=94 flag is a good fit because we explicitly state that we are not int=
erested in case sensitivity on the client.


> Conflating the two seems like it would cause confusion at some point =
- for example, I have no idea how the rest of git behaves if core.ignor=
ecase is set to True on a case-preserving file system.
>=20
> It would probably be necessary to change p4PathStartsWith() to also c=
heck the same flag.
>=20
>=20
>>=20
>> Lars Schneider (1):
>>   git-p4: Obey core.ignorecase when using P4 client specs.
>>=20
>>  git-p4.py                         |   7 ++
>>  t/t9821-git-p4-path-variations.sh | 200 +++++++++++++++++++++++++++=
+++++++++++
>>  2 files changed, 207 insertions(+)
>>  create mode 100755 t/t9821-git-p4-path-variations.sh
>>=20
>> --
>> 1.9.5 (Apple Git-50.3)
>>=20
>=20
