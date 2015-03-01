From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] diff --shortstat --dirstat: remove duplicate output
Date: Sun, 01 Mar 2015 15:23:37 +0100
Message-ID: <54F320E9.1000006@drmicha.warpmail.net>
References: <xmqqegp9gyof.fsf@gitster.dls.corp.google.com> <1425195546-15637-1-git-send-email-marten.kongstad@gmail.com> <54F2E931.7020200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, johan@herland.net
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	=?UTF-8?B?TcOlcnRlbiBLb25nc3RhZA==?= <marten.kongstad@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 15:23:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YS4mX-0002Df-4w
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 15:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbbCAOXk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2015 09:23:40 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54545 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751048AbbCAOXj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2015 09:23:39 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3ABB820697
	for <git@vger.kernel.org>; Sun,  1 Mar 2015 09:23:38 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 01 Mar 2015 09:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=KoPCp3TXzpOX9I5yjW5Aqk
	0Pcec=; b=Zcae1aMBnAy8grmGqzETclWiz2pbU35PZsAzYRFuhasAOhYqEzURUe
	f56l9hxn84QbBruEPiT/Y68UUidcle5BLxQ19T0mFwBclIO5VgvLZ6XEfurniniQ
	dzFZ9w4aUO8nNrprmBIau63YariB/jJ3eQRZOJCmWO5qQAb6+ciGY=
X-Sasl-enc: XMMLJ9RCDlewpxqnwbMk/syTWIfje3D4s3HIJHyo2x7S 1425219818
Received: from localhost.localdomain (unknown [88.71.98.191])
	by mail.messagingengine.com (Postfix) with ESMTPA id 382506800A1;
	Sun,  1 Mar 2015 09:23:38 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <54F2E931.7020200@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264559>

Torsten B=C3=B6gershausen venit, vidit, dixit 01.03.2015 11:25:
> On 2015-03-01 08.39, M=C3=A5rten Kongstad wrote:
> []
>  index ed7e093..128f7bf 100755
>> --- a/t/t4047-diff-dirstat.sh
>> +++ b/t/t4047-diff-dirstat.sh
>> @@ -973,4 +973,15 @@ test_expect_success 'diff.dirstat=3Dfuture_para=
m,0,lines should warn, but still wo
>>  	test_i18ngrep -q "diff\\.dirstat" actual_error
>>  '
>> =20
>> +test_expect_success '--shortstat --dirstat should output only one d=
irstat' '
>> +	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD >actual_diff_=
shortstat_dirstat_changes &&
>> +	test $(grep -c " dst/copy/changed/$" actual_diff_shortstat_dirstat=
_changes) =3D 1 &&
> How portable is the "grep -c" usage ?
> (I don't now it either, do we have other opinions ?), but the followi=
ng seems to be more "Git-style":
>=20
> test_expect_success '--shortstat --dirstat should output only one dir=
stat' '
> 	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD >actual_diff_sh=
ortstat_dirstat_changes &&
> 	grep " dst/copy/changed/$" actual_diff_shortstat_dirstat_changes >ac=
tual &&
> 	test_line_count =3D 1 actual
>=20

If I would have had to guess from the documentation: What does "git dif=
f
--dirstat --shortstat" do? I would have answered: It displays both the
dirstat and the shortstat.

So, is what you are trying to "fix" a peculiarity of
"--dirstat=3Dchanges", or do you simplify prefer --dirstat and --shorts=
tat
to override each other?

Maybe I'm overlooking something (and that's not a rhetorical
conditional), but if you specify both options when you want the output
of only one them, the answer would be the obvious one, not a patch,
wouldn't it?

If there is indeed a good reason to change the behavior it should be
documented.

Michael
