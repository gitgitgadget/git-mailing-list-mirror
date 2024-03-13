Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE5CBA27
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 03:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710300387; cv=none; b=jtqFqHx0ih8/up7vU50GyxsYF6btWSJuRkp4o7JmRSl9KLcGa1a55QFp/ow0+1Bt7UKO+40y2OYwnNWo/SXY7tVtoqb+V8AUWfj7+R1YRq6Kx2lp3/DlfG1Bq6Lf5SyWTBu+3kNFjG+bkb8+jhXUbpuo4SuOjCuleJz8pB5s4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710300387; c=relaxed/simple;
	bh=NRy/9Nv+cvejCJ9o1xqexBAgyGpSiUUW7YgE96ZWh7c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fZxt8ZWxOqjvonYQcG/MQURe0MkOew/ExajL26QWDHjkt+q4/LsdYYdTBtHTl0GFifb5lw6wf9Amaqw6ZGYykrd/guQF7RybpI7yLWhYt3EGY5w+f5aK5AOSKYjwo9O9jE2OkMKGTORE1aICtuMa9e7d0dLXCacFPHN6WX32hF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=v710PnKY; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="v710PnKY"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710300381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1yveKFJaTMjAduVP0Pp7yOVxPuIECX/fg1cceZwEIo=;
	b=v710PnKY1T4sXQ7PfS4stcmlOLLj9J9Fvwrc1QPzLsJbxm/yFtFzZFe2UsOP60L5tPBBHf
	Yc++/zIWINN17BKsRPhor91MyFO+ysZzJeDmmfm7WJ0wwKaTGJly4nIqCFfF63u7ikr2d6
	0yh82mgPZ06PAgnAJ70tTUiJKUYDlug4U26ClHZskfMU+xqUrXkPlzPRi3WeN74Yo7YFxF
	/8AOgeysJiHdxnORXlY1mLdTWCx6DMc9U9dtUU5JuwvZOFenBfdPwBYHoxQO97FifLj7Ki
	6eV0/dA9JNQdirzJMu7IPozrWTOWiUi/uU/cfaGbctXVE/h80uVHv/85Sngp5g==
Date: Wed, 13 Mar 2024 04:26:21 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, David
 Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v3] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <fac4fec23597bff0f4594112d2a9976d@manjaro.org>
References: <20240312231559.GA116605@quokka>
 <fac4fec23597bff0f4594112d2a9976d@manjaro.org>
Message-ID: <71d525423894e02438880f46da17420d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-13 03:15, Dragan Simic wrote:
> On 2024-03-13 00:15, Peter Hutterer wrote:
>> Allow the default prefixes "a/" and "b/" to be tweaked by the
>> diff.srcprefix and diff.dstprefix configuration variables.
> 
> The only thing that's left is to update the patch description
> to use camel case. :)

I've spotted some inconsistencies in the way camel case is already
used in some of the "diff.*" configuration option names, so I went
ahead and fixed those.  I'll send the patches after I figure out how
to best split the changes into patches for easier review, because
there are quite a few small changes.

>> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
>> ---
>> Changes to v2;
>> - doc: change to camelcase diff.srcPrefix/diff.dstPrefix for
>>   consistency with diff.mnemonicPrefix and most other options
>> - git diff --default-prefix forces a/ and b/ regardless of configured
>>   prefix, see the 'diff_opt_default_prefix' hunk in the patch below.
>> 
>> The latter may be slightly controversial but: there are scripts out
>> there that rely on the a/ and b/ prefix (came across one last night).
>> With a custom prefix those scripts will break, having an option that
>> forces the a/ and b/ prefix helps. Plus the man page explicitly says:
>>   Use the default source and destination prefixes ("a/" and "b/").
>> So let's stick with that behaviour then.
>> 
>>  Documentation/config/diff.txt |  6 ++++++
>>  diff.c                        | 14 ++++++++++++--
>>  t/t4013-diff-various.sh       | 35 
>> +++++++++++++++++++++++++++++++++++
>>  3 files changed, 53 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/config/diff.txt 
>> b/Documentation/config/diff.txt
>> index 6c7e09a1ef5e..afc23d7723b6 100644
>> --- a/Documentation/config/diff.txt
>> +++ b/Documentation/config/diff.txt
>> @@ -111,6 +111,12 @@ diff.mnemonicPrefix::
>>  diff.noprefix::
>>  	If set, 'git diff' does not show any source or destination prefix.
>> 
>> +diff.srcPrefix::
>> +	If set, 'git diff' uses this source prefix. Defaults to 'a/'.
>> +
>> +diff.dstPrefix::
>> +	If set, 'git diff' uses this destination prefix. Defaults to 'b/'.
>> +
>>  diff.relative::
>>  	If set to 'true', 'git diff' does not show changes outside of the 
>> directory
>>  	and show pathnames relative to the current directory.
>> diff --git a/diff.c b/diff.c
>> index e50def45383e..108c1875775d 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -62,6 +62,8 @@ static const char *diff_order_file_cfg;
>>  int diff_auto_refresh_index = 1;
>>  static int diff_mnemonic_prefix;
>>  static int diff_no_prefix;
>> +static const char *diff_src_prefix = "a/";
>> +static const char *diff_dst_prefix = "b/";
>>  static int diff_relative;
>>  static int diff_stat_name_width;
>>  static int diff_stat_graph_width;
>> @@ -408,6 +410,12 @@ int git_diff_ui_config(const char *var, const 
>> char *value,
>>  		diff_no_prefix = git_config_bool(var, value);
>>  		return 0;
>>  	}
>> +	if (!strcmp(var, "diff.srcprefix")) {
>> +		return git_config_string(&diff_src_prefix, var, value);
>> +	}
>> +	if (!strcmp(var, "diff.dstprefix")) {
>> +		return git_config_string(&diff_dst_prefix, var, value);
>> +	}
>>  	if (!strcmp(var, "diff.relative")) {
>>  		diff_relative = git_config_bool(var, value);
>>  		return 0;
>> @@ -3425,8 +3433,8 @@ void diff_set_noprefix(struct diff_options 
>> *options)
>> 
>>  void diff_set_default_prefix(struct diff_options *options)
>>  {
>> -	options->a_prefix = "a/";
>> -	options->b_prefix = "b/";
>> +	options->a_prefix = diff_src_prefix;
>> +	options->b_prefix = diff_dst_prefix;
>>  }
>> 
>>  struct userdiff_driver *get_textconv(struct repository *r,
>> @@ -5362,6 +5370,8 @@ static int diff_opt_default_prefix(const struct
>> option *opt,
>> 
>>  	BUG_ON_OPT_NEG(unset);
>>  	BUG_ON_OPT_ARG(optarg);
>> +	diff_src_prefix = "a/";
>> +	diff_dst_prefix = "b/";
>>  	diff_set_default_prefix(options);
>>  	return 0;
>>  }
>> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>> index 1e3b2dbea484..e75f9f7d4cb2 100755
>> --- a/t/t4013-diff-various.sh
>> +++ b/t/t4013-diff-various.sh
>> @@ -663,6 +663,41 @@ test_expect_success 'diff --default-prefix
>> overrides diff.mnemonicprefix' '
>>  	check_prefix actual a/file0 b/file0
>>  '
>> 
>> +test_expect_success 'diff respects diff.srcprefix' '
>> +	git -c diff.srcprefix=x/ diff >actual &&
>> +	check_prefix actual x/file0 b/file0
>> +'
>> +
>> +test_expect_success 'diff respects diff.dstprefix' '
>> +	git -c diff.dstprefix=y/ diff >actual &&
>> +	check_prefix actual a/file0 y/file0
>> +'
>> +
>> +test_expect_success 'diff --src-prefix overrides diff.srcprefix' '
>> +	git -c diff.srcprefix=z/ diff --src-prefix=z/ >actual &&
>> +	check_prefix actual z/file0 b/file0
>> +'
>> +
>> +test_expect_success 'diff --dst-prefix overrides diff.dstprefix' '
>> +	git -c diff.dstprefix=y/ diff --dst-prefix=z/ >actual &&
>> +	check_prefix actual a/file0 z/file0
>> +'
>> +
>> +test_expect_success 'diff src/dstprefix ignored with diff.noprefix' '
>> +	git -c diff.dstprefix=y/ -c diff.srcprefix=x/ -c diff.noprefix diff 
>> >actual &&
>> +	check_prefix actual file0 file0
>> +'
>> +
>> +test_expect_success 'diff src/dstprefix ignored with 
>> diff.mnemonicprefix' '
>> +	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ -c diff.mnemonicprefix
>> diff >actual &&
>> +	check_prefix actual i/file0 w/file0
>> +'
>> +
>> +test_expect_success 'diff src/dstprefix ignored with 
>> --default-prefix' '
>> +	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ diff --default-prefix 
>> >actual &&
>> +	check_prefix actual a/file0 b/file0
>> +'
>> +
>>  test_expect_success 'diff --no-renames cannot be abbreviated' '
>>  	test_expect_code 129 git diff --no-rename >actual 2>error &&
>>  	test_must_be_empty actual &&
