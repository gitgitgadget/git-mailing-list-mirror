Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 902BA1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 10:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbeG0L6Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 07:58:16 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:53365 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbeG0L6P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 07:58:15 -0400
Received: from [192.168.2.201] ([92.22.29.59])
        by smtp.talktalk.net with SMTP
        id j079faknBVlGZj079fo1nN; Fri, 27 Jul 2018 11:36:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532687812;
        bh=j4nFHrOZOftKlcMdw5lbPMLKzJAQxWYA+Mc9DUcMMKk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mwCz1ZsHnPCuAU/wR8TIzZ/g9pPEaMIpVrdxpDlO8X7Twt1OnN+e7S8dhhIyFRNvY
         253aeKXA/WaD36gLZHhWUdiX3R7xACtpzMLqQmTlEOrvjYNrOxeULCuvfVQo+QqD3Y
         U2BFJehIf0N9e21XVwChKZnZNnsuUEn0J1+Yob8E=
X-Originating-IP: [92.22.29.59]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=OmzqbFWWvC/aSYX+a7e/kQ==:117
 a=OmzqbFWWvC/aSYX+a7e/kQ==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=NEAV23lmAAAA:8 a=F2ugIi3ErqxBLyvY5lMA:9 a=0lv490x5G0jFPDSd:21
 a=DzjcY7t-wsgbAbP1:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] sequencer: fix quoting in write_author_script
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@iDaemons.org>
References: <eb295aea-dae5-5e1c-bacf-2c77d3ce0195@talktalk.net>
 <20180718155518.1025-1-phillip.wood@talktalk.net>
 <nycvar.QRO.7.76.6.1807261332130.71@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <dae25f9d-5fde-a9c5-2178-9e06f3150885@talktalk.net>
Date:   Fri, 27 Jul 2018 11:36:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1807261332130.71@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPdKluoo6MVJzLXQYkXUZKRrw7prtqt7PO7Fwps60ZoemXvGwsboKbdFBPOp146XxJAhH0SoywTxtUErRs0FnmKFu8Nr+3fNHfUj6nBqgkhdAICAPS7u
 WLkZz2IA6EgML08rlEra11nDkR+6Sm11PqeH9KtPFcS+RlHRqKB4vkh9JCkNvn+JottWV/EaAFvmtwcGsihHMLFq0jl4ivJy5krSCBU+mN3yZcC7yo1Nnq8q
 G5VpPmrV+2c0D4ixfHz9KbRlZHEEaWPZInwkk8DIPTaCJP5kgy6hkYvLfDtuK2VfEdChHCPVp+SIdQMbTytSbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes
On 26/07/18 13:33, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 18 Jul 2018, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Single quotes should be escaped as \' not \\'. Note that this only
>> affects authors that contain a single quote and then only external
>> scripts that read the author script and users whose git is upgraded from
>> the shell version of rebase -i while rebase was stopped. This is because
>> the parsing in read_env_script() expected the broken version and for
>> some reason sq_dequote() called by read_author_ident() seems to handle
>> the broken quoting correctly.
>>
>> Ideally write_author_script() would be rewritten to use
>> split_ident_line() and sq_quote_buf() but this commit just fixes the
>> immediate bug.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
> 
> Good catch.
> 
>> This is untested, unfortuantely I don't have really have time to write a test or
>> follow this up at the moment, if someone else want to run with it then please
>> do.
> 
> I modified the test that was added by Akinori. As it was added very early,
> and as there is still a test case *after* Akinori's that compares a
> hard-coded SHA-1, I refrained from using `test_commit` (which would change
> that SHA-1). See below.

