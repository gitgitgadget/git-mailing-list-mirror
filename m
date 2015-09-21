From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Tue, 22 Sep 2015 01:03:17 +0200
Message-ID: <E47DE9F0-6017-4E96-AC29-E6C60C4D85CB@gmail.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com> <1442829701-2347-2-git-send-email-larsxschneider@gmail.com> <xmqqio73abl0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, sunshine@sunshineco.com,
	tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 01:03:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeA7T-0005BI-EO
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 01:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933198AbbIUXDY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 19:03:24 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33881 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817AbbIUXDW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2015 19:03:22 -0400
Received: by wicfx3 with SMTP id fx3so167965516wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 16:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iK66TuhYA9Bpi7sD/dOPtuFIZ3JmsHtjBKGOOpdFG+k=;
        b=bKNhqFZi6q9HDECqhHu3+uGu36WHhZLX7+hr24+iSsYD78oir+l2xrx0JI7CJII3+C
         JcXmV/+JIwiY+Ok3vUZFVSfSg+z/eZibQOXZ5Z4MprUnWbRUrcP6HtuptIMDNg4e2368
         4WR/Izr7AZ4OBwc5IYtWyuhWKegwsRPogUsLGy4tXMIudIe/n4iursuWPx0PRfPlZXQc
         7HK8koso36A2DoU0/rMbB81Q/i0xcp08zjbCkEHcz52sTHiNaPAiAvV491DaStM0ur5r
         1AEZOd+T3P/NlbjpK8bLAK9SlXiG483GqIfvHP/HfON7IKswZZjx/T6tzZBsSWwWwWw6
         FUrg==
X-Received: by 10.194.223.104 with SMTP id qt8mr16564305wjc.60.1442876600919;
        Mon, 21 Sep 2015 16:03:20 -0700 (PDT)
Received: from [10.32.249.137] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id c2sm15748642wiy.11.2015.09.21.16.03.19
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 16:03:20 -0700 (PDT)
In-Reply-To: <xmqqio73abl0.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278359>


On 21 Sep 2015, at 20:09, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> A P4 repository can get into a state where it contains a file with
>> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
>> attempts to retrieve the file then the process crashes with a
>> "Translation of file content failed" error.
>>=20
>> More info here: http://answers.perforce.com/articles/KB/3117
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> t/t9825-git-p4-handle-utf16-without-bom.sh | 50 ++++++++++++++++++++=
++++++++++
>> 1 file changed, 50 insertions(+)
>> create mode 100755 t/t9825-git-p4-handle-utf16-without-bom.sh
>>=20
>> diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh
>> b/t/t9825-git-p4-handle-utf16-without-bom.sh
>> new file mode 100755
>> index 0000000..65c3c4e
>> --- /dev/null
>> +++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
>> @@ -0,0 +1,50 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'git p4 handling of UTF-16 files without BOM'
>> +
>> +. ./lib-git-p4.sh
>> +
>> +UTF16=3D"\227\000\227\000"
>> +
>> +test_expect_success 'start p4d' '
>> +	start_p4d
>> +'
>> +
>> +test_expect_success 'init depot with UTF-16 encoded file and artifi=
cially remove BOM' '
>> +	(
>> +		cd "$cli" &&
>> +		printf "$UTF16" >file1 &&
>> +		p4 add -t utf16 file1 &&
>> +		p4 submit -d "file1"
>> +	) &&
>> +
>> +	(
>> +		cd "db" &&
>> +		p4d -jc &&
>> +		# P4D automatically adds a BOM. Remove it here to make the file i=
nvalid.
>> +		sed -e "$ d" depot/file1,v >depot/file1,v.new &&
>=20
> Do you need the space between the address $ (i.e. the last line) and
> operation 'd' (i.e. delete it)?  I am asking because that looks very
> unusual at least in our codebase.
Well, I am no =93sed=94 pro. I have to admit that I found this snippet =
on the Internet and it just worked. If I remove the space then it does =
not work. I was not yet able to figure out why=85 anyone an idea?

Thanks,
Lars



>=20
>> +		mv -- depot/file1,v.new depot/file1,v &&
>> +		printf "@$UTF16@" >>depot/file1,v &&
>> +		p4d -jrF checkpoint.1
>> +	)
>> +'
>> +
>> +test_expect_failure 'clone depot with invalid UTF-16 file in verbos=
e mode' '
>> +	git p4 clone --dest=3D"$git" --verbose //depot &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		printf "$UTF16" >expect &&
>> +		test_cmp_bin expect file1
>> +	)
>> +'
>> +
>> +test_expect_failure 'clone depot with invalid UTF-16 file in non-ve=
rbose mode' '
>> +	git p4 clone --dest=3D"$git" //depot
>> +'
>> +
>> +test_expect_success 'kill p4d' '
>> +	kill_p4d
>> +'
>> +
>> +test_done
