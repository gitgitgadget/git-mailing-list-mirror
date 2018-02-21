Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86311F576
	for <e@80x24.org>; Wed, 21 Feb 2018 11:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbeBUL0j (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 06:26:39 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:44407 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753896AbeBUL0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 06:26:36 -0500
Received: from [192.168.2.240] ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id oSXgeEdiqYeIpoSXhecntm; Wed, 21 Feb 2018 11:26:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519212394;
        bh=qlmeUjhBYzTp6vSY37MtxfhQdFHIdgvyq/lohZDvnoU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Zj8Nn9cSLqZLhV4LD42kYw1H8FFOr1JH0Iep+F/fb7Pnpm1TsosajlgBy87SLDP4l
         6uK8O37El0/TVML7gc6D2xgE8uWNVfbLDq6GJB0UnBM1jSn7++vEriHctQBh9bqwf1
         3EP2xlCINQRkpd/O+Se3UkTuRLeLAhJbHJFRJprg=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=WZB8UwpX c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=IkcTkHD0fZMA:10 a=BCjA09oAAAAA:8
 a=2ubVzkizJVlQS-h7FGAA:9 a=QEXdDO2ut3YA:10 a=jYKBPJSq9nmHKCndOPe9:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/9] t3701: use test_write_lines and write_script
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net>
 <20180219112910.24471-4-phillip.wood@talktalk.net>
 <CAPig+cRWCd6pYxc8NrOM_ntodgkwwfMpD_tWQXYXOukVWgQfCw@mail.gmail.com>
 <xmqqr2pf4m0l.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <372bd26b-4e95-3f82-a1b1-dd0191568503@talktalk.net>
Date:   Wed, 21 Feb 2018 11:26:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2pf4m0l.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDBZeabIZThfwTAdfYivfQdDGAJN1gbaGvjFVXLDKE+xJdC6Rfm8sbNXMdr6fXL9yaucucRfJkAujhEThBiroAwpqWdZjJL83w99CO4HrEq7nZihKWEi
 glnExxSHn1S8eNhyrZCprl9yg9BLFxDfiu02wUPz35e6vnYau30ViyoMDKPR7xeljwdC4lu67U/HLf8qcNlhLWX2Jd3TFhU+p2Vi06obooyqSTzkOt+ttGa+
 9KwqE1eDyXHZQw03QDy27oKt0HIFoqNrGU5PSnQPuJ6fy4czRIBrLMn3CL6PRajr2Fd3UJcu2/bQLFOlO1cwqxR7qCm/bDwU2AhbGqsKBMk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/02/18 17:19, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>>>   test_expect_success 'setup fake editor' '
>>> -       echo "#!$SHELL_PATH" >fake_editor.sh &&
>>> -       cat >>fake_editor.sh <<-\EOF &&
>>> +       FAKE_EDITOR="$(pwd)/fake-editor.sh" &&
>>> +       write_script "$FAKE_EDITOR" <<-\EOF &&
>>>          mv -f "$1" oldpatch &&
>>>          mv -f patch "$1"
>>>          EOF
>>> -       chmod a+x fake_editor.sh &&
>>> -       test_set_editor "$(pwd)/fake_editor.sh"
>>> +       test_set_editor "$FAKE_EDITOR"
>>>   '
>>
>> The very first thing that test_set_editor() does is set FAKE_EDITOR to
>> the value of $1, so it is confusing to see it getting setting it here
>> first; the reader has to spend extra brain cycles wondering if
>> something non-obvious is going on that requires this manual
>> assignment. Perhaps drop the assignment altogether and just write
>> literal "fake_editor.sh" in the couple places it's needed (as was done
>> in the original code)?
> 
> Yeah, I think $(pwd)/ prefix is needed at the final step (i.e. as
> the first argument to test_set_editor) for this to be a faithful
> rewrite but it is distracting having to write it anywhere else.
> 
> Other than that, this looks like a quite straight-forward cleanup.
> 
> Thanks, both.  Here is what I'd be queuing tentatively.

That looks good, thanks for fixing it up

Phillip
> 
>   t/t3701-add-interactive.sh | 33 +++++----------------------------
>   1 file changed, 5 insertions(+), 28 deletions(-)
> 
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 39c7423069..4a369fcb51 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -87,13 +87,8 @@ test_expect_success 'setup expected' '
>   	EOF
>   '
>   
> -test_expect_success 'setup fake editor' '
> -	>fake_editor.sh &&
> -	chmod a+x fake_editor.sh &&
> -	test_set_editor "$(pwd)/fake_editor.sh"
> -'
> -
>   test_expect_success 'dummy edit works' '
> +	test_set_editor : &&
>   	(echo e; echo a) | git add -p &&
>   	git diff > diff &&
>   	test_cmp expected diff
> @@ -110,12 +105,10 @@ test_expect_success 'setup patch' '
>   '
>   
>   test_expect_success 'setup fake editor' '
> -	echo "#!$SHELL_PATH" >fake_editor.sh &&
> -	cat >>fake_editor.sh <<-\EOF &&
> +	write_script "fake_editor.sh" <<-\EOF &&
>   	mv -f "$1" oldpatch &&
>   	mv -f patch "$1"
>   	EOF
> -	chmod a+x fake_editor.sh &&
>   	test_set_editor "$(pwd)/fake_editor.sh"
>   '
>   
> @@ -302,18 +295,12 @@ test_expect_success 'deleting an empty file' '
>   
>   test_expect_success 'split hunk setup' '
>   	git reset --hard &&
> -	for i in 10 20 30 40 50 60
> -	do
> -		echo $i
> -	done >test &&
> +	test_write_lines 10 20 30 40 50 60 >test &&
>   	git add test &&
>   	test_tick &&
>   	git commit -m test &&
>   
> -	for i in 10 15 20 21 22 23 24 30 40 50 60
> -	do
> -		echo $i
> -	done >test
> +	test_write_lines 10 15 20 21 22 23 24 30 40 50 60 >test
>   '
>   
>   test_expect_success 'split hunk "add -p (edit)"' '
> @@ -334,17 +321,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
>   '
>   
>   test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
> -	cat >test <<-\EOF &&
> -	5
> -	10
> -	20
> -	21
> -	30
> -	31
> -	40
> -	50
> -	60
> -	EOF
> +	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
>   	git reset &&
>   	# test sequence is s(plit), n(o), y(es), e(dit)
>   	# q n q q is there to make sure we exit at the end.
> 

