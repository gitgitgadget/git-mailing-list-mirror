Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D28C433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 07:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ECBA23120
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 07:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAGHpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 02:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbhAGHpy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 02:45:54 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18A6C0612F4
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 23:45:13 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id b9so8531445ejy.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 23:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bEGPfFz1LYsFfrNWkX1T0IWCrKd8VqgY8aUXy+h2PhM=;
        b=ojfb8irvVoiiYS1pxFE4ZSRIp/P9SCatH2BJdhTrJ7tT69mlnDMCpB08WZG8Sg+Z1i
         Vk81M9t5BsWYnmCrOLMw6OImavnjEiaoqu7qhKp3WRge4c7rXtEUsQsq0SRnkEUw+QQ/
         AeMiigf3FsrZ0X55MtH+tdqMSCfGfTurHPF5qTPiTujwdG29p5+tKkP82xx3DPOcHOje
         H/28tw1GRoac5wIBCXTEPFCslfIDKPcTkIE8SGsW8SMcADN/n3/Q+/v6SAFtLAC2x7Yx
         edNjap7M6SMFaSJozHOGFdIYIAZVQj8PU2lVsg6sZEgyrEDpGUX0bNvvzt15gk1X+/PW
         4uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=bEGPfFz1LYsFfrNWkX1T0IWCrKd8VqgY8aUXy+h2PhM=;
        b=ujYUOUEajBww6ixJGwU4ZTtZC60U+oZ3+7bZn5J++ujKF0ATiWJVz0wOwNjscd3M6Q
         ruWEiKG40htyshXcRargHMx+2Z3xVxstEGty1aVwiybLjLHvgQNkk7Nje0S5Swoz+B4f
         9yt2TkQ+6pPK7Zn0KMnxhnNz9j1FLRXTs7I3yaNfrkXqLNdah3lHCeaD9dlu+NmCsXZi
         3Xmcc/hqeQbfYpqiwySeauPFoatzdhJ2rof6S/0lyxxGOb4qsV34ggWoONxqdCLGuXSo
         JsUECN1wzHwYHseTd19AuXIhAL3xzvNL1A7yN/dOjZEOeirWYxzRAEAjrtp77UaMS1eL
         E3sw==
X-Gm-Message-State: AOAM53329opSs75W8XAB28A+hnYg/11uSGaE3VTJ/Yit9QCuuug12Wox
        8U6MWr2M1lYoQYEf/ofsfLo=
X-Google-Smtp-Source: ABdhPJw5DkXwVHlzGygWfJ2352GU/YOLFJaVEB0jf9xOdXzR1W+9KaN6dqvWhb6OUAVDdwchc5TKBg==
X-Received: by 2002:a17:906:605:: with SMTP id s5mr5563722ejb.280.1610005512388;
        Wed, 06 Jan 2021 23:45:12 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id s19sm2346832edx.7.2021.01.06.23.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 23:45:11 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 23/23] mktag: add a --[no-]strict option
References: <xmqq4kjuygw7.fsf@gitster.c.googlers.com>
 <20210106114727.8405-1-avarab@gmail.com>
 <xmqqmtxlpuyg.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqqmtxlpuyg.fsf@gitster.c.googlers.com>
