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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2CEC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 22:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D036103A
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 22:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhHRWTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 18:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbhHRWTk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 18:19:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E86EC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 15:19:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q2so2710926plr.11
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XPewk6+vOXfDNYjbWxfVcU1UdQsLArdIRddcoJ4ia98=;
        b=bn9GElBZNPx+63n4BdU6BhPaqcnZAs1d4z+Im3oDCk4jleLd7Oo1pOApRh+TC3XNSM
         ugeJCUC021OefJCPzZ7Jzvdnaor9I90PTbrCp3fKzdBkycFZPOpIF0stJQhuFFVWZC3l
         8ndZh3erhHSoXSLgYDVVQrpeEXhzYcZAomzTZ1ORx3TZYADjZaVS3YqkQJcumhN1ALlW
         HSuLjKZO3uMVyQ66W1cP3HBsbnU38ekhvYk5Lkx8kAo7riokpi0Viv+MDhVpF8W0hNS1
         M/PuvYHgyKeau+m5tgsy0p1j/gVKfFdABzf1kOkiesxecGo5jbO8By5lRJJfKbRRGWJ5
         w5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XPewk6+vOXfDNYjbWxfVcU1UdQsLArdIRddcoJ4ia98=;
        b=CIM7MNTu1kankxSOHJASOoUGqY6DiZ2hBWzAtY90HLXn2AgWTSlFJtQTnBqvZqolnq
         Z4EqHp2iLQUN8TZDSvGhB6okOUdnNLsPazOs32+RWot5408fuTDm9LQWontN5sbg6Lzy
         UM1+SBaNLZf4dE4YxlewZDtTMJMk5Fy61lwNL96exCH9mXcZqgIFjEN6fCDzjkaEUmYK
         kjF/Fe2QPJBHjRT8uedli2rW0QUCJSnzIkCylhAzsvLfEWABPvY0T975mtj4j0HPExk/
         7ezm+zCjZ77iHjDt/LnBhnlH+mgTApUuXcOLyEwffUewioS14QoArJzkN8UiqMJzH30z
         v8MQ==
X-Gm-Message-State: AOAM532/VUU4S8m+RK+kF9JfSpCu93pb1440mY9uxHenghmFUaZ6GM8Q
        0o8dGnNm4PWjQHpX0UHnnT4=
X-Google-Smtp-Source: ABdhPJzaSgvyB0SbNwtvUZ2AGMFn77e5QGeVUSmHRrKinxtKeK2z8SCgdt62giBzTXALqWEUKzZGAw==
X-Received: by 2002:a17:902:bd98:b029:12c:9106:b54f with SMTP id q24-20020a170902bd98b029012c9106b54fmr8953824pls.40.1629325144938;
        Wed, 18 Aug 2021 15:19:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:f590:5dc4:8388:5140])
        by smtp.gmail.com with ESMTPSA id b6sm804993pfr.158.2021.08.18.15.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:19:03 -0700 (PDT)
Date:   Wed, 18 Aug 2021 15:19:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, hanwen@google.com,
        avarab@gmail.com, hanwenn@gmail.com
Subject: Re: [PATCH] fixup! propagate errno from failing read
Message-ID: <YR2HVU4KBCihqoYZ@google.com>
References: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com>
 <20210817161419.3606302-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817161419.3606302-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:
> Han-Wen Nienhuys wrote:

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 0d96eeba61b..f546cc3cc3d 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -454,6 +454,7 @@ stat_ref:
>>  	}
>>  	strbuf_reset(&sb_contents);
>>  	if (strbuf_read(&sb_contents, fd, 256) < 0) {
>> +		myerr = errno;
>>  		close(fd);
>>  		goto out;
>>  	}
>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
>
> Thanks - a straightforward fixup. (I don't think we need the errno from
> close() in this case.)

This looks good as far as it goes, but how do we know this has covered
all the code paths?  Let's see.

The only nonobvious paths are

 stat_ref:
	/*
	 * We might have to loop back here to avoid a race
	 * condition: first we lstat() the file, then we try
	 * to read it as a link or as a file.  But if somebody
	 * changes the type of the file (file <-> directory
	 * <-> symlink) between the lstat() and reading, then
	 * we don't want to report that as an error but rather
	 * try again starting with the lstat().
	 *
	 * We'll keep a count of the retries, though, just to avoid
	 * any confusing situation sending us into an infinite loop.
	 */

	if (remaining_retries-- <= 0)
		goto out;

and

	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr);

 out:
	if (ret && !myerr)
		BUG("returning non-zero %d, should have set myerr!", ret);

For the 'stat_ref' case, we have to check that whenever we 'goto
stat_ref', we set myerr moments before.  Fortunately, that is the
case.

For the 'fall through into out' case, we have the check the
parse_loose_ref_contents always sets *failure_errno on error.  That is
also the case.

So this indeed covers all our cases, and the BUG now correctly
reflects an invariant we can count on.  Thanks for the fix, and thanks
for looking it over.

Sincerely,
Jonathan
