Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC0EC5517A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 05:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA13522200
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 05:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJ3EU/t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440302AbgJUFBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 01:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407064AbgJUFBu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 01:01:50 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEBCC0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 22:01:50 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v186so765176qkb.11
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 22:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=87SZL+0fyKZYC/ykpHeojkeq9lP88W4PbTdjGwpLN0g=;
        b=UJ3EU/t3TNOPib5LFIpmWvSJ5BtBzVxPWUX0K1TuXbiFLt8o+k94MI5wgqmXWfLDW3
         836ch+Y/AUDNb7V1ph4ZiXByzRcGtxwWl9GbgLd2FHe3HYvehUtJ0xmANgH5Hq2JEdvN
         FG6gdKInqcPYoPTOHvTOngSwA9ClCwkWN5eXayRjlPUVRPpl7Q9OE+GTemlLZE5+Ld7O
         ZPeaI9fXdbjt7eyj+uVVg3qbzvkji9voPzPaufCsmC5mKP/3efsSBGygHYVivVauNYxX
         uXCuPaoyeIrEBuofcqcEK9tQOohY5tFz4HsaQ9DcciiPl6uwoV+9P8kdark7XHZjeJZh
         +Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=87SZL+0fyKZYC/ykpHeojkeq9lP88W4PbTdjGwpLN0g=;
        b=svDeIFoRypUmNbcEr6Yh2Nc/uahtE+/QMwonnPZ6iwzmuvYr+egcyujC/01/Trnslm
         uBqav4oa1sI2qUqZSjvArIBXFxiWHQHNDeaKh5PYn9pAH/yRnICbEi5tZy2KeuDrqW4p
         myoqlI0wIcZ6NB5IILK898Oht+08BVD1zFUfJsvvD7hqvY6Y3KnD3XORbE+dP9TS+es3
         e+flaYK+mUyz/hjGR92f/16GTQUivpdnXLQrBqw98CESdsaT2vUi3Sdn5fVs6l3QaIPp
         eiaI4cKC0XKpFj5Pcr7HuiIeAEfyEAuTQ/pdwg3w8nHp4rjjnjaKd9FlJxoRrpAPrnkP
         99+w==
X-Gm-Message-State: AOAM532f7ujMtZ1CLp6CDu0wKRXywgvaP1PcO6Rf7dk4HCCO7Mbzn02j
        +JpSRLfTxmQltQvDKi6WobT+FT3fc1au
X-Google-Smtp-Source: ABdhPJw33Po5nHhJgg2k6aYDOCiSUVCqQkL2S48rizIxDIp02r1+nWeGnLD0vU7XdEmYeHCuVqnprmew3uzA
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:ad4:4f8f:: with SMTP id
 em15mr1196711qvb.9.1603256509444; Tue, 20 Oct 2020 22:01:49 -0700 (PDT)
Date:   Wed, 21 Oct 2020 05:01:46 +0000
In-Reply-To: <xmqqk0vtki66.fsf@gitster.c.googlers.com>
Message-Id: <20201021050146.3001222-1-shengfa@google.com>
Mime-Version: 1.0
References: <xmqqk0vtki66.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: Re: [WIP v2 1/2] Adding a record-time-zone command option for commit
From:   Shengfa Lin <shengfa@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nathaniel@google.com,
        rsbecker@nexbridge.com, sandals@crustytoothpaste.net,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Many places in Git record the timezone of actor when a
>> timestamp is recorded, including the commiter and author
>> timestamps in a commit object and the tagger timestamp in a tag
>> object. Some people however prefer not to share where they
>> actually are.
>>
>> They _could_ just say "export TZ=UTC" and be done with it,
>> but the method would not easily allow them to pretend to be
>> in the UTC timezone only with Git, while revealing their true
>> timezone to other activities (e.g. sending e-emails?).
>>
>> Introduce --[no-]record-time-zone for commit command, which can be
>> specified to disallow Git to record time zone. Timezone will be
>> recorded by default.
>>
>> Note that this is a WIP and the test is failing.
>
> And there is no outline of the design decision made so far, so it is
> hard to give useful review comments.

Thanks for the comments and sorry for not describing the design.
I will add it here.

First, I would like to use a "global" variable to keep track of whether
record-time-zone is set and default to true. Then in various places such
as commit, pull, merge and rebase; we can add command option that can
modify this value.

