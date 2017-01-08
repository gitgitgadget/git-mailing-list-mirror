Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C26320756
	for <e@80x24.org>; Sun,  8 Jan 2017 03:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934099AbdAHDCk (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 22:02:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52167 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933527AbdAHDCj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 22:02:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCEC05FFCA;
        Sat,  7 Jan 2017 22:02:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vjVXhohJ9grzdhtToMGJVNjHEzM=; b=bA2Zgp
        S1ioCgxBf4w4tk2H0DfvyMKIcRmEPbCbkxs0SlOU0ssRifgm2DpHmeT6bW5QeLB+
        2DiAKwdi3wBjtVSQZXe+TSdRPAs7kRqsd2Lz14KGrCQA4ADXQXZc9EGQ/2tmayh9
        s7lXfs6WfufU4NhU5RPTmcJT1Xp0bwaCI2jE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rZMstQAh+1SaQOefeNTdiNTgi4HsHrE/
        7yd2ikAsrilqI0QJ8K21on6oeSjATTXruBkdDG6DB3SZFkb4KIVdjh+fUdSns3ti
        kSKzYYzxWqZR6yORCFtzN5J8xw8vGMeG7ltw4qnI8X9ACqZskA24Ndl+ZKDH0LUQ
        Ji00dr0iGX4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C44205FFC9;
        Sat,  7 Jan 2017 22:02:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F232B5FFC8;
        Sat,  7 Jan 2017 22:02:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] diff: add interhunk context config option
References: <20170102233114.20778-1-vegard.nossum@oracle.com>
        <CAFZEwPMLk5KTeLR9zygU6ZH5zN7TLnQzmJVpyCNig8FrYcOazw@mail.gmail.com>
Date:   Sat, 07 Jan 2017 19:02:35 -0800
In-Reply-To: <CAFZEwPMLk5KTeLR9zygU6ZH5zN7TLnQzmJVpyCNig8FrYcOazw@mail.gmail.com>
        (Pranit Bauva's message of "Tue, 3 Jan 2017 11:49:25 +0530")
Message-ID: <xmqqtw9a1cfo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8BA693C-D54E-11E6-8A41-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

>> diff --git a/diff.c b/diff.c
>> index 84dba60c4..40b4e6afe 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -33,6 +33,7 @@ static int diff_rename_limit_default = 400;
>>  static int diff_suppress_blank_empty;
>>  static int diff_use_color_default = -1;
>>  static int diff_context_default = 3;
>> +static int diff_interhunk_context_default = 0;

Do not explicitly initialize BSS variables to 0 (or NULL).

>>  static const char *diff_word_regex_cfg;
>>  static const char *external_diff_cmd_cfg;
>>  static const char *diff_order_file_cfg;
>> @@ -248,6 +249,12 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>>                         return -1;
>>                 return 0;
>>         }
>> +       if (!strcmp(var, "diff.interhunkcontext")) {
>> +               diff_interhunk_context_default = git_config_int(var, value);
>> +               if (diff_interhunk_context_default < 0)
>> +                       return -1;
>> +               return 0;
>> +       }
>>         if (!strcmp(var, "diff.renames")) {
>>                 diff_detect_rename_default = git_config_rename(var, value);
>>                 return 0;
>> @@ -3371,6 +3378,7 @@ void diff_setup(struct diff_options *options)
>>         options->rename_limit = -1;
>>         options->dirstat_permille = diff_dirstat_permille_default;
>>         options->context = diff_context_default;
>> +       options->interhunkcontext = diff_interhunk_context_default;

Will this receive -1 if diff.interhunkcontext configuration variable
is misconfigured and the *_default variable receives the error return
value from git_config_int()?


>>         options->ws_error_highlight = ws_error_highlight_default;
>>         DIFF_OPT_SET(options, RENAME_EMPTY);
>
> On a first look, it seems that we can overwrite the default config
> values by using a different command line argument which is good.
>
> Also, tests are missing. It seems that t/t4032 might be a good place
> to add those tests.
>
> Rest all is quite good! :)
>
> Regards,
> Pranit Bauva
