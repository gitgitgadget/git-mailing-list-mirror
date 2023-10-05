Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED76AE92734
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 19:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjJETqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 15:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjJETqt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 15:46:49 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ABFCE
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 12:46:49 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65d03071a07so2056926d6.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696535208; x=1697140008; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jL89OZFvBNy553AAYXmTtroAsrNWRRM0RA1hGzIitJk=;
        b=f8yO2NToI+CSZMAplEPDd309PIr8fy7Is+icSxvLSPOOVhfWk5OJxllFtc0UPAUFXy
         n0RQzGFSTgD6cdQOWIQSFmwLZ3MI6jRc58FtT0JPeE1LrTnB7u71YGylWyFP3w44+Ou5
         z5kjcSjuWKJhmKl5WIeqkvPoaFMcr5u3tZVcJ0e1YqsnwRZ0apTKMMFEAFXQzrhE5/KY
         bkCG8DmYwkcKR/6LWLPpDst8HEAcgl7dq00Dndl/rGYscAHnE0oNxXpGb1jjGRw6PlAe
         lxR8n2GXlr9TKowPEgEn9FHdhL78EYVgdbrJIQ/tQteqdtG9jR1CNPJOFY0TfYontmt/
         t5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696535208; x=1697140008;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jL89OZFvBNy553AAYXmTtroAsrNWRRM0RA1hGzIitJk=;
        b=YO6O2ndI7NZqoo6BIe9UC4WbCXGl2FSFk1atF1w6EkmWEHHLjnPcnH7ZAxXYJrN/df
         rFVrCHNVfv726o0b16vfhuhGnwbR0igYHeRqD9/+ils3963SklqCnzXi/QgKalpZtvVE
         zYiFX65zsq1mWHQlpygxPwM2hb9cRbDuNfvuZJ4LLd9fQWC8wJ7mWz9D3UEX+iEtifKy
         lG4X5t3g5fa8mlPi4MQ0hWoBAEab0nhp3qDQlE7JeDItIRoN1FFo2fHg5E7t2qMYwxfg
         OthSxVflhTjLCwVEGv2etUVFY2CZfYQxVBZSq2co20quX18yf3zduT8ZvDg5+/T3znsb
         W80w==
X-Gm-Message-State: AOJu0YwXJ0hr1HS+A8HSE7utYrvwiUz92P0SPi8mQaM0XUOZ9qkbKNjH
        jL9LfEO5mdTKzQWG1tu53WU=
X-Google-Smtp-Source: AGHT+IGkHLRYegEkA2ZSuPwDqpYMxzBF2FyV4S2oEnGSmBhdqafl7cSMPaqLtc+ceGm/3iVh3VeCeg==
X-Received: by 2002:a05:6214:2303:b0:668:e31b:5576 with SMTP id gc3-20020a056214230300b00668e31b5576mr6420844qvb.1.1696535207967;
        Thu, 05 Oct 2023 12:46:47 -0700 (PDT)
Received: from [192.168.1.195] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id h26-20020a0cb4da000000b0065b0a3ae7c7sm745856qvf.113.2023.10.05.12.46.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Oct 2023 12:46:47 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] attr: add attr.tree for setting the treeish to read attributes from
Date:   Thu, 05 Oct 2023 15:46:46 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <BC4BEE47-2BE1-44F8-B368-6E858D98D416@gmail.com>
In-Reply-To: <20231005170703.GA975921@coredump.intra.peff.net>
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
 <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
 <446bce03a96836f35f94e9ef8548cf4a2b041ba8.1696443502.git.gitgitgadget@gmail.com>
 <xmqqfs2qp3bg.fsf@gitster.g>
 <20231005170703.GA975921@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On 5 Oct 2023, at 13:07, Jeff King wrote:

> On Wed, Oct 04, 2023 at 12:58:43PM -0700, Junio C Hamano wrote:
>
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: John Cai <johncai86@gmail.com>
>>>
>>> 44451a2e5e (attr: teach "--attr-source=<tree>" global option to "git",
>>> 2023-05-06) provided the ability to pass in a treeish as the attr
>>> source. In the context of serving Git repositories as bare repos like we
>>> do at GitLab however, it would be easier to point --attr-source to HEAD
>>> for all commands by setting it once.
>>>
>>> Add a new config attr.tree that allows this.
>>
>> Hmph, I wonder if we want to go all the way to emulate how the
>> mailmap.blob was done, including
>>
>>  - Default the value of attr.tree to HEAD in a bare repository;
>>
>>  - Notice but ignore errors if the attr.tree does not point at a
>>    tree object, and pretend as if attr.tree specified an empty tree;
>>
>> which does not seem to be in this patch.  With such a change,
>> probably we do not even need [2/2] of the series, perhaps?
>
> Oh good, this was exactly what I was going to write in a review, so now
> I don't have to. :)
>
> Even though it creates behavior differences between attr.tree and
> --attr-source, I think that is justifiable. Config options apply across
> a wider set of contexts, so loosening the error handling may make sense
> where it would not for a command-line option.

Makes sense. Will adjust in the next version.

> But we should document both that, and also how the two interact (I assume
> "git --attr-source" would override attr.tree completely).

Yes, --attr-source would take precedence over attr.tree

>
> -Peff

thanks!
John