Then in datestamp in date.c, we can check this value; offset would be
initialized to 0 and only be set if record_time_zone is true. Additionally,
date_string from the same file would take an extra argument to indicate if
we want to use nagative sign for zero offset. Then the timestamp along with
sign and 4 digits offset would be stored in "git_default_date" as buf
"1603255519 -0000". I think of this as the "encoding" step.

Initially, I thought this would be sufficient to show "-0000" in commit log
message. However, I found that the show_date function is used for "decoding";
converting timestamp and tz to more readable format. Then I realize the
function won't distinguish between +0 and -0 as it only takes in a tz as
argument. As a result, I added the sign pointer as an argument; the reason for
pointer being there are many call sites for the show_date function but I am not sure
if they all need to display in the new format(-0000). I used NULL to denote
not sure and just do whatever they were doing before. For show_ident_date in
pretty.c, I have extracted the sign in ident tz and pass it into show_date.
Then added helper functions in date.c to print either %+05d or -%04d depending
on tz and sign pointer.

In fmt_ident(ident.c), we are calling parse_date which calls parse_date_basic
and used the parameters it parsed to call date_string again, so I modified
parse_date_basic to parse the sign as well.

> It does not help that the patch is distracting by turning tabs to
> spaces and breaking alingment X-<.

I was assuming 1 HT is 8 spaces. Then after doing :set list in vim, I think
1 HT is actually ctrl + I. Is this correct?

>> diff --git a/builtin/am.c b/builtin/am.c
>> index 2c7673f74e..059cc5fce7 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -884,7 +884,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
>>  			if (tz > 0)
>>  				tz2 = -tz2;
>>  
>> -			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, DATE_MODE(RFC2822)));
>> +			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, NULL, DATE_MODE(RFC2822)));
>
> For example, it appears that tweaking "show_date()" API function
> seems to be a central part of the design, as there are so many
> instances like this change in the patch.  If the proposed log
> message mentioned, even briefly, what the extra parameter added to
> the API function meant (especially what NULL means there) upfront,
> then readers can coast the part that added NULL there, like these
> ones, and concentrate on the parts of this patch that matter, which
> presumably uses something more interesting than NULL instead.

Added above, the extra parameter is the decoded sign if not NULL.

>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 1dfd799ec5..ee3ca2c7ac 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1547,7 +1547,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>  				N_("ok to record an empty change")),
>>  		OPT_HIDDEN_BOOL(0, "allow-empty-message", &allow_empty_message,
>>  				N_("ok to record a change with an empty message")),
>> -
>> +                OPT_BOOL(0, "record-time-zone", &record_time_zone, N_("record user timezone")),
>
> Our code indents with HT; get used to the style early and your
> patches won't distract reviewers as much, leading to more quality
> reviews and suggestions.

My bad, I didn't realize I was doing it wrong all along, I was thinking that I was
sometimes missing spaces.
I use vim, is there any easy way to ensure that indent is with HT?
I was using 4 tabs since each tab is 2 spaces. Should I type in ctrl + I
instead?

> Likewise.  The record_time_zone global variable seems to play a
> crucial role in this change, but without preparing readers by
> mentioning where it is defined, what normal/default value it takes,
> and who potentially touches it, in the proposed log message, it
> makes reading the change harder than necessary.
> 
> A system-wide global like this is usually defined in environment.c,
> by the way.  Look for say trust_executable_bit and mimic where it 
> is defined and declared.

Will move to environment.c.

>>  		OPT_END()
>>  	};
>>  
>> @@ -1580,6 +1580,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>  	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>>  					  builtin_commit_usage,
>>  					  prefix, current_head, &s);
>> +
>>  	if (verbose == -1)
>>  		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
>>  
>
> Distraction.

Will remove.

