Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60253C3DA6F
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 17:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbjHYRVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjHYRVj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 13:21:39 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F682119
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 10:21:37 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7766072ba4so3045594276.1
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1692984096; x=1693588896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBWsXUfT/2pZnw4UbV2ENi3n327vzxTp76s5ugAZAWU=;
        b=ZWUzfz14R6KIAt8gvvJzLC4/vCHcoHjyNh/jALjWVBSFrpA91gDqjPBiR1QVFKYHFe
         C3uiiA1625sxTH8YNF6PZLl6hJoDoaWEL6TpwyjeCV5m4YwnLzILPekfwhcISYJAFA5K
         Eg59JaNZ0/LjdvVA9Ql0PwqiDKPat8QH7kUyL7/C+AC6lo0AJRCHaTNFC8/+GTqcUjNv
         aOVoGD+Cae1NubkpU6VMZesYqwGmiu5qjuWJSltdBfnJkeGoIU7QSOsUUV9leNMZPHGE
         QYa2LyqCJ5P8mNQkLyiwUM4Bu3x3PmQJqlILa7SJH7y7kK8TQLxabfCWheDR5uLZSIZj
         nOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692984096; x=1693588896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBWsXUfT/2pZnw4UbV2ENi3n327vzxTp76s5ugAZAWU=;
        b=XHvDD3dtfHSJoCJOnsBChy0aUv4HppnOdeJX0a0NbAZDXsfYMG9FfuL3i76calURmB
         dTH4KrW+8wv12vxneYMRwpBpVhry87tkSZsTrPjfVxDOJgNgt0sRYTJYX4tXYm+YNBWm
         9LxtYeg6EZqEoRbKIjXds/8OTGACfftlBegId9NkgBjitMmMWBC1Jn725W98wNsrzqzH
         BdzRe5HRH8NrrZTeZ9ez+dpNKdQrXp3aQv/vbDlsE0uoQqMMmOr7g9zpwSmEreFfFaO6
         4ZtKeNyzYojmipO49J0Nefhz5ht5h1htRngX75yZHCEFDkQPY2iXBeT0YY/8OO3Mp1Iy
         vWnA==
X-Gm-Message-State: AOJu0YxWPgFD/SQLBmlIq2bcFriv1EJWwuBww9G6MIb7lDVP3v39Vy4l
        4XF0ryK4Frh1ua3S+FgV5Gqm
X-Google-Smtp-Source: AGHT+IF2cQRW+GS81Mt24LyoPVdK+T2SGzXHx8HZ915nZfYfcVYmiOVYCy3LQRcCMvQd1b7ZHexocw==
X-Received: by 2002:a25:ad4f:0:b0:d72:8ebc:6497 with SMTP id l15-20020a25ad4f000000b00d728ebc6497mr19595386ybe.14.1692984096527;
        Fri, 25 Aug 2023 10:21:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:3cef:28f4:21ea:aecf? ([2600:1700:60ba:9810:3cef:28f4:21ea:aecf])
        by smtp.gmail.com with ESMTPSA id v64-20020a25abc6000000b00d746dda812esm473539ybi.53.2023.08.25.10.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 10:21:36 -0700 (PDT)
Message-ID: <f751dc4d-b605-43ef-8b73-082e8acd5914@github.com>
Date:   Fri, 25 Aug 2023 13:21:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] scalar reconfigure: help users remove buggy repos
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
 <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
 <7ac7311863d2e05c3dc8e26cb821fe8a7c4b6804.1692725056.git.gitgitgadget@gmail.com>
 <xmqqmsyilv3e.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqmsyilv3e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2023 3:45 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> +		switch (discover_git_directory_reason(&commondir, &gitdir)) {
>> +		case GIT_DIR_INVALID_OWNERSHIP:
>> +			warning(_("repository at '%s' has different owner"), dir);
>> +			goto loop_end;
>> +
>> +		case GIT_DIR_DISCOVERED:
>> +			succeeded = 1;
>> +			break;
>> +
>> +		default:
>> +			warning(_("repository not found in '%s'"), dir);
>> +			break;
> 
> Among the error cases, INVALID_OWNERSHIP is one of the possibilities
> that merits specialized message to the end-user.  I wonder if others
> also deserve to be explained, though.

The specific choice of GIT_DIR_INVALID_OWNERSHIP is singled out
because it's a new-ish reason and is the most confusing to users
when things fail for this reason.
 
>  - HIT_CEILING and HIT_MOUNT_POINT will happen when there is no
>    usable repository between "dir" and the specified ceiling.

These are basically "didn't find a Git repo" but there are different
reasons why Git stopped looking. I'm not sure there is something more
valuable to indicate here than the "repository not found" message
that already exists.

>  - INVALID_GITFILE and INVALID_FORMAT are signs of some repository
>    corruption.

I can add a message for this kind of error, which seems helpful to
point out to a user.

>  - DISALLOWED_BARE is unlikely to happen in the scalar context.

I agree.

Thanks,
-Stolee