Date:   Thu, 07 Jan 2021 08:45:10 +0100
Message-ID: <87zh1lqjg9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 06 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Now that mktag has been migrated to use the fsck machinery to check
>> its input, it makes sense to teach it to run in the equivalent of "git
>> fsck"'s default mode.
>>
>> For cases where mktag is used to (re)create a tag object using data
>> from an existing and malformed tag object, the validation may
>> optionally have to be loosened. Teach the command to take the
>> "--[no-]strict" option to do so.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> On Wed, Jan 06 2021, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>>
>>>> Now that mktag has been migrated to use the fsck machinery to check
>>>> its input, it makes sense to teach it to run in the equivalent of "git
>>>> fsck"'s default mode, instead of hardcoding "git fsck --strict". Let's
>>>> do that and support the "--no-strict" option.
>>>>
>>>> Since this is a new option we don't need to cater to parse-option.c's
>>>> default of automatically supporting --strict. So let's use
>>>> PARSE_OPT_NONEG, using a new trivial helper macro.
>>>
>>> I do not understand the last paragraph.
>>
>> I forgot to update the commit message when changing this from
>> v4->v5. Here's a v6 of just this patch (to save on list traffic) with
>> an updated commit message. Thanks!
>
> Okay.  I actually was expecting to hear the reason why the approach
> taken in v4 to use PARSE_OPT_NONEG is a good one, but I take the
> change of approach in v5 as the sign that you now agree with me that
> a plain vanilla bool that happens to default to true is easier to
> manage.

There was no good reason. I couldn't find whether &no_var with "no-OPT"
options & PARSE_OPT_NONEG was the preferred pattern or &var with a
default of 1 with "OPT". There's a few examples of the former in the
codebase, but I'm happy to go with the latter.

