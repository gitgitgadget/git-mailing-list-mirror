From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 2/2] test-config: Add tests for the config_set API
Date: Wed, 02 Jul 2014 17:34:39 +0530
Message-ID: <53B3F557.3080001@gmail.com>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>	<1404280905-26763-3-git-send-email-tanayabh@gmail.com> <vpqzjgskt1v.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 02 14:04:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2JHR-0004w6-2I
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 14:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbaGBMEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 08:04:48 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34612 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbaGBMEr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 08:04:47 -0400
Received: by mail-pa0-f47.google.com with SMTP id kq14so12409856pab.20
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=WWmQ7I5oUsY0HckO6KVh5861NINXT4acQVLHBB7VZdk=;
        b=oLvcCnpmoyv8TiQavq2VUamPFI3zCbwCc3cYiyPWUhPSw93+9QYDaBon86pIHQvmc3
         qOby7pb9QZr4+fTx2vKTf59R4F5Y9HYOTbpvNMKG584iaS4P+NzmrTElq68RGqn3c39L
         rL2iXueDmVT86CZm8R3iFq3FQm7+sX/CIRUXcy/U4DT95jPyKYNWqxk33u7fv+J/0yZ8
         xY8EX1uGSg/70Dk5fvMUqbhwXLT+3OdqmkBXRFw7JpJuWU4HR6NZTAfG9p1sHzuDF6ke
         DzPnU4Yy4DU5rntYP5TV6qY8nzoWrVWTpaOvA1nYwomBhNs4btMvgGVL/ihYbcIOVVcY
         lRHA==
X-Received: by 10.66.254.166 with SMTP id aj6mr65759872pad.11.1404302687174;
        Wed, 02 Jul 2014 05:04:47 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.223.133])
        by mx.google.com with ESMTPSA id zc10sm129293235pac.46.2014.07.02.05.04.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 05:04:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqzjgskt1v.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252777>



On 7/2/2014 2:59 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> +test_expect_success 'clear default config' '
>> +	rm -f .git/config
>> +'
>> +
>> +cat > .git/config << EOF
> 
> t/README says:
> 
>  - Put all code inside test_expect_success and other assertions.
> 
>    Even code that isn't a test per se, but merely some setup code
>    should be inside a test assertion.
> 
> Even these cat > would better be in a test_expect_success 'initialize
> config'.
> 
> (Not applied everywhere in Git's code essentially because some tests
> were written before the guideline was set and never updated).

Sorry about that. I followed t1300-repo-config.sh which has these mistakes
also.

>> +[core]
>> +	penguin = very blue
>> +	Movie = BadPhysics
>> +	UPPERCASE = true
>> +	MixedCase = true
>> +	my =
>> +	foo
>> +	baz = sam
>> +[Cores]
>> +	WhatEver = Second
>> +[my "Foo bAr"]
>> +	hi = hello
> 
> To really stress the "case sensitive middle part" case, you should also
> have other sections like
> 
> [my "foo bar"]
> 	hi = lower-case
> [my "FOO BAR"]
> 	hi = upper-case
> 
> and check that you get the right value for my.*.hi
> 
> Similarly, I'd add a [CORE] and a [CoRe] section to check that their
> content is actually merged with [core].
>

Noted.

>> +test_expect_success 'get value for a key with value as an empty string' '
>> +	echo "" >expect &&
>> +	test-config get_value core.my >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'get value for a key with value as NULL' '
>> +	echo "(NULL)" >expect &&
>> +	test-config get_value core.foo >actual &&
>> +	test_cmp expect actual
>> +'
>> +test_expect_success 'upper case key' '
> 
> Keep the style consistent, if you separate tests with a single blank
> line, do it everywhere.
> 
>> +cat > expect << EOF
> 
> See above, should be in test_expect_success.
> 
> Also, >expect, not > expect.
> 
> There are other instances.
>

Noted. Again copied t1300-repo-config.sh style for cat.

>> +1
>> +0
>> +1
>> +1
>> +1
>> +EOF
>> +
>> +test_expect_success 'find bool value for the entered key' '
>> +	test-config get_bool goat.head >>actual &&
> 
> The first one should be a single >, or you should clear actual before
> the test.
> 

Noted.

>> +int main(int argc, char **argv)
>> +{
>> +	int i, no_of_files;
>> +	int ret = 0;
>> +	const char *v;
>> +	int val;
>> +	const struct string_list *strptr;
>> +	struct config_set cs = CONFIG_SET_INIT;
> 
> 
> 
>> +	if (argc == 3 && !strcmp(argv[1], "get_value")) {
>> +		if (!git_config_get_value(argv[2], &v)) {
>> +			if (!v)
>> +				printf("(NULL)\n");
>> +			else
>> +				printf("%s\n", v);
>> +			return 0;
>> +		} else {
>> +			printf("Value not found for \"%s\"\n", argv[2]);
>> +			return -1;
>> +		}
>> +	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
>> +		strptr = git_config_get_value_multi(argv[2]);
>> +		if (strptr) {
>> +			for (i = 0; i < strptr->nr; i++) {
>> +				v = strptr->items[i].string;
>> +				if (!v)
>> +					printf("(NULL)\n");
>> +				else
>> +					printf("%s\n", v);
>> +			}
>> +			return 0;
>> +		} else {
>> +			printf("Value not found for \"%s\"\n", argv[2]);
>> +			return -1;
>> +		}
>> +	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
>> +		if (!git_config_get_int(argv[2], &val)) {
>> +			printf("%d\n", val);
>> +			return 0;
>> +		} else {
>> +			printf("Value not found for \"%s\"\n", argv[2]);
>> +			return -1;
>> +		}
>> +	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
>> +		if (!git_config_get_bool(argv[2], &val)) {
>> +			printf("%d\n", val);
>> +			return 0;
>> +		} else {
>> +			printf("Value not found for \"%s\"\n", argv[2]);
>> +			return -1;
>> +		}
>> +	} else if (!strcmp(argv[1], "configset_get_value")) {
>> +		no_of_files = git_config_int("unused", argv[2]);
> 
> Why ask the user to give a number of files on the command-line. With a
> syntax like
> 
> test-config configset_get_value <key> <files>...
> 
> you could just use argc to iterate over argv. Here, you trust the user
> to provide the right value, and most likely segfault otherwise (and this
> is not really documented). I know this is only test code, but why not do
> it right anyway ;-).
> 

Yup, your way is much better, thanks for the review.
Tanay.
