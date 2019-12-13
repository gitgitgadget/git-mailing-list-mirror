Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD099C3499B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E305D2478B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvpE8EyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfLMOkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:40:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36446 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfLMOkD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 09:40:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id q20so679654qtp.3
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7MOqTB7Yyv5ZqidC06Z4Shq0j5XWWzSDkY/mvPZgP3M=;
        b=DvpE8EyI8oGwJp2t7/b4tPBym3eqHbruQmaqo3w4zhq9snQmzJiHhffYvwd4RpYm1X
         hjFNYgRnrJqjSyO4MMWaYcg6djyfl0HfpCu1RQZpu8UVqBWwoy8hgk+VzNLPlmIqcx6w
         GeFLS4dfFw666rnyjMa7Ql29nIJGwLIvZyorB0sXBbr86G/uPsabSP3FhXUVqvo5HKP7
         yw0RV++7RnnlVSnftEVsoX6990IybRjVKDDKMw9ynx1puOhy9/nz//Vb+ae0poADOyBS
         MIK12A0T0hcydJMU4+XFoWIy8HyVXrOP4lDRwFQ4QMvhN+Fw8iK3iSCwemKPBdxvRr5l
         0Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7MOqTB7Yyv5ZqidC06Z4Shq0j5XWWzSDkY/mvPZgP3M=;
        b=nJ+N3cH+0GSY8qeyw5HZvxuH0HmyrZu1cmZ3jtqS42qEnZIW9E5z9aaAwv3DbEVhXL
         tkJO5QJO0KUkyKIdszrLU4C1d/cmrNhN80b1up8cXQrTd6O1TOMp+AgJr+cjg89d/+W3
         53WrSP1VaxKpmD3kGIW2wvbxdb+nkYsO13bNW5aZF31k0zrYuRBwgLE1p1JGlULuVR3m
         USL8kgOn/Tv3yyBsw1DX558XSuoRHyU8XGi5ceeNGbtRMLoIbEIpXX42Lm7AvWjbqfOz
         G9aU/JPIaXarif7MKdMuNbjF4fBe0Ehy4NMhMebuqcMtMvFLSzvdmODgA56ydftE+pi2
         my4w==
X-Gm-Message-State: APjAAAVDN0R0g8JriHAUe14rOHSjaUryDad+6L9iL6uHeII5xKjA4HU9
        CYtWmL2kjFIb2+RAmQ6KDzYoCQ7TjjQ=
X-Google-Smtp-Source: APXvYqw+h/lkwdAbcxqYnLZ5pSgj+XGc5bhINu8wB0yAoOfKuEf18NP+NyazTYe0RakKn/ov+yOIDQ==
X-Received: by 2002:aed:3242:: with SMTP id y60mr12416538qtd.254.1576248002061;
        Fri, 13 Dec 2019 06:40:02 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id 11sm2843381qko.76.2019.12.13.06.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 06:40:01 -0800 (PST)
Subject: Re: [PATCH v5 04/15] git-p4: change the expansion test from
 basestring to list
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
 <7170aface2270e8c46439c5c1e01d2b18cdf6fd0.1575740863.git.gitgitgadget@gmail.com>
 <xmqq8snlutyx.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <7141d2c7-8b6f-d4a9-f6cf-6660f42fb5e1@gmail.com>
Date:   Fri, 13 Dec 2019 09:40:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8snlutyx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/9/2019 3:25 PM, Junio C Hamano wrote:
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> The original code used 'basestring' in a test to determine if a list or
>> literal string was passed into 9 different functions.  This is used to
>> This is mostly true, but the use in p4_build_cmd() and the second
...
> use among the two uses in p4CmdList() are different.
>
> 	Some codepaths can represent a command line the program
> 	internally prepares to execute either as a single string
> 	(i.e. each token properly quoted, concatenated with $IFS) or
> 	as a list of argv[] elements, and there are 9 places where
> 	we say "if X is isinstance(_, basestring), then do this
> 	thing to handle X as a command line in a single string; if
> 	not, X is a command line in a list form".
>
> 	This does not work well with Python 3, as there is no
> 	basestring (everything is Unicode now), and even with Python
> 	2, it was not an ideal way to tell the two cases apart,
> 	because an internally formed command line could have been in
> 	a single Unicode string.
>
> 	Flip the check to say "if X is not a list, then handle X as
> 	a command line in a single string; otherwise treat it as a
> 	command line in a list form".
>
> 	This will get rid of references to 'basestring', to migrate
> 	the code ready for Python 3.
>
> or something like that?
>
I incorporated this into my suggested submission to Yang's work. Thank you.