>>
>>  Documentation/git-mktag.txt |  8 ++++++++
>>  builtin/mktag.c             |  9 +++++++++
>>  t/t3800-mktag.sh            | 33 +++++++++++++++++++++++----------
>>  3 files changed, 40 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
>> index 79813ff8df0..17a2603a600 100644
>> --- a/Documentation/git-mktag.txt
>> +++ b/Documentation/git-mktag.txt
>> @@ -11,6 +11,14 @@ SYNOPSIS
>>  [verse]
>>  'git mktag'
>>=20=20
>> +OPTIONS
>> +-------
>> +
>> +--strict::
>> +	By default mktag turns on the equivalent of
>> +	linkgit:git-fsck[1] `--strict` mode. Use `--no-strict` to
>> +	disable it.
>> +
>>  DESCRIPTION
>>  -----------
>>=20=20
>> diff --git a/builtin/mktag.c b/builtin/mktag.c
>> index 9b04b61c2bb..41a399a69e4 100644
>> --- a/builtin/mktag.c
>> +++ b/builtin/mktag.c
>> @@ -10,6 +10,7 @@ static char const * const builtin_mktag_usage[] =3D {
>>  	N_("git mktag"),
>>  	NULL
>>  };
>> +static int option_strict =3D 1;
>>=20=20
>>  static struct fsck_options fsck_options =3D FSCK_OPTIONS_STRICT;
>>=20=20
>> @@ -25,6 +26,12 @@ static int mktag_fsck_error_func(struct fsck_options =
*o,
>>  {
>>  	switch (msg_type) {
>>  	case FSCK_WARN:
>> +		if (!option_strict) {
>> +			fprintf_ln(stderr, _("warning: tag input does not pass fsck: %s"), m=
essage);
>> +			return 0;
>> +
>> +		}
>> +		/* fallthrough */
>>  	case FSCK_ERROR:
>>  		/*
>>  		 * We treat both warnings and errors as errors, things
>> @@ -67,6 +74,8 @@ static int verify_object_in_tag(struct object_id *tagg=
ed_oid, int *tagged_type)
>>  int cmd_mktag(int argc, const char **argv, const char *prefix)
>>  {
>>  	static struct option builtin_mktag_options[] =3D {
>> +		OPT_BOOL(0, "strict", &option_strict,
>> +			 N_("enable more strict checking")),
>>  		OPT_END(),
>>  	};
>>  	struct strbuf buf =3D STRBUF_INIT;
>> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
>> index 0ddd0f01cc7..4d76ccbbc19 100755
>> --- a/t/t3800-mktag.sh
>> +++ b/t/t3800-mktag.sh
>> @@ -12,12 +12,17 @@ test_description=3D'git mktag: tag object verify tes=
t'
>>  # given in the expect.pat file.
>>=20=20
>>  check_verify_failure () {
>> -	expect=3D"$2"
>> -	test_expect_success "$1" '
>> +	test_expect_success "$1" "
>>  		test_must_fail env GIT_TEST_GETTEXT_POISON=3Dfalse \
>>  			git mktag <tag.sig 2>message &&
>> -		grep "$expect" message
>> -	'
>> +		grep '$2' message &&
>> +		if test '$3' !=3D '--no-strict'
>> +		then
>> +			test_must_fail env GIT_TEST_GETTEXT_POISON=3Dfalse \
>> +				git mktag --no-strict <tag.sig 2>message.no-strict &&
>> +			grep '$2' message.no-strict
>> +		fi
>> +	"
>>  }
>>=20=20
>>  test_expect_mktag_success() {
>> @@ -65,7 +70,7 @@ too short for a tag
>>  EOF
>>=20=20
>>  check_verify_failure 'Tag object length check' \
>> -	'^error:.* missingObject:'
>> +	'^error:.* missingObject:' 'strict'
>>=20=20
>>  ############################################################
>>  #  2. object line label check
>> @@ -240,7 +245,7 @@ tagger . <> 0 +0000
>>  EOF
>>=20=20
>>  check_verify_failure 'verify tag-name check' \
>> -	'^error:.* badTagName:'
>> +	'^error:.* badTagName:' '--no-strict'
>>=20=20
>>  ############################################################
>>  # 11. tagger line label check #1
>> @@ -254,7 +259,7 @@ This is filler
>>  EOF
>>=20=20
>>  check_verify_failure '"tagger" line label check #1' \
>> -	'^error:.* missingTaggerEntry:'
>> +	'^error:.* missingTaggerEntry:' '--no-strict'
>>=20=20
>>  ############################################################
>>  # 12. tagger line label check #2
>> @@ -269,7 +274,7 @@ This is filler
>>  EOF
>>=20=20
>>  check_verify_failure '"tagger" line label check #2' \
>> -	'^error:.* missingTaggerEntry:'
>> +	'^error:.* missingTaggerEntry:' '--no-strict'
>>=20=20
>>  ############################################################
>>  # 13. allow missing tag author name like fsck
>> @@ -298,7 +303,7 @@ tagger T A Gger <
>>  EOF
>>=20=20
>>  check_verify_failure 'disallow malformed tagger' \
>> -	'^error:.* badEmail:'
>> +	'^error:.* badEmail:' '--no-strict'
>>=20=20
>>  ############################################################
>>  # 15. allow empty tag email
>> @@ -422,13 +427,21 @@ this line should not be here
>>  EOF
>>=20=20
>>  check_verify_failure 'detect invalid header entry' \
>> -	'^error:.* extraHeaderEntry:'
>> +	'^error:.* extraHeaderEntry:' '--no-strict'
>>=20=20
>>  test_expect_success 'invalid header entry config & fsck' '
>>  	test_must_fail git mktag <tag.sig &&
>> +	git mktag --no-strict <tag.sig &&
>> +
>>  	test_must_fail git -c fsck.extraHeaderEntry=3Derror mktag <tag.sig &&
>> +	test_must_fail git -c fsck.extraHeaderEntry=3Derror mktag --no-strict =
<tag.sig &&
>> +
>>  	test_must_fail git -c fsck.extraHeaderEntry=3Dwarn mktag <tag.sig &&
>> +	git -c fsck.extraHeaderEntry=3Dwarn mktag --no-strict <tag.sig &&
>> +
>>  	git -c fsck.extraHeaderEntry=3Dignore mktag <tag.sig &&
>> +	git -c fsck.extraHeaderEntry=3Dignore mktag --no-strict <tag.sig &&
>> +
>>  	git fsck &&
>>  	env GIT_TEST_GETTEXT_POISON=3Dfalse \
>>  		git -c fsck.extraHeaderEntry=3Dwarn fsck 2>err &&

