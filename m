Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368BEC433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 15:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F59E206E6
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 15:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggQPJQk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgFDPXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgFDPX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 11:23:29 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C59C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 08:23:29 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e16so5560499qtg.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XYiGfAjLzWeS4p7XukkwKtVVBZWGJIQWCnU5OipTDqo=;
        b=ggQPJQk+iBzUPVDsbSqxdm+eQz1/7hXzU7sfs8bIiTX+HQPz6gg340vZYCASiFAWtS
         Fm5Fn59ENUU8OHiEk9OaMiwWPLs2gw7xTWlbINFXaaX4Wyki+XMCvoh0eVYtoc21Iy3H
         e7uf6lYog/ZGfwV0Gy03qnqd+kdLm+fiwMAypDNeKoAqY2Gg9LN9JX1pKzCXxJQW5mZa
         VxTbQEm5thsd/SiXR8UdZh837IIl54598yKbsAmhLXF1V3VYYQ+kZZ9Z8/E3z0URll6z
         tUZaBWqu6TaZ5YIRex9QxlTlqX+X1jNDeXLJ5sd7STC8IPx7MXjBzHLAWnAfXg1SmjY6
         yjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XYiGfAjLzWeS4p7XukkwKtVVBZWGJIQWCnU5OipTDqo=;
        b=UdKUbeYHhtTiW0TGVlHONVQU0/eTEDOtIdUH7/4nl5KMF6Bj9ZRXw9BUME4N/lxdCo
         flbRjihco7LmG8+MgR/AUSiSAoTxkfJlcZZ3Hz0ppplzLy/PrCFYiAZ8C0JVMdua60HI
         bJmc5qi9zfotcHJqn/z2xOYL6aVFzCtT6TLg+kKDaTKEuepm03I52iZ0dCcV0uKfMJ60
         N1igJjslOMXQo3tmikq/okPwvYrlWgpT8OF3QSuCfZaTLvFj/8so/3CLm6jh6cMnv1YQ
         eJOR+pr3ApNzFIWEXWnbk7cwHOw2JiO+IdEMvgzyp5VFRyaxS4ektEEhc4Rny5UC9QeK
         FLwA==
X-Gm-Message-State: AOAM533JGWfEnEvLUope43p8s0zz27dE4h204dMlOUoZkmKGlgO4SVxb
        eoFG1mHprZDq5fBhhSer1zk=
X-Google-Smtp-Source: ABdhPJzLv+jlMntatZP8kjeqn1n0mKdn/S36Rq3b3U8NUSAsKQAA00j/jPE3uB5wo5TJGdNTjlbgIg==
X-Received: by 2002:aed:3f25:: with SMTP id p34mr4966727qtf.92.1591284208511;
        Thu, 04 Jun 2020 08:23:28 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x186sm4347402qkd.125.2020.06.04.08.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 08:23:27 -0700 (PDT)
Subject: Re: [PATCH] sparse-checkout: avoid staging deletions of all files
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Shaun Case <warmsocks@gmail.com>
References: <pull.801.git.git.1591258657818.gitgitgadget@gmail.com>
 <7c34da8e-87b8-5236-4536-4d8fbc3f1e80@gmail.com>
 <CABPp-BFmFd7gxN7cd04GFD9kCFEMbfXdv7dHCYRB4z21AUpZWQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6e5970f6-9b9b-19ba-1035-f4f53d9ac030@gmail.com>
Date:   Thu, 4 Jun 2020 11:23:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFmFd7gxN7cd04GFD9kCFEMbfXdv7dHCYRB4z21AUpZWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2020 11:05 AM, Elijah Newren wrote:
> On Thu, Jun 4, 2020 at 7:48 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 6/4/2020 4:17 AM, Elijah Newren via GitGitGadget wrote:
>>> +test_expect_success 'interaction with clone --no-checkout (unborn index)' '
>>> +     git clone --no-checkout "file://$(pwd)/repo" clone_no_checkout &&
>>> +     git -C clone_no_checkout sparse-checkout init --cone &&
>>> +     git -C clone_no_checkout sparse-checkout set folder1 &&
>>> +     git -C clone_no_checkout sparse-checkout list >actual &&
>>> +     cat >expect <<-\EOF &&
>>> +     folder1
>>> +     EOF
>>> +     test_cmp expect actual &&
>>> +     ls clone_no_checkout >actual &&
>>> +     test_must_be_empty actual &&
>>
>> My only comment on the test case is to see if you could use
>> the "check_files" macro instead of "ls". See 761e3d26
>> (sparse-checkout: improve OS ls compatibility, 2019-12-20)
>> for details.
> 
> I attempted to do so initially, but that function fails badly when
> there are no files (other than the "hidden" files '.git', '.', and
> '..') in the directory.  The reason for this comes from the "printf
> '%s\n' *" -- the glob won't match anything and so it prints a literal
> asterisk, which is not helpful.
> 
> I thought about writing an asterisk out to the expected file for
> comparison, but that just made the testcase look confusing.  It was a
> lot cleaner to just use ls with no glob coupled with
> test_must_be_empty.
> 
>>> +     test_path_is_missing clone_no_checkout/.git/index &&
>>> +
>>> +     # No branch is checked out until we manually switch to one
>>> +     git -C clone_no_checkout switch master &&
>>> +     test_path_is_file clone_no_checkout/.git/index &&
>>> +     check_files clone_no_checkout a folder1
> 
> However, when I did have files in the directory, then I used your
> check_files function as seen here.  :-)
> 
> 
> Does that make sense, or is there a better alternative?

Unfortunately, we'll still have the platform issue, since there
_is_ a .git directory. To repeat the commit message for 761e3d26:

    On FreeBSD, when executed by root ls enables the '-A' option:
    
      -A  Include directory entries whose names begin with a dot (`.')
          except for . and ...  Automatically set for the super-user unless
          -I is specified.
    
    As a result the .git directory appeared in the output when run as root.
    Simulate no-dotfile ls behaviour using a shell glob.

So maybe be purposeful and include the -a option and expect only the
.git dir (along with . and ..)?

Something like:

	cat >expect <<-\EOF &&
	.
	..
	.git
	EOF
	ls -a clone_no_checkout >actual &&
	test_cmp expect actual &&

Thanks,
-Stolee


