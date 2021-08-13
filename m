Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F09C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 13:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B325D61038
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 13:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbhHMNHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 09:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhHMNG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 09:06:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78ACC061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 06:06:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so13299749wrs.0
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 06:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MMI8+sycr6UzqjKYpBnE9S7fONFnr4ctoFwbNAYmueU=;
        b=RmPXNUAdicJctpzhtOXAZcFBd02ARNKH3IDqV1Hmpt5od7ZxDXW0WbqNK0nrDyQrfw
         i2WO+sWzYZCroaHnGkH2xKu5tWLXqw85pfOqg2sCn+VJUkdWSN0nruH4aAzXFovYa1sK
         Uso0fSk/mo3twvVegywp13MTajvn40c4aqU/8bt7jVWlMyy/EtEkPtJklLSOokd6d/yT
         GBHYSJcqm5vvsNaNh6pJSscLhCRTUsFqZtWlfNIHdI2x50v6Qg08djJA+D9XHPWwIW3Z
         FGTYp4S2yhnU52z3h/vVnM5eSGFGxF5Z7JFokJeNa53mXlxRaPlsJcMPOlWlDpzS2djF
         WSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MMI8+sycr6UzqjKYpBnE9S7fONFnr4ctoFwbNAYmueU=;
        b=ULCnTKCHJ7aB6YxQNFkXAxzpS5tnqQGJMJY6YzEVI/JuNmLG325ZMqzKsWKkB7DnP/
         RhJaoH5/8/S2dZ90zb38c06p/CoVM3yGlXw4Lhpa40iL06xo5kYOnC7lM+PGakuL4AcK
         MxVNnZf1u5GrC2RaqJJBiO2z3GZ9uvOeeEXibHRCJ0zvvadCcmOnfya/vJgp0P0ng1jo
         +2bZRUhcbFRC0H91/XaXaMrdvlPwbhiyRXDT3AJ1HYJfq0rQeNxdK2UUvV4e6i9H51us
         bT4j8/101bAt0Y+xvrdurl5RHWJ0UEUOhpfRghdL2wakIUv8+AkkH5Rk5s0Guf0oBVLA
         Thtg==
X-Gm-Message-State: AOAM533n5T2n1XcI7Q/IqGEZFVSPcEyy2T4plMDPtmH1HIzUNWBbdo74
        JGMdd3j3UD6Mw5FthRw3anY=
X-Google-Smtp-Source: ABdhPJx6pxX6Acdh0eR++R3VH4NqiUkrnW2Cm1WRUVRORrV8kcc4s42s4KIAcvL1TK0QESenPp4YrQ==
X-Received: by 2002:a5d:4207:: with SMTP id n7mr3006593wrq.138.1628859990330;
        Fri, 13 Aug 2021 06:06:30 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id b18sm1547106wrr.89.2021.08.13.06.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 06:06:29 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] commit: restore --edit when combined with --fixup
To:     Joel Klinghed <the_jk@spawned.biz>, phillip.wood@dunelm.org.uk,
        Joel Klinghed via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com>
 <pull.1014.v3.git.1628755346354.gitgitgadget@gmail.com>
 <e3a24819-9953-0245-7f64-472def4d180a@gmail.com>
 <0576a44a-c726-4550-ad29-52f09982de98@www.fastmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0151003c-d544-1fab-18e9-34eb84842555@gmail.com>
Date:   Fri, 13 Aug 2021 14:06:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0576a44a-c726-4550-ad29-52f09982de98@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08/2021 11:01, Joel Klinghed wrote:
> On Thu, Aug 12, 2021, at 11:32, Phillip Wood wrote:
>> Hi Joel
>>
>> @@ -1170,7 +1206,7 @@ static int parse_and_validate_options(int argc,
>> const char *argv[],
>>           if (force_author && renew_authorship)
>>                   die(_("Using both --reset-author and --author does not
>> make sense"));
>>
>> -       if (logfile || have_option_m || use_message || fixup_message)
>> +       if (logfile || have_option_m || use_message)
>>                   use_editor = 0;
>>           if (0 <= edit_flag)
>>                   use_editor = edit_flag;
>>
>> I think it should have moved those last two context lines that set
>> `use_editor` to below the part that you are fixing. Then the `use_editor
>> = 0` line that you are changing continues to work as before. (As you see
>> there are quite a few legacy Yoda conditions in this file, nowadays we
>> avoid adding new ones). I'm not sure if it is worth re working this
>> patch to do that, but it does have the advantage of only testing
>> edit_flag once.
> 
> I looked at moving the condition to one place but as use_editor = 0
> is only set for --fixup if there isn't a suboption specified I didn't want
> to have to duplicate the check for a suboption when deciding if
> use_editor should default to zero.

I don't think you need to duplicate the check for a suboption, can't you 
just do this on top of master (i.e without you patch applied)?

diff --git a/builtin/commit.c b/builtin/commit.c
index 243c626307..67a84ff6e4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1251,11 +1251,6 @@ static int parse_and_validate_options(int argc, 
const char *argv[],
         if (force_author && renew_authorship)
                 die(_("Using both --reset-author and --author does not 
make sense"));

-       if (logfile || have_option_m || use_message)
-               use_editor = 0;
-       if (0 <= edit_flag)
-               use_editor = edit_flag;
-
         /* Sanity check options */
         if (amend && !current_head)
                 die(_("You have nothing to amend."));
@@ -1344,6 +1339,11 @@ static int parse_and_validate_options(int argc, 
const char *argv[],
                 }
         }

+       if (logfile || have_option_m || use_message)
+               use_editor = 0;
+       if (0 <= edit_flag)
+               use_editor = edit_flag;
+
         cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);

         handle_untracked_files_arg(s);

I chose to move the other clause that sets use_editor as well so they 
stay together.

Best wishes

Phillip
>   
>>> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
>>> index 7d02f79c0de..a48fe859235 100755
>>> --- a/t/t7500-commit-template-squash-signoff.sh
>>> +++ b/t/t7500-commit-template-squash-signoff.sh
>>> @@ -281,6 +281,19 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
>>>    
>>>    extra"
>>>    '
>>> +test_expect_success 'commit --fixup --edit' '
>>> +	commit_for_rebase_autosquash_setup &&
>>> +	write_script e-append <<-\EOF &&
>>> +	sed -e "2a\\
>>> +something\\
>>> +extra" <"$1" >"$1-"
>>> +	mv "$1-" "$1"
>>> +	EOF
>>
>> Again I'm not sure it is worth changing it now but for future reference
>> this is a rather complicated way of appending to the commit message. The
>> test file has an example using set_fake_editor() together with
>> FAKE_COMMIT_AMEND just below where you have added this test or you can
>> just have
>>
>>       EDITOR="echo something extra >>" git commit --fixup=HEAD~1 --edit
>>
>> Best Wishes
>>
>> Phillip
>>
> 
> Yeah, especially getting sed in a POSIX and BSD compatible mode took some
> doing. I wanted to have a similar output to the test above this one, with a line break
> between something and extra, and frankly, my shell-foo lacked for
> getting either FAKE_COMMIT_AMEND or EDITOR="... >>" to include a newline.
> But looking at it again, I realize that EDITOR="printf \"something\nextra\" >>"
> works just fine.
> 
> /JK
> 
