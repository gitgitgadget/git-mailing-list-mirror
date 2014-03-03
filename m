From: Ilya Bobyr <ilya.bobir@gmail.com>
Subject: Re: [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
Date: Mon, 03 Mar 2014 15:16:56 -0800
Message-ID: <53150D68.7070803@gmail.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>	<1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com> <CAPig+cT46ekT87TuoTtwvt0G+DraB9cdgW1wd6NsodjJ5FmJrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:17:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKc6f-0007eB-QM
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbaCCXRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:17:04 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:52402 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbaCCXRD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:17:03 -0500
Received: by mail-pa0-f44.google.com with SMTP id bj1so4405503pad.17
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 15:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eqGtifJVNKdRdOwWTvUr/lOZCZ0GdxIopjqrWlreVZM=;
        b=0jCNwlUl3AolEJsCkI3ouZ4Gz29u8iyjyT0gm09jSURBw0xDavSctlZspo4oHjtyAB
         S6vE60uh+jNRy25NvpBqUsba4TrmdLj6p+P2jNOz+WAj1WAO9iWQ2HeOpD6V3bhwlPje
         /icdT7BI2vNiidcsZRFgvgDdvWlTabkM6XsRzUhLKjnbjE2TJ+ReM/aXp0Xm+TAb3GgT
         prtUjxm8cGmB3gifXnuGMCaaggnxSOTTw02LuthzD23AVDqS3f71cBpFi3e5o1ctt6B+
         nRN7mE2PRvFZDjqcsNU2M/w5f1zosWmg4scLSgSHtKhImWU+Zw1a6IYhIvqZqpDU2O6s
         wPZA==
X-Received: by 10.66.145.199 with SMTP id sw7mr2134787pab.143.1393888622458;
        Mon, 03 Mar 2014 15:17:02 -0800 (PST)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id fk4sm92025866pab.23.2014.03.03.15.17.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2014 15:17:01 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Thunderbird/27.0
In-Reply-To: <CAPig+cT46ekT87TuoTtwvt0G+DraB9cdgW1wd6NsodjJ5FmJrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243305>

On 3/3/2014 3:03 PM, Eric Sunshine wrote:
> On Mon, Mar 3, 2014 at 5:24 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
>> This is a counterpart to GIT_SKIP_TESTS.  Mostly useful when debugging.
> To be grammatically similar to GIT_SKIP_TESTS, perhaps name it GIT_RUN_TESTS?

There is actually an upside in the fact that the name is "different 
enough".  When you pull a command from a history it is easier to see if 
it is the excluding or the including one.
Maybe we can have a third opinion here?

>> ---
>>   t/README      |   15 +++++++++++++++
>>   t/test-lib.sh |    8 ++++++++
>>   2 files changed, 23 insertions(+), 0 deletions(-)
>>
>> diff --git a/t/README b/t/README
>> index caeeb9d..f939987 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -187,6 +187,21 @@ and either can match the "t[0-9]{4}" part to skip the whole
>>   test, or t[0-9]{4} followed by ".$number" to say which
>>   particular test to skip.
>>
>> +Sometimes the opposite is desired - ability to execute only one or
>> +several tests.  Mostly while debugging tests.  For that you can say
>> +
>> +    $ GIT_TEST_ONLY=t9200.8 sh ./t9200-git-cvsexport-commit.sh
>> +
>> +or, similrary to GIT_SKIP_TESTS
>> +
>> +    $ GIT_TEST_ONLY='t[0-4]??? t91?? t9200.8' make
>> +
>> +In additiona to matching against "<test suite number>.<test number>"
> s/additiona/addition/
>
> Plus the other typos already mentioned by Philip...

Thank you.  I will include all of those in the next version of the patch.

> [...]
