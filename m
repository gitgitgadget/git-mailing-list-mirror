From: Ilya Bobyr <ilya.bobir@gmail.com>
Subject: Re: [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
Date: Mon, 03 Mar 2014 15:48:41 -0800
Message-ID: <531514D9.4000101@gmail.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>	<1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com>	<CAPig+cT46ekT87TuoTtwvt0G+DraB9cdgW1wd6NsodjJ5FmJrA@mail.gmail.com> <xmqqob1mn9t6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:48:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKcbM-0004VP-VP
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbaCCXst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:48:49 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:49836 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182AbaCCXss (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:48:48 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so528869pad.0
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 15:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5FN0n8QWuhg44VFTXUSDFBq+D5aSIAb4vBNOZlkNaLc=;
        b=hq5R01gtWONCcd9pTLqVXDX5dZP2Yq88LnqVS3owYInQZTAT64KUQpVf5aCbYnWh8L
         h+K9oS38qYGlhF2ctFEkCi/CtHsnQb8L5RLioiRkI+h1WABETOnMFll/Oti9Z0NAeM9k
         VEN49aoxlHs8o8lANqjBdyAFfhJBndpCwBFVPPysFVeKGP0nv3P+MLfYZNrJ9YxTTyv7
         PhbzOmPy/ApJIDFmmYmt02P7e8TkcIH8s7RlF9U0cYO3Hmqhsyq2IIB+HEvkQltMmesg
         Tyq+Qe9nPDwngjDralh9y082WrXoemn86b3MVBdkf9vk2M3Na3uUDA+mdEgGQpo7IiHC
         yLDQ==
X-Received: by 10.66.142.170 with SMTP id rx10mr2324389pab.117.1393890528124;
        Mon, 03 Mar 2014 15:48:48 -0800 (PST)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id eb5sm92497016pad.22.2014.03.03.15.48.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2014 15:48:47 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Thunderbird/27.0
In-Reply-To: <xmqqob1mn9t6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243314>

On 3/3/2014 3:26 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Mon, Mar 3, 2014 at 5:24 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
>>> This is a counterpart to GIT_SKIP_TESTS.  Mostly useful when debugging.
>> To be grammatically similar to GIT_SKIP_TESTS, perhaps name it GIT_RUN_TESTS?
> I actually do not like the interface to use two variables very much.
> Can't we just allow negative entries on "to be skipped" list?
>
> That is
>
> 	GIT_SKIP_TESTS='t9??? !t91??'
>
> would skip nine-thousand series, but would run 91xx series, and all
> the others are not excluded.
>
> Simple rules to consider:
>
>   - If the list consists of _only_ negated patterns, pretend that
>     there is "unless otherwise specified with negatives, skip all
>     tests", i.e. treat GIT_SKIP_TESTS='!t91??' just the same way you
>     would treat GIT_SKIP_TESTS='* !t91??'.
>
>   - The orders should not matter for simplicity of the semantics;
>     before running each test, check if it matches any negative (and
>     run it if it matches, without looking at any positives), and
>     otherwise check if it matches any positive (and skip it if it
>     does not).
>
> Hmm?

I can do that.  But I am not sure that matches the use cases I had in 
mind the best.

First use case is that while developing I want to run tests frequently 
and I have a specific test that I am working on at the moment.
That test is broken and I am trying to fix it (TDD).
I want to run just the initialization test(s) and then that specific test.
Running everything is quite slow.

GIT_RUN_ONLY addresses the TDD case.

Second case is when I broke one or more tests and want to figure out 
what is wrong.
In this case running tests after the broken one will clutter the output 
directory and will make debugging somewhat harder, especially if I am 
not familiar with all the tests.

For the second case I was actually thinking that something like 
"<t9100.32" would be useful, where 32 is the broken test.

Maybe we can come up with an interface that covers all 3 cases?

While exclusion can be used it adds an extra step to both cases, as you 
need to mentally negate what you want first.

It might be that we are looking at different use cases, as you are 
talking about whole test suits.