>> +static int negative_zero(int tz, int *sign)
>> +{
>> +        return !tz && sign && (*sign) == '-';
>> +}
>> +
>> +static const char *tz_fmt(int tz, int *sign)
>> +{
>> +        if (!negative_zero(tz, sign))
>> +                return " %+05d";
>> +        else
>> +                return " -%04d";
>> +}
>> +
>> +
>> +static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm, int tz, int *sign, struct tm *human_tm, int human_tz, int local)
>>  {
>>  	struct {
>>  		unsigned int	year:1,
>> @@ -277,10 +293,10 @@ static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm
>>  		strbuf_addf(buf, " %d", tm->tm_year + 1900);
>>  
>>  	if (!hide.tz)
>> -		strbuf_addf(buf, " %+05d", tz);
>> +                strbuf_addf(buf, tz_fmt(tz, sign), tz);
>>  }
>>  
>> -const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
>> +const char *show_date(timestamp_t time, int tz, int *signp, const struct date_mode *mode)
>
> With its type, we can tell easily that sign is a pointer, so no need
> for 'p' (we do not have modep, either, next door).  More important
> is if 'sign' is a good name that conveys what the parameter (which
> is almost always NULL) means.  Without any introductory text, it is
> hard to tell and offer recommendations.

The reason I used signp instead of sign here is because there is a variable with
name sign used in the function. Regarding "good name", maybe sign_hint is more appropriate.

>> @@ -826,17 +849,21 @@ static int match_object_header_date(const char *date, timestamp_t *timestamp, in
>>  
>>  /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
>>     (i.e. English) day/month names, and it doesn't work correctly with %z. */
>> -int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
>> +int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset, int *zero_offset_negative_sign)
>>  {
>>  	struct tm tm;
>>  	int tm_gmt;
>>  	timestamp_t dummy_timestamp;
>>  	int dummy_offset;
>> +        int dummy_zero_offset_negative_sign;
>> +        int negative_sign;
>>  	if (!timestamp)
>>  		timestamp = &dummy_timestamp;
>>  	if (!offset)
>>  		offset = &dummy_offset;
>
> I see no need for the extra dummy_zero_offset_negative_sign variable.
> I can guess this mimics "if (!offset) offset = &dummy_offset" without
> much thought---a big difference is that after calling match_tz() to
> fill *offset, the code needs to obtain the value match_tz() parsed
> to decide if it needs to do the mktime() dance to guess the current
> zone offset, and also needs to read *offset to adjust *timestamp
> the function returns.
> 
> The zero_offset_negative_sign pointer that specifies the location to
> optionally return a bit of info is *ONLY* used once at the very end
> of the function, so 
>> +        if (!zero_offset_negative_sign)
>> +                zero_offset_negative_sign = &dummy_zero_offset_negative_sign;
>
> there is absolutely no need for the dummy variable or this
> assignment, especially since the patch adds negative_sign variable
> that always exists, and ...
>
>>  	memset(&tm, 0, sizeof(tm));
>>  	tm.tm_year = -1;
>> @@ -848,6 +875,7 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
>>  	tm.tm_sec = -1;
>>  	*offset = -1;
>>  	tm_gmt = 0;
>> +        negative_sign = 0;
>>  
>>  	if (*date == '@' &&
>>  	    !match_object_header_date(date + 1, timestamp, offset))
>> @@ -864,9 +892,11 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
>>  			match = match_alpha(date, &tm, offset);
>>  		else if (isdigit(c))
>>  			match = match_digit(date, &tm, offset, &tm_gmt);
>> -		else if ((c == '-' || c == '+') && isdigit(date[1]))
>> +		else if ((c == '-' || c == '+') && isdigit(date[1])) {
>>  			match = match_tz(date, offset);
>> -
>> +                        if (c == '-')
>> +                                negative_sign = 1;
>> +                }
>
>... is usable.

Got it, thanks for pointing out.

>>  		if (!match) {
>>  			/* BAD CRAP */
>>  			match = 1;
>> @@ -895,6 +925,9 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
>>  
>>  	if (!tm_gmt)
>>  		*timestamp -= *offset * 60;
>> +
>> +        *zero_offset_negative_sign = (!(*offset) && negative_sign);
>> +
>
> The only change needed for this optional extra bit return is to
> make sure that the assignment happens only when it was requested by
> the caller, i.e.
>
> 	if (zero_offset_negative_sign)
> 		*zero_offset_negative_sign = ...
>
> Having said all that, quite honestly, I do not know if this is going
> in the right direction.  Specifically, I do not offhand see why we
> need such a huge surgery to date.c just to touch datestamp() and
> date_string().
> 
> I may be totally off, partly due to lack of explanation of how the
> patch attempts to achieve its goal, but wouldn't it be just the
> matter of touching the single callsite of datestamp() in ident.c, so
> that after it gets git_default_date string filled, null out the last
> 5 bytes in it with "-0000" if record_tz is off?
>

Changing parse_date_basic because it's called by parse_date in fmt_ident(ident.c).

