Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0397C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 15:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD6660F11
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 15:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbhHNPVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 11:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhHNPVP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 11:21:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91B7C061764
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 08:20:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u1so8790052wmm.0
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:reply-to:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rkhVv47oSk4rASCk9k0dvG8cSMvH5y8vDlzNT5FW95c=;
        b=gfayKJ+ST6HTxEL3wqkkPHDWJhc8aoM5We++refutYl3jWUz8QLyoml8Dkcm912gZk
         os0qROiygwTuqC2IVzLZL7OfYYFUPGXNbtAUSImD4R319OgXxieW9uZXEf3on5o6uZHt
         IYomxcqHJzkZqA4SpuKb1O+yOmO+cEjWzalJquX4PaSqqpBDV+Fwa2y04mDCBBkG3vnQ
         /Mh00x0lnyofDNfILkYT0HEJA2uG2K04ClNRzdZoaES/Zs0HCVEf/EqAnZj+XawdJ/8v
         FK50dAadXhv2r8/T+II6hvlqxhCHhy9Bp/tRPo2Nu46q6BEm0tEaiyHNH/cA0N4dOJnZ
         cicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:reply-to:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rkhVv47oSk4rASCk9k0dvG8cSMvH5y8vDlzNT5FW95c=;
        b=DlK/RN7C4SIWRqZs1t14js+RGfsfjC49Fk6lodlrVkd1GOBhBsignQ5ffCsI9pkFlK
         rXqVXt/WzvP96rRtu6oGNZ1Kb31qll4sn5ale0lWyolxDAVauuExprPMTZVJEAMNX2dG
         lp+MkmOrFmD2bme8aVOUl9CzF/qVTP1QtpVkoqhntvSOn069ECEUDtMmymR+EEa0FtSt
         9iKMID4IGD7gZnnTJrF9PgsArhkFdBIeyYwDsPBSur699/UFBsX2sN3iU2oBA9sHi0Vp
         1h+m/5kntOCc0EudS7ZTzng8WdpHbk84OD/wfF61sdDAylV0+3bYO+nzb1ePaTZJvKbN
         ++3g==
X-Gm-Message-State: AOAM5313Wjb1blEqs4pmyHRT4CbbY5xhTOsnZpwiLX45VBJQFT0QgkRY
        tiLUCVCZIx2Pd9VRMy/kRGA=
X-Google-Smtp-Source: ABdhPJwjgZXVn95wliSN9zvBLN0TEqc8DtZXXdStTveUDDlDUqrKhHDisDIQxZh2OEoqkB54WWjyxQ==
X-Received: by 2002:a1c:39c4:: with SMTP id g187mr7565339wma.163.1628954445079;
        Sat, 14 Aug 2021 08:20:45 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id o17sm4404939wmp.13.2021.08.14.08.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 08:20:44 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] commit: restore --edit when combined with --fixup
Reply-To: phillip.wood@dunelm.org.uk
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
 <0151003c-d544-1fab-18e9-34eb84842555@gmail.com>
 <1fc066c5-a085-4865-9eb9-853dfcbe33c2@www.fastmail.com>
Message-ID: <ec5f6698-46e9-c8c8-057d-b04851cb9265@gmail.com>
Date:   Sat, 14 Aug 2021 16:20:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1fc066c5-a085-4865-9eb9-853dfcbe33c2@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel

On 13/08/2021 16:35, Joel Klinghed wrote:
> 
> 
> On Fri, Aug 13, 2021, at 15:06, Phillip Wood wrote:
>> On 12/08/2021 11:01, Joel Klinghed wrote:
>>> I looked at moving the condition to one place but as use_editor = 0
>>> is only set for --fixup if there isn't a suboption specified I didn't want
>>> to have to duplicate the check for a suboption when deciding if
>>> use_editor should default to zero.
>>
>> I don't think you need to duplicate the check for a suboption, can't you
>> just do this on top of master (i.e without you patch applied)?
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 243c626307..67a84ff6e4 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1251,11 +1251,6 @@ static int parse_and_validate_options(int argc,
>> const char *argv[],
>>           if (force_author && renew_authorship)
>>                   die(_("Using both --reset-author and --author does not
>> make sense"));
>>
>> -       if (logfile || have_option_m || use_message)
>> -               use_editor = 0;
>> -       if (0 <= edit_flag)
>> -               use_editor = edit_flag;
>> -
>>           /* Sanity check options */
>>           if (amend && !current_head)
>>                   die(_("You have nothing to amend."));
>> @@ -1344,6 +1339,11 @@ static int parse_and_validate_options(int argc,
>> const char *argv[],
>>                   }
>>           }
>>
>> +       if (logfile || have_option_m || use_message)
>> +               use_editor = 0;
>> +       if (0 <= edit_flag)
>> +               use_editor = edit_flag;
>> +
>>           cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
>>
>>           handle_untracked_files_arg(s);
>>
>> I chose to move the other clause that sets use_editor as well so they
>> stay together.
>>
> 
> With the above change use_editor no longer defaults to 0 for --fixup as
> it used to do.
> My expected behavior (based on old versions):
> git commit --fixup <hash>  /// No editor
> git commit --fixup <hash> --edit  /// Editor
> As far as I can see your change would display an editor in both cases.

I've just tested it and it works as expected. However moving the
'if (logfile...)' breaks the test "commit --squash works with -c" so we
need to just move the second if clause. This is what I have on top of
master (i.e. without your patch so a plain fixup is still setting
use_editor=0)

diff --git a/builtin/commit.c b/builtin/commit.c
index 243c626307..7c9b1e7be3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1253,8 +1253,6 @@ static int parse_and_validate_options(int argc, const char *argv[],

         if (logfile || have_option_m || use_message)
                 use_editor = 0;
-       if (0 <= edit_flag)
-               use_editor = edit_flag;

         /* Sanity check options */
         if (amend && !current_head)
@@ -1344,6 +1342,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
                 }
         }

+       if (0 <= edit_flag)
+               use_editor = edit_flag;
+
         cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);

         handle_untracked_files_arg(s);
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 54c2082acb..3fa674e52d 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -270,7 +270,7 @@ EOF
  
  test_expect_success 'commit --fixup provides correct one-line commit message' '
         commit_for_rebase_autosquash_setup &&
-       git commit --fixup HEAD~1 &&
+       EDITOR="printf \"something\nextra\" >>" git commit --fixup HEAD~1 &&
         commit_msg_is "fixup! target message subject line"
  '
  
@@ -281,6 +281,14 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '

  extra"
  '
+
+test_expect_success 'commit --fixup --edit' '
+       commit_for_rebase_autosquash_setup &&
+       EDITOR="printf \"something\nextra\" >>" git commit --fixup HEAD~1 --edit &&
+       commit_msg_is "fixup! target message subject linesomething
+extra"
+'
+
  get_commit_msg () {
         rev="$1" &&
         git log -1 --pretty=format:"%B" "$rev"
