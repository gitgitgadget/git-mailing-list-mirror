Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C24548F2
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355680; cv=none; b=iy/1wLekb3jOpYHsJGWaAtgJx2q4tC4r31BD2WC9OcRTByRqfy2kXHvsBMRS2qp3FY1HHggo2BmT5Zg4tXLMYXckR1cv59BtouF6l/LdDiwalUd3JPnieKH7jSCO8i7yUFTyH36vz2rGLH1YWBrRa7lLU2y0lTj2Qv9jjQZJpkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355680; c=relaxed/simple;
	bh=0QpqyAneQ5bKDuyLVC5l91h4S5Qdfbn/d7J6JZlyzFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pA0J5TReSGKx4p602IR5AvHfZnzo/ETwVL1gmlmQgZlqAc5CgGu37UeQANY45dj/iMlur9ZZ0rAjcyMrktnBn+NOHPf5eBTPxZgi7jCl1wVxoIP/dFVPpCw5E1gqeBmK90hSch0Rzt2O7pLv16NApU1+vggmtGdylcUwdRTNlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=p7nJsk0m; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="p7nJsk0m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1710355668; x=1710960468; i=l.s.r@web.de;
	bh=0QpqyAneQ5bKDuyLVC5l91h4S5Qdfbn/d7J6JZlyzFQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=p7nJsk0mUEeIhe+D6WIoDKYIqlu24Ejme9UzKRGScJ70P7awbceqIIE919WVzZet
	 b2QXc5/eWtEgYNGzdd9p9/KCZYmXv9Nki4Apt5M3KstDpBdOvsxoFzjQjQQsxmRUi
	 c0iX6M9tioo6ORCz9D4NrJ9Nc6oeeP61k3iYog82q/IXnkwAlf5TRhluVq8O+oj+9
	 3gb9vp6ubh3jAkzJO1e2OQYr4NuzwYOThKnIp7Y5X87FvovsU3K1Mfdfr6AL0+run
	 oa7TOMewgyzQK2AQ8s4IvdVr9jRI2SI6ME/Lnt4WUyJlKSq8uBq+uIClDNucd//C5
	 0ans3kPvEL/8jZCOjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOli-1rNHOi3Gwu-00UFAt; Wed, 13
 Mar 2024 19:47:48 +0100
Message-ID: <e820c026-4897-434d-8c17-b7febf3d07a0@web.de>
Date: Wed, 13 Mar 2024 19:47:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] parse-options: factor out register_abbrev() and
 struct parsed_option
Content-Language: en-US
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <20240224212953.44026-1-l.s.r@web.de>
 <20240303121944.20627-1-l.s.r@web.de> <20240303121944.20627-4-l.s.r@web.de>
 <ZfDMhJ4r5g-g-B3n@google.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ZfDMhJ4r5g-g-B3n@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eYcWlaFRC/zOTM8tmhVHUIdQltTmU+8esWR1UCLMp9MDiCaKYPF
 m0d6XZceMHKmzuOHW02SLEKZekS9JGEdWXp72qBkgdZfNuHw/MWbpTfaHOklDC+Q6KWysq1
 XZwM+64b4HAvT75u/mu6ohhuC3WfsEXMk8wexPQHU5D+WbH/OFPpj50qdj2WkeoqJ2uViyf
 D+Nup8klVAUUXbfIwqqqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yGKOmmsPapU=;CTZ9mc3iECFzkJHRGNs0t/bbfN9
 e4NieVo2CJt98IsJzpsnWqP92CB0mmdYu5xMFQcufJm/jcCUwnlqX9hAVv2aPuDaAhOzLbmbt
 omxBCxzJV7C8CI/g+4htcCqwmIjclGiyMP9jgOSob+dm/YfisyDlQdr8aB5NzSdzIcsIBHJ80
 oogwElEJZBgZshpUwwN0iY7KdQ6H309COTno2/NYqjX6cY7e22P+OpdwXquyLFDfBXsrRRLvR
 UN2fUnCjfVsbO8L5jcni8LZv5+L+N65UhWMYBmgaxyjhUxFutZ1SR7zf0I/hiIQE+eycjTcfP
 GITi0lezkndobEy1Y+mTimNg5SzriCbKqJN9kN6Fhqz7ubNanYcierVaRaMcXgssrGx6YXewA
 VyAyLPjEMDX75rkLCmXkUGo+F5eAXFmOUc++DmyX+EllF9qwqniVpocw+ZtX69mEBxm7G4663
 zWMFklWoMZ/7G99Q/r4gPwO4MignIlGrJ2quueJ4mgAnQ4Ba7+VTXU0Oqii5VVv/CrujOCuGB
 y7zix/zMIiUQlLeMQa/814tFUsuXURdCvk1CTB1WXd/+ASrV68Kfy3hSGXfO2M/+qiWxU2fcn
 Rsa3W6xIjMhXBtVFVg87e5a+1bx7clXfpLALTsgFRYcoPOvFL1adbv735qVQ2E/GpnzcCX6EI
 HLj6wLY41tqUAW/rqP4KXGDya2GCLQnpdR5R5o9oWMNLZ80npls7uPyRvkQW/crm5OJbnQQ2q
 cvCy7Y3G8ohnpcxQgDZSftfth6b4+DUK8lTIVv0b0Fq9Kt4MhS5e/rlKt87TgSr6Ae7QjliRI
 Rcu9EX322n+nO6WVw7/1EfhqHAppDokUw/acLeEcFPpwQ=

