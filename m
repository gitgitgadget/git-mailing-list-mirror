Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF304C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 01:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDNBNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 21:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNBNx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 21:13:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C24D3A9D
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 18:13:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b509fe13eso221148b3a.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 18:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681434829; x=1684026829;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yn996VfkRt9Bk0u+a8O6Arl4D5szqkvsedwbEaLziA0=;
        b=Mt2qwP72WvfxzrGlBm5n0ZloA0NyUh0lCGoXF+WvwkOKDZIJOYLR7fEdqmv+PPxvfb
         /uTragrliiLN5UDXCIyKnv5VoI0Z7LLGauNLsadZ97Y2AXWQ0jHfvtiqNx4WUBO0afYs
         7h0wsE4XQOU8JkjNx8AcdFehYxYLo0ECMjZmJRlUEWJNzy+e05xpTNV7va/HsOAZjBYD
         4aB2kskkRBf9/g6UJI8sDYRsDZwIBe+zDQAdyLVJyxMg8DNUUhqPq8lDSWsY+sXScDhq
         VDB5vIaNR+Clu8/o475FcT6K8nmQfkYAHBsnIKhU8T0h6t87lQyzuAIqa+Nx7Db3okHl
         eMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681434829; x=1684026829;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yn996VfkRt9Bk0u+a8O6Arl4D5szqkvsedwbEaLziA0=;
        b=SHlqzJ8X++LxHS/t8T2bE0k4oowJkOoS2+BLqvV8N4vATYZPpOtcIjZoXrUXQTjcZG
         hCJB8wpyQkqM+qi43k6JYkSlSeaehOGOegRIkS3xIgc3qa/uG9b6/bMB/C+019y+Wxjj
         /us9zTeXVesM0HOXmx52cQnxhTEdjhpSH8RFS3YpA+1ThLjP0wF1cOVb9ofMSMuXPAog
         Ry5chkCSbyVZI/zNkZrUVwWSzj7BRBo6iFdzavqsMYlUF0YtqNeffxXYXS+Qu6BRcIC7
         oO8Fh+tgVbtHIBIFjgF/b/jsvy4fcmUHre34as/MaNYyIpDGbI5KBog5V5mhlo/uCOZ+
         OLhQ==
X-Gm-Message-State: AAQBX9ddEqr69UmagaM9lj7x0tJTXpJ8xpfAsJ45X5hpsDE9InMDOfJD
        VPy7JSsOdqhw+Tx/ndSLASk=
X-Google-Smtp-Source: AKy350afh+pFAcYxxFmT7bSffAs1J8V+5WK9ONTnPx/4HPK5wgZqoaSQdAITUWQlqwaCQz8/QElbIg==
X-Received: by 2002:a05:6a00:cd5:b0:628:4c9:a07 with SMTP id b21-20020a056a000cd500b0062804c90a07mr5571479pfv.29.1681434828835;
        Thu, 13 Apr 2023 18:13:48 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id r12-20020a62e40c000000b0063b63b32ae4sm315156pfh.85.2023.04.13.18.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 18:13:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Raghul Nanth A <nanth.raghul@gmail.com>,
        Shuqi Liang <cheskaqiqi@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2023, #03; Tue, 11)
References: <xmqqo7ns69sz.fsf@gitster.g>
        <df61d79b-8234-d3fd-5eb5-614d1b97d046@github.com>
Date:   Thu, 13 Apr 2023 18:13:48 -0700
In-Reply-To: <df61d79b-8234-d3fd-5eb5-614d1b97d046@github.com> (Victoria Dye's
        message of "Thu, 13 Apr 2023 15:19:13 -0700")
Message-ID: <xmqqmt3bw9ir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Junio C Hamano wrote:
>> * rn/sparse-diff-index (2023-04-10) 1 commit
> ...
> I just sent a review of the newest version [1] ...

Thanks.

>> * rn/sparse-describe (2023-04-03) 1 commit
>>  - describe: enable sparse index for describe
>> ... 
> This looks good to me, agreed that it's ready for 'next'.

Yeah, thanks for helping the author to polish the topic into a very
good shape.

>> * sl/sparse-write-tree (2023-04-04) 1 commit
> ...
> Sorry for getting to this one so late - I did have some comments [2] on the
> tests in this patch that weren't addressed. However, I'm fairly certain the
> integration itself is correct, so I may just submit the test updates as a
> separate patch in the (near-ish?) future.

Again, very much appreciated.

>> * sl/diff-files-sparse (2023-03-22) 2 commits
>>  - diff-files: integrate with sparse index
>>  - t1092: add tests for `git diff-files`
>> 
>>  Teach "diff-files" not to expand sparse-index unless needed.
>> 
>>  Comments?
>>  source: <20230322161820.3609-1-cheskaqiqi@gmail.com>
>
> I also just sent a review for this one [3] [4], ...

Yup, I saw them.  Looked very sensible.

Thanks.
