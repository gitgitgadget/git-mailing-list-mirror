From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH] t9300: use cmp instead of test_cmp to compare binary
 files
Date: Fri, 12 Sep 2014 20:14:42 +0200
Message-ID: <54133812.2050002@virtuell-zuhause.de>
References: <54132E88.8050803@kdbg.org> <xmqq1trgbu0p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 20:15:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSVN2-0001hn-4X
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 20:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbaILSOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 14:14:52 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:58517 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750925AbaILSOv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 14:14:51 -0400
Received: from p5ddc2271.dip0.t-ipconnect.de ([93.220.34.113] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XSVMv-00049M-L3; Fri, 12 Sep 2014 20:14:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <xmqq1trgbu0p.fsf@gitster.dls.corp.google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1410545691;242bba7c;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256936>

Am 12.09.2014 um 19:58 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> test_cmp is intended to produce diff output for human consumption. The
>> input in one instance in t9300-fast-import.sh are binary files, however.
>> Use cmp to compare the files.
> 
> Thanks.
> 
>>
>> This was noticed because on Windows we have a special implementation of
>> test_cmp in pure bash code (to ignore differences due to intermittent CR
>> in actual output), and bash runs into an infinite loop due to the binary
>> nature of the input.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>  t/t9300-fast-import.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
>> index 99f5161..4b13170 100755
>> --- a/t/t9300-fast-import.sh
>> +++ b/t/t9300-fast-import.sh
>> @@ -2687,7 +2687,7 @@ test_expect_success 'R: verify created pack' '
>>  test_expect_success \
>>  	'R: verify written objects' \
>>  	'git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
>> -	 test_cmp expect actual &&
>> +	 cmp expect actual &&
>>  	 a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
>>  	 b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
>>  	 test $a = $b'

May I suggest to use test_cmp_bin instead of plain cmp?
test_cmp_bin was introduced in
b93e6e36 (t5000, t5003: do not use test_cmp to compare binary files,
2014-06-04) and by default is plain cmp.