Am 12.03.24 um 22:43 schrieb Josh Steadmon:
> I found this change to be hard to follow, although I'm not sure anything
> actually needs to be changed. Thinking aloud below, apologies for being
> verbose.

Thank you for taking the time to review and share!

> On 2024.03.03 13:19, Ren=C3=A9 Scharfe wrote:
>> Add a function, register_abbrev(), for storing the necessary details fo=
r
>> remembering an abbreviated and thus potentially ambiguous option.  Call
>> it instead of sharing the code using goto, to make the control flow mor=
e
>> explicit.
>>
>> Conveniently collect these details in the new struct parsed_option to
>> reduce the number of necessary function arguments.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  parse-options.c | 83 +++++++++++++++++++++++++++++--------------------
>>  1 file changed, 49 insertions(+), 34 deletions(-)
>>
>> diff --git a/parse-options.c b/parse-options.c
>> index 056c6b30e9..398ebaef14 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -350,14 +350,40 @@ static int is_alias(struct parse_opt_ctx_t *ctx,
>>  	return 0;
>>  }
>>
>> +struct parsed_option {
>> +	const struct option *option;
>> +	enum opt_parsed flags;
>> +};
>
> We're bundling up the state for previously-examined options that "arg"
> might expand to. Looks good.
>
>
>> +static void register_abbrev(struct parse_opt_ctx_t *p,
>> +			    const struct option *option, enum opt_parsed flags,
>> +			    struct parsed_option *abbrev,
>> +			    struct parsed_option *ambiguous)
>> +{
>
> Here we're defining a function to separate out the logic that we
> previously jumped to with "goto is_abbreviated;". Looks good.
>
>
>> +	if (p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
>> +		return;
>
> This is the (negation of the) allow_abbrev condition that was removed
> below. Looks good.
>
>> +	if (abbrev->option &&
>> +	    !is_alias(p, abbrev->option, option)) {
>> +		/*
>> +		 * If this is abbreviated, it is
>> +		 * ambiguous. So when there is no
>> +		 * exact match later, we need to
>> +		 * error out.
>> +		 */
>> +		ambiguous->option =3D abbrev->option;
>> +		ambiguous->flags =3D abbrev->flags;
>
> Couldn't this just be "*ambiguous =3D *abbrev;" ?

It could, but I wanted to keep it as close to the original as possible.
I was hoping the changes made here would be mechanical enough to be
reviewable without requiring a deeper understanding of what the code
actually does, but that didn't quite work out it seems.  Glad you made
it through, though! :)

>
>
>> +	}
>> +	abbrev->option =3D option;
>> +	abbrev->flags =3D flags;
>> +}
>
> So, we've found a candidate that matches our abbreviation. If this is
> the second (or later) candidate, then we've got an ambiguous
> abbreviation, which we'll need to warn about later. Since we're
> overwriting both "ambiguous" and "abbrev", we'll only refer to the last
> two candidates seen, but that seems fine.
>
>>  static enum parse_opt_result parse_long_opt(
>>  	struct parse_opt_ctx_t *p, const char *arg,
>>  	const struct option *options)
>>  {
>>  	const char *arg_end =3D strchrnul(arg, '=3D');
>> -	const struct option *abbrev_option =3D NULL, *ambiguous_option =3D NU=
LL;
>> -	enum opt_parsed abbrev_flags =3D OPT_LONG, ambiguous_flags =3D OPT_LO=
NG;
>> -	int allow_abbrev =3D !(p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT);
>> +	struct parsed_option abbrev =3D { .option =3D NULL, .flags =3D OPT_LO=
NG };
>> +	struct parsed_option ambiguous =3D { .option =3D NULL, .flags =3D OPT=
_LONG };
>>
>>  	for (; options->type !=3D OPTION_END; options++) {
>>  		const char *rest, *long_name =3D options->long_name;
>> @@ -377,31 +403,20 @@ static enum parse_opt_result parse_long_opt(
>>  			rest =3D NULL;
>>  		if (!rest) {
>>  			/* abbreviated? */
>> -			if (allow_abbrev &&
>> -			    !strncmp(long_name, arg, arg_end - arg)) {
>> -is_abbreviated:
>> -				if (abbrev_option &&
>> -				    !is_alias(p, abbrev_option, options)) {
>> -					/*
>> -					 * If this is abbreviated, it is
>> -					 * ambiguous. So when there is no
>> -					 * exact match later, we need to
>> -					 * error out.
>> -					 */
>> -					ambiguous_option =3D abbrev_option;
>> -					ambiguous_flags =3D abbrev_flags;
>> -				}
>> -				abbrev_option =3D options;
>> -				abbrev_flags =3D flags ^ opt_flags;
>> +			if (!strncmp(long_name, arg, arg_end - arg)) {
>> +				register_abbrev(p, options, flags ^ opt_flags,
>> +						&abbrev, &ambiguous);
>
> This part I found hard to follow; the change itself is a simple
> replacement of the original logic with our new function, but I don't
> understand the original logic in the first place. Why do we XOR flags
> and opt_flags here?
>
> These are both bitflags which can hold a combination of OPT_SHORT and/or
> OPT_UNSET (i.e., we've passed --no-foo). Since we're only looking at
> args that we already know are in long form, the only one we should need
> to worry about is whether OPT_UNSET is true or false. And indeed, we
> never set OPT_SHORT in this function.

Right.  We do set OPT_LONG as well, but its value is 0, so that's just
for show.

> IIUC, "flags" corresponds to "arg", the flag we're trying to parse, and
> "opt_flags" corresponds to "options", the current item in the list of
> all options that we're trying to match against.
>
> So OPT_UNSET will be true in "flags" if either "arg" starts with "no-"
> or if it is a prefix of "no-".
>
> OPT_UNSET will be true in "opt_flags" if all of the following are true:
> * "arg" does not start with "no-"
> * PARSE_OPT_NONEG is not set in options->flags
> * options->long_name starts with "no-"

Right.

> So OPT_UNSET can never be set at the same time in both "flags" and
> "opt_flags",

It can if arg is "no" or "n" (the "negated and abbreviated very much?"
path), PARSE_OPT_NONEG is unset and long_name starts with "no-".

> and thus the XOR makes a bit more sense: either the
> argument we're parsing or the canonical form of the candidate that we're
> matching against is negated. We don't care which one, but we need to
> know about the negation later, to either set the value properly, or to
> report potential ambiguities with the "no-" prefix.

Right.  The flags track whether the user negated an option, but with
the twist that both arguments given by the user and long names in the
option definition can start with "no-":

arg        option       negated
=2D--------- ------------ -------
=2D-index     --index     no
=2D-index     --no-index  yes
=2D-no-index  --index     yes
=2D-no-index  --no-index  no

"negated" means "the opposite meaning of the defined option" here,
not "presence of no- somewhere".  --index asks for the opposite
effect of what an option defined as --no-index would do.

If OPT_UNSET is set in both, the XOR cancels it out.  E.g. "--no"
directly matches "--no-index" as an abbreviation, without negating it.
(It also matches all other negatable options, so that's only usable
for commands that have a single one of them..)

>
>>  				continue;
>>  			}
>>  			/* negation allowed? */
>>  			if (options->flags & PARSE_OPT_NONEG)
>>  				continue;
>>  			/* negated and abbreviated very much? */
>> -			if (allow_abbrev && starts_with("no-", arg)) {
>> +			if (starts_with("no-", arg)) {
>>  				flags |=3D OPT_UNSET;
>> -				goto is_abbreviated;
>> +				register_abbrev(p, options, flags ^ opt_flags,
>> +						&abbrev, &ambiguous);
>> +				continue;
>
> This is a slight change: we might set OPT_UNSET in flags where before we
> were prevented by the "allow_abbrev" condition, but register_abbrev will
> still be a no-op in that case, so I don't think this changes any
> behavior.

Indeed.  The continue statement starts the loop over and initializes
flags anew, and the allow_abbrev condition is checked at the top of
register_abbrev(), as you noted.

> All the other changes in this patch are straightforward. So, despite
> having to puzzle out the original logic, everything here looks good.
