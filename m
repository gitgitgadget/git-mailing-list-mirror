From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Tue, 15 Sep 2015 16:49:44 +0200
Message-ID: <EA7A521F-1E7B-4169-A0EA-65F16904EE92@gmail.com>
References: <1442249728-89494-1-git-send-email-larsxschneider@gmail.com> <1442249728-89494-2-git-send-email-larsxschneider@gmail.com> <55F7A12D.9020603@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, luke@diamand.org
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 15 16:49:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbrYQ-0006ML-Ob
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 16:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbbIOOtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2015 10:49:50 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34414 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbbIOOts convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2015 10:49:48 -0400
Received: by wicfx3 with SMTP id fx3so32473148wic.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z0BCYiys5axQDwVb0pSFtdnCt2fWcmT7HJAvD9Qq46s=;
        b=bWWUr34GQaRy7CthZHet0flnr8plA1k4Yvk2iJqntS1gGz1iwiN/kqLWDWFIUYH/4a
         1EJGLkeU1KP7YbYvpG/oG/+Ew7y/OvUHNmjI1sirPUE0V2N65rebnkVO7XYRuWZ//qHb
         7F8mfBto0eadIEPT4IKWj6L6Mwy/TmdsgnBW5cHJ64oqfUuZViML2xt8HP3n/AaTB3h/
         Je74ajhu95mSOJBmWNwSyAZojPIKTcb/HegXbrYiXQ1lgwgdscYriTLhCq6E8Dg/P1F8
         OaaF1esUm0dPRCX8WrWdOjm6CG76df5Tqv08y/nrK5bIXWixo4mAp1ElOwyTfRk8GSbG
         t7Lg==
X-Received: by 10.180.86.232 with SMTP id s8mr8272878wiz.27.1442328587086;
        Tue, 15 Sep 2015 07:49:47 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id gt4sm20303932wib.21.2015.09.15.07.49.46
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 07:49:46 -0700 (PDT)
In-Reply-To: <55F7A12D.9020603@web.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277900>


On 15 Sep 2015, at 06:40, Torsten B=F6gershausen <tboegi@web.de> wrote:

> On 09/14/2015 06:55 PM, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> A P4 repository can get into a state where it contains a file with
>> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
>> attempts to retrieve the file then the process crashes with a
>> "Translation of file content failed" error.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  t/t9824-git-p4-handle-utf16-without-bom.sh | 47 +++++++++++++++++++=
+++++++++++
>>  1 file changed, 47 insertions(+)
>>  create mode 100755 t/t9824-git-p4-handle-utf16-without-bom.sh
>>=20
>> diff --git a/t/t9824-git-p4-handle-utf16-without-bom.sh b/t/t9824-gi=
t-p4-handle-utf16-without-bom.sh
>> new file mode 100755
>> index 0000000..fa8043b
>> --- /dev/null
>> +++ b/t/t9824-git-p4-handle-utf16-without-bom.sh
>> @@ -0,0 +1,47 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'git p4 handle UTF-16 without BOM'
>> +
>> +. ./lib-git-p4.sh
>> +
>> +UTF16=3D"\\x97\\x0\\x97\\x0"
>> +
>> +test_expect_success 'start p4d' '
>> +	start_p4d
>> +'
>> +
>> +test_expect_success 'init depot with UTF-16 encoded file and artifi=
cially remove BOM' '
>> +	(
>> +		cd "$cli" &&
>> +		echo "file1 -text" > .gitattributes &&
> Please no space between '>' and the filename,
> (this is our coding standard, and the same further down)
Correct! Sorry, I still need to get used to this style. Thanks for the =
reminder!

>=20
>> +		perl -e "printf \"$UTF16\"" >file1 &&
> Ehh, do we need perl here ?
> This will invoke a process-fork, which costs time and cpu load.
> The following works for me:
> printf '\227\000\227\000' >file1
I agree this is better.

Both issues will be fixed v3.

Thanks!