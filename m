Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E659C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 01:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63A3207FF
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 01:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6hEiBSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLJBtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:49:40 -0500
Received: from mail-yw1-f47.google.com ([209.85.161.47]:37692 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfLJBtj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 20:49:39 -0500
Received: by mail-yw1-f47.google.com with SMTP id v84so300781ywa.4
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 17:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SUDXIvnDTmZ05dXvQJo6JD7kP/NxvSJqMS2IqMVYIjg=;
        b=U6hEiBSt70v7/2DIRCLPF3f+yTtdG6HlAkoerqQ2adakweaIchArx+6we74RBFDp+m
         uNX+BQYpXqllVCeQ7+488Hw0qL7qk4ZQ1Q/ars3jODO49pHcWhG1Sodf+1pL8Ij6ELNe
         rG7etc895vw0WIX8a87hZ5zTdSQ8wXbVKdv2OiutrCzNR5z0zToAHRuZWjFN2DhH0923
         ZAtoHNzjCKLwkt471Ng6R2WB0XOYmbWvMpWjpvzCfezLcCOiftjiFdAmBJAWzBJqjzIt
         +3Cp3DF+xxvrL1cxktwJOnkUYw8l1OvftnDy444VLLGzHzCNM2gYHZqnKuvQSeiJrXOb
         z/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SUDXIvnDTmZ05dXvQJo6JD7kP/NxvSJqMS2IqMVYIjg=;
        b=hYbKf+M/Z0cNiG6IcGWU8lejH5ZkyDNpNyumLqIbsj2Y4dnPF/pe87bxqUlw9KOV6Y
         q+26bon1ZUBdaPDp0k7cT54XMsiqwbqWmJ+rE8na9XxFMapvOghEBg+lk3n0hUdQDGag
         XG0UuKAX87rDSEcRe3jK/vFkuka6KPwGiBmrZgxQi4DKTBRmZC5qFy7wEgq+wIrg93yh
         03qCBypCQ96abgk8HEzLrV8bBM8q6v+E9srKQzHknkHxygyf7T8IwGu4U838W92BgT66
         JvW5HNPiDDHv/t0/Syip7SmX5A4Lv9BljBbFqHHxDMFyIS3PpYpmu/cR4/HnU9LEhBkU
         8RAg==
X-Gm-Message-State: APjAAAXGAfs2JM4vnCpvWQC6x+HQbnq5CLneYp0wCBQIXvi6UgPWGT9z
        XmvpTdIjUirD81mQYNYU31E=
X-Google-Smtp-Source: APXvYqwdH5n+sca+ftmIRqR+EBbJp9/iQCrnO19LaTFy3YAFXZGJHBwFQG03LZ3ah0azirArgGXA/g==
X-Received: by 2002:a81:a541:: with SMTP id v1mr17290610ywg.423.1575942578644;
        Mon, 09 Dec 2019 17:49:38 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j5sm774358ywc.30.2019.12.09.17.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 17:49:38 -0800 (PST)
Subject: Re: [PATCH v2 8/8] test-lib: clear watchman watches at test
 completion
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
 <e51165f260d564ccb7a9b8e696691eccb184c01a.1575907804.git.gitgitgadget@gmail.com>
 <xmqqwob5ru27.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bfa73fab-ce2c-a05e-3568-cd406dd5c31f@gmail.com>
Date:   Mon, 9 Dec 2019 20:49:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqwob5ru27.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2019 5:52 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +test_clear_watchman () {
>> +	if test -n "$GIT_TEST_FSMONITOR"
>> +	then
>> +		watchman watch-list |
>> +			grep "$TRASH_DIRECTORY" |
>> +			sed "s/\",//g" |
>> +			sed "s/\"//g" >repo-list
> 
> Whoa, this is scary.  "$TRASH_DIRECTORY" comes from $(pwd) and the
> leading part of it can have arbitrary garbage like "[a-z]*" that may
> match paths "watchman watch-list" may emit that does not have
> anything to do with the temporary directory used by this test.

Hm. That is a good point. Can we assume that our version of grep has
a "-F" or "--fixed-strings" option? ([1] seems to say that "-F" would
work.)

[1] https://www.gnu.org/savannah-checkouts/gnu/grep/manual/grep.html#index-grep-programs

> What are these stripping of ", and " about?  Could you tell readers
> how a typical output from the program we are reading from looks like
> perhaps in the log message or in-code comment around here?

Watchman outputs its list of paths in JSON format. Luckily, it formats
the output so the path lines are on separate lines, each quoted.

For example:

{
	"version": "4.9.0",
	"roots": [
		"<path1>",
		"<path2>",
		"<path3>"
	]
}

Thanks,
-Stolee
