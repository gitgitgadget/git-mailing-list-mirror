Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A76C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97F22073E
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2HphA30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgDMOPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbgDMOPA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 10:15:00 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3324AC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:15:00 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m2so9210660otr.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v5aQCwGW5qna2h2W3zbyUpwwvxqS/YylSDe99iGsDII=;
        b=a2HphA3022mqn2Kw0NYNQvAnTgD76xqRg4jkEggT2d8jH4F/25p/ZSqvt3HV+CIrxv
         v7PeRgew+I+NpFBnAGROQtHJgKR1YnuoEJYy4pkkZlhdDTbAQ+hHSEJLJdDJ61l8x6vo
         86yOjjPC3lsqqBPZzJRY537ijH5V8x4sDR4MJ/DOK0lpP7+ubAW/iskfgcL/aaxBuYeT
         8gh6nZglHSuGDweRo9CDIQrV4NtiOV826HqFjC4iZEsXx5MFF8mnXOBiX2Eg/I91gSYa
         yYI2YHDiJ3PkdtfMf3TEdfGUjoMtv50QjkA7nSzULT91fTRhtEhFqFLSYXxSffmT/Uvl
         QYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v5aQCwGW5qna2h2W3zbyUpwwvxqS/YylSDe99iGsDII=;
        b=OfJ2kx1cDtrHjHU3VpLBaTraPZOOCPsQE5L8udvnTG+HzmwiRk8DCYJOY/QPmwH9/a
         sqhqpjhFzrPac+k99IqEUO5h/HI+H0ffAADQJahtHgJS2LWPPc0m+ZxOK9q4qSz6JH7N
         Qvq3icYGdYA5fspv1a9hKoDNnb8IcWqEu0cs7Y5P+DzCk1kecHW+zzz5X7bWmPODKB8p
         wuXFVN+RC8WKAcjDlNB63sGprAtWA8d8A+WuDruJUbTJGxrgAJWqqxsYsXOFBkhd0ho8
         lo4F8SP1zEponqx806ryM+nvcOI12Uf0YfdcwbvYpvaKNm72jHPO0iE9p6F+sxNkybOs
         Kk4Q==
X-Gm-Message-State: AGi0PubGHQ0I1CS7dsMmyvuWX/aOYnAI3XSm/0bJIlSsR3hQkwYu1I2z
        AjYAAMhpkzz5yjKfIy845pQ=
X-Google-Smtp-Source: APiQypLqobo3fnMh2IjIqwlzuGN2eWsWJRwpmCxn8MwhAN1x0vf2ucFla15qjLfxDNjjV4Rzs+zsiA==
X-Received: by 2002:a05:6830:2386:: with SMTP id l6mr4531734ots.128.1586787299298;
        Mon, 13 Apr 2020 07:14:59 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h65sm4776822oth.34.2020.04.13.07.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 07:14:58 -0700 (PDT)
Subject: Re: [PATCH 03/15] run-job: implement fetch job
To:     Son Luong Ngoc <sluongng@gmail.com>, gitgitgadget@gmail.com
Cc:     dstolee@microsoft.com, git@vger.kernel.org, jrnieder@google.com,
        peff@peff.net
References: <CAL3xRKew_RHbPbp0qSa7WcDbaMmMWWmBi_nvPbmKaSpVDJM08g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fb80f3e5-ea22-b9fe-5818-c915e5a15014@gmail.com>
Date:   Mon, 13 Apr 2020 10:14:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <CAL3xRKew_RHbPbp0qSa7WcDbaMmMWWmBi_nvPbmKaSpVDJM08g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2020 9:15 AM, Son Luong Ngoc wrote:
> Hi Derrick,
> 
> First of all, thanks a ton for upstreaming this.
> Despite multiple complaints about re-implementing cron in git,
> I see this as a huge improvement to git UX and it is very much welcome change.
> 
>> 3. By adding a new refspec "+refs/heads/*:refs/hidden/<remote>/*"
>>    we can ensure that we actually load the new values somewhere in
>>    our refspace while not updating refs/heads or refs/remotes. By
>>    storing these refs here, the commit-graph job will update the
>>    commit-graph with the commits from these hidden refs.
> Ideally I think we want to let user configure which refs they want to
> prefetch with the default behavior being prefecting all HEADS
> available from remote.
> Using Facebook's Mercurial extension
> [RemoteFileLog](https://www.mercurial-scm.org/repo/hg/file/tip/hgext/remotefilelog/__init__.py#l31)
> as a UX reference,
> users should only prefetch the refs that they actually care about.

I will be sure to review this prior art before
submitting an update to this series.

>> 1. One downside of the refs/hidden pattern is that 'git log' will
>>    decorate commits with twice as many refs if they appear at a
>>    remote ref (<remote>/<ref> _and_ refs/hidden/<remote>/<ref>). Is
>>    there an easy way to exclude a refspace from decorations? Should
>>    we make refs/hidden/* a "special" refspace that is excluded from
>>    decorations?
> In git-log, there is
> [--decorate-refs-exclude](https://git-scm.com/docs/git-log#Documentation/git-log.txt---decorate-refs-excludeltpatterngt)
> which I think we can move into git-config as
> `log.decorate-refs-exclude`?
> If you let the `prefetch refs` be configurable as I suggested above, I
> think it make sense to have the git-log exclusions being configurable
> as well.

I was literally just working on exactly this when
your message arrived. I was going to name the config
option "log.decorateExclude".

Thanks,
-Stolee
