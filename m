Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CDCC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 15:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjDXPOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjDXPOX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 11:14:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627B1FE6
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:14:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso3912375b3a.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682349262; x=1684941262;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gcbx9R5VCMN/qMOhmi5hE1RWAFRtF9u5Hw9Iyfk7bRA=;
        b=qddz28+XRWLBxZ+m+tVoS0dv/8RjersLHZZTgJUxuPdqfBKNYMpzBPaRxB7yDAZbBH
         khGI6MveI8B5qgwkodJJBF/nEzcPU6bwjPhn2BxAYlvXxNvUy2KJ6OK3vOimgcYDYpus
         PvePIbImmeczHTq6RXcC8Wmay2JwXLR0+IjHHDgQi6X2EUf9t5YPJTh6ZCXERbSrgx54
         dK/LHIKjbG71V0ELLViggPQXsah/SiUW54oqVngcbbKsf4n32eJvfNDwqaKKyS9Bsa/z
         tEXZrABjW5VxNwS4BxbkYi6yAurSwpjuPPGeEFw9HXMpAqN8htIJaqIDXwlKhI5HtXZb
         IlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349262; x=1684941262;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gcbx9R5VCMN/qMOhmi5hE1RWAFRtF9u5Hw9Iyfk7bRA=;
        b=d+MavuhdA4yhFhvDwbc19LtpO9mVgebsTExv5dPsvojhFy4Y5vwUOdaYgIggpOGVgT
         1K069iXy9Kw5oqxxNcgHa4HXqgi23cS5X2fVS5OmC8Z+wx9npESyvXiajx+6b3l/MBuX
         e51lOqHETy4GwZ3fPkW9Uge9KneRgAKkLj0cOSatA2CtVGqzKxSRZPir+dAZRq/homw7
         1uWchrMUi3rgqwhVxtFS+yLaIogObrsot8u88jWtSaeebxM9i+/9wRfGG+OwXyFVI7Lt
         2MTbR+yBkRTnS0yiXaeYvVYLp6rD7vqcotdf8J7HMx8YABkpau0jJWair7XN6y/1sgtA
         fFWg==
X-Gm-Message-State: AAQBX9ckDlx3G/VoSO1uYYDuFF2hPaWFbuu3JUVPTpZJbJGRBoM98RYV
        9m6200wwy/sCtXHrUVYy6xk=
X-Google-Smtp-Source: AKy350bYbRN/7R9raOJqlORUS9uew8aFcGGYwJcy76O+HIKIorJZfzmQ5zOLwXKbJEee78+FF9REUQ==
X-Received: by 2002:a05:6a21:6702:b0:cd:5334:e25e with SMTP id wh2-20020a056a21670200b000cd5334e25emr14334104pzb.17.1682349261905;
        Mon, 24 Apr 2023 08:14:21 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id np9-20020a17090b4c4900b002367325203fsm8412805pjb.50.2023.04.24.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 08:14:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>, Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH v4] write-tree: integrate with sparse index
References: <20230419072148.4297-1-cheskaqiqi@gmail.com>
        <20230421004108.32554-1-cheskaqiqi@gmail.com>
        <8b2a754c-6162-54d9-e9ba-fd994058066c@github.com>
Date:   Mon, 24 Apr 2023 08:14:21 -0700
In-Reply-To: <8b2a754c-6162-54d9-e9ba-fd994058066c@github.com> (Victoria Dye's
        message of "Fri, 21 Apr 2023 14:42:34 -0700")
Message-ID: <xmqq7cu1ia7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Shuqi Liang wrote:
>> Update 'git write-tree' to allow using the sparse-index in memory
>> without expanding to a full one.
>> 
>> The recursive algorithm for update_one() was already updated in 2de37c5
>> (cache-tree: integrate with sparse directory entries, 2021-03-03) to
>> handle sparse directory entries in the index. Hence we can just set the
>> requires-full-index to false for "write-tree".
>> 
>> The `p2000` tests demonstrate a ~96% execution time reduction for 'git
>> write-tree' using a sparse index:
>> 
>> Test                                           before  after
>> -----------------------------------------------------------------
>> 2000.78: git write-tree (full-v3)              0.34    0.33 -2.9%
>> 2000.79: git write-tree (full-v4)              0.32    0.30 -6.3%
>> 2000.80: git write-tree (sparse-v3)            0.47    0.02 -95.8%
>> 2000.81: git write-tree (sparse-v4)            0.45    0.02 -95.6%
>
> Please update your commit message to explain only the incremental updates on
> top of 1a65b41b38a (write-tree: integrate with sparse index, 2023-04-03);
> that patch's message (what you have here) does not accurately describe what
> _this_ patch is doing.

Good point.

In addition, as this is the first iteration of a follow-up topic,
"v4" on the subject line is a bit misleading.  Let's treat it as a
new and separate topic that build on top of the previous achievement.

Thanks for working on this topic and mentoring a new contributor.
