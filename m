Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FDBC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3A364F03
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhBYS3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:29:31 -0500
Received: from [93.83.142.38] ([93.83.142.38]:54090 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S233269AbhBYS27 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 13:28:59 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 21DAA2BFE8;
        Thu, 25 Feb 2021 19:28:35 +0100 (CET)
Subject: Re: [PATCH v3 12/35] userdiff tests: change setup loop to individual
 test setup
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210224195129.4004-13-avarab@gmail.com> <xmqqa6rsyi2u.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5fb2fd5c-7c69-a6fe-566d-227ed09946e4@kdbg.org>
Date:   Thu, 25 Feb 2021 19:28:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqa6rsyi2u.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.02.21 um 03:52 schrieb Junio C Hamano:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
>> +# check each individual file
>> +for i in $(git -C t4018 ls-files)
>> +do
>> +	test_expect_success "setup hunk header: $i" "
>> +		grep -v '^t4018' \"t4018/$i\" >\"t4018/$i.content\" &&
>> +		sed -n -e 's/^t4018 header: //p' <\"t4018/$i\" >\"t4018/$i.header\" &&
>> +		cp \"t4018/$i.content\" \"$i\" &&
>>  
>>  		# add test file to the index
>> -		git add "$i" &&
>> +		git add \"$i\" &&
>>  		# place modified file in the worktree
>> -		sed -e "s/ChangeMe/IWasChanged/" <"t4018/$i.content" >"$i" || return 1
>> -	done
>> -'
>> +		sed -e 's/ChangeMe/IWasChanged/' <\"t4018/$i.content\" >\"$i\"
>> +	"
> 
> Please use '' around the second argument (i.e. test body) of the
> test_expect_success, and use "" inside it.  "$i" that is used in the
> loop is visible perfectly fine inside the test body when it is
> eval'ed, and we won't have to count ugly backslashes that way.

If we do that, then we better be sure that the implementation of
test_expect_success does not clobber $i. Looks like we are OK at this time.

-- Hannes
