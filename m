From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] t9824: fix broken &&-chain in a subshell
Date: Sun, 24 Apr 2016 18:37:29 +0200
Message-ID: <20160424183729.Horde.yxK_t3vqDHiCc6kvoXJqwst@webmail.informatik.kit.edu>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
 <1461498621-25422-1-git-send-email-szeder@ira.uka.de>
 <78046710-31FD-43D8-820E-95D56564C3F5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 18:38:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auN3J-0005SZ-St
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 18:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbcDXQiD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 12:38:03 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50450 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752724AbcDXQiB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 12:38:01 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1auN2i-0005dy-KQ; Sun, 24 Apr 2016 18:37:56 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1auN2I-0008Pa-0K; Sun, 24 Apr 2016 18:37:30 +0200
Received: from x4db27354.dyn.telefonica.de (x4db27354.dyn.telefonica.de
 [77.178.115.84]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sun, 24 Apr 2016 18:37:29 +0200
In-Reply-To: <78046710-31FD-43D8-820E-95D56564C3F5@gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1461515876.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292419>


Quoting Lars Schneider <larsxschneider@gmail.com>:

> On 24 Apr 2016, at 13:50, SZEDER G=C3=A1bor <szeder@ira.uka.de> wrote=
:
>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>> ---
>>
>> As far as I can tell after eyeballing the test script, this was the
>> only case where the &&-chain was broken.
>>
>> t/t9824-git-p4-git-lfs.sh | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
>> index 0b664a377c45..64f8d18216d4 100755
>> --- a/t/t9824-git-p4-git-lfs.sh
>> +++ b/t/t9824-git-p4-git-lfs.sh
>> @@ -265,7 +265,7 @@ test_expect_success 'Add big files to repo and =20
>> store files in LFS based on compr
>> 		# We only import HEAD here ("@all" is missing!)
>> 		git p4 clone --destination=3D"$git" //depot &&
>>
>> -		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYYZ=
ZZZZ"
>> +		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYYZ=
ZZZZ" &&
> Thanks! I believe I remember some script/flag to detect broken &&-cha=
ins.
> Do I imagine that or can anyone point me to it?

It was introduced in bb79af9d0970 (t/test-lib: introduce --chain-lint
option, 2015-03-20) and is enabled by default.  Unfortunately, it
can't "see" inside subshells, that's why it couldn't detect this case.


>> 		test_file_count_in_dir ".git/lfs/objects" 1 &&
>>
>> 		cat >expect <<-\EOF &&
>> --
>> 2.8.1.99.g5d5236f
>>
