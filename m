Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC30C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 13:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864F620707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 13:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX9SK4jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgA3Npi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:45:38 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45413 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgA3Nph (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 08:45:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so2887172qkl.12
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 05:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UbndqxjVpjUkPXPR6V3YuVl5dOL7kd9y3upv+ZLURRM=;
        b=gX9SK4jpMDVaYBMAWVQExmb7K1bR37wmN5/fsjF2Ym9bSj/UdScOqQAhqMZyaWp9RQ
         4yf1xH1fGhZcoGNNNiJTaNZbpkgg2xI9TrK8BGA5y41XAht+U090WsdwLjdaPsaczyNb
         x7EWoerk3DCvy/s0aqJO+/5b0XR5kpvcupyvWwo/np0LF/Z/7S5zT11pVEYWabnk2Lka
         dlXV+jC/YIq2XJ89PKHdZVp0p6MyrQkbrk/YKgG7ERZ4v7pUNXNaGeHXpyCexy3Rxsad
         HX7xEOAuy06ApfdYHCGqEy3o4U7FX6+CIyQlxnFktOLkYVeqcsl+4C1BsXaVjcwG16jS
         XPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UbndqxjVpjUkPXPR6V3YuVl5dOL7kd9y3upv+ZLURRM=;
        b=PRqm/W6JBDYU+QMVXH+vwP7Xnn7ZQZEl0ad/3ST88C4mkW8uyPjse9+ruI7OKDbpw2
         0zOkv8eX0HCx6mkq6TljRM7Y6P2D7abzm40THcikhJIuySyIfNkDEX1aQjviezLgm9QN
         rSYzwXBG3vD22Yz/xDP01YXb8LkUjuD0r5wsVvdyyinbBYPOUo7oB6Kv75ThUSJLduRO
         08OP7rLWecJ1HaAAdEsxxIjXqgsctyfgv+WmxbNlebxk0M2SMkUa3OubnIHtgWbwEY5r
         j9U12FS8ght85u4R/AWwuCgHZO47yq4cbBf++Z5kKhyORrX6NqWYvTca/v51gbyR4R4v
         xAww==
X-Gm-Message-State: APjAAAVCybFYvKEci8hAH+xCfJXq0kos1JWXLB1JgFHxbDKeydOGRhh8
        wypncziGADbxGwXAMgWJPmoAiGOCSLE=
X-Google-Smtp-Source: APXvYqyj8r5LFp/fgaukutKsRlkNYTym8ebOy7N4+F0RVbRhLD+vqqkJ3zbWx7sxyZ5d04To1TD/Zg==
X-Received: by 2002:a05:620a:8ca:: with SMTP id z10mr4724553qkz.345.1580391936564;
        Thu, 30 Jan 2020 05:45:36 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id o33sm3085115qta.27.2020.01.30.05.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 05:45:35 -0800 (PST)
Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
To:     Bryan Turner <bturner@atlassian.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
 <CAGyf7-FS8k4gXM-C+qhW8YNGKC57Gh-NY0hM0A08YoFDSETQzg@mail.gmail.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <d5dc5887-7cf3-258c-f778-66b2b504a729@gmail.com>
Date:   Thu, 30 Jan 2020 08:45:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAGyf7-FS8k4gXM-C+qhW8YNGKC57Gh-NY0hM0A08YoFDSETQzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 1/29/2020 8:51 PM, Bryan Turner wrote:
> On Mon, Jan 20, 2020 at 1:17 PM Ben Keene via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> From: Ben Keene <seraphire@gmail.com>
>>
>> Add an additional hook to the git-p4 command to allow a hook to modify
>> the text of the changelist prior to displaying the p4editor command.
>>
>> This hook will be called prior to checking for the flag
>> "--prepare-p4-only".
>>
>> The hook is optional, if it does not exist, it will be skipped.
>>
>> The hook takes a single parameter, the filename of the temporary file
>> that contains the P4 submit text.
>>
>> The hook should return a zero exit code on success or a non-zero exit
>> code on failure.  If the hook returns a non-zero exit code, git-p4
>> will revert the P4 edits by calling p4_revert(f) on each file that was
>> flagged as edited and then it will return False so the calling method
>> may continue as it does in existing failure cases.
>>
>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> ---
>>      git-p4: Add hook p4-pre-pedit-changelist
>>
>>      Our company's workflow requires that our P4 check-in messages have a
>>      specific format. A helpful feature in the GIT-P4 program would be a hook
>>      that occurs after the P4 change list is created but before it is
>>      displayed in the editor that would allow an external program to possibly
>>      edit the changelist text.
>>
>>      My suggestion for the hook name is p4-pre-edit-changelist.
>>
>>      It would take a single parameter, the full path of the temporary file.
>>      If the hook returns a non-zero exit code, it would cancel the current P4
>>      submit.
>>
>>      The hook should be optional.
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-698%2Fseraphire%2Fseraphire%2Fp4-hook-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-698/seraphire/seraphire/p4-hook-v1
>> Pull-Request: https://github.com/git/git/pull/698
>>
>>   git-p4.py | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 40d9e7c594..1f8c7383df 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2026,6 +2026,17 @@ def applyCommit(self, id):
>>           tmpFile.write(submitTemplate)
>>           tmpFile.close()
>>
>> +        # Run the pre-edit hook to allow programmatic update to the changelist
>> +        hooks_path = gitConfig("core.hooksPath")
>> +        if len(hooks_path) <= 0:
>> +            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
>> +
>> +        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")
> The commit subject and the resulting email say "p4-pre-pedit", and I
> see Junio is asking about "p4-pre-pedit", but the actual code, and the
> scissors message, both say "p4-pre-edit". So which is it intended to
> be? "edit", or "pedit"?


"pedit" was a typo in the gitgitgadget submission.  I have since
changed the submission title to the corrected text "edit".

>> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
>> +            for f in editedFiles:
>> +                p4_revert(f)
>> +            return False
>> +
>>           if self.prepare_p4_only:
>>               #
>>               # Leave the p4 tree prepared, and the submit template around
>>
>> base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
>> --
>> gitgitgadget