Thanks for adding a test, that sounds like sensible approach, however
having thought about it I wonder if we should just be writing a plain
text file (e.g rebase-merge/author-data) and fixing the reader to read
that if it exists and only then fall back to reading the legacy
rebase-merge/author-script with a fix to correctly handle the script
written by the shell version - what do you think? The author-script
really should be just an implementation detail. If anyone really wants
to read it they can still do 'read -r l' and split the lines with
${l%%=*} and ${l#*=}

>> diff --git a/sequencer.c b/sequencer.c
>> index 5354d4d51e..0b78d1f100 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -638,21 +638,21 @@ static int write_author_script(const char *message)
>>  		else if (*message != '\'')
>>  			strbuf_addch(&buf, *(message++));
>>  		else
>> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
>> +			strbuf_addf(&buf, "'\\%c'", *(message++));
>>  	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
>>  	while (*message && *message != '\n' && *message != '\r')
>>  		if (skip_prefix(message, "> ", &message))
>>  			break;
>>  		else if (*message != '\'')
>>  			strbuf_addch(&buf, *(message++));
>>  		else
>> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
>> +			strbuf_addf(&buf, "'\\%c'", *(message++));
>>  	strbuf_addstr(&buf, "'\nGIT_AUTHOR_DATE='@");
>>  	while (*message && *message != '\n' && *message != '\r')
>>  		if (*message != '\'')
>>  			strbuf_addch(&buf, *(message++));
>>  		else
>> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
>> +			strbuf_addf(&buf, "'\\%c'", *(message++));
>>  	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
> 
> I resolved the merge conflict with Akinori's patch. FWIW I pushed all of
> this, including the fixup to Junio's fixup to the
> `fix-t3404-author-script-test` branch at https://github.com/dscho/git.
> 
>>  	strbuf_release(&buf);
>>  	return res;
>> @@ -666,13 +666,21 @@ static int read_env_script(struct argv_array *env)
>>  {
>>  	struct strbuf script = STRBUF_INIT;
>>  	int i, count = 0;
>> -	char *p, *p2;
>> +	const char *p2;
>> +	char *p;
>>  
>>  	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
>>  		return -1;
>>  
>>  	for (p = script.buf; *p; p++)
>> -		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
>> +		/*
>> +		 * write_author_script() used to escape "'" incorrectly as
>> +		 * "'\\\\''" rather than "'\\''" so we check for the correct
>> +		 * version the incorrect version in case git was upgraded while
>> +		 * rebase was stopped.
>> +		 */
>> +		if (skip_prefix(p, "'\\''", &p2) ||
>> +		    skip_prefix(p, "'\\\\''", &p2))
> 
> I think in this form, it is possibly unsafe because it assumes that the
> new code cannot generate output that would trigger that same code path.
> Although I have to admit that I did not give this a great deal of thought.

Hm, I not sure that it can. If the Author begins \\' then this will be
written as the C string "'\\\\'\\''...". If \\' comes at the end then I
think this will be written as "\\\\'\\'''", in the middle of the name it
will be "\\\\'\\''..."

> In any case, if you have to think long and hard about some fix, it might
> be better to go with something that is easier to reason about. So how
> about this: we already know that the code is buggy, Akinori fixed the bug,
> where the author-script missed its trailing single-quote. We can use this
> as a tell-tale for *this* bug. Assuming that Junio will advance both your
> and Akinori's fix in close proximity.

That sounds like a good approach
> Again, this is pushed to the `fix-t3404-author-script-test` branch at
> https://github.com/dscho/git; My fixup on top of your patch looks like
> this (feel free to drop the sq_bug part and only keep the test part):
> 
> -- snipsnap --
> diff --git a/sequencer.c b/sequencer.c
> index 46c0b3e720f..7abe78dc78e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -573,13 +573,14 @@ static int write_author_script(const char *message)
>  static int read_env_script(struct argv_array *env)
>  {
>  	struct strbuf script = STRBUF_INIT;
> -	int i, count = 0;
> +	int i, count = 0, sq_bug;
>  	const char *p2;
>  	char *p;
>  
>  	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
>  		return -1;
>  
> +	sq_bug = script.len && script.buf[script.len - 1] != '\'';
>  	for (p = script.buf; *p; p++)
>  		/*
>  		 * write_author_script() used to escape "'" incorrectly as
> @@ -587,8 +588,9 @@ static int read_env_script(struct argv_array *env)
>  		 * version the incorrect version in case git was upgraded while
>  		 * rebase was stopped.
>  		 */

We probably want the change the comment slightly to explain sq_bug

> -		if (skip_prefix(p, "'\\''", &p2) ||
> -		    skip_prefix(p, "'\\\\''", &p2))
> +		if (sq_bug && skip_prefix(p, "'\\\\''", &p2))
> +			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
> +		else if (skip_prefix(p, "'\\''", &p2))
>  			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
>  		else if (*p == '\'')
>  			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 97f0b4bf881..dd726ff4dc4 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -75,16 +75,18 @@ test_expect_success 'rebase --keep-empty' '
>  	test_line_count = 6 actual
>  '
>  
> +SQ="'"
>  test_expect_success 'rebase -i writes correct author-script' '
>  	test_when_finished "test_might_fail git rebase --abort" &&
> -	git checkout master &&
> +	git checkout -b author-with-sq master &&
> +	GIT_AUTHOR_NAME="Auth O$SQ R" git commit --allow-empty -m with-sq &&
>  	set_fake_editor &&
> -	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
> +	FAKE_LINES="edit 1" git rebase -ki HEAD^ &&
>  	(
>  		sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
>  		. .git/rebase-merge/author-script &&
>  		test "$(git show -s --date=raw --format=%an,%ae,@%ad)" = \
> -			"$GIT_AUTHOR_NAME,$GIT_AUTHOR_EMAIL,$GIT_AUTHOR_DATE"
> +			"Auth O$SQ R,$GIT_AUTHOR_EMAIL,$GIT_AUTHOR_DATE"
>  	)
>  '

Testing all three variables together is nice.

Best Wishes

Phillip

> @@ -1347,7 +1349,6 @@ test_expect_success 'editor saves as CR/LF' '
>  	)
>  '
>  
> -SQ="'"
>  test_expect_success 'rebase -i --gpg-sign=<key-id>' '
>  	set_fake_editor &&
>  	FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" HEAD^ \
> 

