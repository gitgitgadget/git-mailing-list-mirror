From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH/RFC] t0000-*.sh: Fix the GIT_SKIP_TESTS sub-tests
Date: Tue, 20 May 2014 23:20:04 +0100
Message-ID: <537BD514.4040708@ramsay1.demon.co.uk>
References: <537BC8A2.9060009@ramsay1.demon.co.uk> <20140520214006.GT12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Ilya Bobyr <ilya.bobyr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 00:20:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmsON-000706-GB
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 00:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbaETWUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 18:20:09 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:58504 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750835AbaETWUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 18:20:08 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 4A2F212807B;
	Tue, 20 May 2014 23:20:14 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 0611412807A;
	Tue, 20 May 2014 23:20:14 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Tue, 20 May 2014 23:20:13 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140520214006.GT12314@google.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249755>

On 20/05/14 22:40, Jonathan Nieder wrote:
> Ramsay Jones wrote:
> 
>> --- a/t/t0000-basic.sh
>> +++ b/t/t0000-basic.sh
>> @@ -296,8 +296,9 @@ test_expect_success 'test --verbose-only' '
>>  '
>>  
>>  test_expect_success 'GIT_SKIP_TESTS' "
>> -	GIT_SKIP_TESTS='git.2' \
>> -		run_sub_test_lib_test git-skip-tests-basic \
>> +	GIT_SKIP_TESTS='git.2' && export GIT_SKIP_TESTS &&
>> +	test_when_finished sane_unset GIT_SKIP_TESTS &&
> 
> Oof.  Good catch.
> 
> What should happen if I have set GIT_SKIP_TESTS explicitly to run
> only some of the tests in t0000-basic?

A quick test (with the above patch applied) shows that
it works as I would expect:

  $  GIT_SKIP_TESTS=t0000.1[2-6] ./t0000-basic.sh
  ...
  ok 11 - test --verbose
  ok 12 # skip test --verbose-only (GIT_SKIP_TESTS)
  ok 13 # skip GIT_SKIP_TESTS (GIT_SKIP_TESTS)
  ok 14 # skip GIT_SKIP_TESTS several tests (GIT_SKIP_TESTS)
  ok 15 # skip GIT_SKIP_TESTS sh pattern (GIT_SKIP_TESTS)
  ok 16 # skip --run basic (GIT_SKIP_TESTS)
  ok 17 - --run with a range
  ...
  ok 77 - very long name in the index handled sanely
  # passed all 77 test(s)
  1..77
  $ 

ATB,
Ramsay Jones
