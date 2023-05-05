Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710CBC77B75
	for <git@archiver.kernel.org>; Fri,  5 May 2023 21:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjEEVox (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 17:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjEEVoa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 17:44:30 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D0F6E95
        for <git@vger.kernel.org>; Fri,  5 May 2023 14:43:53 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-5e7534b6736so3370326d6.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683322980; x=1685914980;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RUMfr6T4ERaFgfMRBYLRq95cpX8zg3p9u3xDqV7XfrM=;
        b=motgbJY+zROncZMfA8oBXmFNMLu49n0sbY3oYiLm0gu1CHdDAPdwB3Edk40xiFI7kM
         MMDJ8fBjefyuG9bD/31daHa9BKXhN3combat2fZA7B9/g7BpBgyflRTxta4ZhKwz+lPk
         na9jKvAiP+brO7xioHSADQA49nGFfBnHIYsIZPVaUeABE7UAYEbmtZWTFOV6kISHcfvB
         eFXIi15KY9v+dWbGqcUP3EBV306Uy6REy40RiEcriluK+YnI7Xvszc3fqnqxQK2vi1Ee
         o80PtYajhYTYHXh5eUKFz57XZsCx0JCiBPgtYuUaj0oqX3fKK3JEFAb6TEh09sTuIuiF
         dPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322980; x=1685914980;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUMfr6T4ERaFgfMRBYLRq95cpX8zg3p9u3xDqV7XfrM=;
        b=QRGz3+DS4zRJ3luY+VVXIU2OvGbFydwiEB6F5HHn7qjY2/vWWYfjRNynobhHV8aOc/
         2WotBRfUZuYb4biedNTn6avTxyS6+/NaYsl05CP4QXxs8l51CVLLgrSKj6Uffex2sV+6
         ZKCqJlDCdJRUJlEoKuAcZf218lO0ib33fEwFdGjPkq/HunH9Uof+o+uB8HsxuYAtKO9k
         hYu6aG99b9asWii0cmOHEqK4wEKsPR02jgQ5jDg1abEHwDW8Oh2PT/9Xah75yVzfWPYH
         QmlqtDZEGw/SY12jCvTpZit0BORwSKjlvp6B0zjdCWypXNE5bjz4o3ZakrzV46xuUIDz
         bYzg==
X-Gm-Message-State: AC+VfDxuERkXIOYcvLh6XeIPBQVOJ00FB67mgvXA2ns/svqHCaA9wYIQ
        7KXPDIDIlW74MWdGI0oXxD0=
X-Google-Smtp-Source: ACHHUZ51Fq8hzOMINGmTq78Mu+FnDV181hL/UQG+Un2he5D+bqB10sYGc8K38SIVQ9mrvlwbwyva0Q==
X-Received: by 2002:a05:6214:622:b0:621:bf0:7609 with SMTP id a2-20020a056214062200b006210bf07609mr87580qvx.0.1683322980373;
        Fri, 05 May 2023 14:43:00 -0700 (PDT)
Received: from [10.37.129.2] ([2600:4041:4533:8b00:d00d:6770:7b2e:5240])
        by smtp.gmail.com with ESMTPSA id n8-20020a0cdc88000000b0061a0f7fb340sm901850qvk.6.2023.05.05.14.42.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 May 2023 14:42:59 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] name-rev: make --stdin hidden
Date:   Fri, 05 May 2023 17:42:58 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <DA805D46-DB2A-4571-A157-5959344C8CA8@gmail.com>
In-Reply-To: <xmqqild6d0y0.fsf@gitster.g>
References: <pull.1225.git.git.1646774677277.gitgitgadget@gmail.com>
 <pull.1225.v2.git.git.1683314270964.gitgitgadget@gmail.com>
 <xmqqild6d0y0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 5 May 2023, at 15:37, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> In 34ae3b70 (name-rev: deprecate --stdin in favor of --annotate-stdin),
>> we renamed --stdin to --annotate-stdin for the sake of a clearer name
>> for the option, and added text that indicates --stdin is deprecated. The
>> next step is to hide --stdin completely.
>>
>> Make the option hidden. Also, update documentation to remove all
>> mentions of --stdin.
>>
>> Signed-off-by: "John Cai" <johncai86@gmail.com>
>> ---
>>     name-rev: make --stdin hidden
>>
>>     Now that --stdin has been deprecated for several releases, the next step
>>     of replacing name-rev --stdin with --annotate-stdin is to make --stdin
>>     hidden. This patch also updates documentation to get rid of any mention
>>     of --stdin.
>
> Nice.  It has been a year, and I agree that it is about time.
>
> Thanks for not forgetting about the topic.
>
>>      -+			   N_("deprecated: use annotate-stdin instead"),
>>      ++			   N_("deprecated: use --annotate-stdin instead"),
>
> And of course this one is a very nice touch, relative to the
> previous round.
>
>>       +			   PARSE_OPT_HIDDEN),
>
>> diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
>> index ec8a27ce8bf..5f196c03708 100644
>> --- a/Documentation/git-name-rev.txt
>> +++ b/Documentation/git-name-rev.txt
>> @@ -10,7 +10,7 @@ SYNOPSIS
>>  --------
>>  [verse]
>>  'git name-rev' [--tags] [--refs=<pattern>]
>> -	       ( --all | --stdin | <commit-ish>... )
>> +	       ( --all | --annotate-stdin | <commit-ish>... )
>>
>>  DESCRIPTION
>>  -----------
>> @@ -70,10 +70,6 @@ The full name after substitution is master,
>>  while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
>>  -----------
>>
>> ---stdin::
>> -	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
>> -	They are functionally equivalent.
>> -
>>  --name-only::
>>  	Instead of printing both the SHA-1 and the name, print only
>>  	the name.  If given with --tags the usual tag prefix of
>
> I agree with the main thrust of the change, but I am not sure if it
> is a good idea to "completely" remove the mention.
>
> Even after we stop talking about it, people find old scriptlets that
> use "name-rev --stdin" from various random places on the Internet,
> and wonder if they are buggy.  I wonder if having something like
> this for a year or two may help?  We would need to scan for "was
> called" and decide to clean them up once in a while, of course.

Yeah, that's valid.

>
> Will queue as is.  Thanks.
>
>  Documentation/git-name-rev.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git c/Documentation/git-name-rev.txt w/Documentation/git-name-rev.txt
> index 5f196c0370..1173deae57 100644
> --- c/Documentation/git-name-rev.txt
> +++ w/Documentation/git-name-rev.txt
> @@ -46,7 +46,8 @@ OPTIONS
>  	Transform stdin by substituting all the 40-character SHA-1
>  	hexes (say $hex) with "$hex ($rev_name)".  When used with
>  	--name-only, substitute with "$rev_name", omitting $hex
> -	altogether.
> +	altogether.  This option was called `--stdin` in older
> +	versions of Git.
>  +
>  For example:
>  +

Sounds good to me. Will add this in

thanks!
John
