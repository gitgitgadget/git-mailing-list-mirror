From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 2/2] submodule: don't print status output with ignore=all
Date: Wed, 04 Sep 2013 23:26:08 +0200
Message-ID: <5227A570.7040500@web.de>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net> <1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net> <xmqqob89r8bc.fsf@gitster.dls.corp.google.com> <522791AE.8070103@web.de> <xmqqli3cl2yk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, judge.packham@gmail.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 23:26:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHKan-0000H4-KY
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 23:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab3IDV0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 17:26:12 -0400
Received: from mout.web.de ([212.227.15.4]:58234 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755443Ab3IDV0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 17:26:12 -0400
Received: from [192.168.178.41] ([91.3.170.120]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MeScR-1VdhC21WBz-00QFik for <git@vger.kernel.org>;
 Wed, 04 Sep 2013 23:26:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqli3cl2yk.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:afZGsV4v7SPVkKcOvs7gl+wsGALJh3B0rMz98NVUGBpgfgQBeq0
 xJMVTRTWdA/qN4wflTsSsqxm6UsInugl6lr+4XQq+Imc0DdWJ1olUHQIMnpLk6PkJfdlt1Z
 W0oyIuk7v/GZX2LfQKhlQcKR9WtsdHkt5pIU7+/NrUWaHviLA0R68D6dFg5P1zaGa7Ksj9o
 kjKaXaHrmtHH4PF8/ByRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233878>

Am 04.09.2013 22:57, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 03.09.2013 21:53, schrieb Junio C Hamano:
>>> Does this update to 2/2 look good to you?  Sorry, but I lost track
>>> of the discussion that led to this reroll, hence a ping.
>>
>> v3 fixes the bug Matthieu noticed, I only had some remarks to the
>> new test Brian added. If you could replace his patch to t7401 with
>> the following diff it's an ack from me on this one too.
>>
>> -------------------------8<---------------------------
>> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
>> index ac2434c..81ae7c9 100755
>> --- a/t/t7401-submodule-summary.sh
>> +++ b/t/t7401-submodule-summary.sh
>> @@ -104,6 +104,24 @@ EOF
>>  	test_cmp expected actual
>>  "
>>
>> +test_expect_success 'no ignore=all setting has any effect' "
>> +	git config -f .gitmodules submodule.sm1.path sm1 &&
>> +	git config -f .gitmodules submodule.sm1.ignore all &&
>> +	git config submodule.sm1.ignore all &&
>> +	git config diff.ignoreSubmodules all &&
>> +	git submodule summary >actual &&
>> +	cat >expected <<-EOF &&
>> +* sm1 $head1...$head2 (1):
>> +  > Add foo3
>> +
>> +EOF
>> +	test_cmp expected actual &&
>> +	git config --unset diff.ignoreSubmodules &&
>> +	git config --remove-section submodule.sm1 &&
>> +	git config -f .gitmodules --remove-section submodule.sm1
>> +"
>> +
>> +
>>  commit_file sm1 &&
>>  head3=$(
>>  	cd sm1 &&
> 
> Thanks.
> 
> The above patch makes the <<-EOF situation that already exists in
> this script worse. The only reason we would say -EOF not EOF is
> because we would want to indent the here-document to align with the
> rest of the command sequence, so we should either indent with HT, or
> drop the dash.  I suspect the original did it that way fearing that
> someday the indentation of the submodule difference list might start
> using HT, but I do not think that is likely to happen, so my vote
> goes to keeping '-' and indenting.
> 
> We need a clean-up patch after this series settles.

Ok, will do (unless someone else volunteers ;-).
